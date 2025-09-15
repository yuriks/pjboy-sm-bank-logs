;;; $8000: PLM populations ;;;
{
;                        ________________ 0: PLM ID. 0 = terminator
;                       |      __________ 2: X position in blocks
;                       |     |   _______ 3: Y position in blocks
;                       |     |  |    ___ 4: Parameter
;                       |     |  |   |
;                       rrrr, xx,yy, pppp

; Room $91F8, state $9213. Landing site - default
; Room $91F8, state $922D. Landing site - event "Zebes is awake" is set
; Room $91F8, state $9247. Landing site - power bombs have been collected
$8F:8000             dx B703, 1E,28, 92B0, ; Scroll PLM
                        B647, 1E,27, 8000, ; Upwards extension
                        B647, 1E,26, 8000, ; Upwards extension
                        B647, 1E,25, 8000, ; Upwards extension
                        C872, 8E,46, 0000, ; Door. Green door facing left
                        C85A, 8E,16, 0001, ; Door. Yellow door facing left
                        0000

; Room $91F8, state $9261. Landing site - event "Zebes timebomb set" is set
$8F:8026             dx B703, 1E,28, 92B0, ; Scroll PLM
                        B647, 1E,27, 8000, ; Upwards extension
                        B647, 1E,26, 8000, ; Upwards extension
                        B647, 1E,25, 8000, ; Upwards extension
                        DB44, 08,08, 0008, ; Sets Metroids cleared states when required
                        C848, 01,26, 9002, ; Door. Grey door facing right
                        C842, 8E,46, 9003, ; Door. Grey door facing left
                        C842, 8E,16, 9004, ; Door. Grey door facing left
                        0000

; Room $92B3. Gauntlet east
$8F:8058             dx 0000

; Room $92FD, state $9314. Crateria mainstreet - default
; Room $92FD, state $932E. Crateria mainstreet - event "Zebes is awake" is set
$8F:805A             dx B703, 3F,0B, 9389, ; Scroll PLM
                        B703, 43,0B, 938C, ; Scroll PLM
                        B703, 16,0D, 938F, ; Scroll PLM
                        B63B, 17,0D, 8000, ; Rightwards extension
                        B63B, 18,0D, 8000, ; Rightwards extension
                        B63B, 19,0D, 8000, ; Rightwards extension
                        B703, 16,0B, 9396, ; Scroll PLM
                        B63B, 17,0B, 8000, ; Rightwards extension
                        B63B, 18,0B, 8000, ; Rightwards extension
                        B63B, 19,0B, 8000, ; Rightwards extension
                        B703, 0E,09, 9399, ; Scroll PLM
                        B647, 0E,08, 8000, ; Upwards extension
                        B647, 0E,07, 8000, ; Upwards extension
                        B703, 1C,0A, 939C, ; Scroll PLM
                        B647, 1C,09, 8000, ; Upwards extension
                        B647, 1C,08, 8000, ; Upwards extension
                        B647, 1C,07, 8000, ; Upwards extension
                        B647, 1C,06, 8000, ; Upwards extension
                        B647, 1C,05, 8000, ; Upwards extension
                        B703, 32,0B, 939F, ; Scroll PLM
                        B703, 3C,0B, 939F, ; Scroll PLM
                        B703, 3A,11, 93A2, ; Scroll PLM
                        B63B, 3B,11, 8000, ; Rightwards extension
                        B63B, 3C,11, 8000, ; Rightwards extension
                        B63B, 3D,11, 8000, ; Rightwards extension
                        B63B, 3E,11, 8000, ; Rightwards extension
                        B703, 34,0E, 93A5, ; Scroll PLM
                        C88A, 1E,36, 0005, ; Door. Red door facing left
                        0000

; Room $92FD, state $9348. Crateria mainstreet - event "Zebes timebomb set" is set
$8F:8104             dx B703, 3F,0B, 9389, ; Scroll PLM
                        B703, 43,0B, 938C, ; Scroll PLM
                        B703, 16,0D, 938F, ; Scroll PLM
                        B63B, 17,0D, 8000, ; Rightwards extension
                        B63B, 18,0D, 8000, ; Rightwards extension
                        B63B, 19,0D, 8000, ; Rightwards extension
                        B703, 16,0B, 9396, ; Scroll PLM
                        B63B, 17,0B, 8000, ; Rightwards extension
                        B63B, 18,0B, 8000, ; Rightwards extension
                        B63B, 19,0B, 8000, ; Rightwards extension
                        B703, 0E,09, 9399, ; Scroll PLM
                        B647, 0E,08, 8000, ; Upwards extension
                        B647, 0E,07, 8000, ; Upwards extension
                        B703, 1C,0A, 939C, ; Scroll PLM
                        B647, 1C,09, 8000, ; Upwards extension
                        B647, 1C,08, 8000, ; Upwards extension
                        B647, 1C,07, 8000, ; Upwards extension
                        B647, 1C,06, 8000, ; Upwards extension
                        B647, 1C,05, 8000, ; Upwards extension
                        B703, 32,0B, 939F, ; Scroll PLM
                        B703, 3C,0B, 939F, ; Scroll PLM
                        B703, 3A,11, 93A2, ; Scroll PLM
                        B63B, 3B,11, 8000, ; Rightwards extension
                        B63B, 3C,11, 8000, ; Rightwards extension
                        B63B, 3D,11, 8000, ; Rightwards extension
                        B63B, 3E,11, 8000, ; Rightwards extension
                        B703, 34,0E, 93A5, ; Scroll PLM
                        DB44, 08,08, 000A, ; Sets Metroids cleared states when required
                        C848, 01,06, 9006, ; Door. Grey door facing right
                        C848, 11,26, 9007, ; Door. Grey door facing right
                        C848, 11,36, 9008, ; Door. Grey door facing right
                        C842, 1E,36, 9009, ; Door. Grey door facing left
                        C84E, 16,4D, 900A, ; Door. Grey door facing up
                        0000

; Room $93AA. Landing site power bombs cave
$8F:81CC             dx EEE3, 1D,07, 0000, ; Power bomb tank
                        0000

; Room $93D5. Crateria save station
$8F:81D4             dx B76F, 05,0B, 0001, ; Save station
                        0000

; Room $93FE. Wrecked Ship entrance
$8F:81DC             dx C842, 5E,36, 900B, ; Door. Grey door facing left
                        C872, 7E,46, 000C, ; Door. Green door facing left
                        EEDB, 02,5B, 0001, ; Missile tank
                        EF83, 1C,03, 0002, ; Missile tank, shot block
                        EEDB, 01,2F, 0003, ; Missile tank
                        0000

; Room $9461. Pre orange zoomer hall
$8F:81FC             dx 0000

; Room $948C. Pre moat room
$8F:81FE             dx B703, 17,0F, 94C2, ; Scroll PLM
                        B63B, 18,0F, 8000, ; Rightwards extension
                        B703, 16,0C, 94C7, ; Scroll PLM
                        B63B, 17,0C, 8000, ; Rightwards extension
                        B63B, 18,0C, 8000, ; Rightwards extension
                        B63B, 19,0C, 8000, ; Rightwards extension
                        C85A, 2E,06, 000D, ; Door. Yellow door facing left
                        C866, 16,2D, 000E, ; Door. Yellow door facing up
                        0000

; Room $94CC. Crateria -> Maridia elevator
$8F:8230             dx B703, 08,0D, 94FA, ; Scroll PLM
                        0000

; Room $94FD. Wrecked Ship back door
$8F:8238             dx 0000

; Room $9552. Forgotten highway kago shaft
$8F:823A             dx 0000

; Room $957D. Crab maze
$8F:823C             dx 0000

; Room $95A8. Forgotten highway elbow
$8F:823E             dx C866, 06,0D, 000F, ; Door. Yellow door facing up
                        0000

; Room $95D4. Crateria tube
$8F:8246             dx 0000

; Room $95FF. Moat
$8F:8248             dx EEDB, 0E,09, 0004, ; Missile tank
                        0000

; Room $962A. Crateria -> Red Brinstar elevator
$8F:8250             dx B703, 08,0D, 9658, ; Scroll PLM
                        C86C, 06,02, 0010, ; Door. Yellow door facing down
                        0000

; Room $965B. Gauntlet west
$8F:825E             dx B703, 54,0C, 968C, ; Scroll PLM
                        EED7, 53,08, 0005, ; Energy tank
                        0000

; Room $968F. Orange zoomer hall
$8F:826C             dx 0000

; Room $96BA, state $96D1. Old Tourian escape shaft - default
; Room $96BA, state $96EB. Old Tourian escape shaft - event "Zebes is awake" is set
$8F:826E             dx B703, 1D,05, 9747, ; Scroll PLM
                        B703, 20,05, 9744, ; Scroll PLM
                        B703, 1D,76, 974D, ; Scroll PLM
                        B703, 20,76, 974A, ; Scroll PLM
                        B63F, 12,85, 8000, ; Leftwards extension
                        B63F, 13,85, 8000, ; Leftwards extension
                        B647, 14,85, 8000, ; Upwards extension
                        B647, 14,86, 8000, ; Upwards extension
                        B647, 14,87, 8000, ; Upwards extension
                        B647, 14,88, 8000, ; Upwards extension
                        B703, 14,89, 9753, ; Scroll PLM
                        B647, 0F,86, 8000, ; Upwards extension
                        B647, 0F,87, 8000, ; Upwards extension
                        B647, 0F,88, 8000, ; Upwards extension
                        B703, 0F,89, 9750, ; Scroll PLM
                        B647, 0D,86, 8000, ; Upwards extension
                        B647, 0D,87, 8000, ; Upwards extension
                        B647, 0D,88, 8000, ; Upwards extension
                        B703, 0D,89, 9756, ; Scroll PLM
                        B647, 08,86, 8000, ; Upwards extension
                        B647, 08,87, 8000, ; Upwards extension
                        B647, 08,88, 8000, ; Upwards extension
                        B703, 08,89, 9759, ; Scroll PLM
                        C842, 2E,06, 9011, ; Door. Grey door facing left
                        C848, 01,86, 9012, ; Door. Grey door facing right
                        C85A, 2E,76, 0013, ; Door. Yellow door facing left
                        0000

; Room $96BA, state $9705. Old Tourian escape shaft - event "Zebes timebomb set" is set
$8F:830C             dx B703, 1D,05, 9747, ; Scroll PLM
                        B703, 20,05, 9744, ; Scroll PLM
                        B703, 1D,76, 974D, ; Scroll PLM
                        B703, 20,76, 974A, ; Scroll PLM
                        B63F, 12,85, 8000, ; Leftwards extension
                        B63F, 13,85, 8000, ; Leftwards extension
                        B647, 14,85, 8000, ; Upwards extension
                        B647, 14,86, 8000, ; Upwards extension
                        B647, 14,87, 8000, ; Upwards extension
                        B647, 14,88, 8000, ; Upwards extension
                        B703, 14,89, 9753, ; Scroll PLM
                        B647, 0F,86, 8000, ; Upwards extension
                        B647, 0F,87, 8000, ; Upwards extension
                        B647, 0F,88, 8000, ; Upwards extension
                        B703, 0F,89, 9750, ; Scroll PLM
                        B647, 0D,86, 8000, ; Upwards extension
                        B647, 0D,87, 8000, ; Upwards extension
                        B647, 0D,88, 8000, ; Upwards extension
                        B703, 0D,89, 9756, ; Scroll PLM
                        B647, 08,86, 8000, ; Upwards extension
                        B647, 08,87, 8000, ; Upwards extension
                        B647, 08,88, 8000, ; Upwards extension
                        B703, 08,89, 9759, ; Scroll PLM
                        DB44, 08,08, 000C, ; Sets Metroids cleared states when required
                        C842, 2E,06, 9014, ; Door. Grey door facing left
                        C842, 2E,76, 9015, ; Door. Grey door facing left
                        C842, 1E,86, 9016, ; Door. Grey door facing left
                        C848, 01,86, 9017, ; Door. Grey door facing right
                        0000

; Room $975C, state $976D. Old Mother Brain room - default
$8F:83B6             dx B703, 04,0F, 97AB, ; Scroll PLM
                        B703, 06,0F, 97AB, ; Scroll PLM
                        B703, 05,09, 97B0, ; Scroll PLM
                        C848, 01,06, 9018, ; Door. Grey door facing right
                        0000

; Room $975C, state $9787. Old Mother Brain room - morph ball and missiles have been collected
$8F:83D0             dx B703, 04,0F, 97AB, ; Scroll PLM
                        B703, 06,0F, 97AB, ; Scroll PLM
                        B703, 05,09, 97B0, ; Scroll PLM
                        C842, 2E,06, 0C19, ; Door. Grey door facing left
                        C848, 01,06, 0C1A, ; Door. Grey door facing right
                        EEDB, 05,1A, 0006, ; Missile tank
                        0000

; Room $97B5. Crateria -> Blue Brinstar elevator
$8F:83F6             dx B703, 07,0D, 9801, ; Scroll PLM
                        0000

; Room $9804, state $981B. Bomb Torizo - default
; Room $9804, state $9835. Bomb Torizo - area torizo is dead
$8F:83FE             dx BAF4, 01,06, 081B, ; Bomb torizo grey door
                        EF3B, 0C,0A, 0007, ; Bombs, chozo orb
                        D6EA, 0D,0B, 0000, ; Bomb Torizo's crumbling chozo
                        0000

; Room $9804, state $984F. Bomb Torizo - event "Zebes timebomb set" is set
$8F:8412             dx DB44, 08,08, 000E, ; Sets Metroids cleared states when required
                        C848, 01,06, 181C, ; Door. Grey door facing right
                        0000

; Room $9879, state $9890. Pre Bomb Torizo hall - default
; Room $9879, state $98AA. Pre Bomb Torizo hall - area torizo is dead
$8F:8420             dx C88A, 2E,06, 001D, ; Door. Red door facing left
                        0000

; Room $9879, state $98C4. Pre Bomb Torizo hall - event "Zebes timebomb set" is set
$8F:8428             dx DB44, 08,08, 0010, ; Sets Metroids cleared states when required
                        0000

; Room $98E2. Pre Crateria map station hall
$8F:8430             dx 0000

; Room $990D. Crateria slope
$8F:8432             dx EED7, 07,2A, 0008, ; Energy tank
                        0000

; Room $9938. Crateria -> Green Brinstar elevator
$8F:843A             dx B703, 07,0D, 9966, ; Scroll PLM
                        0000

; Room $9969. West Crateria kago hall
$8F:8442             dx 0000

; Room $9994. Crateria map station
$8F:8444             dx B6D3, 0B,0A, 8000, ; Map station
                        0000

; Room $99BD. Crateria space pirate shaft
$8F:844C             dx B703, 07,43, 99F3, ; Scroll PLM
                        B63B, 08,43, 8000, ; Rightwards extension
                        B703, 09,46, 99F6, ; Scroll PLM
                        B63B, 0A,46, 8000, ; Rightwards extension
                        EEDB, 0D,1B, 0009, ; Missile tank
                        EEDB, 02,1B, 000A, ; Missile tank
                        C88A, 0E,66, 001E, ; Door. Red door facing left
                        0000

; Room $99F9. Crateria spike floor room
$8F:8478             dx EEDF, 3B,09, 000B, ; Super missile tank
                        0000

; Room $9A44, state $9A56. Crateria bomb block hall - default
$8F:8480             dx 0000

; Room $9A44, state $9A70. Crateria bomb block hall - event "Zebes is awake" is set
$8F:8482             dx 0000

; Room $9A90, state $9AA2. Crateria chozo missile - default
$8F:8484             dx 0000

; Room $9A90, state $9ABC. Crateria chozo missile - event "Zebes is awake" is set
$8F:8486             dx EEDB, 04,07, 000C, ; Missile tank
                        0000

; Room $9AD9. Green Brinstar mainstreet
$8F:848E             dx B703, 07,71, 9B46, ; Scroll PLM
                        B703, 10,A8, 9B4B, ; Scroll PLM
                        B703, 21,A8, 9B4B, ; Scroll PLM
                        B703, 0D,AC, 9B52, ; Scroll PLM
                        B70B, 06,2C, 8000, ; Elevator platform
                        EF37, 3C,7A, 000D, ; Power bomb tank, chozo orb
                        C890, 01,56, 001F, ; Door. Red door facing right
                        C890, 01,46, 0020, ; Door. Red door facing right
                        C88A, 0E,46, 0021, ; Door. Red door facing left
                        C88A, 0E,66, 0022, ; Door. Red door facing left
                        C890, 01,66, 0023, ; Door. Red door facing right
                        C842, 0E,76, 9024, ; Door. Grey door facing left
                        0000

; Room $9B5B. Spore Spawn's super missile shaft
$8F:84D8             dx B703, 17,0B, 9B98, ; Scroll PLM
                        B63B, 18,0B, 8000, ; Rightwards extension
                        EF33, 1A,87, 000E, ; Super missile tank, chozo orb
                        0000

; Room $9B9D. Pre Brinstar map room hall
$8F:84EC             dx C842, 2E,06, 0C25, ; Door. Grey door facing left
                        0000

; Room $9BC8. Early supers room
$8F:84F4             dx B703, 29,0E, 9BF9, ; Scroll PLM
                        B63B, 2A,0E, 8000, ; Rightwards extension
                        B63B, 2B,0E, 8000, ; Rightwards extension
                        B703, 04,13, 9C00, ; Scroll PLM
                        B703, 04,0F, 9BF9, ; Scroll PLM
                        C88A, 2E,16, 0026, ; Door. Red door facing left
                        EEDB, 13,1B, 000F, ; Missile tank
                        EEDF, 04,06, 0010, ; Super missile tank
                        0000

; Room $9C07. Brinstar reserve tank room
$8F:8526             dx B703, 0E,0B, 9C32, ; Scroll PLM
                        EF7B, 0B,07, 0011, ; Reserve tank, chozo orb
                        EF83, 1E,07, 0012, ; Missile tank, shot block
                        EEDB, 19,07, 0013, ; Missile tank
                        0000

; Room $9C35. Brinstar map station
$8F:8540             dx B6D3, 05,0A, 8000, ; Map station
                        0000

; Room $9C5E. Fireflea room
$8F:8548             dx C878, 01,26, 0027, ; Door. Green door facing right
                        0000

; Room $9C89. Green Brinstar missile station
$8F:8550             dx B6EB, 04,0A, 0014, ; Missile station
                        0000

; Room $9CB3. Dachora room
$8F:8558             dx B643, 45,0E, 8000, ; Downwards extension
                        B63F, 45,0D, 8000, ; Leftwards extension
                        B63F, 46,0D, 8000, ; Leftwards extension
                        B63F, 47,0D, 8000, ; Leftwards extension
                        B63F, 48,0D, 8000, ; Leftwards extension
                        B63F, 49,0D, 8000, ; Leftwards extension
                        B703, 4A,0D, 9D11, ; Scroll PLM
                        B647, 40,08, 8000, ; Upwards extension
                        B647, 40,09, 8000, ; Upwards extension
                        B647, 40,0A, 8000, ; Upwards extension
                        B703, 40,0B, 9D14, ; Scroll PLM
                        B643, 4B,0B, 8000, ; Downwards extension
                        B643, 4B,0A, 8000, ; Downwards extension
                        B63B, 4B,09, 8000, ; Rightwards extension
                        B63B, 4A,09, 8000, ; Rightwards extension
                        B63B, 49,09, 8000, ; Rightwards extension
                        B63B, 48,09, 8000, ; Rightwards extension
                        B63B, 47,09, 8000, ; Rightwards extension
                        B63B, 46,09, 8000, ; Rightwards extension
                        B63B, 45,09, 8000, ; Rightwards extension
                        B647, 44,09, 8000, ; Upwards extension
                        B647, 44,0A, 8000, ; Upwards extension
                        B703, 44,0B, 9D14, ; Scroll PLM
                        0000

; Room $9D19. Charge beam room
$8F:85E4             dx B703, 2E,6B, 9D84, ; Scroll PLM
                        B703, 20,7A, 9D8B, ; Scroll PLM
                        B703, 3D,57, 9D8E, ; Scroll PLM
                        B703, 40,57, 9D91, ; Scroll PLM
                        B703, 1F,08, 9D96, ; Scroll PLM
                        B703, 21,08, 9D99, ; Scroll PLM
                        EEDB, 24,32, 0015, ; Missile tank
                        EEDB, 22,67, 0016, ; Missile tank
                        EF3F, 25,76, 0017, ; Charge beam, chozo orb
                        C85A, 3E,46, 0028, ; Door. Yellow door facing left
                        C872, 3E,66, 0029, ; Door. Green door facing left
                        C88A, 3E,06, 002A, ; Door. Red door facing left
                        C890, 01,96, 002B, ; Door. Red door facing right
                        0000

; Room $9D9C. Pre Spore Spawn hall
$8F:8634             dx C848, 01,06, 0C2C, ; Door. Grey door facing right
                        C854, 36,03, 0C2D, ; Door. Grey door facing down
                        0000

; Room $9DC7. Spore Spawn
$8F:8642             dx C87E, 06,2E, 002E, ; Door. Green door facing up
                        0000

; Room $9E11. Brinstar super-sidehopper power bomb room
$8F:864A             dx B703, 08,0E, 9E40, ; Scroll PLM
                        B703, 08,0B, 9E49, ; Scroll PLM
                        C842, 1E,06, 0C2F, ; Door. Grey door facing left
                        EEE3, 06,17, 0018, ; Power bomb tank
                        0000

; Room $9E52. Brinstar diagonal room
$8F:8664             dx C82A, 64,37, 8000, ; Downwards closed gate
                        C836, 64,37, 0000, ; Downwards gate shotblock
                        C85A, 1E,06, 0030, ; Door. Yellow door facing left
                        EEDB, 3D,18, 0019, ; Missile tank
                        0000

; Room $9E9F, state $9EB1. Morph ball room - default
$8F:867E             dx B703, 1F,2B, 9F05, ; Scroll PLM
                        B647, 08,23, 8000, ; Upwards extension
                        B647, 08,24, 8000, ; Upwards extension
                        B647, 08,25, 8000, ; Upwards extension
                        B647, 08,26, 8000, ; Upwards extension
                        B647, 08,27, 8000, ; Upwards extension
                        B647, 08,28, 8000, ; Upwards extension
                        B647, 08,29, 8000, ; Upwards extension
                        B647, 08,2A, 8000, ; Upwards extension
                        B703, 08,2B, 9F08, ; Scroll PLM
                        B63B, 58,21, 8000, ; Rightwards extension
                        B703, 57,21, 9F0B, ; Scroll PLM
                        B63B, 58,0A, 8000, ; Rightwards extension
                        B703, 57,0A, 9F0B, ; Scroll PLM
                        B63B, 58,26, 8000, ; Rightwards extension
                        B703, 57,26, 9F0E, ; Scroll PLM
                        EF23, 45,29, 001A, ; Morph ball
                        0000

; Room $9E9F, state $9ECB. Morph ball room - event "Zebes is awake" is set
$8F:86E6             dx B703, 1F,2B, 9F05, ; Scroll PLM
                        B647, 08,23, 8000, ; Upwards extension
                        B647, 08,24, 8000, ; Upwards extension
                        B647, 08,25, 8000, ; Upwards extension
                        B647, 08,26, 8000, ; Upwards extension
                        B647, 08,27, 8000, ; Upwards extension
                        B647, 08,28, 8000, ; Upwards extension
                        B647, 08,29, 8000, ; Upwards extension
                        B647, 08,2A, 8000, ; Upwards extension
                        B703, 08,2B, 9F08, ; Scroll PLM
                        B63B, 58,21, 8000, ; Rightwards extension
                        B703, 57,21, 9F0B, ; Scroll PLM
                        B63B, 58,0A, 8000, ; Rightwards extension
                        B703, 57,0A, 9F0B, ; Scroll PLM
                        B63B, 58,26, 8000, ; Rightwards extension
                        B703, 57,26, 9F0E, ; Scroll PLM
                        C848, 01,26, 0C31, ; Door. Grey door facing right
                        EEE3, 28,2A, 001B, ; Power bomb tank
                        0000

; Room $9F11. Old Kraid entrance
$8F:8754             dx B703, 04,0B, 9F5F, ; Scroll PLM
                        B63B, 05,0B, 8000, ; Rightwards extension
                        B63B, 06,0B, 8000, ; Rightwards extension
                        B63B, 07,0B, 8000, ; Rightwards extension
                        B63B, 08,0B, 8000, ; Rightwards extension
                        B63B, 09,0B, 8000, ; Rightwards extension
                        B63B, 0A,0B, 8000, ; Rightwards extension
                        B63B, 0B,0B, 8000, ; Rightwards extension
                        C88A, 0E,06, 0032, ; Door. Red door facing left
                        0000

; Room $9F64. Blue Brinstar ceiling e-tank hall
$8F:878C             dx B703, 27,0B, 9FB7, ; Scroll PLM
                        B703, 27,26, 9FB7, ; Scroll PLM
                        EEDB, 2E,29, 001C, ; Missile tank
                        EF7F, 1C,22, 001D, ; Energy tank, shot block
                        0000

; Room $9FBA. n00b bridge
$8F:87A6             dx C872, 5E,06, 0033, ; Door. Green door facing left
                        0000

; Room $9FE5. Etecoon area beetom room
$8F:87AE             dx 0000

; Room $A011. Etecoon area spike hall
$8F:87B0             dx B703, 07,0B, A04A, ; Scroll PLM
                        B63B, 08,0B, 8000, ; Rightwards extension
                        B63B, 09,0B, 8000, ; Rightwards extension
                        EED7, 05,09, 001E, ; Energy tank
                        C878, 01,06, 0034, ; Door. Green door facing right
                        0000

; Room $A051. Etecoon area super missiles
$8F:87D0             dx EEDF, 07,09, 001F, ; Super missile tank
                        0000

; Room $A07B. Dachora energy station
$8F:87D8             dx B6DF, 04,0A, 0020, ; Energy station
                        0000

; Room $A0A4. Post Spore Spawn supers hall
$8F:87E0             dx C878, 01,06, 0035, ; Door. Green door facing right
                        0000

; Room $A0D2. Pink Brinstar flooded hall
$8F:87E8             dx B647, 0F,09, 8000, ; Upwards extension
                        B647, 0F,0A, 8000, ; Upwards extension
                        B703, 0F,0B, A104, ; Scroll PLM
                        EED7, 04,09, 0021, ; Energy tank
                        0000

; Room $A107. Blue Brinstar missile room
$8F:8802             dx EF2F, 04,07, 0022, ; Missile tank, chozo orb
                        0000

; Room $A130. Brinstar wave-gate sidehopper room
$8F:880A             dx C82A, 11,04, 8000, ; Downwards closed gate
                        C836, 11,04, 0002, ; Downwards gate shotblock
                        C848, 01,16, 0C36, ; Door. Grey door facing right
                        C842, 1E,16, 0C37, ; Door. Grey door facing left
                        0000

; Room $A15B. Brinstar wave-gate energy tank
$8F:8824             dx EED7, 0B,09, 0023, ; Energy tank
                        0000

; Room $A184. Spore Spawn save station
$8F:882C             dx B76F, 05,0B, 0000, ; Save station
                        0000

; Room $A1AD. Blue Brinstar boulder room
$8F:8834             dx 0000

; Room $A1D8. Blue Brinstar double missile room
$8F:8836             dx EEDB, 07,09, 0024, ; Missile tank
                        EF83, 05,0C, 0025, ; Missile tank, shot block
                        0000

; Room $A201. Green Brinstar mainstreet save station
$8F:8844             dx B76F, 05,0B, 0001, ; Save station
                        0000

; Room $A22A. Etecoon area save station
$8F:884C             dx B76F, 05,0B, 0002, ; Save station
                        0000

; Room $A253. Red Brinstar mainstreet
$8F:8854             dx B703, 09,6A, A28E, ; Scroll PLM
                        B63B, 0A,6A, 8000, ; Rightwards extension
                        C878, 01,96, 0038, ; Door. Green door facing right
                        C860, 01,66, 0039, ; Door. Yellow door facing right
                        0000

; Room $A293. Pre x-ray spike hall
$8F:886E             dx C890, 01,06, 003A, ; Door. Red door facing right
                        0000

; Room $A2CE. X-ray room
$8F:8876             dx EF63, 05,07, 0026, ; X-ray scope, chozo orb
                        0000

; Room $A2F7. Red Brinstar damage boost hall
$8F:887E             dx 0000

; Room $A322. Red Brinstar -> Crateria elevator
$8F:8880             dx B703, 05,5E, A36F, ; Scroll PLM
                        B63B, 06,5E, 8000, ; Rightwards extension
                        B703, 10,37, A374, ; Scroll PLM
                        B703, 0D,37, A379, ; Scroll PLM
                        B70B, 06,2C, 8000, ; Elevator platform
                        C82A, 26,35, 8000, ; Downwards closed gate
                        C836, 26,35, 000A, ; Downwards gate shotblock
                        C878, 01,36, 003B, ; Door. Green door facing right
                        C860, 01,56, 003C, ; Door. Yellow door facing right
                        C878, 01,76, 003D, ; Door. Green door facing right
                        0000

; Room $A37C. Red Brinstar power bomb floor room
$8F:88BE             dx B703, 07,0E, A3A9, ; Scroll PLM
                        B63B, 08,0E, 8000, ; Rightwards extension
                        EEE3, 04,13, 0027, ; Power bomb tank
                        C842, 1E,06, 0C3E, ; Door. Grey door facing left
                        0000

; Room $A3AE. Red Brinstar power bomb wall room
$8F:88D8             dx B647, 0F,04, 8000, ; Upwards extension
                        B647, 0F,05, 8000, ; Upwards extension
                        B647, 0F,06, 8000, ; Upwards extension
                        B647, 0F,07, 8000, ; Upwards extension
                        B647, 0F,08, 8000, ; Upwards extension
                        B647, 0F,09, 8000, ; Upwards extension
                        B647, 0F,0A, 8000, ; Upwards extension
                        B647, 0F,0B, 8000, ; Upwards extension
                        B703, 0F,0C, A3DA, ; Scroll PLM
                        EF37, 14,09, 0028, ; Power bomb tank, chozo orb
                        EEDB, 02,08, 0029, ; Missile tank
                        0000

; Room $A3DD. Red Brinstar skree-duo hall
$8F:891C             dx 0000

; Room $A408. Pre spazer room
$8F:891E             dx B703, 10,11, A439, ; Scroll PLM
                        B63B, 11,11, 8000, ; Rightwards extension
                        B63B, 12,11, 8000, ; Rightwards extension
                        B63B, 13,11, 8000, ; Rightwards extension
                        B703, 10,14, A43E, ; Scroll PLM
                        B63B, 11,14, 8000, ; Rightwards extension
                        B63B, 12,14, 8000, ; Rightwards extension
                        B63B, 13,14, 8000, ; Rightwards extension
                        B703, 08,11, A439, ; Scroll PLM
                        B703, 08,14, A43E, ; Scroll PLM
                        B703, 02,11, A439, ; Scroll PLM
                        B703, 02,14, A43E, ; Scroll PLM
                        C872, 1E,06, 003F, ; Door. Green door facing left
                        0000

; Room $A447. Spazer room
$8F:896E             dx EF53, 0B,09, 002A, ; Spazer beam, chozo orb
                        0000

; Room $A471. Kraid's lair zeela room
$8F:8976             dx B703, 02,0B, A4A2, ; Scroll PLM
                        B703, 02,19, A4A9, ; Scroll PLM
                        B703, 07,19, A4AE, ; Scroll PLM
                        B703, 15,19, A4A9, ; Scroll PLM
                        C848, 01,16, 0040, ; Door. Grey door facing right
                        0000

; Room $A4B1. Kraid's lair beetom room
$8F:8996             dx C842, 0E,06, 0C41, ; Door. Grey door facing left
                        EF7F, 05,04, 002B, ; Energy tank, shot block
                        0000

; Room $A4DA. Kraid's lair kihunter hall
$8F:89A4             dx B703, 17,0B, A50F, ; Scroll PLM
                        B703, 17,0E, A514, ; Scroll PLM
                        B647, 0B,04, 8000, ; Upwards extension
                        B647, 0B,05, 8000, ; Upwards extension
                        B647, 0B,06, 8000, ; Upwards extension
                        B647, 0B,07, 8000, ; Upwards extension
                        B647, 0B,08, 8000, ; Upwards extension
                        B647, 0B,09, 8000, ; Upwards extension
                        B647, 0B,0A, 8000, ; Upwards extension
                        B703, 0B,0B, A519, ; Scroll PLM
                        B703, 27,0C, A51C, ; Scroll PLM
                        B703, 2E,0C, A51C, ; Scroll PLM
                        EF83, 2E,08, 002C, ; Missile tank, shot block
                        0000

; Room $A521. Fake Kraid's room
$8F:89F4             dx C842, 5E,06, 0C42, ; Door. Grey door facing left
                        C848, 01,06, 0C43, ; Door. Grey door facing right
                        0000

; Room $A56B. Pre Kraid room
$8F:8A02             dx B703, 03,12, A59C, ; Scroll PLM
                        B63B, 04,12, 8000, ; Rightwards extension
                        B63B, 05,12, 8000, ; Rightwards extension
                        C872, 0E,06, 0044, ; Door. Green door facing left
                        DB5A, 1E,16, 0045, ; Door. Eye door, facing left
                        DB60, 1E,19, 0045, ; Eye door bottom, facing left
                        DB56, 1E,17, 0045, ; Eye door eye, facing left
                        0000

; Room $A59F. Kraid
$8F:8A2E             dx C842, 1E,16, 0046, ; Door. Grey door facing left
                        C848, 01,16, 0047, ; Door. Grey door facing right
                        0000

; Room $A5ED. Pre Tourian entrance hall
$8F:8A3C             dx 0000

; Room $A618. Red Brinstar energy station
$8F:8A3E             dx B6DF, 04,0A, 002D, ; Energy station
                        0000

; Room $A641. Kraid's lair refill station
$8F:8A46             dx B6EB, 09,0A, 002E, ; Missile station
                        B6DF, 07,0A, 002F, ; Energy station
                        0000

; Room $A66A. Tourian entrance
$8F:8A54             dx C848, 01,06, 9448, ; Door. Grey door facing right
                        0000

; Room $A6A1. Kraid's lair entrance
$8F:8A5C             dx B703, 07,0C, A6D6, ; Scroll PLM
                        B63B, 08,0C, 8000, ; Rightwards extension
                        B703, 10,09, A6D9, ; Scroll PLM
                        B647, 10,08, 8000, ; Upwards extension
                        B647, 10,07, 8000, ; Upwards extension
                        B703, 12,09, A6DC, ; Scroll PLM
                        B647, 12,08, 8000, ; Upwards extension
                        B647, 12,07, 8000, ; Upwards extension
                        B647, 12,06, 8000, ; Upwards extension
                        B703, 13,0B, A6DF, ; Scroll PLM
                        B63B, 14,0B, 8000, ; Rightwards extension
                        B647, 14,0A, 8000, ; Upwards extension
                        B647, 14,09, 8000, ; Upwards extension
                        B647, 14,08, 8000, ; Upwards extension
                        B647, 14,07, 8000, ; Upwards extension
                        B647, 14,06, 8000, ; Upwards extension
                        B647, 14,05, 8000, ; Upwards extension
                        B647, 14,04, 8000, ; Upwards extension
                        0000

; Room $A6E2. Varia suit room
$8F:8ACA             dx EF5B, 07,09, 0030, ; Varia suit, chozo orb
                        0000

; Room $A70B. Kraid's lair save station
$8F:8AD2             dx B76F, 07,0B, 0003, ; Save station
                        0000

; Room $A734. Red Brinstar save station
$8F:8ADA             dx B76F, 07,0B, 0004, ; Save station
                        0000

; Room $A75D. Ice beam tripper hall
$8F:8AE2             dx 0000

; Room $A788. Lava missile room
$8F:8AE4             dx EF83, 22,1C, 0031, ; Missile tank, shot block
                        C872, 2E,16, 0049, ; Door. Green door facing left
                        0000

; Room $A7B3. First hot room
$8F:8AF2             dx C88A, 2E,06, 004A, ; Door. Red door facing left
                        0000

; Room $A7DE. Norfair mainstreet
$8F:8AFA             dx B70B, 06,2C, 8000, ; Elevator platform
                        C878, 01,36, 004B, ; Door. Green door facing right
                        C860, 01,46, 004C, ; Door. Yellow door facing right
                        C890, 01,56, 004D, ; Door. Red door facing right
                        0000

; Room $A815. Ice beam mockball hall
$8F:8B14             dx B703, 37,2D, A860, ; Scroll PLM
                        B63B, 38,2D, 8000, ; Rightwards extension
                        0000

; Room $A865. Ice beam practice room
$8F:8B22             dx 0000

; Room $A890. Ice beam room
$8F:8B24             dx EF43, 0C,07, 0032, ; Ice beam, chozo orb
                        0000

; Room $A8B9. Pre ice beam shaft
$8F:8B2C             dx B703, 0F,17, A8EC, ; Scroll PLM
                        B703, 0D,17, A8EF, ; Scroll PLM
                        B703, 11,17, A8F2, ; Scroll PLM
                        B703, 13,17, A8F5, ; Scroll PLM
                        0000

; Room $A8F8. Crumble block platform shaft
$8F:8B46             dx EF83, 01,08, 0033, ; Missile tank, shot block
                        0000

; Room $A923. Norfair slope
$8F:8B4E             dx B703, 9E,28, A980, ; Scroll PLM
                        B647, 9E,27, 8000, ; Upwards extension
                        B647, 9E,26, 8000, ; Upwards extension
                        B647, 9E,25, 8000, ; Upwards extension
                        B647, 9E,24, 8000, ; Upwards extension
                        B703, BE,29, A987, ; Scroll PLM
                        B647, BE,28, 8000, ; Upwards extension
                        B647, BE,27, 8000, ; Upwards extension
                        B703, C2,29, A98A, ; Scroll PLM
                        B647, C2,28, 8000, ; Upwards extension
                        B647, C2,27, 8000, ; Upwards extension
                        B647, C2,26, 8000, ; Upwards extension
                        C87E, C6,2D, 004E, ; Door. Green door facing up
                        0000

; Room $A98D. Crocomire
$8F:8B9E             dx C854, 36,02, 044F, ; Door. Grey door facing down
                        EED7, 7D,06, 0034, ; Energy tank
                        0000

; Room $A9E5. Hi-jump room
$8F:8BAC             dx EF47, 03,0A, 0035, ; Hi-jump, chozo orb
                        0000

; Room $AA0E. Norfair grapple ceiling room
$8F:8BB4             dx C82A, 06,05, 8000, ; Downwards closed gate
                        C836, 06,05, 000A, ; Downwards gate shotblock
                        EEDB, 0D,09, 0036, ; Missile tank
                        0000

; Room $AA41. Pre hi-jump room
$8F:8BC8             dx B703, 10,0C, AA75, ; Scroll PLM
                        B703, 0F,05, AA70, ; Scroll PLM
                        B703, 08,1C, AA7C, ; Scroll PLM
                        B703, 0B,12, AA7F, ; Scroll PLM
                        C842, 1E,06, 0C50, ; Door. Grey door facing left
                        EEDB, 09,06, 0037, ; Missile tank
                        EED7, 17,08, 0038, ; Energy tank
                        0000

; Room $AA82. Post Crocomire room
$8F:8BF4             dx C890, 01,06, 0051, ; Door. Red door facing right
                        0000

; Room $AAB5. Post Crocomire save station
$8F:8BFC             dx B76F, 07,0B, 0000, ; Save station
                        0000

; Room $AADE. Post Crocomire power bombs room
$8F:8C04             dx EEE3, 07,08, 0039, ; Power bomb tank
                        0000

; Room $AB07. Post Crocomire shaft
$8F:8C0C             dx C88A, 0E,36, 0052, ; Door. Red door facing left
                        0000

; Room $AB3B. Post Crocomire tidal acid cave
$8F:8C14             dx EEDB, 3C,09, 003A, ; Missile tank
                        0000

; Room $AB64. Double lake grapple practice room
$8F:8C1C             dx C82A, 2A,05, 8000, ; Downwards closed gate
                        C836, 2A,05, 0008, ; Downwards gate shotblock
                        0000

; Room $AB8F. Huge jump room
$8F:8C2A             dx EEDB, 43,09, 003B, ; Missile tank
                        0000

; Room $ABD2. Grapple practice shaft
$8F:8C32             dx 0000

; Room $AC00. Single lake grapple practice room
$8F:8C34             dx 0000

; Room $AC2B. Grapple room
$8F:8C36             dx EF6B, 04,27, 003C, ; Grapple beam, chozo orb
                        0000

; Room $AC5A. Bubble Norfair reserve tank room
$8F:8C3E             dx EF7B, 02,07, 003D, ; Reserve tank, chozo orb
                        EF83, 07,0B, 003E, ; Missile tank, shot block
                        0000

; Room $AC83. Pre Bubble Norfair reserve tank room
$8F:8C4C             dx B703, 10,05, ACB0, ; Scroll PLM
                        EEDB, 14,0A, 003F, ; Missile tank
                        0000

; Room $ACB3. Bubble Norfair mainstreet
$8F:8C5A             dx C878, 01,06, 0053, ; Door. Green door facing right
                        C872, 1E,06, 0054, ; Door. Green door facing left
                        EEDB, 14,3C, 0040, ; Missile tank
                        0000

; Room $ACF0. Speed booster lavaquake
$8F:8C6E             dx B8AC, 00,00, 8000, ; Speed booster escape
                        EF83, BC,13, 0041, ; Missile tank, shot block
                        C88A, BE,16, 0055, ; Door. Red door facing left
                        0000

; Room $AD1B. Speed booster room
$8F:8C82             dx EF4B, 0B,06, 0042, ; Speed booster, chozo orb
                        0000

; Room $AD5E. Alcoon shaft
$8F:8C8A             dx B703, 0D,08, ADA7, ; Scroll PLM
                        B703, 10,08, ADAA, ; Scroll PLM
                        B647, 4D,0A, 8000, ; Upwards extension
                        B647, 4D,0B, 8000, ; Upwards extension
                        B703, 4D,0C, ADAA, ; Scroll PLM
                        C88A, 0E,16, 0056, ; Door. Red door facing left
                        0000

; Room $ADAD. Pre wave beam room
$8F:8CB0             dx C82A, 1A,05, 8000, ; Downwards closed gate
                        C836, 1A,05, 0000, ; Downwards gate shotblock
                        EEDB, 1F,09, 0043, ; Missile tank
                        C88A, 3E,06, 0057, ; Door. Red door facing left
                        0000

; Room $ADDE. Wave beam room
$8F:8CCA             dx EF4F, 0B,06, 0044, ; Wave beam, chozo orb
                        0000

; Room $AE07. Norfair sinking tripper hall
$8F:8CD2             dx 0000

; Room $AE32. Volcano room
$8F:8CD4             dx B703, 20,29, AE66, ; Scroll PLM
                        B703, 1F,29, AE6B, ; Scroll PLM
                        B647, 19,24, 8000, ; Upwards extension
                        B647, 19,25, 8000, ; Upwards extension
                        B647, 19,26, 8000, ; Upwards extension
                        B647, 19,27, 8000, ; Upwards extension
                        B647, 19,28, 8000, ; Upwards extension
                        B703, 19,29, AE6E, ; Scroll PLM
                        B647, 26,26, 8000, ; Upwards extension
                        B647, 26,27, 8000, ; Upwards extension
                        B647, 26,28, 8000, ; Upwards extension
                        B703, 26,29, AE71, ; Scroll PLM
                        0000

; Room $AE74. Pre lava dive shaft
$8F:8D1E             dx B703, 0F,17, AEA9, ; Scroll PLM
                        B703, 11,17, AEAC, ; Scroll PLM
                        B647, 08,15, 8000, ; Upwards extension
                        B647, 08,16, 8000, ; Upwards extension
                        B647, 08,17, 8000, ; Upwards extension
                        B703, 08,18, AEB1, ; Scroll PLM
                        C82A, 07,14, 8000, ; Downwards closed gate
                        C836, 07,14, 0000, ; Downwards gate shotblock
                        C860, 11,26, 0058, ; Door. Yellow door facing right
                        0000

; Room $AEB4. Magdollite multiviola hall
$8F:8D56             dx 0000

; Room $AEDF. Purple shaft
$8F:8D58             dx B703, 02,0B, AF0F, ; Scroll PLM
                        B63B, 03,0B, 8000, ; Rightwards extension
                        B63B, 04,0B, 8000, ; Rightwards extension
                        B703, 0B,0B, AF0F, ; Scroll PLM
                        B63B, 0C,0B, 8000, ; Rightwards extension
                        B63B, 0D,0B, 8000, ; Rightwards extension
                        0000

; Room $AF14. Lava dive room
$8F:8D7E             dx 0000

; Room $AF3F. Norfair -> Lower Norfair elevator
$8F:8D80             dx B703, 08,0B, AF6F, ; Scroll PLM
                        0000

; Room $AF72. Norfair wave gate room
$8F:8D88             dx C82A, 06,15, 8000, ; Downwards closed gate
                        C836, 06,15, 0000, ; Downwards gate shotblock
                        0000

; Room $AFA3. Norfair long lavaquake hall
$8F:8D96             dx 0000

; Room $AFCE. Norfair metal floor hall
$8F:8D98             dx 0000

; Room $AFFB. Norfair lava-spike hall
$8F:8D9A             dx 0000

; Room $B026. Norfair energy station
$8F:8D9C             dx B6DF, 07,0A, 0045, ; Energy station
                        0000

; Room $B051. Purple farming room
$8F:8DA4             dx 0000

; Room $B07A. Speed booster lavaquake farming room
$8F:8DA6             dx B703, 09,0C, B0A7, ; Scroll PLM
                        B63B, 0A,0C, 8000, ; Rightwards extension
                        B703, 09,10, B0AC, ; Scroll PLM
                        B63B, 0A,10, 8000, ; Rightwards extension
                        B703, 06,13, B0B1, ; Scroll PLM
                        B63B, 07,13, 8000, ; Rightwards extension
                        B63B, 08,13, 8000, ; Rightwards extension
                        B63B, 09,13, 8000, ; Rightwards extension
                        0000

; Room $B0B4. Norfair map station
$8F:8DD8             dx B6D3, 05,0A, 8000, ; Map station
                        0000

; Room $B0DD. Bubble Norfair save station
$8F:8DE0             dx B76F, 05,0B, 0001, ; Save station
                        0000

; Room $B106. Norfair speed blockade hall
$8F:8DE8             dx 0000

; Room $B139. Norfair stone zoomer shaft
$8F:8DEA             dx 0000

; Room $B167. Rock Norfair save station
$8F:8DEC             dx B76F, 07,0B, 0002, ; Save station
                        0000

; Room $B192. Pre Crocomire save station
$8F:8DF4             dx B76F, 07,0B, 0003, ; Save station
                        0000

; Room $B1BB. Pre Lower Norfair save station
$8F:8DFC             dx B76F, 05,0B, 0004, ; Save station
                        0000

; Room $B1E5. Lower Norfair chozo room
$8F:8E04             dx B703, 0C,1E, B224, ; Scroll PLM
                        B703, 0C,23, B22D, ; Scroll PLM
                        0000

; Room $B236. Lower Norfair mainstreet
$8F:8E12             dx B703, 47,08, B27D, ; Scroll PLM
                        B63B, 48,08, 8000, ; Rightwards extension
                        B703, 47,23, B27D, ; Scroll PLM
                        B63B, 48,23, 8000, ; Rightwards extension
                        B703, 47,29, B280, ; Scroll PLM
                        B63B, 48,29, 8000, ; Rightwards extension
                        B70B, 46,2A, 8000, ; Elevator platform
                        0000

; Room $B283. Golden Torizo
$8F:8E3E             dx B703, 04,0C, B2D1, ; Scroll PLM
                        B63B, 05,0C, 8000, ; Rightwards extension
                        B63B, 06,0C, 8000, ; Rightwards extension
                        B63B, 07,0C, 8000, ; Rightwards extension
                        B63B, 08,0C, 8000, ; Rightwards extension
                        B63B, 09,0C, 8000, ; Rightwards extension
                        B63B, 0A,0C, 8000, ; Rightwards extension
                        B63B, 0B,0C, 8000, ; Rightwards extension
                        EEDB, 0D,08, 0046, ; Missile tank
                        EF87, 15,08, 0047, ; Super missile tank, shot block
                        C842, 1E,16, 0859, ; Door. Grey door facing left
                        0000

; Room $B2DA. Ripper ii room
$8F:8E82             dx C82A, 34,05, 8000, ; Downwards closed gate
                        C836, 34,05, 0008, ; Downwards gate shotblock
                        0000

; Room $B305. Lower Norfair energy station
$8F:8E90             dx B6DF, 08,0A, 0048, ; Energy station
                        0000

; Room $B32E. Ridley
$8F:8E98             dx C842, 0E,06, 005A, ; Door. Grey door facing left
                        C848, 01,16, 005B, ; Door. Grey door facing right
                        0000

; Room $B37A. Pre Ridley hall
$8F:8EA6             dx DB4C, 01,06, 005C, ; Door. Eye door, facing right
                        DB52, 01,09, 005C, ; Eye door bottom, facing right
                        DB48, 01,07, 005C, ; Eye door eye, facing right
                        0000

; Room $B3A5. Pre pillars hall
$8F:8EBA             dx B703, 07,21, B3D9, ; Scroll PLM
                        B63B, 08,21, 8000, ; Rightwards extension
                        B703, 07,1B, B3DC, ; Scroll PLM
                        B63B, 08,1B, 8000, ; Rightwards extension
                        0000

; Room $B3E1. Unused room
$8F:8ED4             dx 0000

; Room $B40A. Lower Norfair multi-level one-way shaft
$8F:8ED6             dx B703, 30,16, B445, ; Scroll PLM
                        B703, 32,16, B448, ; Scroll PLM
                        B703, 2D,16, B44B, ; Scroll PLM
                        B647, 2B,14, 8000, ; Upwards extension
                        B647, 2B,15, 8000, ; Upwards extension
                        B647, 2B,16, 8000, ; Upwards extension
                        B703, 2B,17, B44E, ; Scroll PLM
                        B647, 38,36, 8000, ; Upwards extension
                        B647, 38,37, 8000, ; Upwards extension
                        B647, 38,38, 8000, ; Upwards extension
                        B703, 38,39, B451, ; Scroll PLM
                        B63B, 3D,34, 8000, ; Rightwards extension
                        B63B, 3C,34, 8000, ; Rightwards extension
                        B703, 3B,34, B454, ; Scroll PLM
                        C848, 01,36, 0C5D, ; Door. Grey door facing right
                        EEDB, 27,1B, 0049, ; Missile tank
                        0000

; Room $B457. Pillars hall
$8F:8F38             dx 0000

; Room $B482. Lower Norfair holtz room
$8F:8F3A             dx 0000

; Room $B4AD. Lower Norfair wall space pirates shaft
$8F:8F3C             dx B703, 03,10, B4E0, ; Scroll PLM
                        B63B, 04,10, 8000, ; Rightwards extension
                        B63B, 05,10, 8000, ; Rightwards extension
                        B63B, 06,10, 8000, ; Rightwards extension
                        B63B, 07,10, 8000, ; Rightwards extension
                        B63B, 08,10, 8000, ; Rightwards extension
                        B63B, 09,10, 8000, ; Rightwards extension
                        B63B, 0A,10, 8000, ; Rightwards extension
                        B63B, 0B,10, 8000, ; Rightwards extension
                        B63B, 0C,10, 8000, ; Rightwards extension
                        0000

; Room $B4E5. Lower Norfair rising acid room
$8F:8F7A             dx 0000

; Room $B510. Lower Norfair spring ball maze room
$8F:8F7C             dx B703, 0C,09, B547, ; Scroll PLM
                        B647, 0C,08, 8000, ; Upwards extension
                        B647, 0C,07, 8000, ; Upwards extension
                        B647, 0C,06, 8000, ; Upwards extension
                        B703, 03,12, B54E, ; Scroll PLM
                        B63B, 04,12, 8000, ; Rightwards extension
                        B63B, 05,12, 8000, ; Rightwards extension
                        B63B, 06,12, 8000, ; Rightwards extension
                        B63B, 07,12, 8000, ; Rightwards extension
                        B63B, 08,12, 8000, ; Rightwards extension
                        B63B, 09,12, 8000, ; Rightwards extension
                        B63B, 0A,12, 8000, ; Rightwards extension
                        B703, 2F,03, B555, ; Scroll PLM
                        EEDB, 2B,07, 004A, ; Missile tank
                        0000

; Room $B55A. Lower Norfair escape power bomb room
$8F:8FD2             dx EEE3, 0C,08, 004B, ; Power bomb tank
                        0000

; Room $B585. Lower Norfair south kihunter shaft
$8F:8FDA             dx B703, 11,48, B5C3, ; Scroll PLM
                        B63B, 09,46, 8000, ; Rightwards extension
                        B647, 08,46, 8000, ; Upwards extension
                        B703, 08,47, B5C8, ; Scroll PLM
                        B703, 1F,48, B5C3, ; Scroll PLM
                        B703, 24,48, B5C8, ; Scroll PLM
                        B703, 06,0E, B5CD, ; Scroll PLM
                        B63B, 07,0E, 8000, ; Rightwards extension
                        B63B, 08,0E, 8000, ; Rightwards extension
                        B63B, 09,0E, 8000, ; Rightwards extension
                        B703, 06,0B, B5D2, ; Scroll PLM
                        B63B, 07,0B, 8000, ; Rightwards extension
                        B63B, 08,0B, 8000, ; Rightwards extension
                        B63B, 09,0B, 8000, ; Rightwards extension
                        C866, 26,4D, 005E, ; Door. Yellow door facing up
                        0000

; Room $B5D5. Lower Norfair spike platform room
$8F:9036             dx B703, 17,0D, B612, ; Scroll PLM
                        B63B, 18,0D, 8000, ; Rightwards extension
                        B703, 15,08, B615, ; Scroll PLM
                        B63B, 16,08, 8000, ; Rightwards extension
                        B63B, 17,08, 8000, ; Rightwards extension
                        B63B, 18,08, 8000, ; Rightwards extension
                        B63B, 19,08, 8000, ; Rightwards extension
                        B63B, 1A,08, 8000, ; Rightwards extension
                        B703, 4F,09, B61A, ; Scroll PLM
                        B703, 51,09, B622, ; Scroll PLM
                        B703, 0F,0B, B61D, ; Scroll PLM
                        B703, 3C,09, B622, ; Scroll PLM
                        B703, 3F,09, B61A, ; Scroll PLM
                        B703, 14,07, B625, ; Scroll PLM
                        B647, 14,06, 8000, ; Upwards extension
                        B647, 14,05, 8000, ; Upwards extension
                        B647, 14,04, 8000, ; Upwards extension
                        B703, 09,09, B628, ; Scroll PLM
                        B647, 09,08, 8000, ; Upwards extension
                        B647, 09,07, 8000, ; Upwards extension
                        B647, 09,06, 8000, ; Upwards extension
                        B647, 09,05, 8000, ; Upwards extension
                        C878, 11,26, 005F, ; Door. Green door facing right
                        EEE3, 07,08, 004C, ; Power bomb tank
                        0000

; Room $B62B. Ninja space pirate hall
$8F:90C8             dx C848, 01,06, 0C60, ; Door. Grey door facing right
                        0000

; Room $B656. Lower Norfair north kihunter shaft
$8F:90D0             dx B703, 0B,2A, B68D, ; Scroll PLM
                        B647, 0B,29, 8000, ; Upwards extension
                        B647, 0B,28, 8000, ; Upwards extension
                        B647, 0B,27, 8000, ; Upwards extension
                        B647, 0B,26, 8000, ; Upwards extension
                        B647, 0B,25, 8000, ; Upwards extension
                        B703, 0F,2A, B690, ; Scroll PLM
                        B703, 14,2A, B695, ; Scroll PLM
                        EEDB, 08,29, 004D, ; Missile tank
                        0000

; Room $B698. Ridley's energy tank
$8F:9108             dx EF7F, 0E,0B, 004E, ; Energy tank, shot block
                        0000

; Room $B6C1. Screw attack room
$8F:9110             dx EF73, 0B,28, 004F, ; Screw attack, chozo orb
                        0000

; Room $B6EE. Norfair rolling boulder shaft
$8F:9118             dx B647, 1F,36, 8000, ; Upwards extension
                        B647, 1F,37, 8000, ; Upwards extension
                        B703, 1F,38, B72D, ; Scroll PLM
                        B63B, 2D,39, 8000, ; Rightwards extension
                        B63B, 2C,39, 8000, ; Rightwards extension
                        B703, 2B,39, B730, ; Scroll PLM
                        B647, 0F,06, 8000, ; Upwards extension
                        B647, 0F,07, 8000, ; Upwards extension
                        B647, 0F,08, 8000, ; Upwards extension
                        B703, 0F,09, B737, ; Scroll PLM
                        B63B, 1B,0B, 8000, ; Rightwards extension
                        B63B, 1A,0B, 8000, ; Rightwards extension
                        B63B, 19,0B, 8000, ; Rightwards extension
                        B63B, 18,0B, 8000, ; Rightwards extension
                        B63B, 17,0B, 8000, ; Rightwards extension
                        B63B, 16,0B, 8000, ; Rightwards extension
                        B63B, 15,0B, 8000, ; Rightwards extension
                        B703, 14,0B, B73C, ; Scroll PLM
                        EED7, 2A,51, 0050, ; Energy tank
                        0000

; Room $B741. Lower Norfair save station
$8F:918C             dx B76F, 07,0B, 0005, ; Save station
                        0000
}


;;; $9194..F7: Room setup ASM ;;;
{
;;; $9194: Room setup ASM - clear Crateria mainstreet escape passage if critters escaped and shake screen ;;;
{
; Room $92FD, state $9348. Crateria mainstreet - event "Zebes timebomb set" is set
$8F:9194 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:9198             dx  3D, 0B, BB30       ;} Spawn PLM to clear Crateria mainstreet escape passage if critters escaped
$8F:919C A9 18 00    LDA #$0018             ;\
$8F:919F 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1, BG2 and enemies, 3 pixel displacement, horizontal
$8F:91A2 A9 FF FF    LDA #$FFFF             ;\
$8F:91A5 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = FFFFh
$8F:91A8 60          RTS
}


;;; $91A9: Room setup ASM - make old Tourian escape shaft fake wall explode ;;;
{
; Room $96BA, state $9705. Old Tourian escape shaft - event "Zebes timebomb set" is set
$8F:91A9 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:91AD             dx  10, 87, B964       ;} Spawn PLM to make old Tourian escape shaft fake wall explode
$8F:91B1 60          RTS
}


;;; $91B2: Room setup ASM - spawn critters escape block ;;;
{
; Room $9804, state $984F. Bomb Torizo - event "Zebes timebomb set" is set
$8F:91B2 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:91B6             dx  0F, 0A, B9ED       ;} Spawn critters escape block PLM
$8F:91BA 60          RTS
}


;;; $91BB: RTS. Room setup ASM ;;;
{
; Room $9879, state $98C4. Pre Bomb Torizo hall - event "Zebes timebomb set" is set
$8F:91BB 60          RTS
}


;;; $91BC: RTS. Room setup ASM ;;;
{
; Room $92FD, state $932E. Crateria mainstreet      - event "Zebes is awake" is set
; Room $96BA, state $96EB. Old Tourian escape shaft - event "Zebes is awake" is set
; Room $975C, state $9787. Old Mother Brain room              - morph ball and missiles have been collected
; Room $97B5, state $97E0. Crateria -> Blue Brinstar elevator - morph ball and missiles have been collected
; Room $9E9F, state $9ECB. Morph ball room                   - event "Zebes is awake" is set
; Room $9F11, state $9F3D. Old Kraid entrance                - event "Zebes is awake" is set
; Room $9F64, state $9F90. Blue Brinstar ceiling e-tank hall - event "Zebes is awake" is set
$8F:91BC 60          RTS
}


;;; $91BD: Room setup ASM - scrolling sky land, shake screen ;;;
{
; Room $91F8, state $9261. Landing site - event "Zebes timebomb set" is set
$8F:91BD A9 06 00    LDA #$0006             ;\
$8F:91C0 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 3 pixel displacement, horizontal
$8F:91C3 A9 FF FF    LDA #$FFFF             ;\
$8F:91C6 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = FFFFh
}


;;; $91C9: Room setup ASM - scrolling sky land ;;;
{
; Room $91F8, state $9213. Landing site - default
; Room $91F8, state $922D. Landing site - event "Zebes is awake" is set
; Room $91F8, state $9247. Landing site - power bombs have been collected
$8F:91C9 22 D8 A7 88 JSL $88A7D8[$88:A7D8]  ; Spawn scrolling sky land HDMA object
$8F:91CD 60          RTS
}


;;; $91CE: Room setup ASM - scrolling sky ocean ;;;
{
; Room $93FE. Wrecked Ship entrance
; Room $94FD. Wrecked Ship back door
; Room $968F. Orange zoomer hall
$8F:91CE 22 00 A8 88 JSL $88A800[$88:A800]  ; Spawn scrolling sky ocean HDMA object
$8F:91D2 60          RTS
}


;;; $91D3: RTS. Room setup ASM ;;;
{
; Room $92B3. Gauntlet east
; Room $92FD, state $9314. Crateria mainstreet - default
; Room $93AA. Landing site power bombs cave
; Room $93D5. Crateria save station
; Room $9461. Pre orange zoomer hall
; Room $948C. Pre moat room
; Room $94CC. Crateria -> Maridia elevator
; Room $9552. Forgotten highway kago shaft
; Room $957D. Crab maze
; Room $95A8. Forgotten highway elbow
; Room $95D4. Crateria tube
; Room $95FF. Moat
; Room $962A. Crateria -> Red Brinstar elevator
; Room $965B. Gauntlet west
$8F:91D3 60          RTS
}


;;; $91D4: RTS. Room setup ASM ;;;
{
; Room $96BA, state $96D1. Old Tourian escape shaft - default
; Room $975C, state $976D. Old Mother Brain room - default
; Room $97B5, state $97C6. Crateria -> Blue Brinstar elevator - default
; Room $9804, state $981B. Bomb Torizo - default
; Room $9804, state $9835. Bomb Torizo - area torizo is dead
; Room $9879, state $9890. Pre Bomb Torizo hall - default
; Room $9879, state $98AA. Pre Bomb Torizo hall - area torizo is dead
; Room $98E2. Pre Crateria map station hall
; Room $990D. Crateria slope
; Room $9938. Crateria -> Green Brinstar elevator
; Room $9969. West Crateria kago hall
; Room $9994. Crateria map station
; Room $99BD. Crateria space pirate shaft
; Room $99F9. Crateria spike floor room
; Room $9A44. Crateria bomb block hall
; Room $9A90. Crateria chozo missile
$8F:91D4 60          RTS
}


;;; $91D5: RTS. Room setup ASM ;;;
{
; Room $9AD9. Green Brinstar mainstreet
; Room $9B5B. Spore Spawn's super missile shaft
; Room $9B9D. Pre Brinstar map room hall
; Room $9BC8. Early supers room
; Room $9C07. Brinstar reserve tank room
; Room $9C35. Brinstar map station
; Room $9C5E. Fireflea room
; Room $9C89. Green Brinstar missile station
; Room $9CB3. Dachora room
; Room $9D19. Charge beam room
; Room $9D9C. Pre Spore Spawn hall
; Room $9DC7. Spore Spawn
; Room $9E11. Brinstar super-sidehopper power bomb room
; Room $9E52. Brinstar diagonal room
; Room $9E9F, state $9EB1. Morph ball room - default
; Room $9F11, state $9F23. Old Kraid entrance - default
; Room $9F64, state $9F76. Blue Brinstar ceiling e-tank hall - default
; Room $9FBA. n00b bridge
; Room $9FE5. Etecoon area beetom room
; Room $A011. Etecoon area spike hall
; Room $A051. Etecoon area super missiles
; Room $A07B. Dachora energy station
; Room $A0A4. Post Spore Spawn supers hall
; Room $A0D2. Pink Brinstar flooded hall
; Room $A107. Blue Brinstar missile room
; Room $A130. Brinstar wave-gate sidehopper room
; Room $A15B. Brinstar wave-gate energy tank
; Room $A184. Spore Spawn save station
; Room $A1AD. Blue Brinstar boulder room
; Room $A1D8. Blue Brinstar double missile room
; Room $A201. Green Brinstar mainstreet save station
; Room $A22A. Etecoon area save station
$8F:91D5 60          RTS
}


;;; $91D6: RTS. Room setup ASM ;;;
{
; Room $A253. Red Brinstar mainstreet
; Room $A293. Pre x-ray spike hall
; Room $A2CE. X-ray room
; Room $A2F7. Red Brinstar damage boost hall
; Room $A322. Red Brinstar -> Crateria elevator
; Room $A37C. Red Brinstar power bomb floor room
; Room $A3AE. Red Brinstar power bomb wall room
; Room $A3DD. Red Brinstar skree-duo hall
; Room $A408. Pre spazer room
; Room $A447. Spazer room
; Room $A471. Kraid's lair zeela room
; Room $A4B1. Kraid's lair beetom room
; Room $A4DA. Kraid's lair kihunter hall
; Room $A521. Fake Kraid's room
; Room $A56B. Pre Kraid room
; Room $A59F. Kraid
; Room $A5ED. Pre Tourian entrance hall
; Room $A618. Red Brinstar energy station
; Room $A641. Kraid's lair refill station
$8F:91D6 60          RTS
}


;;; $91D7: Room setup ASM - run statue unlocking animations ;;;
{
; Room $A66A. Tourian entrance
$8F:91D7 A0 58 85    LDY #$8558             ;\
$8F:91DA 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn Tourian statue - Kraid animated tiles object
$8F:91DE A0 4C 85    LDY #$854C             ;\
$8F:91E1 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn Tourian statue - Phantoon animated tiles object
$8F:91E5 A0 5E 85    LDY #$855E             ;\
$8F:91E8 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn Tourian statue - Draygon animated tiles object
$8F:91EC A0 52 85    LDY #$8552             ;\
$8F:91EF 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn Tourian statue - Ridley animated tiles object
$8F:91F3 60          RTS
}


;;; $91F4: RTS. Room setup ASM ;;;
{
; Room $A6A1. Kraid's lair entrance
; Room $A6E2. Varia suit room
; Room $A70B. Kraid's lair save station
; Room $A734. Red Brinstar save station
$8F:91F4 60          RTS
}


;;; $91F5: RTS. Room setup ASM ;;;
{
; Room $A75D. Ice beam tripper hall
; Room $A788. Lava missile room
; Room $A7B3. First hot room
; Room $A7DE. Norfair mainstreet
; Room $A815. Ice beam mockball hall
; Room $A865. Ice beam practice room
; Room $A890. Ice beam room
; Room $A8B9. Pre ice beam shaft
; Room $A8F8. Crumble block platform shaft
; Room $A923. Norfair slope
$8F:91F5 60          RTS
}


;;; $91F6: RTS. Room setup ASM ;;;
{
; Room $A98D. Crocomire
; Room $A9E5. Hi-jump room
; Room $AA0E. Norfair grapple ceiling room
; Room $AA41. Pre hi-jump room
; Room $AA82. Post Crocomire room
; Room $AAB5. Post Crocomire save station
; Room $AADE. Post Crocomire power bombs room
; Room $AB07. Post Crocomire shaft
; Room $AB3B. Post Crocomire tidal acid cave
; Room $AB64. Double lake grapple practice room
; Room $AB8F. Huge jump room
; Room $ABD2. Grapple practice shaft
; Room $AC00. Single lake grapple practice room
; Room $AC2B. Grapple room
; Room $AC5A. Bubble Norfair reserve tank room
; Room $AC83. Pre Bubble Norfair reserve tank room
; Room $ACB3. Bubble Norfair mainstreet
; Room $ACF0. Speed booster lavaquake
; Room $AD1B. Speed booster room
; Room $AD5E. Alcoon shaft
; Room $ADAD. Pre wave beam room
; Room $ADDE. Wave beam room
; Room $AE07. Norfair sinking tripper hall
; Room $AE32. Volcano room
; Room $AE74. Pre lava dive shaft
; Room $AEB4. Magdollite multiviola hall
; Room $AEDF. Purple shaft
; Room $AF14. Lava dive room
; Room $AF3F. Norfair -> Lower Norfair elevator
; Room $AF72. Norfair wave gate room
; Room $AFA3. Norfair long lavaquake hall
; Room $AFCE. Norfair metal floor hall
; Room $AFFB. Norfair lava-spike hall
; Room $B026. Norfair energy station
; Room $B051. Purple farming room
; Room $B07A. Speed booster lavaquake farming room
; Room $B0B4. Norfair map station
; Room $B0DD. Bubble Norfair save station
; Room $B106. Norfair speed blockade hall
; Room $B139. Norfair stone zoomer shaft
; Room $B167. Rock Norfair save station
; Room $B192. Pre Crocomire save station
$8F:91F6 60          RTS
}


;;; $91F7: RTS. Room setup ASM ;;;
{
; Room $B1E5. Lower Norfair chozo room
; Room $B236. Lower Norfair mainstreet
; Room $B283. Golden Torizo
; Room $B2DA. Ripper ii room
; Room $B305. Lower Norfair energy station
; Room $B32E. Ridley
; Room $B37A. Pre Ridley hall
; Room $B3A5. Pre pillars hall
; Room $B3E1. Unused room
; Room $B40A. Lower Norfair multi-level one-way shaft
; Room $B457. Pillars hall
; Room $B482. Lower Norfair holtz room
; Room $B4AD. Lower Norfair wall space pirates shaft
; Room $B4E5. Lower Norfair rising acid room
; Room $B510. Lower Norfair spring ball maze room
; Room $B55A. Lower Norfair escape power bomb room
; Room $B585. Lower Norfair south kihunter shaft
; Room $B5D5. Lower Norfair spike platform room
; Room $B62B. Ninja space pirate hall
; Room $B656. Lower Norfair north kihunter shaft
; Room $B698. Ridley's energy tank
; Room $B6C1. Screw attack room
$8F:91F7 60          RTS
}
}


;;; $91F8: Room headers, scroll data, door lists ;;;
{
; Room header format:
;      __________________________________________ Room index
;     |   _______________________________________ Area index
;     |  |    ___________________________________ X position (of top left corner) on the map
;     |  |   |   ________________________________ Y position (of top left corner) on the map
;     |  |   |  |    ____________________________ Room width (in units of screens = 16 blocks = 256 pixels)
;     |  |   |  |   |   _________________________ Room height (in units of screens = 16 blocks = 256 pixels)
;     |  |   |  |   |  |    _____________________ Up scroller
;     |  |   |  |   |  |   |   __________________ Down scroller
;     |  |   |  |   |  |   |  |    ______________ CRE bitset
;     |  |   |  |   |  |   |  |   |    __________ Door list pointer
;     |  |   |  |   |  |   |  |   |   |      ____ State conditions list
;     |  |   |  |   |  |   |  |   |   |     |
;     ii,aa, xx,yy, ww,hh, uu,dd, cc, dddd, [...]

; State conditions list format:
;      ______________ State condition
;     |     _________ State condition parameters
;     |    |      ___ State header pointer
;     |    |     |
;     eeee [...] ssss ; First state condition
;     eeee [...] ssss ; Second state condition
;     [...]           ; Other state conditions
;     E5E6            ; Default state condition (terminator)

; State header format:
;      ___________________________________________________________________________ Level data
;     |        ___________________________________________________________________ Tileset
;     |       |    _______________________________________________________________ Music data index
;     |       |   |   ____________________________________________________________ Music track
;     |       |   |  |    ________________________________________________________ FX ($83)
;     |       |   |  |   |      __________________________________________________ Enemy population ($A1)
;     |       |   |  |   |     |      ____________________________________________ Enemy set ($B4)
;     |       |   |  |   |     |     |      ______________________________________ Layer 2 scroll X
;     |       |   |  |   |     |     |     |   ___________________________________ Layer 2 scroll Y
;     |       |   |  |   |     |     |     |  |    _______________________________ Scroll
;     |       |   |  |   |     |     |     |  |   |      _________________________ Special x-ray blocks
;     |       |   |  |   |     |     |     |  |   |     |      ___________________ Main ASM
;     |       |   |  |   |     |     |     |  |   |     |     |      _____________ PLM population
;     |       |   |  |   |     |     |     |  |   |     |     |     |      _______ Library background
;     |       |   |  |   |     |     |     |  |   |     |     |     |     |      _ Setup ASM
;     |       |   |  |   |     |     |     |  |   |     |     |     |     |     |
;     llllll, tt, MM,mm, ffff, eeee, EEEE, xx,yy, ssss, xxxx, AAAA, pppp, bbbb, aaaa

; Room header. Landing site
$8F:91F8             dx 00,00, 17,00, 09,05, 70,A0, 00, 927B, E612,0E,9261, E669,9247, E612,00,922D, E5E6

; State header. Room $91F8. Landing site - default
$8F:9213             dx C2C2BB, 00, 06,05, 80C0, 883D, 8193, 81,01, 9283, 0000, C116, 8000, B76A, 91C9

; State header. Room $91F8. Landing site - event "Zebes is awake" is set
$8F:922D             dx C2C2BB, 00, 06,06, 80C0, 883D, 8193, 81,01, 9283, 0000, C116, 8000, B76A, 91C9

; State header. Room $91F8. Landing site - power bombs have been collected
$8F:9247             dx C2C2BB, 00, 0C,05, 80D0, 883D, 8193, 81,01, 9283, 0000, C116, 8000, B76A, 91C9

; State header. Room $91F8. Landing site - event "Zebes timebomb set" is set
$8F:9261             dx C2C2BB, 00, 00,00, 8000, 8C0D, 8283, 81,01, 9283, 0000, C120, 8026, B76A, 91BD

; Door list. Room $91F8. Landing site
$8F:927B             dw 8916, 8922, 892E, 893A

; Scroll data. Room $91F8. Landing site
$8F:9283             db 00, 00, 02, 02, 02, 02, 02, 02, 02, 00, 00, 02, 02, 02, 02, 02, 02, 02, 01, 00, 02, 02, 02, 02, 02, 02, 02, 00, 00, 02, 02, 02, 02, 02, 02, 02, 01, 01, 01, 01, 01, 01, 01, 01, 01

; PLM scroll data. Room $91F8. Landing site (PLM index 0)
$8F:92B0             db 13,01, 80

; Room header. Gauntlet east
$8F:92B3             dx 01,00, 12,02, 05,01, 70,A0, 00, 92F9, E612,00,92DF, E5E6

; State header. Room $92B3. Gauntlet east - default
$8F:92C5             dx C2D6E8, 00, 00,00, 80E0, 847A, 80A1, C1,C1, 0000, 0000, 0000, 8058, B899, 91D3

; State header. Room $92B3. Gauntlet east - event "Zebes is awake" is set
$8F:92DF             dx C2D6E8, 00, 09,05, 80E0, 847A, 80A1, C1,C1, 0000, 0000, 0000, 8058, B899, 91D3

; Door list. Room $92B3. Gauntlet east
$8F:92F9             dw 8946, 8952

; Room header. Crateria mainstreet
$8F:92FD             dx 02,00, 12,04, 05,05, 70,A0, 00, 9362, E612,0E,9348, E612,00,932E, E5E6

; State header. Room $92FD. Crateria mainstreet - default
$8F:9314             dx C2DBC4, 00, 00,00, 80F0, 86FA, 8185, C1,C1, 9370, 0000, 0000, 805A, B8B4, 91D3

; State header. Room $92FD. Crateria mainstreet - event "Zebes is awake" is set
$8F:932E             dx C2DBC4, 00, 09,05, 8050, 8261, 8067, C1,C1, 9370, 0000, 0000, 805A, B8B4, 91BC

; State header. Room $92FD. Crateria mainstreet - event "Zebes timebomb set" is set
$8F:9348             dx C2DBC4, 00, 00,00, 8010, 8DA0, 8295, C1,C1, 9370, 0000, C124, 8104, B8B4, 9194

; Door list. Room $92FD. Crateria mainstreet
$8F:9362             dw 895E, 896A, 8976, 8982, 898E, 899A, 89A6

; Scroll data. Room $92FD. Crateria mainstreet
$8F:9370             db 00, 01, 01, 01, 01, 00, 00, 00, 00, 00, 00, 02, 00, 01, 00, 00, 02, 00, 00, 00, 00, 02, 00, 00, 00

; PLM scroll data. Room $92FD. Crateria mainstreet (PLM index 0)
$8F:9389             db 08,02, 80

; PLM scroll data. Room $92FD. Crateria mainstreet (PLM index 1)
$8F:938C             db 08,00, 80

; PLM scroll data. Room $92FD. Crateria mainstreet (PLM index 2)
$8F:938F             db 00,00, 02,00, 06,02, 80

; PLM scroll data. Room $92FD. Crateria mainstreet (PLM index 6)
$8F:9396             db 06,00, 80

; PLM scroll data. Room $92FD. Crateria mainstreet (PLM index Ah)
$8F:9399             db 00,01, 80

; PLM scroll data. Room $92FD. Crateria mainstreet (PLM index Dh)
$8F:939C             db 02,01, 80

; PLM scroll data. Room $92FD. Crateria mainstreet (PLM indices 13h/14h)
$8F:939F             db 04,01, 80

; PLM scroll data. Room $92FD. Crateria mainstreet (PLM index 15h)
$8F:93A2             db 04,00, 80

; PLM scroll data. Room $92FD. Crateria mainstreet (PLM index 1Ah)
$8F:93A5             db 04,00, 08,02, 80

; Room header. Landing site power bombs cave
$8F:93AA             dx 03,00, 20,01, 02,01, 70,A0, 00, 93D1, E5E6

; State header. Room $93AA. Landing site power bombs cave - default
$8F:93B7             dx C2E977, 00, 00,00, 8100, 80D5, 801F, C1,C1, 93D3, 0000, C116, 81CC, B8B4, 91D3

; Door list. Room $93AA. Landing site power bombs cave
$8F:93D1             dw 89B2

; Scroll data. Room $93AA. Landing site power bombs cave
$8F:93D3             db 01, 01

; Room header. Crateria save station
$8F:93D5             dx 04,00, 12,06, 01,01, 70,A0, 00, 93FC, E5E6

; State header. Room $93D5. Crateria save station - default
$8F:93E2             dx CE92CB, 19, 09,05, 8110, 85D8, 8129, 00,00, 0000, 0000, 0000, 81D4, 0000, 91D3

; Door list. Room $93D5. Crateria save station
$8F:93FC             dw 89BE

; Room header. Wrecked Ship entrance
$8F:93FE             dx 05,00, 26,00, 08,06, 90,A0, 00, 9425, E5E6

; State header. Room $93FE. Wrecked Ship entrance - default
$8F:940B             dx C2EB45, 00, 0C,05, 8112, 8684, 8161, 81,01, 9431, 0000, C11B, 81DC, B7AE, 91CE

; Door list. Room $93FE. Wrecked Ship entrance
$8F:9425             dw 89CA, 89D6, 89E2, 89EE, 89FA, 8A06

; Scroll data. Room $93FE. Wrecked Ship entrance
$8F:9431             db 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 00, 00, 02, 00, 00, 02, 02, 02, 02, 02, 02, 00, 00, 02, 02, 02, 02, 02, 02, 02, 02, 01, 01, 01, 01, 01, 01, 01, 01

; Room header. Pre orange zoomer hall
$8F:9461             dx 06,00, 29,02, 02,01, 70,A0, 00, 9488, E5E6

; State header. Room $9461. Pre orange zoomer hall - default
$8F:946E             dx C38E1F, 00, 00,00, 8122, 897C, 81E1, C1,C1, 0000, 0000, 0000, 81FC, B899, 91D3

; Door list. Room $9461. Pre orange zoomer hall
$8F:9488             dw 8A12, 8A1E

; Room header. Pre moat room
$8F:948C             dx 07,00, 21,04, 03,03, 70,A0, 00, 94B3, E5E6

; State header. Room $948C. Pre moat room - default
$8F:9499             dx C38FFE, 00, 00,05, 8132, 8F19, 82BF, C1,C1, 94B9, 0000, 0000, 81FE, B8B4, 91D3

; Door list. Room $948C. Pre moat room
$8F:94B3             dw 8A2A, 8A36, 8A42

; Scroll data. Room $948C. Pre moat room
$8F:94B9             db 01, 01, 01, 00, 00, 00, 00, 02, 00

; PLM scroll data. Room $948C. Pre moat room (PLM index 0)
$8F:94C2             db 01,02, 04,02, 80

; PLM scroll data. Room $948C. Pre moat room (PLM index 2)
$8F:94C7             db 01,01, 04,00, 80

; Room header. Crateria -> Maridia elevator
$8F:94CC             dx 08,00, 34,0A, 01,01, 70,A0, 00, 94F3, E5E6

; State header. Room $94CC. Crateria -> Maridia elevator - default
$8F:94D9             dx C39BFC, 02, 09,03, 8142, 8B74, 8255, C1,C1, 94F9, 0000, 0000, 8230, B93B, 91D3

; Door list. Room $94CC. Crateria -> Maridia elevator
$8F:94F3             dw 8A4E, 8A5A, 88FC

; Scroll data. Room $94CC. Crateria -> Maridia elevator
$8F:94F9             db 01

; PLM scroll data. Room $94CC. Crateria -> Maridia elevator (PLM index 0)
$8F:94FA             db 00,02, 80

; Room header. Wrecked Ship back door
$8F:94FD             dx 09,00, 31,00, 07,06, 70,A0, 00, 9524, E5E6

; State header. Room $94FD. Wrecked Ship back door - default
$8F:950A             dx C39DB8, 00, 0C,05, 8144, 8002, 8009, 81,01, 9528, 0000, C11B, 8238, B7F2, 91CE

; Door list. Room $94FD. Wrecked Ship back door
$8F:9524             dw 8A66, 8A72

; Scroll data. Room $94FD. Wrecked Ship back door
$8F:9528             db 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 02, 02, 02, 02, 02, 02, 02, 01, 01, 01, 01, 01, 01, 01

; Room header. Forgotten highway kago shaft
$8F:9552             dx 0A,00, 38,04, 01,04, 70,A0, 00, 9579, E5E6

; State header. Room $9552. Forgotten highway kago shaft - default
$8F:955F             dx C3ACDB, 00, 00,00, 8154, 8B3E, 823D, C1,C1, 0001, 0000, 0000, 823A, B87E, 91D3

; Door list. Room $9552. Forgotten highway kago shaft
$8F:9579             dw 8A7E, 8A8A

; Room header. Crab maze
$8F:957D             dx 0B,00, 35,08, 04,02, 90,A0, 00, 95A4, E5E6

; State header. Room $957D. Crab maze - default
$8F:958A             dx C3B1BA, 00, 00,00, 8156, 8AB8, 8221, C1,C1, 0001, 0000, 0000, 823C, B8B4, 91D3

; Door list. Room $957D. Crab maze
$8F:95A4             dw 8A96, 8AAE

; Room header. Forgotten highway elbow
$8F:95A8             dx 0C,00, 34,09, 01,01, 70,A0, 00, 95CF, E5E6

; State header. Room $95A8. Forgotten highway elbow - default
$8F:95B5             dx C3BB9B, 00, 00,05, 8166, 85DB, 8133, C1,C1, 95D3, 0000, 0000, 823E, B87E, 91D3

; Door list. Room $95A8. Forgotten highway elbow
$8F:95CF             dw 8AA2, 8ABA

; Scroll data. Room $95A8. Forgotten highway elbow
$8F:95D3             db 02

; Room header. Crateria tube
$8F:95D4             dx 0D,00, 20,04, 01,01, 70,A0, 00, 95FB, E5E6

; State header. Room $95D4. Crateria tube - default
$8F:95E1             dx C3BCD2, 00, 00,00, 8168, 8B3B, 8233, 00,00, 0000, 0000, 0000, 8246, 0000, 91D3

; Door list. Room $95D4. Crateria tube
$8F:95FB             dw 8AC6, 8AD2

; Room header. Moat
$8F:95FF             dx 0E,00, 24,04, 02,02, 90,A0, 00, 9626, E5E6

; State header. Room $95FF. Moat - default
$8F:960C             dx C3BD6D, 00, 00,00, 816A, 85DE, 8141, C1,C1, 0000, 0000, 0000, 8248, B8B4, 91D3

; Door list. Room $95FF. Moat
$8F:9626             dw 8ADE, 8AEA

; Room header. Crateria -> Red Brinstar elevator
$8F:962A             dx 0F,00, 22,07, 01,01, 70,A0, 00, 9651, E5E6

; State header. Room $962A. Crateria -> Red Brinstar elevator - default
$8F:9637             dx C3C145, 02, 00,03, 817A, 89DF, 81F3, C1,C1, 9657, 0000, 0000, 8250, B93B, 91D3

; Door list. Room $962A. Crateria -> Red Brinstar elevator
$8F:9651             dw 8AF6, 8B02, 88FC

; Scroll data. Room $962A. Crateria -> Red Brinstar elevator
$8F:9657             db 01

; PLM scroll data. Room $962A. Crateria -> Red Brinstar elevator (PLM index 0)
$8F:9658             db 00,02, 80

; Room header. Gauntlet west
$8F:965B             dx 10,00, 0C,02, 06,01, 70,A0, 00, 9682, E5E6

; State header. Room $965B. Gauntlet west - default
$8F:9668             dx C3C301, 00, 00,00, 817C, 89F2, 81FD, C1,C1, 9686, 0000, 0000, 825E, B899, 91D3

; Door list. Room $965B. Gauntlet west
$8F:9682             dw 8B0E, 8B1A

; Scroll data. Room $965B. Gauntlet west
$8F:9686             db 01, 01, 01, 01, 00, 01

; PLM scroll data. Room $965B. Gauntlet west (PLM index 0)
$8F:968C             db 04,01, 80

; Room header. Orange zoomer hall
$8F:968F             dx 11,00, 2B,02, 01,01, 70,A0, 00, 96B6, E5E6

; State header. Room $968F. Orange zoomer hall - default
$8F:969C             dx C3C80C, 00, 0C,05, 818C, 88B6, 81C1, 81,01, 0000, 0000, C11B, 826C, B80A, 91CE

; Door list. Room $968F. Orange zoomer hall
$8F:96B6             dw 8B26, 8B32

; Room header. Old Tourian escape shaft
$8F:96BA             dx 12,00, 12,09, 03,09, 70,A0, 00, 971F, E612,0E,9705, E612,00,96EB, E5E6

; State header. Room $96BA. Old Tourian escape shaft - default
$8F:96D1             dx C3C998, 03, 00,00, 818E, 85E1, 814F, C1,C1, 9729, 0000, 0000, 826E, B905, 91D4

; State header. Room $96BA. Old Tourian escape shaft - event "Zebes is awake" is set
$8F:96EB             dx C3C998, 02, 09,05, 8060, 88C9, 81D3, C1,C1, 9729, 0000, 0000, 826E, B905, 91BC

; State header. Room $96BA. Old Tourian escape shaft - event "Zebes timebomb set" is set
$8F:9705             dx C3C998, 02, 24,07, 8020, 85B2, 8111, C1,C1, 9729, 0000, C124, 830C, B905, 91A9

; Door list. Room $96BA. Old Tourian escape shaft
$8F:971F             dw 8B3E, 8B4A, 8B56, 8B62, 8B6E

; Scroll data. Room $96BA. Old Tourian escape shaft
$8F:9729             db 00, 02, 00, 00, 02, 00, 00, 02, 00, 00, 02, 00, 00, 02, 00, 00, 02, 00, 00, 02, 00, 00, 02, 00, 00, 01, 00

; PLM scroll data. Room $96BA. Old Tourian escape shaft (PLM index 1)
$8F:9744             db 02,01, 80

; PLM scroll data. Room $96BA. Old Tourian escape shaft (PLM index 0)
$8F:9747             db 02,00, 80

; PLM scroll data. Room $96BA. Old Tourian escape shaft (PLM index 3)
$8F:974A             db 17,01, 80

; PLM scroll data. Room $96BA. Old Tourian escape shaft (PLM index 2)
$8F:974D             db 17,00, 80

; PLM scroll data. Room $96BA. Old Tourian escape shaft (PLM index Eh)
$8F:9750             db 18,01, 80

; PLM scroll data. Room $96BA. Old Tourian escape shaft (PLM index Ah)
$8F:9753             db 18,00, 80

; PLM scroll data. Room $96BA. Old Tourian escape shaft (PLM index 12h)
$8F:9756             db 19,01, 80

; PLM scroll data. Room $96BA. Old Tourian escape shaft (PLM index 16h)
$8F:9759             db 19,00, 80

; Room header. Old Mother Brain room
$8F:975C             dx 13,00, 14,11, 03,02, 70,A0, 00, 97A1, E652,9787, E5E6

; State header. Room $975C. Old Mother Brain room - default
$8F:976D             dx C3D9F7, 03, 00,05, 819E, 8A15, 820F, C1,C1, 97A5, 0000, 0000, 83B6, B905, 91D4

; State header. Room $975C. Old Mother Brain room - morph ball and missiles have been collected
$8F:9787             dx C3D9F7, 02, 09,05, 8080, 8427, 808F, C1,C1, 97A5, 0000, 0000, 83D0, B905, 91BC

; Door list. Room $975C. Old Mother Brain room
$8F:97A1             dw 8B7A, 8B86

; Scroll data. Room $975C. Old Mother Brain room
$8F:97A5             db 01, 01, 01, 00, 00, 00

; PLM scroll data. Room $975C. Old Mother Brain room (PLM indices 0/1)
$8F:97AB             db 00,02, 03,02, 80

; PLM scroll data. Room $975C. Old Mother Brain room (PLM index 2)
$8F:97B0             db 00,01, 03,00, 80

; Room header. Crateria -> Blue Brinstar elevator
$8F:97B5             dx 14,00, 17,11, 01,01, 70,A0, 00, 97FA, E652,97E0, E5E6

; State header. Room $97B5. Crateria -> Blue Brinstar elevator - default
$8F:97C6             dx C3DF23, 02, 06,05, 81AE, 8B61, 824B, 00,00, 9800, 0000, 0000, 83F6, 0000, 91D4

; State header. Room $97B5. Crateria -> Blue Brinstar elevator - morph ball and missiles have been collected
$8F:97E0             dx C3DF23, 02, 00,03, 8090, 8B61, 824B, 00,00, 9800, 0000, 0000, 83F6, 0000, 91BC

; Door list. Room $97B5. Crateria -> Blue Brinstar elevator
$8F:97FA             dw 8B92, 8B9E, 88FC

; Scroll data. Room $97B5. Crateria -> Blue Brinstar elevator
$8F:9800             db 01

; PLM scroll data. Room $97B5. Crateria -> Blue Brinstar elevator (PLM index 0)
$8F:9801             db 00,02, 80

; Room header. Bomb Torizo
$8F:9804             dx 15,00, 19,06, 01,01, 70,A0, 00, 9869, E612,0E,984F, E629,04,9835, E5E6

; State header. Room $9804. Bomb Torizo - default
$8F:981B             dx C3E0D0, 02, 24,03, 81BE, 84ED, 80B3, C1,C1, 0000, 0000, 0000, 83FE, B905, 91D4

; State header. Room $9804. Bomb Torizo - area torizo is dead
$8F:9835             dx C3E0D0, 02, 00,03, 81BE, 84ED, 80B3, C1,C1, 0000, 0000, 0000, 83FE, B905, 91D4

; State header. Room $9804. Bomb Torizo - event "Zebes timebomb set" is set
$8F:984F             dx C3E0D0, 02, 00,00, 8030, 8ED3, 82A3, C1,C1, 0000, 986B, C124, 8412, B905, 91B2

; Door list. Room $9804. Bomb Torizo
$8F:9869             dw 8BAA

; Special x-ray blocks. Room $9804, state $984F. Bomb Torizo - event "Zebes timebomb set" is set
$8F:986B             dx 0F,0A,0052, 0F,0B,0052, 0F,0C,0052, 00,00

; Room header. Pre Bomb Torizo hall
$8F:9879             dx 16,00, 16,06, 03,01, 70,A0, 00, 98DE, E612,0E,98C4, E629,04,98AA, E5E6

; State header. Room $9879. Pre Bomb Torizo hall - event "Zebes timebomb set" is set
$8F:984F             dx C3E0D0, 02, 00,00, 8030, 8ED3, 82A3, C1,C1, 0000, 986B, C124, 8412, B905, 91B2

; State header. Room $9879. Pre Bomb Torizo hall - area torizo is dead
$8F:98AA             dx C3E16E, 02, 09,05, 81C0, 8364, 807D, C1,C1, 0000, 0000, 0000, 8420, B8EA, 91D4

; State header. Room $9879. Pre Bomb Torizo hall - event "Zebes timebomb set" is set
$8F:98C4             dx C3E16E, 02, 24,07, 8040, 8F16, 82B5, C1,C1, 0000, 0000, C124, 8428, B8EA, 91BB

; Door list. Room $9879. Pre Bomb Torizo hall
$8F:98DE             dw 8BB6, 8BC2

; Room header. Pre Crateria map station hall
$8F:98E2             dx 17,00, 14,07, 03,01, 70,A0, 00, 9909, E5E6

; State header. Room $98E2. Pre Crateria map station hall - default
$8F:98EF             dx C3E232, 02, 00,00, 81C2, 8B87, 825F, C1,C1, 0000, 0000, 0000, 8430, B920, 91D4

; Door list. Room $98E2. Pre Crateria map station hall
$8F:9909             dw 8BCE, 8BDA

; Room header. Crateria slope
$8F:990D             dx 18,00, 0C,04, 06,03, A0,A0, 00, 9934, E5E6

; State header. Room $990D. Crateria slope - default
$8F:991A             dx C3E2FC, 02, 00,00, 81C2, 8108, 8031, C1,C1, 0000, 0000, 0000, 8432, B8CF, 91D4

; Door list. Room $990D. Crateria slope
$8F:9934             dw 8BE6, 8BF2

; Room header. Crateria -> Green Brinstar elevator
$8F:9938             dx 19,00, 06,08, 01,01, 70,A0, 00, 995F, E5E6

; State header. Room $9938. Crateria -> Green Brinstar elevator - default
$8F:9945             dx C3E985, 02, 09,03, 81C2, 8573, 80D3, 00,00, 9965, 0000, 0000, 843A, 0000, 91D4

; Door list. Room $9938. Crateria -> Green Brinstar elevator
$8F:995F             dw 8BFE, 8C0A, 88FC

; Scroll data. Room $9938. Crateria -> Green Brinstar elevator
$8F:9965             db 01

; PLM scroll data. Room $9938. Crateria -> Green Brinstar elevator (PLM index 0)
$8F:9966             db 00,02, 80

; Room header. West Crateria kago hall
$8F:9969             dx 1A,00, 07,08, 04,01, 70,A0, 00, 9990, E5E6

; State header. Room $9969. West Crateria kago hall - default
$8F:9976             dx C3EB35, 02, 00,05, 81C2, 8BCA, 8271, C1,C1, 0000, 0000, 0000, 8442, B8CF, 91D4

; Door list. Room $9969. West Crateria kago hall
$8F:9990             dw 8C16, 8C22

; Room header. Crateria map station
$8F:9994             dx 1B,00, 17,07, 01,01, 70,A0, 00, 99BB, E5E6

; State header. Room $9994. Crateria map station - default
$8F:99A1             dx CE86BD, 15, 00,00, 81C2, 85A9, 80EB, 00,00, 0000, 0000, 0000, 8444, 0000, 91D4

; Door list. Room $9994. Crateria map station
$8F:99BB             dw 8C2E

; Room header. Crateria space pirate shaft
$8F:99BD             dx 1C,00, 0B,02, 01,07, 70,A0, 00, 99E4, E5E6

; State header. Room $99BD. Crateria space pirate shaft - default
$8F:99CA             dx C3EE60, 02, 00,05, 81C2, 8500, 80C1, 01,C1, 99EC, 0000, 0000, 844C, B956, 91D4

; Door list. Room $99BD. Crateria space pirate shaft
$8F:99E4             dw 8C3A, 8C46, 8C52, 8C5E

; Scroll data. Room $99BD. Crateria space pirate shaft
$8F:99EC             db 02, 02, 02, 00, 02, 02, 01

; PLM scroll data. Room $99BD. Crateria space pirate shaft (PLM index 0)
$8F:99F3             db 03,02, 80

; PLM scroll data. Room $99BD. Crateria space pirate shaft (PLM index 2)
$8F:99F6             db 03,00, 80

; Room header. Crateria spike floor room
$8F:99F9             dx 1D,00, 15,09, 04,08, 70,A0, 00, 9A20, E5E6

; State header. Room $99F9. Crateria spike floor room - default
$8F:9A06             dx C3F4D3, 02, 00,00, 81C4, 8870, 81A5, C1,C1, 9A24, 0000, 0000, 8478, B905, 91D4

; Door list. Room $99F9. Crateria spike floor room
$8F:9A20             dw 8C6A, 8C76

; Scroll data. Room $99F9. Crateria spike floor room
$8F:9A24             db 01, 01, 01, 02, 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 02, 01, 01, 01, 01

; Room header. Crateria bomb block hall
$8F:9A44             dx 1E,00, 11,07, 02,01, 70,A0, 00, 9A8A, E612,00,9A70, E5E6

; State header. Room $9A44. Crateria bomb block hall - default
$8F:9A56             dx C4811E, 02, 00,00, 81D4, 81FE, 8055, C1,C1, 9A8E, 0000, 0000, 8480, B956, 91D4

; State header. Room $9A44. Crateria bomb block hall - event "Zebes is awake" is set
$8F:9A70             dx C4811E, 02, 00,00, 80A0, 819B, 8043, C1,C1, 9A8E, 0000, 0000, 8482, B956, 91D4

; Door list. Room $9A44. Crateria bomb block hall
$8F:9A8A             dw 8C82, 8C8E

; Scroll data. Room $9A44. Crateria bomb block hall
$8F:9A8E             db 01, 01

; Room header. Crateria chozo missile
$8F:9A90             dx 1F,00, 10,07, 01,01, 70,A0, 00, 9AD6, E612,00,9ABC, E5E6

; State header. Room $9A90. Crateria chozo missile - default
$8F:9AA2             dx C48232, 02, 00,00, 81E4, 8586, 80DD, C1,C1, 9AD8, 0000, 0000, 8484, B905, 91D4

; State header. Room $9A90. Crateria chozo missile - event "Zebes is awake" is set
$8F:9ABC             dx C48232, 02, 00,00, 80B0, 85AF, 8107, C1,C1, 9AD8, 0000, 0000, 8486, B905, 91D4

; Door list. Room $9A90. Crateria chozo missile
$8F:9AD6             dw 8C9A

; Scroll data. Room $9A90. Crateria chozo missile
$8F:9AD8             db 01

; Room header. Green Brinstar mainstreet
$8F:9AD9             dx 00,01, 09,00, 04,0C, 70,A0, 00, 9B00, E5E6

; State header. Room $9AD9. Green Brinstar mainstreet - default
$8F:9AE6             dx C4F1CE, 06, 0F,05, 8204, 997A, 8541, 00,C0, 9B16, 0000, 0000, 848E, BA37, 91D5

; Door list. Room $9AD9. Green Brinstar mainstreet
$8F:9B00             dw 8CA6, 8CB2, 8CBE, 8CCA, 8CD6, 8CE2, 8CEE, 8CFA, 8D06, 88FC, 8D12

; Scroll data. Room $9AD9. Green Brinstar mainstreet
$8F:9B16             db 02, 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 00, 00, 02, 01, 02, 00, 02, 00, 02, 00, 02, 00, 02, 00, 02, 00, 00, 00, 02, 00

; PLM scroll data. Room $9AD9. Green Brinstar mainstreet (PLM index 0)
$8F:9B46             db 1C,02, 1D,00, 80

; PLM scroll data. Room $9AD9. Green Brinstar mainstreet (PLM indices 1/2)
$8F:9B4B             db 1C,00, 1D,01, 29,01, 80

; PLM scroll data. Room $9AD9. Green Brinstar mainstreet (PLM index 3)
$8F:9B52             db 18,02, 1C,02, 1D,00, 29,00, 80

; Room header. Spore Spawn's super missile shaft
$8F:9B5B             dx 01,01, 17,01, 02,09, 70,A0, 00, 9B82, E5E6

; State header. Room $9B5B. Spore Spawn's super missile shaft - default
$8F:9B68             dx C58BD5, 06, 00,03, 8214, 9A2D, 8557, C1,C1, 9B86, 0000, 0000, 84D8, BABE, 91D5

; Door list. Room $9B5B. Spore Spawn's super missile shaft
$8F:9B82             dw 8D1E, 8D2A

; Scroll data. Room $9B5B. Spore Spawn's super missile shaft
$8F:9B86             db 01, 02, 00, 02, 00, 02, 00, 02, 00, 02, 00, 02, 00, 02, 00, 02, 01, 01

; PLM scroll data. Room $9B5B. Spore Spawn's super missile shaft (PLM index 0)
$8F:9B98             db 01,02, 03,02, 80

; Room header. Pre Brinstar map room hall
$8F:9B9D             dx 02,01, 06,04, 03,01, 70,A0, 00, 9BC4, E5E6

; State header. Room $9B9D. Pre Brinstar map room hall - default
$8F:9BAA             dx C59642, 06, 00,00, 8224, 8F7C, 82D5, C1,C1, 0000, 0000, 0000, 84EC, BA88, 91D5

; Door list. Room $9B9D. Pre Brinstar map room hall
$8F:9BC4             dw 8D36, 8D42

; Room header. Early supers room
$8F:9BC8             dx 03,01, 0A,03, 03,02, 70,A0, 00, 9BEF, E5E6

; State header. Room $9BC8. Early supers room - default
$8F:9BD5             dx C59755, 06, 00,05, 8226, 9A40, 8565, C1,C1, 9BF3, 0000, 0000, 84F4, BAA3, 91D5

; Door list. Room $9BC8. Early supers room
$8F:9BEF             dw 8D4E, 8D5A

; Scroll data. Room $9BC8. Early supers room
$8F:9BF3             db 00, 00, 00, 01, 01, 01

; PLM scroll data. Room $9BC8. Early supers room (PLM indices 0/4)
$8F:9BF9             db 00,02, 01,02, 02,02, 80

; PLM scroll data. Room $9BC8. Early supers room (PLM index 3)
$8F:9C00             db 00,00, 01,00, 02,00, 80

; Room header. Brinstar reserve tank room
$8F:9C07             dx 04,01, 0D,04, 02,01, 70,A0, 00, 9C2E, E5E6

; State header. Room $9C07. Brinstar reserve tank room - default
$8F:9C14             dx C59B00, 06, 00,03, 8228, 9F38, 85FD, C1,C1, 9C30, 0000, 0000, 8526, BA6D, 91D5

; Door list. Room $9C07. Brinstar reserve tank room
$8F:9C2E             dw 8D66

; Scroll data. Room $9C07. Brinstar reserve tank room
$8F:9C30             db 01, 00

; PLM scroll data. Room $9C07. Brinstar reserve tank room (PLM index 0)
$8F:9C32             db 01,01, 80

; Room header. Brinstar map station
$8F:9C35             dx 05,01, 05,04, 01,01, 70,A0, 00, 9C5C, E5E6

; State header. Room $9C35. Brinstar map station - default
$8F:9C42             dx CE83C3, 15, 00,00, 822A, 8FBF, 82E7, 00,00, 0000, 0000, 0000, 8540, 0000, 91D5

; Door list. Room $9C35. Brinstar map station
$8F:9C5C             dw 8D72

; Room header. Fireflea room
$8F:9C5E             dx 06,01, 06,06, 03,02, 70,A0, 00, 9C85, E5E6

; State header. Room $9C5E. Fireflea room - default
$8F:9C6B             dx C59CAC, 06, 00,00, 822C, 96E2, 84C9, 00,00, 0000, 0000, 0000, 8548, 0000, 91D5

; Door list. Room $9C5E. Fireflea room
$8F:9C85             dw 8D7E, 8D8A

; Room header. Green Brinstar missile station
$8F:9C89             dx 07,01, 05,07, 01,01, 70,A0, 00, 9CB0, E5E6

; State header. Room $9C89. Green Brinstar missile station - default
$8F:9C96             dx CE8CB3, 18, 00,00, 823C, 8FC2, 82F1, 00,00, 9CB2, 0000, 0000, 8550, 0000, 91D5

; Door list. Room $9C89. Green Brinstar missile station
$8F:9CB0             dw 8D96

; Scroll data. Room $9C89. Green Brinstar missile station
$8F:9CB2             db 01

; Room header. Dachora room
$8F:9CB3             dx 08,01, 0A,06, 07,07, 70,A0, 00, 9CDA, E5E6

; State header. Room $9CB3. Dachora room - default
$8F:9CC0             dx C5A15F, 06, 00,00, 823E, 9D5C, 85B9, C0,00, 9CE0, 0000, C1E6, 8558, 0000, 91D5

; Door list. Room $9CB3. Dachora room
$8F:9CDA             dw 8DA2, 8DAE, 8DBA

; Scroll data. Room $9CB3. Dachora room
$8F:9CE0             db 01, 01, 01, 01, 01, 01, 01, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 00, 02, 00, 00, 02, 02, 02, 02, 02, 00, 00

; PLM scroll data. Room $9CB3. Dachora room (PLM index 6)
$8F:9D11             db 0B,02, 80

; PLM scroll data. Room $9CB3. Dachora room (PLM indices Ah/16h)
$8F:9D14             db 04,01, 0B,00, 80

; Room header. Charge beam room
$8F:9D19             dx 09,01, 0F,04, 05,0A, 70,A0, 00, 9D40, E5E6

; State header. Room $9D19. Charge beam room - default
$8F:9D26             dx C5B54D, 06, 0F,05, 824E, 953E, 8429, C1,C1, 9D52, 0000, 0000, 85E4, BB45, 91D5

; Door list. Room $9D19. Charge beam room
$8F:9D40             dw 8DC6, 8DD2, 8DDE, 8DEA, 8DF6, 8E02, 8E0E, 8E1A, 8E26

; Scroll data. Room $9D19. Charge beam room
$8F:9D52             db 00, 00, 02, 02, 00, 00, 00, 02, 02, 00, 00, 00, 02, 02, 00, 00, 00, 02, 02, 00, 00, 00, 02, 02, 00, 00, 00, 02, 02, 00, 00, 00, 01, 01, 00, 02, 00, 00, 00, 00, 02, 00, 00, 00, 00, 02, 00, 00, 00, 00

; PLM scroll data. Room $9D19. Charge beam room (PLM index 0)
$8F:9D84             db 20,02, 25,02, 26,02, 80

; PLM scroll data. Room $9D19. Charge beam room (PLM index 1)
$8F:9D8B             db 24,02, 80

; PLM scroll data. Room $9D19. Charge beam room (PLM index 2)
$8F:9D8E             db 1D,00, 80

; PLM scroll data. Room $9D19. Charge beam room (PLM index 3)
$8F:9D91             db 1C,01, 1D,01, 80

; PLM scroll data. Room $9D19. Charge beam room (PLM index 4)
$8F:9D96             db 01,02, 80

; PLM scroll data. Room $9D19. Charge beam room (PLM index 5)
$8F:9D99             db 01,00, 80

; Room header. Pre Spore Spawn hall
$8F:9D9C             dx 0A,01, 13,04, 04,01, 70,A0, 00, 9DC3, E5E6

; State header. Room $9D9C. Pre Spore Spawn hall - default
$8F:9DA9             dx C5CBA7, 06, 0F,05, 825E, 8FC5, 82FB, C1,C1, 0000, 0000, 0000, 8634, BA52, 91D5

; Door list. Room $9D9C. Pre Spore Spawn hall
$8F:9DC3             dw 8E32, 8E3E

; Room header. Spore Spawn
$8F:9DC7             dx 0B,01, 16,01, 01,03, 70,A0, 00, 9E0D, E629,02,9DF3, E5E6

; State header. Room $9DC7. Spore Spawn - default
$8F:9DD9             dx C5CE34, 06, 2A,05, 826E, A0FD, 8663, 00,00, 0001, 0000, 0000, 8642, 0000, 91D5

; State header. Room $9DC7. Spore Spawn - area mini-boss is dead
$8F:9DF3             dx C5CE34, 06, 00,03, 826E, A0FD, 8663, 00,00, 0001, 0000, 0000, 8642, 0000, 91D5

; Door list. Room $9DC7. Spore Spawn
$8F:9E0D             dw 8E4A, 8E56

; Room header. Brinstar super-sidehopper power bomb room
$8F:9E11             dx 0C,01, 0F,07, 02,02, 70,A0, 00, 9E38, E5E6

; State header. Room $9E11. Brinstar super-sidehopper power bomb room - default
$8F:9E1E             dx C5D18F, 06, 00,00, 827E, 961D, 846F, C1,C1, 9E3C, 0000, 0000, 864A, BAA3, 91D5

; Door list. Room $9E11. Brinstar super-sidehopper power bomb room
$8F:9E38             dw 8E62, 8E6E

; Scroll data. Room $9E11. Brinstar super-sidehopper power bomb room
$8F:9E3C             db 01, 01, 00, 00

; PLM scroll data. Room $9E11. Brinstar super-sidehopper power bomb room (PLM index 0)
$8F:9E40             db 00,02, 01,00, 02,01, 03,01, 80

; PLM scroll data. Room $9E11. Brinstar super-sidehopper power bomb room (PLM index 1)
$8F:9E49             db 00,01, 01,01, 02,00, 03,00, 80

; Room header. Brinstar diagonal room
$8F:9E52             dx 0D,01, 13,0A, 08,04, 70,A0, 00, 9E79, E5E6

; State header. Room $9E52. Brinstar diagonal room - default
$8F:9E5F             dx C5D559, 06, 0F,05, 828E, 9CB9, 85A7, C1,C1, 9E7F, 0000, 0000, 8664, BAD9, 91D5

; Door list. Room $9E52. Brinstar diagonal room
$8F:9E79             dw 8E7A, 8E86, 8E92

; Scroll data. Room $9E52. Brinstar diagonal room
$8F:9E7F             db 02, 02, 00, 00, 00, 00, 00, 00, 02, 02, 02, 02, 00, 00, 00, 00, 02, 02, 02, 02, 02, 02, 02, 02, 01, 01, 01, 01, 01, 01, 01, 01

; Room header. Morph ball room
$8F:9E9F             dx 0E,01, 15,08, 08,03, 70,A0, 00, 9EE5, E612,00,9ECB, E5E6

; State header. Room $9E9F. Morph ball room - default
$8F:9EB1             dx C5DED5, 06, 06,07, 8290, 93AC, 83D1, C1,C1, 9EED, 0000, 0000, 867E, BAF4, 91D5

; State header. Room $9E9F. Morph ball room - event "Zebes is awake" is set
$8F:9ECB             dx C5DED5, 06, 09,05, 81F4, 9326, 83B5, C1,C1, 9EED, 0000, 0000, 86E6, BAF4, 91BC

; Door list. Room $9E9F. Morph ball room
$8F:9EE5             dw 8E9E, 8EAA, 8EB6, 88FC

; Scroll data. Room $9E9F. Morph ball room
$8F:9EED             db 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01, 01, 01, 01, 01, 01, 01, 01

; PLM scroll data. Room $9E9F. Morph ball room (PLM index 0)
$8F:9F05             db 12,01, 80

; PLM scroll data. Room $9E9F. Morph ball room (PLM index 9)
$8F:9F08             db 12,00, 80

; PLM scroll data. Room $9E9F. Morph ball room (PLM indices Bh/Dh)
$8F:9F0B             db 0D,02, 80

; PLM scroll data. Room $9E9F. Morph ball room (PLM index Fh)
$8F:9F0E             db 0D,00, 80

; Room header. Old Kraid entrance
$8F:9F11             dx 0F,01, 1D,0A, 01,02, 70,A0, 00, 9F57, E612,00,9F3D, E5E6

; State header. Room $9F11. Old Kraid entrance - default
$8F:9F23             dx C5E63A, 06, 00,00, 82A0, 9BC6, 8595, C1,C1, 9F5D, 0000, 0000, 8754, BABE, 91D5

; State header. Room $9F11. Old Kraid entrance - event "Zebes is awake" is set
$8F:9F3D             dx C5E63A, 06, 00,00, 81F4, 918D, 8377, C1,C1, 9F5D, 0000, 0000, 8754, BABE, 91BC

; Door list. Room $9F11. Old Kraid entrance
$8F:9F57             dw 8EC2, 8ECE, 8EDA

; Scroll data. Room $9F11. Old Kraid entrance
$8F:9F5D             db 01, 00

; PLM scroll data. Room $9F11. Old Kraid entrance (PLM index 0)
$8F:9F5F             db 00,02, 01,01, 80

; Room header. Blue Brinstar ceiling e-tank hall
$8F:9F64             dx 10,01, 1E,08, 03,03, 70,A0, 00, 9FAA, E612,00,9F90, E5E6

; State header. Room $9F64. Blue Brinstar ceiling e-tank hall - default
$8F:9F76             dx C5E86F, 06, 00,00, 82B0, 966F, 84B7, C1,C1, 9FAE, 0000, 0000, 878C, BAF4, 91D5

; State header. Room $9F64. Blue Brinstar ceiling e-tank hall - event "Zebes is awake" is set
$8F:9F90             dx C5E86F, 06, 00,00, 81F4, 9200, 8389, C1,C1, 9FAE, 0000, 0000, 878C, BAF4, 91BC

; Door list. Room $9F64. Blue Brinstar ceiling e-tank hall
$8F:9FAA             dw 8EE6, 8EF2

; Scroll data. Room $9F64. Blue Brinstar ceiling e-tank hall
$8F:9FAE             db 00, 00, 02, 00, 00, 00, 01, 01, 01

; PLM scroll data. Room $9F64. Blue Brinstar ceiling e-tank hall (PLM indices 0/1)
$8F:9FB7             db 05,02, 80

; Room header. n00b bridge
$8F:9FBA             dx 11,01, 1B,0D, 06,01, 70,A0, 00, 9FE1, E5E6

; State header. Room $9FBA. n00b bridge - default
$8F:9FC7             dx C5ECAE, 06, 0F,05, 82C0, 92A3, 83A3, C1,C1, 0000, 0000, 0000, 87A6, BA52, 91D5

; Door list. Room $9FBA. n00b bridge
$8F:9FE1             dw 8EFE, 8F0A

; Room header. Etecoon area beetom room
$8F:9FE5             dx 12,01, 08,0A, 01,01, 70,A0, 00, A00C, E5E6

; State header. Room $9FE5. Etecoon area beetom room - default
$8F:9FF2             dx C5EF71, 06, 00,00, 82D0, 9735, 84D7, 01,01, A010, 0000, 0000, 87AE, BA52, 91D5

; Door list. Room $9FE5. Etecoon area beetom room
$8F:A00C             dw 8F16, 8F22

; Scroll data. Room $9FE5. Etecoon area beetom room
$8F:A010             db 01

; Room header. Etecoon area spike hall
$8F:A011             dx 13,01, 06,0A, 05,02, 70,A0, 00, A038, E5E6

; State header. Room $A011. Etecoon area spike hall - default
$8F:A01E             dx C5F057, 06, 00,00, 82D2, 9778, 84E5, C1,C1, A040, 0000, 0000, 87B0, BA52, 91D5

; Door list. Room $A011. Etecoon area spike hall
$8F:A038             dw 8F2E, 8F3A, 8F46, 8F52

; Scroll data. Room $A011. Etecoon area spike hall
$8F:A040             db 01, 01, 00, 00, 00, 00, 00, 01, 01, 01

; PLM scroll data. Room $A011. Etecoon area spike hall (PLM index 0)
$8F:A04A             db 01,02, 05,01, 06,01, 80

; Room header. Etecoon area super missiles
$8F:A051             dx 14,01, 05,0A, 01,01, 70,A0, 00, A078, E5E6

; State header. Room $A051. Etecoon area super missiles - default
$8F:A05E             dx C5F43E, 06, 00,00, 82E2, 9028, 8309, 01,01, A07A, 0000, 0000, 87D0, BA52, 91D5

; Door list. Room $A051. Etecoon area super missiles
$8F:A078             dw 8F5E

; Scroll data. Room $A051. Etecoon area super missiles
$8F:A07A             db 01

; Room header. Dachora energy station
$8F:A07B             dx 15,01, 09,0C, 01,01, 70,A0, 00, A0A2, E5E6

; State header. Room $A07B. Dachora energy station - default
$8F:A088             dx CE89B6, 17, 00,00, 82F2, 902B, 8313, 00,00, 0000, 0000, 0000, 87D8, 0000, 91D5

; Door list. Room $A07B. Dachora energy station
$8F:A0A2             dw 8F6A

; Room header. Post Spore Spawn supers hall
$8F:A0A4             dx 16,01, 14,09, 03,01, 70,A0, 00, A0CB, E5E6

; State header. Room $A0A4. Post Spore Spawn supers hall - default
$8F:A0B1             dx C5F4C9, 06, 0F,05, 82F4, 902E, 8321, C0,00, A0CF, 0000, 0000, 87E0, 0000, 91D5

; Door list. Room $A0A4. Post Spore Spawn supers hall
$8F:A0CB             dw 8F76, 8F82

; Scroll data. Room $A0A4. Post Spore Spawn supers hall
$8F:A0CF             db 01, 01, 01

; Room header. Pink Brinstar flooded hall
$8F:A0D2             dx 17,01, 08,0D, 07,01, 70,A0, 00, A0F9, E5E6

; State header. Room $A0D2. Pink Brinstar flooded hall - default
$8F:A0DF             dx C5F778, 06, 00,00, 8304, 911A, 8361, C1,01, A0FD, 0000, 0000, 87E8, BAA3, 91D5

; Door list. Room $A0D2. Pink Brinstar flooded hall
$8F:A0F9             dw 8F8E, 8F9A

; Scroll data. Room $A0D2. Pink Brinstar flooded hall
$8F:A0FD             db 00, 01, 01, 01, 01, 01, 01

; PLM scroll data. Room $A0D2. Pink Brinstar flooded hall (PLM index 2)
$8F:A104             db 00,01, 80

; Room header. Blue Brinstar missile room
$8F:A107             dx 18,01, 1C,0B, 01,01, 70,A0, 00, A12E, E5E6

; State header. Room $A107. Blue Brinstar missile room - default
$8F:A114             dx C5FD50, 06, 00,00, 8314, 9EB2, 85E5, 01,01, 0000, 0000, 0000, 8802, BABE, 91D5

; Door list. Room $A107. Blue Brinstar missile room
$8F:A12E             dw 8FA6

; Room header. Brinstar wave-gate sidehopper room
$8F:A130             dx 19,01, 13,07, 02,02, 70,A0, 00, A157, E5E6

; State header. Room $A130. Brinstar wave-gate sidehopper room - default
$8F:A13D             dx C5FE1B, 06, 00,00, 8324, 97FB, 84F7, C1,C1, 0000, 0000, 0000, 880A, BAA3, 91D5

; Door list. Room $A130. Brinstar wave-gate sidehopper room
$8F:A157             dw 8FB2, 8FBE

; Room header. Brinstar wave-gate energy tank
$8F:A15B             dx 1A,01, 15,08, 01,01, 70,A0, 00, A182, E5E6

; State header. Room $A15B. Brinstar wave-gate energy tank - default
$8F:A168             dx C681C2, 06, 00,00, 8334, 90C4, 8345, 00,00, 0000, 0000, 0000, 8824, 0000, 91D5

; Door list. Room $A15B. Brinstar wave-gate energy tank
$8F:A182             dw 8FCA

; Room header. Spore Spawn save station
$8F:A184             dx 1B,01, 0F,04, 01,01, 70,A0, 00, A1AB, E5E6

; State header. Room $A184. Spore Spawn save station - default
$8F:A191             dx CE92CB, 19, 0F,05, 8336, 953B, 841F, 00,00, 0000, 0000, 0000, 882C, 0000, 91D5

; Door list. Room $A184. Spore Spawn save station
$8F:A1AB             dw 8FD6

; Room header. Blue Brinstar boulder room
$8F:A1AD             dx 1C,01, 1E,08, 02,01, 70,A0, 00, A1D4, E5E6

; State header. Room $A1AD. Blue Brinstar boulder room - default
$8F:A1BA             dx C68318, 06, 00,00, 8338, 9505, 8407, C1,01, 0000, 0000, 0000, 8834, BAF4, 91D5

; Door list. Room $A1AD. Blue Brinstar boulder room
$8F:A1D4             dw 8FE2, 8FEE

; Room header. Blue Brinstar double missile room
$8F:A1D8             dx 1D,01, 1D,08, 01,01, 70,A0, 00, A1FF, E5E6

; State header. Room $A1D8. Blue Brinstar double missile room - default
$8F:A1E5             dx C68437, 06, 00,00, 8348, 9538, 8415, 01,01, 0000, 0000, 0000, 8836, BAF4, 91D5

; Door list. Room $A1D8. Blue Brinstar double missile room
$8F:A1FF             dw 8FFA

; Room header. Green Brinstar mainstreet save station
$8F:A201             dx 1E,01, 08,05, 01,01, 70,A0, 00, A228, E5E6

; State header. Room $A201. Green Brinstar mainstreet save station - default
$8F:A20E             dx CE92CB, 19, 0F,05, 834A, 9617, 845B, 00,00, 0000, 0000, 0000, 8844, 0000, 91D5

; Door list. Room $A201. Green Brinstar mainstreet save station
$8F:A228             dw 9006

; Room header. Etecoon area save station
$8F:A22A             dx 1F,01, 05,0B, 01,01, 70,A0, 00, A251, E5E6

; State header. Room $A22A. Etecoon area save station - default
$8F:A237             dx CE92CB, 19, 0F,05, 834C, 95E1, 843F, 00,00, 0000, 0000, 0000, 884C, 0000, 91D5

; Door list. Room $A22A. Etecoon area save station
$8F:A251             dw 9012

; Room header. Red Brinstar mainstreet
$8F:A253             dx 20,01, 21,09, 01,0A, 70,A0, 00, A27A, E5E6

; State header. Room $A253. Red Brinstar mainstreet - default
$8F:A260             dx C684EE, 07, 12,05, 834E, 9452, 83F1, C1,C1, A284, 0000, 0000, 8854, BB7B, 91D6

; Door list. Room $A253. Red Brinstar mainstreet
$8F:A27A             dw 901E, 902A, 9036, 9042, 904E

; Scroll data. Room $A253. Red Brinstar mainstreet
$8F:A284             db 02, 02, 02, 02, 02, 02, 01, 00, 02, 02

; PLM scroll data. Room $A253. Red Brinstar mainstreet (PLM index 0)
$8F:A28E             db 06,02, 07,02, 80

; Room header. Pre x-ray spike hall
$8F:A293             dx 21,01, 19,0F, 08,02, 90,A0, 00, A2BA, E5E6

; State header. Room $A293. Pre x-ray spike hall - default
$8F:A2A0             dx C691E3, 07, 00,05, 835E, 9B13, 857F, 00,00, A2BE, 0000, 0000, 886E, 0000, 91D6

; Door list. Room $A293. Pre x-ray spike hall
$8F:A2BA             dw 905A, 9066

; Scroll data. Room $A293. Pre x-ray spike hall
$8F:A2BE             db 02, 02, 01, 01, 02, 02, 01, 01, 01, 01, 00, 00, 01, 01, 00, 00

; Room header. X-ray room
$8F:A2CE             dx 22,01, 17,0F, 02,01, 70,A0, 00, A2F5, E5E6

; State header. Room $A2CE. X-ray room - default
$8F:A2DB             dx C69BF9, 07, 00,03, 836E, 9F3B, 8607, C1,C1, 0000, 0000, 0000, 8876, BC38, 91D6

; Door list. Room $A2CE. X-ray room
$8F:A2F5             dw 9072

; Room header. Red Brinstar damage boost hall
$8F:A2F7             dx 23,01, 22,09, 03,01, 70,A0, 00, A31E, E5E6

; State header. Room $A2F7. Red Brinstar damage boost hall - default
$8F:A304             dx C69D70, 07, 00,00, 8370, 9E2F, 85D3, C1,C1, 0000, 0000, 0000, 887E, BBCC, 91D6

; Door list. Room $A2F7. Red Brinstar damage boost hall
$8F:A31E             dw 907E, 908A

; Room header. Red Brinstar -> Crateria elevator
$8F:A322             dx 24,01, 25,04, 03,08, 70,A0, 00, A349, E5E6

; State header. Room $A322. Red Brinstar -> Crateria elevator - default
$8F:A32F             dx C69F4B, 07, 12,05, 8380, A057, 863F, 00,00, A357, 0000, 0000, 8880, 0000, 91D6

; Door list. Room $A322. Red Brinstar -> Crateria elevator
$8F:A349             dw 9096, 90A2, 90AE, 90BA, 90C6, 88FC, 90D2

; Scroll data. Room $A322. Red Brinstar -> Crateria elevator
$8F:A357             db 02, 00, 00, 02, 00, 00, 02, 00, 00, 02, 00, 01, 02, 00, 00, 01, 00, 00, 00, 00, 00, 02, 00, 00

; PLM scroll data. Room $A322. Red Brinstar -> Crateria elevator (PLM index 0)
$8F:A36F             db 0F,02, 12,02, 80

; PLM scroll data. Room $A322. Red Brinstar -> Crateria elevator (PLM index 2)
$8F:A374             db 0A,01, 09,02, 80

; PLM scroll data. Room $A322. Red Brinstar -> Crateria elevator (PLM index 3)
$8F:A379             db 0A,00, 80

; Room header. Red Brinstar power bomb floor room
$8F:A37C             dx 25,01, 23,07, 02,02, 70,A0, 00, A3A3, E5E6

; State header. Room $A37C. Red Brinstar power bomb floor room - default
$8F:A389             dx C6B31F, 07, 00,00, 8390, 90C7, 834F, C1,C1, A3A5, 0000, 0000, 88BE, BBE7, 91D6

; Door list. Room $A37C. Red Brinstar power bomb floor room
$8F:A3A3             dw 90DE

; Scroll data. Room $A37C. Red Brinstar power bomb floor room
$8F:A3A5             db 01, 01, 00, 00

; PLM scroll data. Room $A37C. Red Brinstar power bomb floor room (PLM index 0)
$8F:A3A9             db 00,02, 02,01, 80

; Room header. Red Brinstar power bomb wall room
$8F:A3AE             dx 26,01, 22,0B, 03,01, 70,A0, 00, A3D5, E5E6

; State header. Room $A3AE. Red Brinstar power bomb wall room - default
$8F:A3BB             dx C6B58C, 07, 00,03, 83A0, 9F61, 861F, C1,C1, A3D7, 0000, 0000, 88D8, BCEC, 91D6

; Door list. Room $A3AE. Red Brinstar power bomb wall room
$8F:A3D5             dw 90EA

; Scroll data. Room $A3AE. Red Brinstar power bomb wall room
$8F:A3D7             db 00, 01, 01

; PLM scroll data. Room $A3AE. Red Brinstar power bomb wall room (PLM index 8)
$8F:A3DA             db 00,01, 80

; Room header. Red Brinstar skree-duo hall
$8F:A3DD             dx 27,01, 22,12, 02,01, 70,A0, 00, A404, E5E6

; State header. Room $A3DD. Red Brinstar skree-duo hall - default
$8F:A3EA             dx C6B739, 07, 00,00, 83B0, A110, 8671, C1,C1, 0000, 0000, 0000, 891C, BBE7, 91D6

; Door list. Room $A3DD. Red Brinstar skree-duo hall
$8F:A404             dw 90F6, 9102

; Room header. Pre spazer room
$8F:A408             dx 28,01, 24,11, 02,02, 70,A0, 00, A42F, E5E6

; State header. Room $A408. Pre spazer room - default
$8F:A415             dx C6B91C, 07, 00,05, 83C0, 95E4, 8449, C1,C1, A435, 0000, 0000, 891E, BC02, 91D6

; Door list. Room $A408. Pre spazer room
$8F:A42F             dw 910E, 911A, 9126

; Scroll data. Room $A408. Pre spazer room
$8F:A435             db 00, 00, 01, 01

; PLM scroll data. Room $A408. Pre spazer room (PLM indices 0/8/Ah)
$8F:A439             db 00,02, 01,02, 80

; PLM scroll data. Room $A408. Pre spazer room (PLM indices 4/9/Bh)
$8F:A43E             db 00,00, 01,00, 02,01, 03,01, 80

; Room header. Spazer room
$8F:A447             dx 29,01, 26,11, 01,01, 70,A0, 00, A46E, E5E6

; State header. Room $A447. Spazer room - default
$8F:A454             dx C6BCC7, 07, 00,03, 83D0, 961A, 8465, C1,C1, A470, 0000, 0000, 896E, BCEC, 91D6

; Door list. Room $A447. Spazer room
$8F:A46E             dw 9132

; Scroll data. Room $A447. Spazer room
$8F:A470             db 01

; Room header. Kraid's lair zeela room
$8F:A471             dx 2A,01, 2C,12, 02,02, 70,A0, 00, A498, E5E6

; State header. Room $A471. Kraid's lair zeela room - default
$8F:A47E             dx C6BD83, 07, 00,05, 83D2, 941F, 83E3, C0,00, A49E, 0000, 0000, 8976, 0000, 91D6

; Door list. Room $A471. Kraid's lair zeela room
$8F:A498             dw 913E, 914A, 9156

; Scroll data. Room $A471. Kraid's lair zeela room
$8F:A49E             db 01, 00, 00, 01

; PLM scroll data. Room $A471. Kraid's lair zeela room (PLM index 0)
$8F:A4A2             db 00,02, 02,01, 03,00, 80

; PLM scroll data. Room $A471. Kraid's lair zeela room (PLM indices 1/3)
$8F:A4A9             db 00,02, 02,01, 80

; PLM scroll data. Room $A471. Kraid's lair zeela room (PLM index 2)
$8F:A4AE             db 03,01, 80

; Room header. Kraid's lair beetom room
$8F:A4B1             dx 2B,01, 2B,13, 01,01, 70,A0, 00, A4D8, E5E6

; State header. Room $A4B1. Kraid's lair beetom room - default
$8F:A4BE             dx C6C469, 07, 00,00, 83D2, 988E, 850D, C0,00, 0000, 0000, 0000, 8996, 0000, 91D6

; Door list. Room $A4B1. Kraid's lair beetom room
$8F:A4D8             dw 9162

; Room header. Kraid's lair kihunter hall
$8F:A4DA             dx 2C,01, 2D,12, 04,02, 70,A0, 00, A501, E5E6

; State header. Room $A4DA. Kraid's lair kihunter hall - default
$8F:A4E7             dx C6C630, 07, 12,05, 83D2, 98F7, 8533, C0,00, A507, 0000, 0000, 89A4, 0000, 91D6

; Door list. Room $A4DA. Kraid's lair kihunter hall
$8F:A501             dw 916E, 917A, 9186

; Scroll data. Room $A4DA. Kraid's lair kihunter hall
$8F:A507             db 02, 01, 01, 00, 00, 01, 00, 00

; PLM scroll data. Room $A4DA. Kraid's lair kihunter hall (PLM index 0)
$8F:A50F             db 01,01, 05,00, 80

; PLM scroll data. Room $A4DA. Kraid's lair kihunter hall (PLM index 1)
$8F:A514             db 01,02, 05,01, 80

; PLM scroll data. Room $A4DA. Kraid's lair kihunter hall (PLM index 9)
$8F:A519             db 05,00, 80

; PLM scroll data. Room $A4DA. Kraid's lair kihunter hall (PLM indices Ah/Bh)
$8F:A51C             db 03,01, 05,00, 80

; Room header. Fake Kraid's room
$8F:A521             dx 2D,01, 2F,13, 06,01, 70,A0, 00, A567, E629,01,A54D, E5E6

; State header. Room $A521. Fake Kraid's room - default
$8F:A533             dx C6CDB9, 07, 27,06, 83E2, A0BA, 8651, C1,C1, 0000, 0000, 0000, 89F4, BC6E, 91D6

; State header. Room $A521. Fake Kraid's room - main area boss is dead
$8F:A54D             dx C6CDB9, 07, 27,03, 83E2, A0BA, 8651, C1,C1, 0000, 0000, 0000, 89F4, BC6E, 91D6

; Door list. Room $A521. Fake Kraid's room
$8F:A567             dw 9192, 919E

; Room header. Pre Kraid room
$8F:A56B             dx 2E,01, 35,12, 02,02, 70,A0, 02, A592, E5E6

; State header. Room $A56B. Pre Kraid room - default
$8F:A578             dx C6D2CB, 07, 00,00, 83F2, 9FA4, 862D, 00,00, A598, 0000, 0000, 8A02, 0000, 91D6

; Door list. Room $A56B. Pre Kraid room
$8F:A592             dw 91AA, 91B6, 91C2

; Scroll data. Room $A56B. Pre Kraid room
$8F:A598             db 00, 00, 01, 01

; PLM scroll data. Room $A56B. Pre Kraid room (PLM index 0)
$8F:A59C             db 00,02, 80

; Room header. Kraid
$8F:A59F             dx 2F,01, 37,12, 02,02, 70,A0, 05, A5E5, E629,01,A5CB, E5E6

; State header. Room $A59F. Kraid - default
$8F:A5B1             dx C6D620, 1A, 27,06, 83F4, 9EB5, 85EF, 01,01, A5E9, 0000, 0000, 8A2E, B815, 91D6

; State header. Room $A59F. Kraid - main area boss is dead
$8F:A5CB             dx C6D620, 1A, 00,00, 83F4, 9EB5, 85EF, 01,01, A5E9, 0000, 0000, 8A2E, B840, 91D6

; Door list. Room $A59F. Kraid
$8F:A5E5             dw 91CE, 91DA

; Scroll data. Room $A59F. Kraid
$8F:A5E9             db 02, 02, 01, 01

; Room header. Pre Tourian entrance hall
$8F:A5ED             dx 30,00, 0C,08, 05,01, 70,A0, 00, A614, E5E6

; State header. Room $A5ED. Pre Tourian entrance hall - default
$8F:A5FA             dx C6D88D, 08, 00,04, 83F6, 9F5E, 8615, C1,C1, 0000, 0000, 0000, 8A3C, BCA4, 91D6

; Door list. Room $A5ED. Pre Tourian entrance hall
$8F:A614             dw 91E6, 91F2

; Room header. Red Brinstar energy station
$8F:A618             dx 31,01, 20,12, 01,01, 70,A0, 00, A63F, E5E6

; State header. Room $A618. Red Brinstar energy station - default
$8F:A625             dx CE89B6, 17, 00,00, 8406, 9660, 8485, 00,00, 0000, 0000, 0000, 8A3E, 0000, 91D6

; Door list. Room $A618. Red Brinstar energy station
$8F:A63F             dw 91FE

; Room header. Kraid's lair refill station
$8F:A641             dx 32,01, 36,12, 01,01, 70,A0, 00, A668, E5E6

; State header. Room $A641. Kraid's lair refill station - default
$8F:A64E             dx CEA201, 18, 00,00, 8408, 9663, 848F, 00,00, 0000, 0000, 0000, 8A46, 0000, 91D6

; Door list. Room $A641. Kraid's lair refill station
$8F:A668             dw 920A

; Room header. Tourian entrance
$8F:A66A             dx 33,00, 11,08, 01,02, 70,A0, 00, A691, E5E6

; State header. Room $A66A. Tourian entrance - default
$8F:A677             dx CE9BE9, 15, 09,06, 840A, 9081, 8333, 81,01, A697, 0000, 0000, 8A54, BB60, 91D7

; Door list. Room $A66A. Tourian entrance
$8F:A691             dw 9216, 9222, 88FC

; Scroll data. Room $A66A. Tourian entrance
$8F:A697             db 01, 00

; Unused PLM scroll data
$8F:A699             db 00,02, 01,01, 80

; Unused PLM scroll data
$8F:A69E             db 01,02, 80

; Room header. Kraid's lair entrance
$8F:A6A1             dx 34,01, 29,12, 03,02, 70,A0, 00, A6C8, E5E6

; State header. Room $A6A1. Kraid's lair entrance - default
$8F:A6AE             dx C6DEE0, 07, 12,03, 841A, 98E4, 8529, C1,C1, A6D0, 0000, 0000, 8A5C, BC53, 91F4

; Door list. Room $A6A1. Kraid's lair entrance
$8F:A6C8             dw 922E, 923A, 9246, 88FC

; Scroll data. Room $A6A1. Kraid's lair entrance
$8F:A6D0             db 01, 00, 02, 00, 01, 01

; PLM scroll data. Room $A6A1. Kraid's lair entrance (PLM index 0)
$8F:A6D6             db 00,02, 80

; PLM scroll data. Room $A6A1. Kraid's lair entrance (PLM index 2)
$8F:A6D9             db 01,02, 80

; PLM scroll data. Room $A6A1. Kraid's lair entrance (PLM index 5)
$8F:A6DC             db 00,01, 80

; PLM scroll data. Room $A6A1. Kraid's lair entrance (PLM index 9)
$8F:A6DF             db 00,00, 80

; Room header. Varia suit room
$8F:A6E2             dx 35,01, 39,13, 01,01, 70,A0, 02, A709, E5E6

; State header. Room $A6E2. Varia suit room - default
$8F:A6EF             dx C6E355, 07, 00,03, 842A, 9666, 8499, 00,00, 0000, 0000, 0000, 8ACA, 0000, 91F4

; Door list. Room $A6E2. Varia suit room
$8F:A709             dw 9252

; Room header. Kraid's lair save station
$8F:A70B             dx 36,01, 31,12, 01,01, 70,A0, 00, A732, E5E6

; State header. Room $A70B. Kraid's lair save station - default
$8F:A718             dx CE95C2, 19, 12,05, 842C, 93A9, 83C7, 00,00, 0000, 0000, 0000, 8AD2, 0000, 91F4

; Door list. Room $A70B. Kraid's lair save station
$8F:A732             dw 925E

; Room header. Red Brinstar save station
$8F:A734             dx 37,01, 26,08, 01,01, 70,A0, 00, A75B, E5E6

; State header. Room $A734. Red Brinstar save station - default
$8F:A741             dx CE95C2, 19, 12,05, 842E, 9669, 84A3, 00,00, 0000, 0000, 0000, 8ADA, 0000, 91F4

; Door list. Room $A734. Red Brinstar save station
$8F:A75B             dw 926A

; Room header. Ice beam tripper hall
$8F:A75D             dx 00,02, 04,03, 02,01, 70,A0, 00, A784, E5E6

; State header. Room $A75D. Ice beam tripper hall - default
$8F:A76A             dx C6E4A4, 09, 00,00, 8430, B45B, 89F3, C1,C1, 0000, 0000, 0000, 8AE2, BE3F, 91F5

; Door list. Room $A75D. Ice beam tripper hall
$8F:A784             dw 9276, 9282

; Room header. Lava missile room
$8F:A788             dx 01,02, 0E,03, 03,02, 70,A0, 00, A7AF, E5E6

; State header. Room $A788. Lava missile room - default
$8F:A795             dx C6E5F5, 09, 00,00, 8440, B544, 8A25, 00,00, 0000, 0000, 0000, 8AE4, 0000, 91F5

; Door list. Room $A788. Lava missile room
$8F:A7AF             dw 928E, 929A

; Room header. First hot room
$8F:A7B3             dx 02,02, 0B,03, 03,02, 70,A0, 00, A7DA, E5E6

; State header. Room $A7B3. First hot room - default
$8F:A7C0             dx C6ECB9, 09, 00,00, 8450, AF87, 892B, 00,00, 0000, 0000, 0000, 8AF2, 0000, 91F5

; Door list. Room $A7B3. First hot room
$8F:A7DA             dw 92A6, 92B2

; Room header. Norfair mainstreet
$8F:A7DE             dx 03,02, 0A,00, 01,07, 70,A0, 00, A805, E5E6

; State header. Room $A7DE. Norfair mainstreet - default
$8F:A7EB             dx C6F2E1, 0A, 15,05, 8460, B9D8, 8AED, C1,C1, 0000, 0000, 0000, 8AFA, BEE1, 91F5

; Door list. Room $A7DE. Norfair mainstreet
$8F:A805             dw 92BE, 92CA, 92D6, 92E2, 92EE, 88FC, 92FA, 9306

; Room header. Ice beam mockball hall
$8F:A815             dx 04,02, 03,01, 07,04, 70,A0, 00, A83C, E5E6

; State header. Room $A815. Ice beam mockball hall - default
$8F:A822             dx C6F8C1, 0A, 00,00, 8470, A332, 86D5, C1,C1, A844, 0000, 0000, 8B14, BE5A, 91F5

; Door list. Room $A815. Ice beam mockball hall
$8F:A83C             dw 9312, 931E, 932A, 9336

; Scroll data. Room $A815. Ice beam mockball hall
$8F:A844             db 00, 00, 00, 02, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01, 01, 01, 01, 01, 01, 01, 00, 00, 00, 00

; PLM scroll data. Room $A815. Ice beam mockball hall (PLM index 0)
$8F:A860             db 11,02, 18,01, 80

; Room header. Ice beam practice room
$8F:A865             dx 05,02, 04,01, 02,01, 70,A0, 00, A88C, E5E6

; State header. Room $A865. Ice beam practice room - default
$8F:A872             dx C782ED, 09, 00,00, 8480, B48E, 8A01, C1,C1, 0000, 0000, 0000, 8B22, BE3F, 91F5

; Door list. Room $A865. Ice beam practice room
$8F:A88C             dw 9342, 934E

; Room header. Ice beam room
$8F:A890             dx 06,02, 05,02, 01,01, 70,A0, 00, A8B7, E5E6

; State header. Room $A890. Ice beam room - default
$8F:A89D             dx C784A3, 0A, 00,03, 8490, A63C, 879D, 01,01, 0000, 0000, 0000, 8B24, BE5A, 91F5

; Door list. Room $A890. Ice beam room
$8F:A8B7             dw 935A

; Room header. Pre ice beam shaft
$8F:A8B9             dx 07,02, 03,01, 02,03, 70,A0, 00, A8E0, E5E6

; State header. Room $A8B9. Pre ice beam shaft - default
$8F:A8C6             dx C785D6, 09, 00,05, 84A0, B6AD, 8A5B, C1,C1, A8E6, 0000, 0000, 8B2C, BE5A, 91F5

; Door list. Room $A8B9. Pre ice beam shaft
$8F:A8E0             dw 9366, 9372, 937E

; Scroll data. Room $A8B9. Pre ice beam shaft
$8F:A8E6             db 02, 00, 02, 00, 01, 00

; PLM scroll data. Room $A8B9. Pre ice beam shaft (PLM index 0)
$8F:A8EC             db 03,01, 80

; PLM scroll data. Room $A8B9. Pre ice beam shaft (PLM index 1)
$8F:A8EF             db 03,00, 80

; PLM scroll data. Room $A8B9. Pre ice beam shaft (PLM index 2)
$8F:A8F2             db 02,02, 80

; PLM scroll data. Room $A8B9. Pre ice beam shaft (PLM index 3)
$8F:A8F5             db 02,00, 80

; Room header. Crumble block platform shaft
$8F:A8F8             dx 08,02, 02,04, 01,04, 70,A0, 00, A91F, E5E6

; State header. Room $A8F8. Crumble block platform shaft - default
$8F:A905             dx C78A47, 09, 00,00, 84B0, B1F6, 897D, C1,C1, 0000, 0000, 0000, 8B46, BEE1, 91F5

; Door list. Room $A8F8. Crumble block platform shaft
$8F:A91F             dw 938A, 9396

; Room header. Norfair slope
$8F:A923             dx 09,02, 03,07, 0D,03, 70,A0, 02, A94A, E5E6

; State header. Room $A923. Norfair slope - default
$8F:A930             dx C78CFA, 09, 15,05, 84C0, A9DA, 8845, C1,C1, A954, 0000, 0000, 8B4E, BE5A, 91F5

; Door list. Room $A923. Norfair slope
$8F:A94A             dw 93A2, 93AE, 93BA, 93C6, 93D2

; Scroll data. Room $A923. Norfair slope
$8F:A954             db 01, 01, 01, 02, 02, 00, 00, 00, 00, 00, 00, 00, 02, 00, 00, 00, 02, 02, 02, 02, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 02, 02, 02, 02, 02, 02, 00, 02

; Unused PLM scroll data
$8F:A97B             db 19,02, 26,02, 80

; PLM scroll data. Room $A923. Norfair slope (PLM index 0)
$8F:A980             db 19,02, 25,02, 26,02, 80

; PLM scroll data. Room $A923. Norfair slope (PLM index 5)
$8F:A987             db 25,02, 80

; PLM scroll data. Room $A923. Norfair slope (PLM index 8)
$8F:A98A             db 25,00, 80

; Room header. Crocomire
$8F:A98D             dx 0A,02, 0C,0A, 08,01, 70,A0, 01, A9D3, E629,02,A9B9, E5E6

; State header. Room $A98D. Crocomire - default
$8F:A99F             dx C79D71, 1B, 27,05, 84D0, BB0E, 8B11, 01,01, A9D7, 0000, E8CD, 8B9E, B84D, 91F6

; State header. Room $A98D. Crocomire - area mini-boss is dead
$8F:A9B9             dx C79D71, 1B, 00,00, 84D0, BB0E, 8B11, 01,01, A9D7, 0000, E8CD, 8B9E, B858, 91F6

; Door list. Room $A98D. Crocomire
$8F:A9D3             dw 93DE, 93EA

; Scroll data. Room $A98D. Crocomire
$8F:A9D7             db 00, 00, 01, 01, 01, 01, 01, 01

; Unused PLM scroll data
$8F:A9DF             db 01,01, 80

; Unused PLM scroll data
$8F:A9E2             db 00,01, 80

; Room header. Hi-jump room
$8F:A9E5             dx 0B,02, 07,06, 01,01, 70,A0, 00, AA0C, E5E6

; State header. Room $A9E5. Hi-jump room - default
$8F:A9F2             dx C7A036, 0A, 00,03, 84E0, A63F, 87A7, C1,C1, 0000, 0000, 0000, 8BAC, BE3F, 91F6

; Door list. Room $A9E5. Hi-jump room
$8F:AA0C             dw 93F6

; Room header. Norfair grapple ceiling room
$8F:AA0E             dx 0C,02, 0B,06, 04,02, 90,A0, 00, AA35, E5E6

; State header. Room $AA0E. Norfair grapple ceiling room - default
$8F:AA1B             dx C7A18D, 09, 00,00, 84F0, AD8F, 88BF, C0,00, AA39, 0000, 0000, 8BB4, 0000, 91F6

; Door list. Room $AA0E. Norfair grapple ceiling room
$8F:AA35             dw 9402, 940E

; Scroll data. Room $AA0E. Norfair grapple ceiling room
$8F:AA39             db 02, 02, 02, 02, 01, 01, 01, 01

; Room header. Pre hi-jump room
$8F:AA41             dx 0D,02, 08,05, 02,02, 70,A0, 00, AA68, E5E6

; State header. Room $AA41. Pre hi-jump room - default
$8F:AA4E             dx C7AA70, 0A, 00,05, 8500, B3C5, 89CB, C0,00, AA6C, 0000, 0000, 8BC8, 0000, 91F6

; Door list. Room $AA41. Pre hi-jump room
$8F:AA68             dw 941A, 9426

; Scroll data. Room $AA41. Pre hi-jump room
$8F:AA6C             db 00, 01, 00, 00

; PLM scroll data. Room $AA41. Pre hi-jump room (PLM index 1)
$8F:AA70             db 00,02, 02,02, 80

; PLM scroll data. Room $AA41. Pre hi-jump room (PLM index 0)
$8F:AA75             db 00,02, 02,02, 03,02, 80

; PLM scroll data. Room $AA41. Pre hi-jump room (PLM index 2)
$8F:AA7C             db 03,00, 80

; PLM scroll data. Room $AA41. Pre hi-jump room (PLM index 3)
$8F:AA7F             db 03,02, 80

; Room header. Post Crocomire room
$8F:AA82             dx 0E,02, 0A,0A, 02,02, 90,A0, 02, AAA9, E5E6

; State header. Room $AA82. Post Crocomire room - default
$8F:AA8F             dx C7AEB3, 09, 15,05, 8510, A7BB, 87DF, 00,00, AAB1, 0000, 0000, 8BF4, 0000, 91F6

; Door list. Room $AA82. Post Crocomire room
$8F:AAA9             dw 9432, 943E, 944A, 9456

; Scroll data. Room $AA82. Post Crocomire room
$8F:AAB1             db 02, 02, 02, 02

; Room header. Post Crocomire save station
$8F:AAB5             dx 0F,02, 0C,0B, 01,01, 70,A0, 00, AADC, E5E6

; State header. Room $AAB5. Post Crocomire save station - default
$8F:AAC2             dx CE95C2, 19, 15,05, 8520, A642, 87B1, 00,00, 0000, 0000, 0000, 8BFC, 0000, 91F6

; Door list. Room $AAB5. Post Crocomire save station
$8F:AADC             dw 9462

; Room header. Post Crocomire power bombs room
$8F:AADE             dx 10,02, 09,0A, 01,01, 70,A0, 00, AB05, E5E6

; State header. Room $AADE. Post Crocomire power bombs room - default
$8F:AAEB             dx C7B28B, 09, 00,00, 8530, A639, 8793, C1,C1, 0000, 0000, 0000, 8C04, BEC6, 91F6

; Door list. Room $AADE. Post Crocomire power bombs room
$8F:AB05             dw 946E

; Room header. Post Crocomire shaft
$8F:AB07             dx 11,02, 0A,0C, 01,05, 90,A0, 00, AB2E, E5E6

; State header. Room $AB07. Post Crocomire shaft - default
$8F:AB14             dx C7B3E7, 0A, 00,00, 8540, A1D6, 8695, C1,C1, AB36, 0000, 0000, 8C0C, BEE1, 91F6

; Door list. Room $AB07. Post Crocomire shaft
$8F:AB2E             dw 947A, 9486, 9492, 949E

; Scroll data. Room $AB07. Post Crocomire shaft
$8F:AB36             db 02, 02, 02, 02, 02

; Room header. Post Crocomire tidal acid cave
$8F:AB3B             dx 12,02, 0B,0F, 04,01, 70,A0, 00, AB62, E5E6

; State header. Room $AB3B. Post Crocomire tidal acid cave - default
$8F:AB48             dx C7B780, 0A, 00,00, 8550, B4D1, 8A13, C1,C1, 0000, 0000, 0000, 8C14, BEC6, 91F6

; Door list. Room $AB3B. Post Crocomire tidal acid cave
$8F:AB62             dw 94AA

; Room header. Double lake grapple practice room
$8F:AB64             dx 13,02, 07,0C, 03,02, 90,A0, 00, AB8B, E5E6

; State header. Room $AB64. Double lake grapple practice room - default
$8F:AB71             dx C7BB6B, 0A, 00,00, 8560, A133, 8683, C1,C1, 0000, 0000, 0000, 8C1C, BE5A, 91F6

; Door list. Room $AB64. Double lake grapple practice room
$8F:AB8B             dw 94B6, 94C2

; Room header. Huge jump room
$8F:AB8F             dx 14,02, 04,0F, 08,03, 90,A0, 00, ABB6, E5E6

; State header. Room $AB8F. Huge jump room - default
$8F:AB9C             dx C7BECB, 0A, 00,05, 8570, B11D, 8953, C0,00, ABBA, 0000, 0000, 8C2A, 0000, 91F6

; Door list. Room $AB8F. Huge jump room
$8F:ABB6             dw 94CE, 94DA

; Scroll data. Room $AB8F. Huge jump room
$8F:ABBA             db 02, 02, 02, 02, 02, 00, 00, 00, 02, 02, 02, 02, 02, 00, 00, 00, 01, 01, 01, 01, 01, 01, 01, 01

; Room header. Grapple practice shaft
$8F:ABD2             dx 15,02, 06,0C, 01,03, 90,A0, 00, ABF9, E5E6

; State header. Room $ABD2. Grapple practice shaft - default
$8F:ABDF             dx C7CD91, 0A, 00,00, 8580, B67A, 8A49, C1,C1, ABFD, 0000, 0000, 8C32, BEE1, 91F6

; Door list. Room $ABD2. Grapple practice shaft
$8F:ABF9             dw 94E6, 94F2

; Scroll data. Room $ABD2. Grapple practice shaft
$8F:ABFD             db 02, 02, 01

; Room header. Single lake grapple practice room
$8F:AC00             dx 16,02, 04,0E, 02,01, 70,A0, 00, AC27, E5E6

; State header. Room $AC00. Single lake grapple practice room - default
$8F:AC0D             dx C7CFCD, 0A, 00,05, 8590, B3BF, 89B7, C1,C1, 0000, 0000, 0000, 8C34, BEC6, 91F6

; Door list. Room $AC00. Single lake grapple practice room
$8F:AC27             dw 94FE, 950A

; Room header. Grapple room
$8F:AC2B             dx 17,02, 03,0E, 01,04, 90,A0, 00, AC52, E5E6

; State header. Room $AC2B. Grapple room - default
$8F:AC38             dx C7D13C, 0A, 00,03, 85A0, A964, 8825, C1,C1, AC56, 0000, 0000, 8C36, BEE1, 91F6

; Door list. Room $AC2B. Grapple room
$8F:AC52             dw 9516, 9522

; Scroll data. Room $AC2B. Grapple room
$8F:AC56             db 02, 02, 01, 00

; Room header. Bubble Norfair reserve tank room
$8F:AC5A             dx 18,02, 12,02, 02,01, 70,A0, 00, AC81, E5E6

; State header. Room $AC5A. Bubble Norfair reserve tank room - default
$8F:AC67             dx C7D4FE, 09, 00,00, 85B0, B5E7, 8A37, C1,C1, 0000, 0000, 0000, 8C3E, BF68, 91F6

; Door list. Room $AC5A. Bubble Norfair reserve tank room
$8F:AC81             dw 952E

; Room header. Pre Bubble Norfair reserve tank room
$8F:AC83             dx 19,02, 14,02, 02,01, 70,A0, 00, ACAA, E5E6

; State header. Room $AC83. Pre Bubble Norfair reserve tank room - default
$8F:AC90             dx C7D66F, 09, 00,00, 85C0, AEB1, 8907, C1,C1, ACAE, 0000, 0000, 8C4C, BF83, 91F6

; Door list. Room $AC83. Pre Bubble Norfair reserve tank room
$8F:ACAA             dw 953A, 9546

; Scroll data. Room $AC83. Pre Bubble Norfair reserve tank room
$8F:ACAE             db 00, 01

; PLM scroll data. Room $AC83. Pre Bubble Norfair reserve tank room (PLM index 0)
$8F:ACB0             db 00,01, 80

; Room header. Bubble Norfair mainstreet
$8F:ACB3             dx 1A,02, 16,02, 02,04, 90,A0, 00, ACDA, E5E6

; State header. Room $ACB3. Bubble Norfair mainstreet - default
$8F:ACC0             dx C7D895, 09, 00,00, 85D0, B3D8, 89D9, C1,C1, ACE8, 0000, 0000, 8C5A, BF83, 91F6

; Door list. Room $ACB3. Bubble Norfair mainstreet
$8F:ACDA             dw 9552, 955E, 956A, 9576, 9582, 958E, 959A

; Scroll data. Room $ACB3. Bubble Norfair mainstreet
$8F:ACE8             db 02, 02, 02, 02, 02, 02, 02, 02

; Room header. Speed booster lavaquake
$8F:ACF0             dx 1B,02, 19,01, 0C,02, 70,A0, 00, AD17, E5E6

; State header. Room $ACF0. Speed booster lavaquake - default
$8F:ACFD             dx C7E08C, 09, 00,05, 85E0, B88F, 8ABB, C1,C1, 0000, 0000, 0000, 8C6E, BE5A, 91F6

; Door list. Room $ACF0. Speed booster lavaquake
$8F:AD17             dw 95A6, 95B2

; Room header. Speed booster room
$8F:AD1B             dx 1C,02, 25,02, 01,01, 70,A0, 00, AD5C, E5E6

; State header. Room $AD1B. Speed booster room - default
$8F:AD28             dx C7EAA8, 09, 00,03, 8600, B766, 8A8D, C1,C1, 0000, 0000, 0000, 8C82, BE3F, 91F6

; Unused state header
$8F:AD28             dx C7EAA8, 09, 00,03, 8600, B766, 8A8D, C1,C1, 0000, 0000, 0000, 8C82, BE3F, 91F6

; Door list. Room $AD1B. Speed booster room
$8F:AD5C             dw 95BE

; Room header. Alcoon shaft
$8F:AD5E             dx 1D,02, 18,03, 06,04, 70,A0, 00, AD85, E5E6

; State header. Room $AD5E. Alcoon shaft - default
$8F:AD28             dx C7EAA8, 09, 00,03, 8600, B766, 8A8D, C1,C1, 0000, 0000, 0000, 8C82, BE3F, 91F6

; Door list. Room $AD5E. Alcoon shaft
$8F:AD85             dw 95CA, 95D6, 95E2, 95EE, 95FA

; Scroll data. Room $AD5E. Alcoon shaft
$8F:AD8F             db 02, 00, 01, 01, 01, 01, 02, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 01, 00, 00, 00, 00, 00

; PLM scroll data. Room $AD5E. Alcoon shaft (PLM index 0)
$8F:ADA7             db 01,00, 80

; PLM scroll data. Room $AD5E. Alcoon shaft (PLM indices 1/4)
$8F:ADAA             db 01,01, 80

; Room header. Pre wave beam room
$8F:ADAD             dx 1E,02, 19,04, 04,02, 90,A0, 00, ADD4, E5E6

; State header. Room $ADAD. Pre wave beam room - default
$8F:ADBA             dx C7FF02, 09, 00,05, 8620, A8E1, 880B, C0,00, ADDA, 0000, 0000, 8CB0, 0000, 91F6

; Door list. Room $ADAD. Pre wave beam room
$8F:ADD4             dw 9606, 9612, 961E

; Scroll data. Room $ADAD. Pre wave beam room
$8F:ADDA             db 02, 02, 02, 02

; Room header. Wave beam room
$8F:ADDE             dx 1F,02, 1D,04, 01,01, 70,A0, 00, AE05, E5E6

; State header. Room $ADDE. Wave beam room - default
$8F:ADEB             dx C88532, 09, 00,03, 8630, A4EE, 871D, C1,C1, 0000, 0000, 0000, 8CCA, BEC6, 91F6

; Door list. Room $ADDE. Wave beam room
$8F:AE05             dw 962A

; Room header. Norfair sinking tripper hall
$8F:AE07             dx 20,02, 19,06, 04,01, 70,A0, 00, AE2E, E5E6

; State header. Room $AE07. Norfair sinking tripper hall - default
$8F:AE14             dx C8865C, 09, 00,00, 8640, B733, 8A7B, C1,C1, 0000, 0000, 0000, 8CD2, BEC6, 91F6

; Door list. Room $AE07. Norfair sinking tripper hall
$8F:AE2E             dw 9636, 9642

; Room header. Volcano room
$8F:AE32             dx 21,02, 1B,06, 03,03, 70,A0, 00, AE59, E5E6

; State header. Room $AE32. Volcano room - default
$8F:AE3F             dx C88953, 09, 00,00, 8650, BB34, 8B29, 00,00, AE5D, 0000, 0000, 8CD4, 0000, 91F6

; Door list. Room $AE32. Volcano room
$8F:AE59             dw 964E, 965A

; Scroll data. Room $AE32. Volcano room
$8F:AE5D             db 00, 00, 02, 00, 00, 02, 00, 00, 01

; PLM scroll data. Room $AE32. Volcano room (PLM index 0)
$8F:AE66             db 06,01, 07,01, 80

; PLM scroll data. Room $AE32. Volcano room (PLM index 1)
$8F:AE6B             db 08,01, 80

; PLM scroll data. Room $AE32. Volcano room (PLM index 7)
$8F:AE6E             db 08,00, 80

; PLM scroll data. Room $AE32. Volcano room (PLM index Bh)
$8F:AE71             db 07,00, 80

; Room header. Pre lava dive shaft
$8F:AE74             dx 22,02, 19,08, 02,03, 70,A0, 00, AE9B, E5E6

; State header. Room $AE74. Pre lava dive shaft - default
$8F:AE81             dx C8943A, 09, 00,00, 8670, B995, 8ADF, 00,00, AEA3, 0000, 0000, 8D1E, 0000, 91F6

; Door list. Room $AE74. Pre lava dive shaft
$8F:AE9B             dw 9666, 9672, 967E, 968A

; Scroll data. Room $AE74. Pre lava dive shaft
$8F:AEA3             db 00, 02, 00, 02, 00, 01

; PLM scroll data. Room $AE74. Pre lava dive shaft (PLM index 0)
$8F:AEA9             db 02,01, 80

; PLM scroll data. Room $AE74. Pre lava dive shaft (PLM index 1)
$8F:AEAC             db 02,00, 03,02, 80

; PLM scroll data. Room $AE74. Pre lava dive shaft (PLM index 5)
$8F:AEB1             db 03,00, 80

; Room header. Magdollite multiviola hall
$8F:AEB4             dx 23,02, 17,08, 03,01, 70,A0, 00, AEDB, E5E6

; State header. Room $AEB4. Magdollite multiviola hall - default
$8F:AEC1             dx C89D5D, 09, 00,00, 8680, AC53, 8887, C1,C1, 0000, 0000, 0000, 8D56, BEC6, 91F6

; Door list. Room $AEB4. Magdollite multiviola hall
$8F:AEDB             dw 9696, 96A2

; Room header. Purple shaft
$8F:AEDF             dx 24,02, 16,06, 01,03, A0,A0, 00, AF06, E5E6

; State header. Room $AEDF. Purple shaft - default
$8F:AEEC             dx C89FE3, 09, 00,00, 8690, AEA8, 88E9, C1,C1, AF0C, 0000, 0000, 8D58, BF68, 91F6

; Door list. Room $AEDF. Purple shaft
$8F:AF06             dw 96AE, 96BA, 96C6

; Scroll data. Room $AEDF. Purple shaft
$8F:AF0C             db 02, 02, 01

; PLM scroll data. Room $AEDF. Purple shaft (PLM indices 0/3)
$8F:AF0F             db 00,02, 01,02, 80

; Room header. Lava dive room
$8F:AF14             dx 25,02, 16,0A, 04,03, 70,A0, 00, AF3B, E5E6

; State header. Room $AF14. Lava dive room - default
$8F:AF21             dx C8A2CF, 09, 00,05, 86A0, AD09, 88A3, C1,C1, 0000, 0000, 0000, 8D7E, BE5A, 91F6

; Door list. Room $AF14. Lava dive room
$8F:AF3B             dw 96D2, 96DE

; Room header. Norfair -> Lower Norfair elevator
$8F:AF3F             dx 26,02, 15,0A, 01,01, 70,A0, 00, AF66, E5E6

; State header. Room $AF3F. Norfair -> Lower Norfair elevator - default
$8F:AF4C             dx C8AA89, 09, 15,05, 86B0, A544, 873D, C1,C1, AF6E, 0000, 0000, 8D80, BEC6, 91F6

; Door list. Room $AF3F. Norfair -> Lower Norfair elevator
$8F:AF66             dw 96EA, 96F6, 88FC, 9702

; Scroll data. Room $AF3F. Norfair -> Lower Norfair elevator
$8F:AF6E             db 01

; PLM scroll data. Room $AF3F. Norfair -> Lower Norfair elevator (PLM index 0)
$8F:AF6F             db 00,02, 80

; Room header. Norfair wave gate room
$8F:AF72             dx 27,02, 14,05, 02,02, A0,A0, 00, AF99, E5E6

; State header. Room $AF72. Norfair wave gate room - default
$8F:AF7F             dx C8ABED, 09, 00,00, 86C0, BBD7, 8B3B, C0,00, AF9F, 0000, 0000, 8D88, 0000, 91F6

; Door list. Room $AF72. Norfair wave gate room
$8F:AF99             dw 970E, 971A, 9726

; Scroll data. Room $AF72. Norfair wave gate room
$8F:AF9F             db 02, 02, 01, 01

; Room header. Norfair long lavaquake hall
$8F:AFA3             dx 28,02, 11,04, 05,01, 70,A0, 00, AFCA, E5E6

; State header. Room $AFA3. Norfair long lavaquake hall - default
$8F:AFB0             dx C8B15B, 09, 00,00, 86D0, A6A8, 87C9, C1,C1, 0000, 0000, 0000, 8D96, BEC6, 91F6

; Door list. Room $AFA3. Norfair long lavaquake hall
$8F:AFCA             dw 9732, 973E

; Room header. Norfair metal floor hall
$8F:AFCE             dx 29,02, 10,09, 04,01, 70,A0, 00, AFF5, E5E6

; State header. Room $AFCE. Norfair metal floor hall - default
$8F:AFDB             dx C8B4F9, 09, 00,00, 86F0, B32C, 89A5, C1,C1, 0000, 0000, 0000, 8D98, BEC6, 91F6

; Door list. Room $AFCE. Norfair metal floor hall
$8F:AFF5             dw 974A, 9756, 9762

; Room header. Norfair lava-spike hall
$8F:AFFB             dx 2A,02, 15,09, 04,01, 70,A0, 00, B022, E5E6

; State header. Room $AFFB. Norfair lava-spike hall - default
$8F:B008             dx C8B853, 09, 00,00, 8700, A3F5, 86EF, C1,C1, 0000, 0000, 0000, 8D9A, BEC6, 91F6

; Door list. Room $AFFB. Norfair lava-spike hall
$8F:B022             dw 976E, 977A

; Room header. Norfair energy station
$8F:B026             dx 2B,02, 14,09, 01,01, 70,A0, 00, B04D, E5E6

; State header. Room $B026. Norfair energy station - default
$8F:B033             dx CE8FA6, 17, 00,00, 8710, A55A, 8751, 00,00, 0000, 0000, 0000, 8D9C, 0000, 91F6

; Door list. Room $B026. Norfair energy station
$8F:B04D             dw 9786, 9792

; Room header. Purple farming room
$8F:B051             dx 2C,02, 17,07, 01,01, 70,A0, 00, B078, E5E6

; State header. Room $B051. Purple farming room - default
$8F:B05E             dx C8B9CF, 09, 00,00, 8720, A2DF, 86C7, 01,01, 0000, 0000, 0000, 8DA4, BF68, 91F6

; Door list. Room $B051. Purple farming room
$8F:B078             dw 979E

; Room header. Speed booster lavaquake farming room
$8F:B07A             dx 2D,02, 18,01, 01,02, 70,A0, 00, B0A1, E5E6

; State header. Room $B07A. Speed booster lavaquake farming room - default
$8F:B087             dx C8BB21, 09, 00,05, 8730, B912, 8ACD, 00,00, B0A5, 0000, 0000, 8DA6, 0000, 91F6

; Door list. Room $B07A. Speed booster lavaquake farming room
$8F:B0A1             dw 97AA, 97B6

; Scroll data. Room $B07A. Speed booster lavaquake farming room
$8F:B0A5             db 00, 01

; PLM scroll data. Room $B07A. Speed booster lavaquake farming room (PLM index 0)
$8F:B0A7             db 00,02, 01,02, 80

; PLM scroll data. Room $B07A. Speed booster lavaquake farming room (PLM index 2)
$8F:B0AC             db 00,02, 01,01, 80

; PLM scroll data. Room $B07A. Speed booster lavaquake farming room (PLM index 4)
$8F:B0B1             db 00,00, 80

; Room header. Norfair map station
$8F:B0B4             dx 2E,02, 09,04, 01,01, 70,A0, 00, B0DB, E5E6

; State header. Room $B0B4. Norfair map station - default
$8F:B0C1             dx CE83C3, 15, 00,00, 8740, A55D, 875B, 00,00, 0000, 0000, 0000, 8DD8, 0000, 91F6

; Door list. Room $B0B4. Norfair map station
$8F:B0DB             dw 97C2

; Room header. Bubble Norfair save station
$8F:B0DD             dx 2F,02, 15,03, 01,01, 70,A0, 00, B104, E5E6

; State header. Room $B0DD. Bubble Norfair save station - default
$8F:B0EA             dx CE92CB, 19, 15,05, 8750, B3C2, 89C1, 00,00, 0000, 0000, 0000, 8DE0, 0000, 91F6

; Door list. Room $B0DD. Bubble Norfair save station
$8F:B104             dw 97CE

; Room header. Norfair speed blockade hall
$8F:B106             dx 30,02, 0C,05, 08,01, 70,A0, 00, B12D, E5E6

; State header. Room $B106. Norfair speed blockade hall - default
$8F:B113             dx C8BDE8, 0A, 00,00, 8760, A645, 87BB, C1,01, B131, 0000, 0000, 8DE8, BE3F, 91F6

; Door list. Room $B106. Norfair speed blockade hall
$8F:B12D             dw 97DA, 97E6

; Scroll data. Room $B106. Norfair speed blockade hall
$8F:B131             db 01, 01, 01, 01, 01, 01, 01, 01

; Room header. Norfair stone zoomer shaft
$8F:B139             dx 31,02, 13,06, 01,03, 70,A0, 00, B160, E5E6

; State header. Room $B139. Norfair stone zoomer shaft - default
$8F:B146             dx C8C165, 09, 00,00, 8762, A967, 8833, 01,C1, B164, 0000, 0000, 8DEA, BEE1, 91F6

; Door list. Room $B139. Norfair stone zoomer shaft
$8F:B160             dw 97F2, 97FE

; Scroll data. Room $B139. Norfair stone zoomer shaft
$8F:B164             db 02, 02, 02

; Room header. Rock Norfair save station
$8F:B167             dx 32,02, 0B,05, 01,01, 70,A0, 00, B18E, E5E6

; State header. Room $B167. Rock Norfair save station - default
$8F:B174             dx CE9EF6, 19, 15,05, 8764, B1F0, 8969, 00,00, 0000, 0000, 0000, 8DEC, 0000, 91F6

; Door list. Room $B167. Rock Norfair save station
$8F:B18E             dw 980A, 9816

; Room header. Pre Crocomire save station
$8F:B192             dx 33,02, 10,08, 01,01, 70,A0, 00, B1B9, E5E6

; State header. Room $B192. Pre Crocomire save station - default
$8F:B19F             dx CE95C2, 19, 15,05, 8766, B1F3, 8973, 00,00, 0000, 0000, 0000, 8DF4, 0000, 91F6

; Door list. Room $B192. Pre Crocomire save station
$8F:B1B9             dw 9822

; Room header. Pre Lower Norfair save station
$8F:B1BB             dx 34,02, 14,0A, 01,01, 70,A0, 00, B1E2, E5E6

; State header. Room $B1BB. Pre Lower Norfair save station - default
$8F:B1C8             dx CE92CB, 19, 15,05, 8768, BB31, 8B1F, 00,00, B1E4, 0000, 0000, 8DFC, 0000, 0000

; Door list. Room $B1BB. Pre Lower Norfair save station
$8F:B1E2             dw 982E

; Scroll data. Room $B1BB. Pre Lower Norfair save station
$8F:B1E4             db 01

; Room header. Lower Norfair chozo room
$8F:B1E5             dx 35,02, 0F,0D, 03,03, 90,A0, 00, B20C, E5E6

; State header. Room $B1E5. Lower Norfair chozo room - default
$8F:B1F2             dx C8C4D3, 09, 18,05, 876A, A23C, 86B1, C1,C1, B210, 0000, 0000, 8E04, BF32, 91F7

; Door list. Room $B1E5. Lower Norfair chozo room
$8F:B20C             dw 983A, 9846

; Scroll data. Room $B1E5. Lower Norfair chozo room
$8F:B210             db 02, 02, 00, 01, 01, 00, 00, 00, 00

; Unused PLM scroll data
$8F:B219             db 03,01, 04,01, 06,00, 07,00, 08,00, 80

; PLM scroll data. Room $B1E5. Lower Norfair chozo room (PLM index 0)
$8F:B224             db 03,02, 04,02, 06,02, 07,02, 80

; PLM scroll data. Room $B1E5. Lower Norfair chozo room (PLM index 1)
$8F:B22D             db 04,00, 06,01, 07,01, 08,01, 80

; Room header. Lower Norfair mainstreet
$8F:B236             dx 36,02, 11,0B, 08,03, 70,A0, 00, B25D, E5E6

; State header. Room $B236. Lower Norfair mainstreet - default
$8F:B243             dx C8D59C, 09, 18,05, 878A, AFEA, 893D, C1,01, B265, 0000, 0000, 8E12, BF17, 91F7

; Door list. Room $B236. Lower Norfair mainstreet
$8F:B25D             dw 9852, 985E, 986A, 88FC

; Scroll data. Room $B236. Lower Norfair mainstreet
$8F:B265             db 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 01, 01, 01, 01, 01, 01, 01, 01

; PLM scroll data. Room $B236. Lower Norfair mainstreet (PLM indices 0/2)
$8F:B27D             db 0C,02, 80

; PLM scroll data. Room $B236. Lower Norfair mainstreet (PLM index 4)
$8F:B280             db 0C,00, 80

; Room header. Golden Torizo
$8F:B283             dx 37,02, 12,0F, 02,02, 70,A0, 00, B2C9, E629,04,B2AF, E5E6

; State header. Room $B283. Golden Torizo - default
$8F:B295             dx C8E09D, 09, 24,03, 879A, B720, 8A6D, C0,00, B2CD, 0000, 0000, 8E3E, 0000, 91F7

; State header. Room $B283. Golden Torizo - area torizo is dead
$8F:B2AF             dx C8E09D, 09, 00,03, 879A, B720, 8A6D, C0,00, B2CD, 0000, 0000, 8E3E, 0000, 91F7

; Door list. Room $B283. Golden Torizo
$8F:B2C9             dw 9876, 9882

; Scroll data. Room $B283. Golden Torizo
$8F:B2CD             db 02, 02, 01, 01

; PLM scroll data. Room $B283. Golden Torizo (PLM index 0)
$8F:B2D1             db 00,02, 01,02, 02,01, 03,01, 80

; Room header. Ripper ii room
$8F:B2DA             dx 38,02, 15,0E, 04,01, 70,A0, 00, B301, E5E6

; State header. Room $B2DA. Ripper ii room - default
$8F:B2E7             dx C8E900, 09, 18,05, 87AA, A48B, 870F, C1,C1, 0000, 0000, 0000, 8E82, BF17, 91F7

; Door list. Room $B2DA. Ripper ii room
$8F:B301             dw 988E, 989A

; Room header. Lower Norfair energy station
$8F:B305             dx 39,02, 15,0F, 01,01, 70,A0, 00, B32C, E5E6

; State header. Room $B305. Lower Norfair energy station - default
$8F:B312             dx CE98DC, 17, 00,03, 87BA, A623, 8777, 00,00, 0000, 0000, 0000, 8E90, 0000, 91F7

; Door list. Room $B305. Lower Norfair energy station
$8F:B32C             dw 98A6

; Room header. Ridley
$8F:B32E             dx 3A,02, 17,10, 01,02, 70,A0, 00, B374, E629,01,B35A, E5E6

; State header. Room $B32E. Ridley - default
$8F:B340             dx C8EBFD, 09, 24,04, 87BC, A626, 8781, 01,C1, B378, 0000, E950, 8E98, BF32, 91F7

; State header. Room $B32E. Ridley - main area boss is dead
$8F:B35A             dx C8EBFD, 09, 00,03, 87BC, A626, 8781, 01,C1, B378, 0000, E950, 8E98, BF32, 91F7

; Door list. Room $B32E. Ridley
$8F:B374             dw 98B2, 98BE

; Scroll data. Room $B32E. Ridley
$8F:B378             db 02, 02

; Room header. Pre Ridley hall
$8F:B37A             dx 3B,02, 18,10, 03,01, 70,A0, 00, B3A1, E5E6

; State header. Room $B37A. Pre Ridley hall - default
$8F:B387             dx C8EDCE, 09, 18,05, 87CC, B769, 8A97, C1,C1, 0000, 0000, 0000, 8EA6, BF4D, 91F7

; Door list. Room $B37A. Pre Ridley hall
$8F:B3A1             dw 98CA, 98D6

; Room header. Pre pillars hall
$8F:B3A5             dx 3C,02, 19,0C, 01,03, 70,A0, 00, B3CC, E5E6

; State header. Room $B3A5. Pre pillars hall - default
$8F:B3B2             dx C8F01F, 09, 00,00, 87DC, A4F1, 8727, C1,C1, B3D6, 0000, 0000, 8EBA, BEAB, 91F7

; Door list. Room $B3A5. Pre pillars hall
$8F:B3CC             dw 98E2, 98EE, 98FA, 9906, 9912

; Scroll data. Room $B3A5. Pre pillars hall
$8F:B3D6             db 02, 01, 00

; PLM scroll data. Room $B3A5. Pre pillars hall (PLM index 0)
$8F:B3D9             db 01,02, 80

; PLM scroll data. Room $B3A5. Pre pillars hall (PLM index 2)
$8F:B3DC             db 01,02, 02,01, 80

; Room header. Unused room
$8F:B3E1             dx 3D,02, 1A,0B, 01,01, 70,A0, 00, B408, E5E6

; State header. Room $B3E1. Unused room - default
$8F:B3EE             dx C8F40B, 09, 00,00, 87EC, AD06, 8899, C1,C1, 0000, 0000, 0000, 8ED4, BE90, 91F7

; Door list. Room $B3E1. Unused room
$8F:B408             dw 991E

; Room header. Lower Norfair multi-level one-way shaft
$8F:B40A             dx 3E,02, 1A,09, 04,04, 70,A0, 00, B431, E5E6

; State header. Room $B40A. Lower Norfair multi-level one-way shaft - default
$8F:B417             dx C8F58B, 09, 00,00, 87FC, A560, 8765, C1,C1, B435, 0000, 0000, 8ED6, BF68, 91F7

; Door list. Room $B40A. Lower Norfair multi-level one-way shaft
$8F:B431             dw 992A, 9936

; Scroll data. Room $B40A. Lower Norfair multi-level one-way shaft
$8F:B435             db 00, 00, 00, 02, 00, 00, 00, 02, 00, 00, 00, 02, 01, 01, 01, 01

; PLM scroll data. Room $B40A. Lower Norfair multi-level one-way shaft (PLM index 0)
$8F:B445             db 06,01, 80

; PLM scroll data. Room $B40A. Lower Norfair multi-level one-way shaft (PLM index 1)
$8F:B448             db 06,00, 80

; PLM scroll data. Room $B40A. Lower Norfair multi-level one-way shaft (PLM index 2)
$8F:B44B             db 07,01, 80

; PLM scroll data. Room $B40A. Lower Norfair multi-level one-way shaft (PLM index 6)
$8F:B44E             db 07,00, 80

; PLM scroll data. Room $B40A. Lower Norfair multi-level one-way shaft (PLM index Ah)
$8F:B451             db 0E,01, 80

; PLM scroll data. Room $B40A. Lower Norfair multi-level one-way shaft (PLM index Dh)
$8F:B454             db 0E,00, 80

; Room header. Pillars hall
$8F:B457             dx 3F,02, 1A,0E, 04,01, 70,A0, 00, B47E, E5E6

; State header. Room $B457. Pillars hall - default
$8F:B464             dx C8FCC5, 09, 00,00, 880C, AD6C, 88B1, C1,C1, 0000, 0000, 0000, 8F38, BF17, 91F7

; Door list. Room $B457. Pillars hall
$8F:B47E             dw 9942, 994E

; Room header. Lower Norfair holtz room
$8F:B482             dx 40,02, 1B,10, 03,01, 70,A0, 00, B4A9, E5E6

; State header. Room $B482. Lower Norfair holtz room - default
$8F:B48F             dx C98222, 09, 00,00, 881C, AA8D, 885F, C1,C1, 0000, 0000, 0000, 8F3A, BF4D, 91F7

; Door list. Room $B482. Lower Norfair holtz room
$8F:B4A9             dw 995A, 9966

; Room header. Lower Norfair wall space pirates shaft
$8F:B4AD             dx 41,02, 1E,09, 01,06, 70,A0, 00, B4D4, E5E6

; State header. Room $B4AD. Lower Norfair wall space pirates shaft - default
$8F:B4BA             dx C984D3, 09, 00,00, 882C, A82E, 87F5, C1,C1, B4DA, 0000, 0000, 8F3C, BEFC, 91F7

; Door list. Room $B4AD. Lower Norfair wall space pirates shaft
$8F:B4D4             dw 9972, 997E, 998A

; Scroll data. Room $B4AD. Lower Norfair wall space pirates shaft
$8F:B4DA             db 00, 02, 02, 02, 02, 01

; PLM scroll data. Room $B4AD. Lower Norfair wall space pirates shaft (PLM index 0)
$8F:B4E0             db 00,02, 01,02, 80

; Room header. Lower Norfair rising acid room
$8F:B4E5             dx 42,02, 1F,09, 04,05, 70,A0, 00, B50C, E5E6

; State header. Room $B4E5. Lower Norfair rising acid room - default
$8F:B4F2             dx C9899F, 09, 00,00, 883C, AEF4, 891D, C1,C1, 0000, 0000, 0000, 8F7A, BE5A, 91F7

; Door list. Room $B4E5. Lower Norfair rising acid room
$8F:B50C             dw 9996, 99A2

; Room header. Lower Norfair spring ball maze room
$8F:B510             dx 43,02, 21,05, 05,02, 70,A0, 00, B537, E5E6

; State header. Room $B510. Lower Norfair spring ball maze room - default
$8F:B51D             dx C994BA, 09, 00,05, 885C, AE52, 88D1, C1,C1, B53D, 0000, 0000, 8F7C, BF68, 91F7

; Door list. Room $B510. Lower Norfair spring ball maze room
$8F:B537             dw 99AE, 99BA, 99C6

; Scroll data. Room $B510. Lower Norfair spring ball maze room
$8F:B53D             db 02, 00, 00, 00, 00, 01, 01, 00, 00, 00

; PLM scroll data. Room $B510. Lower Norfair spring ball maze room (PLM index 0)
$8F:B547             db 01,01, 02,01, 06,00, 80

; PLM scroll data. Room $B510. Lower Norfair spring ball maze room (PLM index 4)
$8F:B54E             db 01,00, 02,00, 06,01, 80

; PLM scroll data. Room $B510. Lower Norfair spring ball maze room (PLM index Ch)
$8F:B555             db 03,01, 04,02, 80

; Room header. Lower Norfair escape power bomb room
$8F:B55A             dx 44,02, 25,06, 01,01, 70,A0, 00, B581, E5E6

; State header. Room $B55A. Lower Norfair escape power bomb room - default
$8F:B567             dx C99CE2, 09, 00,00, 886C, AEA5, 88DF, C1,C1, 0000, 0000, 0000, 8FD2, BF32, 91F7

; Door list. Room $B55A. Lower Norfair escape power bomb room
$8F:B581             dw 99D2, 99DE

; Room header. Lower Norfair south kihunter shaft
$8F:B585             dx 45,02, 23,09, 03,05, 70,A0, 00, B5AC, E5E6

; State header. Room $B585. Lower Norfair south kihunter shaft - default
$8F:B592             dx C99E7B, 09, 00,00, 887C, A428, 86FD, C1,C1, B5B4, 0000, 0000, 8FDA, BE5A, 91F7

; Door list. Room $B585. Lower Norfair south kihunter shaft
$8F:B5AC             dw 99EA, 99F6, 9A02, 9A0E

; Scroll data. Room $B585. Lower Norfair south kihunter shaft
$8F:B5B4             db 02, 00, 00, 02, 00, 00, 02, 00, 00, 02, 00, 00, 02, 00, 02

; PLM scroll data. Room $B585. Lower Norfair south kihunter shaft (PLM indices 0/4)
$8F:B5C3             db 0A,02, 0D,02, 80

; PLM scroll data. Room $B585. Lower Norfair south kihunter shaft (PLM indices 3/5)
$8F:B5C8             db 0A,00, 0D,00, 80

; PLM scroll data. Room $B585. Lower Norfair south kihunter shaft (PLM index 6)
$8F:B5CD             db 00,02, 03,02, 80

; PLM scroll data. Room $B585. Lower Norfair south kihunter shaft (PLM index Ah)
$8F:B5D2             db 00,02, 80

; Room header. Lower Norfair spike platform room
$8F:B5D5             dx 46,02, 20,0E, 06,03, 70,A0, 00, B5FC, E5E6

; State header. Room $B5D5. Lower Norfair spike platform room - default
$8F:B5E2             dx C9A88C, 09, 00,00, 888C, B259, 898B, C1,C1, B600, 0000, 0000, 9036, BF32, 91F7

; Door list. Room $B5D5. Lower Norfair spike platform room
$8F:B5FC             dw 9A1A, 9A26

; Scroll data. Room $B5D5. Lower Norfair spike platform room
$8F:B600             db 00, 01, 01, 01, 00, 01, 00, 00, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00

; PLM scroll data. Room $B5D5. Lower Norfair spike platform room (PLM index 0)
$8F:B612             db 07,02, 80

; PLM scroll data. Room $B5D5. Lower Norfair spike platform room (PLM index 2)
$8F:B615             db 01,01, 07,00, 80

; PLM scroll data. Room $B5D5. Lower Norfair spike platform room (PLM indices 8/Ch)
$8F:B61A             db 04,01, 80

; PLM scroll data. Room $B5D5. Lower Norfair spike platform room (PLM index Ah)
$8F:B61D             db 00,01, 01,01, 80

; PLM scroll data. Room $B5D5. Lower Norfair spike platform room (PLM indices 9/Bh)
$8F:B622             db 04,00, 80

; PLM scroll data. Room $B5D5. Lower Norfair spike platform room (PLM index Dh)
$8F:B625             db 00,00, 80

; PLM scroll data. Room $B5D5. Lower Norfair spike platform room (PLM index 11h)
$8F:B628             db 01,00, 80

; Room header. Ninja space pirate hall
$8F:B62B             dx 47,02, 1E,10, 03,01, 70,A0, 00, B652, E5E6

; State header. Room $B62B. Ninja space pirate hall - default
$8F:B638             dx C9B1C7, 09, 00,00, 889C, A219, 86A3, C1,C1, 0000, 0000, 0000, 90C8, BF4D, 91F7

; Door list. Room $B62B. Ninja space pirate hall
$8F:B652             dw 9A32, 9A3E

; Room header. Lower Norfair north kihunter shaft
$8F:B656             dx 48,02, 1D,03, 04,03, 70,A0, 00, B67D, E5E6

; State header. Room $B656. Lower Norfair north kihunter shaft - default
$8F:B663             dx C9B4AB, 09, 18,05, 88AC, BA4B, 8AFB, C1,C1, B681, 0000, 0000, 90D0, BF68, 91F7

; Door list. Room $B656. Lower Norfair north kihunter shaft
$8F:B67D             dw 9A4A, 9A56

; Scroll data. Room $B656. Lower Norfair north kihunter shaft
$8F:B681             db 00, 02, 00, 00, 00, 02, 00, 00, 00, 01, 01, 01

; PLM scroll data. Room $B656. Lower Norfair north kihunter shaft (PLM index 0)
$8F:B68D             db 09,00, 80

; PLM scroll data. Room $B656. Lower Norfair north kihunter shaft (PLM index 6)
$8F:B690             db 08,01, 09,01, 80

; PLM scroll data. Room $B656. Lower Norfair north kihunter shaft (PLM index 7)
$8F:B695             db 08,00, 80

; Room header. Ridley's energy tank
$8F:B698             dx 49,02, 16,11, 01,01, 70,A0, 00, B6BF, E5E6

; State header. Room $B698. Ridley's energy tank - default
$8F:B6A5             dx C9C30D, 09, 00,00, 88BC, AEAB, 88F3, 01,01, 0000, 0000, 0000, 9108, BF32, 91F7

; Door list. Room $B698. Ridley's energy tank
$8F:B6BF             dw 9A62

; Room header. Screw attack room
$8F:B6C1             dx 4A,02, 14,0E, 01,03, 70,A0, 00, B6E8, E5E6

; State header. Room $B6C1. Screw attack room - default
$8F:B6CE             dx C9C428, 09, 00,03, 88CC, AEAE, 88FD, 01,C1, 0000, 0000, 0000, 9110, BF32, 91F7

; Door list. Room $B6C1. Screw attack room
$8F:B6E8             dw 9A6E, 9A7A, 9A86

; Room header. Norfair rolling boulder shaft
$8F:B6EE             dx 4B,02, 23,06, 03,06, 70,A0, 00, B715, E5E6

; State header. Room $B6EE. Norfair rolling boulder shaft - default
$8F:B6FB             dx C9C706, 0A, 18,05, 88DC, AB80, 8871, 00,00, B71B, 0000, 0000, 9118, 0000, 0000

; Door list. Room $B6EE. Norfair rolling boulder shaft
$8F:B715             dw 9A92, 9A9E, 9AAA

; Scroll data. Room $B6EE. Norfair rolling boulder shaft
$8F:B71B             db 00, 02, 00, 00, 02, 00, 00, 02, 00, 00, 01, 00, 00, 00, 00, 00, 01, 01

; PLM scroll data. Room $B6EE. Norfair rolling boulder shaft (PLM index 2)
$8F:B72D             db 0B,01, 80

; PLM scroll data. Room $B6EE. Norfair rolling boulder shaft (PLM index 5)
$8F:B730             db 0B,02, 0D,02, 0E,02, 80

; PLM scroll data. Room $B6EE. Norfair rolling boulder shaft (PLM index 9)
$8F:B737             db 00,01, 04,00, 80

; PLM scroll data. Room $B6EE. Norfair rolling boulder shaft (PLM index 11h)
$8F:B73C             db 01,02, 04,02, 80

; Room header. Lower Norfair save station
$8F:B741             dx 4C,02, 24,0C, 01,01, 70,A0, 00, B768, E5E6

; State header. Room $B741. Lower Norfair save station - default
$8F:B74E             dx CE95C2, 19, 18,05, 88EC, A557, 8747, 00,00, 0000, 0000, 0000, 918C, 0000, 0000

; Door list. Room $B741. Lower Norfair save station
$8F:B768             dw 9AB6
}


;;; $B76A: Library backgrounds ;;;
{
; Room $91F8. Landing site
$8F:B76A             dx 000E, 8946, 8AC180, 4800, 0800, ; Transfer 800h from $8A:C180 to VRAM $4800 if door pointer = $8946
                        000E, 896A, 8AD180, 4800, 0800, ; Transfer 800h from $8A:D180 to VRAM $4800 if door pointer = $896A
                        000E, 89B2, 8AB980, 4C00, 0800, ; Transfer 800h from $8A:B980 to VRAM $4C00 if door pointer = $89B2
                        000E, 8AC6, 8AD180, 4800, 0800, ; Transfer 800h from $8A:D180 to VRAM $4800 if door pointer = $8AC6
                        000E, 88FE, 8AB180, 4800, 0800, ; Transfer 800h from $8A:B180 to VRAM $4800 if door pointer = $88FE
                        000E, 890A, 8AC180, 4800, 0800, ; Transfer 800h from $8A:C180 to VRAM $4800 if door pointer = $890A
                        0000

; Room $93FE. Wrecked Ship entrance
$8F:B7AE             dx 000E, 8A12, 8AC180, 4800, 0800, ; Transfer 800h from $8A:C180 to VRAM $4800 if door pointer = $8A12
                        000E, 8AEA, 8AD980, 4800, 0800, ; Transfer 800h from $8A:D980 to VRAM $4800 if door pointer = $8AEA
                        000E, A18C, 8AB980, 4C00, 0800, ; Transfer 800h from $8A:B980 to VRAM $4C00 if door pointer = $A18C
                        000E, A1B0, 8AD980, 4800, 0800, ; Transfer 800h from $8A:D980 to VRAM $4800 if door pointer = $A1B0
                        000E, A1E0, 8AB180, 4800, 0800, ; Transfer 800h from $8A:B180 to VRAM $4800 if door pointer = $A1E0
                        000E, A300, 8AC980, 4C00, 0800, ; Transfer 800h from $8A:C980 to VRAM $4C00 if door pointer = $A300
                        0000

; Room $94FD. Wrecked Ship back door
$8F:B7F2             dx 000E, 8A7E, 8AD980, 4800, 0800, ; Transfer 800h from $8A:D980 to VRAM $4800 if door pointer = $8A7E
                        000E, A264, 8AD980, 4800, 0800, ; Transfer 800h from $8A:D980 to VRAM $4800 if door pointer = $A264
                        0000

; Room $968F. Orange zoomer hall
$8F:B80A             dx 0002, 8AC180, 4800, 0800, ; Transfer 800h from $8A:C180 to VRAM $4800
                        0000

; Room $A59F, state $A5B1. Kraid - default
$8F:B815             dx 0008, 9AB200, 2000, 1000, ; Transfer 1000h from $9A:B200 to VRAM $2000 and set BG3 tiles base address = $2000
                        0004, B9FA38, 4000,       ; Decompress $B9:FA38 to $7E:4000
                        0002, 7E4000, 4000, 1000, ; Transfer 1000h from $7E:4000 to VRAM $4000
                        0004, B9FE3E, 4000,       ; Decompress $B9:FE3E to $7E:4000
                        0002, 7E4000, 4800, 1000, ; Transfer 1000h from $7E:4000 to VRAM $4800
                        0000

; Room $A59F, state $A5CB. Kraid - main area boss is dead
$8F:B840             dx 0008, 9AB200, 2000, 1000, ; Transfer 1000h from $9A:B200 to VRAM $2000 and set BG3 tiles base address = $2000
                        000C,                     ; Clear Kraid's BG2 tilemap
                        0000

; Room $A98D, state $A99F. Crocomire - default
$8F:B84D             dx 0002, 7E2000, 4800, 1000, ; Transfer 1000h from $7E:2000 to VRAM $4800
                        0000

; Room $A98D, state $A9B9. Crocomire - area mini-boss is dead
$8F:B858             dx 0002, 7E2000, 4800, 1000, ; Transfer 1000h from $7E:2000 to VRAM $4800
                        0000

; Unused
$8F:B863             dx 0004, B9FF4E, 4000,       ; Decompress $B9:FF4E to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9552. Forgotten highway kago shaft
; Room $95A8. Forgotten highway elbow
$8F:B87E             dx 0004, BA807E, 4000,       ; Decompress $BA:807E to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $92B3. Gauntlet east
; Room $9461. Pre orange zoomer hall
; Room $965B. Gauntlet west
$8F:B899             dx 0004, BA82C4, 4000,       ; Decompress $BA:82C4 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $92FD. Crateria mainstreet
; Room $93AA. Landing site power bombs cave
; Room $948C. Pre moat room
; Room $957D. Crab maze
; Room $95FF. Moat
$8F:B8B4             dx 0004, BA8437, 4000,       ; Decompress $BA:8437 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $990D. Crateria slope
; Room $9969. West Crateria kago hall
$8F:B8CF             dx 0004, BA85BA, 4000,       ; Decompress $BA:85BA to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9879. Pre Bomb Torizo hall
$8F:B8EA             dx 0004, BA86FC, 4000,       ; Decompress $BA:86FC to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $96BA. Old Tourian escape shaft
; Room $975C. Old Mother Brain room
; Room $9804. Bomb Torizo
; Room $99F9. Crateria spike floor room
; Room $9A90. Crateria chozo missile
$8F:B905             dx 0004, BA8780, 4000,       ; Decompress $BA:8780 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $98E2. Pre Crateria map station hall
$8F:B920             dx 0004, BA8A49, 4000,       ; Decompress $BA:8A49 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $94CC. Crateria -> Maridia elevator
; Room $962A. Crateria -> Red Brinstar elevator
$8F:B93B             dx 0004, BA8ACD, 4000,       ; Decompress $BA:8ACD to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $99BD. Crateria space pirate shaft
; Room $9A44. Crateria bomb block hall
$8F:B956             dx 0004, BA8DBD, 4000,       ; Decompress $BA:8DBD to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000
}


;;; $B971..BA36: Door ASM ;;;
{
;;; $B971: Door ASM - start Wrecked Ship treadmill - west entrance ;;;
{
; Door destination: Wrecked Ship entrance treadmill
; Room $93FE, door 1. Wrecked Ship entrance
$8F:B971 A0 75 82    LDY #$8275             ;\
$8F:B974 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn Wrecked Ship treadmill - rightwards animated tiles object
$8F:B978 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:B97C             dx 04, 09, B64B        ;} Spawn Wrecked Ship entrance treadmill from west PLM
$8F:B980 60          RTS
}


;;; $B981: Door ASM - scroll 6 = green ;;;
{
; Door destination: Crateria mainstreet
; Room $93D5, door 0. Crateria save station
; Room $96BA, door 0. Old Tourian escape shaft
; Room $98E2, door 0. Pre Crateria map station hall
; Room $9A44, door 1. Crateria bomb block hall
$8F:B981 08          PHP
$8F:B982 E2 20       SEP #$20
$8F:B984 A9 02       LDA #$02
$8F:B986 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:B98A 28          PLP
$8F:B98B 60          RTS
}


;;; $B98C: Door ASM - scroll 0 = blue ;;;
{
; Door destination: Crateria mainstreet
; Room $990D, door 1. Crateria slope
$8F:B98C 08          PHP
$8F:B98D E2 20       SEP #$20
$8F:B98F A9 01       LDA #$01
$8F:B991 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:B995 28          PLP
$8F:B996 60          RTS
}


;;; $B997: Door ASM - scroll 13h = blue ;;;
{
; Door destination: Landing site
; Room $92B3, door 0. Gauntlet east
$8F:B997 08          PHP
$8F:B998 E2 20       SEP #$20
$8F:B99A A9 01       LDA #$01
$8F:B99C 8F 33 CD 7E STA $7ECD33[$7E:CD33]
$8F:B9A0 28          PLP
$8F:B9A1 60          RTS
}


;;; $B9A2: Door ASM - scroll 4 = red, 8 = green ;;;
{
; Door destination: Crateria mainstreet
; Room $9879, door 0. Pre Bomb Torizo hall
$8F:B9A2 08          PHP
$8F:B9A3 E2 20       SEP #$20
$8F:B9A5 A9 00       LDA #$00
$8F:B9A7 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:B9AB A9 02       LDA #$02
$8F:B9AD 8F 28 CD 7E STA $7ECD28[$7E:CD28]
$8F:B9B1 28          PLP
$8F:B9B2 60          RTS
}


;;; $B9B3: Door ASM - scroll 8..Bh = red ;;;
{
; Door destination: Wrecked Ship chozo room
; Room $93FE, door 4. Wrecked Ship entrance
$8F:B9B3 08          PHP
$8F:B9B4 E2 20       SEP #$20
$8F:B9B6 A9 00       LDA #$00
$8F:B9B8 8F 28 CD 7E STA $7ECD28[$7E:CD28]
$8F:B9BC 8F 29 CD 7E STA $7ECD29[$7E:CD29]
$8F:B9C0 8F 2A CD 7E STA $7ECD2A[$7E:CD2A]
$8F:B9C4 8F 2B CD 7E STA $7ECD2B[$7E:CD2B]
$8F:B9C8 28          PLP
$8F:B9C9 60          RTS
}


;;; $B9CA: Door ASM - scroll 2..5,Bh..Dh,11h = red ;;;
{
; Door destination: Wrecked Ship chozo room
; Room $968F, door 1. Orange zoomer hall
$8F:B9CA 08          PHP
$8F:B9CB E2 20       SEP #$20
$8F:B9CD A9 00       LDA #$00
$8F:B9CF 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:B9D3 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:B9D7 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:B9DB 8F 25 CD 7E STA $7ECD25[$7E:CD25]
$8F:B9DF 8F 2B CD 7E STA $7ECD2B[$7E:CD2B]
$8F:B9E3 8F 2C CD 7E STA $7ECD2C[$7E:CD2C]
$8F:B9E7 8F 2D CD 7E STA $7ECD2D[$7E:CD2D]
$8F:B9EB 8F 31 CD 7E STA $7ECD31[$7E:CD31]
$8F:B9EF 28          PLP
$8F:B9F0 60          RTS
}


;;; $B9F1: Door ASM - scroll 1,4 = green ;;;
{
; Door destination: Pre moat room
; Room $962A, door 0. Crateria -> Red Brinstar elevator
$8F:B9F1 08          PHP
$8F:B9F2 E2 20       SEP #$20
$8F:B9F4 A9 02       LDA #$02
$8F:B9F6 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:B9FA 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:B9FE 28          PLP
$8F:B9FF 60          RTS
}


;;; $BA00: Door ASM - scroll 2 = blue ;;;
{
; Door destination: Old Tourian escape shaft
; Room $99F9, door 0. Crateria spike floor room
$8F:BA00 08          PHP
$8F:BA01 E2 20       SEP #$20
$8F:BA03 A9 01       LDA #$01
$8F:BA05 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:BA09 28          PLP
$8F:BA0A 60          RTS
}


;;; $BA0B: Door ASM - scroll 17h = blue ;;;
{
; Door destination: Old Tourian escape shaft
; Room $99F9, door 1. Crateria spike floor room
$8F:BA0B 08          PHP
$8F:BA0C E2 20       SEP #$20
$8F:BA0E A9 01       LDA #$01
$8F:BA10 8F 37 CD 7E STA $7ECD37[$7E:CD37]
$8F:BA14 28          PLP
$8F:BA15 60          RTS
}


;;; $BA16: Door ASM - scroll 4 = blue ;;;
{
; Door destination: Gauntlet west
; Room $99BD, door 3. Crateria space pirate shaft
$8F:BA16 08          PHP
$8F:BA17 E2 20       SEP #$20
$8F:BA19 A9 01       LDA #$01
$8F:BA1B 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:BA1F 28          PLP
$8F:BA20 60          RTS
}


;;; $BA21: Door ASM - scroll 6 = green ;;;
{
; Door destination: Red Brinstar -> Crateria elevator
; Room $962A, door 1. Crateria -> Red Brinstar elevator
$8F:BA21 08          PHP
$8F:BA22 E2 20       SEP #$20
$8F:BA24 A9 02       LDA #$02
$8F:BA26 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:BA2A 28          PLP
$8F:BA2B 60          RTS
}


;;; $BA2C: Door ASM - scroll 3 = green ;;;
{
; Door destination: Crateria space pirate shaft
; Room $965B, door 1. Gauntlet west
$8F:BA2C 08          PHP
$8F:BA2D E2 20       SEP #$20
$8F:BA2F A9 02       LDA #$02
$8F:BA31 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:BA35 28          PLP
$8F:BA36 60          RTS
}
}


;;; $BA37: Library backgrounds ;;;
{
; Room $9AD9. Green Brinstar mainstreet
$8F:BA37             dx 0004, B9C972, 4000,       ; Decompress $B9:C972 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9D9C. Pre Spore Spawn hall
; Room $9FBA. n00b bridge
; Room $9FE5. Etecoon area beetom room
; Room $A011. Etecoon area spike hall
; Room $A051. Etecoon area super missiles
$8F:BA52             dx 0004, B9CD01, 4000,       ; Decompress $B9:CD01 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9C07. Brinstar reserve tank room
$8F:BA6D             dx 0004, B9CE9F, 4000,       ; Decompress $B9:CE9F to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9B9D. Pre Brinstar map room hall
$8F:BA88             dx 0004, B9CFF8, 4000,       ; Decompress $B9:CFF8 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9BC8. Early supers room
; Room $9E11. Brinstar super-sidehopper power bomb room
; Room $A0D2. Pink Brinstar flooded hall
; Room $A130. Brinstar wave-gate sidehopper room
$8F:BAA3             dx 0004, B9D1FB, 4000,       ; Decompress $B9:D1FB to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9B5B. Spore Spawn's super missile shaft
; Room $9F11. Old Kraid entrance
; Room $A107. Blue Brinstar missile room
$8F:BABE             dx 0004, B9D38F, 4000,       ; Decompress $B9:D38F to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9E52. Brinstar diagonal room
$8F:BAD9             dx 0004, B9D3C5, 4000,       ; Decompress $B9:D3C5 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9E9F. Morph ball room
; Room $9F64. Blue Brinstar ceiling e-tank hall
; Room $A1AD. Blue Brinstar boulder room
; Room $A1D8. Blue Brinstar double missile room
$8F:BAF4             dx 0004, B9D3FB, 4000,       ; Decompress $B9:D3FB to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Unused
$8F:BB0F             dx 0004, B9D56A, 4000,       ; Decompress $B9:D56A to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Unused
$8F:BB2A             dx 0004, B9D5A1, 4000,       ; Decompress $B9:D5A1 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $9D19. Charge beam room
$8F:BB45             dx 0004, B9D5D8, 4000,       ; Decompress $B9:D5D8 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A66A. Tourian entrance
$8F:BB60             dx 0004, BAC4BC, 4000,       ; Decompress $BA:C4BC to $7E:4000
                        0002, 7E4000, 4800, 1000, ; Transfer 1000h from $7E:4000 to VRAM $4800
                        0002, 87AD64, 6D00, 0600, ; Transfer 600h from $87:AD64 to VRAM $6D00
                        0000

; Room $A253. Red Brinstar mainstreet
$8F:BB7B             dx 0004, B9D715, 4000,       ; Decompress $B9:D715 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Unused
$8F:BB96             dx 0004, B9D99C, 4000,       ; Decompress $B9:D99C to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Unused
$8F:BBB1             dx 0004, B9DE11, 4000,       ; Decompress $B9:DE11 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A2F7. Red Brinstar damage boost hall
$8F:BBCC             dx 0004, B9E1B3, 4000,       ; Decompress $B9:E1B3 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A37C. Red Brinstar power bomb floor room
; Room $A3DD. Red Brinstar skree-duo hall
$8F:BBE7             dx 0004, B9E61C, 4000,       ; Decompress $B9:E61C to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A408. Pre spazer room
$8F:BC02             dx 0004, B9E885, 4000,       ; Decompress $B9:E885 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Unused
$8F:BC1D             dx 0004, B9E94F, 4000,       ; Decompress $B9:E94F to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A2CE. X-ray room
$8F:BC38             dx 0004, B9EA80, 4000,       ; Decompress $B9:EA80 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A6A1. Kraid's lair entrance
$8F:BC53             dx 0004, B9EBC7, 4000,       ; Decompress $B9:EBC7 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A521. Fake Kraid's room
$8F:BC6E             dx 0004, B9EE52, 4000,       ; Decompress $B9:EE52 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Unused
$8F:BC89             dx 0004, B9F11D, 4000,       ; Decompress $B9:F11D to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A5ED. Pre Tourian entrance hall
$8F:BCA4             dx 0004, B9F1C8, 4000,       ; Decompress $B9:F1C8 to $7E:4000
                        0002, 7E4000, 4800, 1000, ; Transfer 1000h from $7E:4000 to VRAM $4800
                        0000

; Unused
$8F:BCB6             dx 0004, B9F70D, 4000,       ; Decompress $B9:F70D to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Unused
$8F:BCD1             dx 0004, B9F72E, 4000,       ; Decompress $B9:F72E to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A3AE. Red Brinstar power bomb wall room
; Room $A447. Spazer room
$8F:BCEC             dx 0004, B9F94F, 4000,       ; Decompress $B9:F94F to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000
}


;;; $BD07..BE3E: Door ASM ;;;
{
;;; $BD07: Door ASM - scroll 18h,1Ch = green ;;;
{
; Door destination: Green Brinstar mainstreet
; Room $9AD9, door 8. Green Brinstar mainstreet
; Room $9FE5, door 0. Etecoon area beetom room
$8F:BD07 08          PHP
$8F:BD08 E2 20       SEP #$20
$8F:BD0A A9 02       LDA #$02
$8F:BD0C 8F 38 CD 7E STA $7ECD38[$7E:CD38]
$8F:BD10 8F 3C CD 7E STA $7ECD3C[$7E:CD3C]
$8F:BD14 28          PLP
$8F:BD15 60          RTS
}


;;; $BD16: Door ASM - scroll 5..6 = blue ;;;
{
; Door destination: Etecoon area spike hall
; Room $9AD9, door 7. Green Brinstar mainstreet
; Room $A22A, door 0. Etecoon area save station
$8F:BD16 08          PHP
$8F:BD17 E2 20       SEP #$20
$8F:BD19 A9 01       LDA #$01
$8F:BD1B 8F 25 CD 7E STA $7ECD25[$7E:CD25]
$8F:BD1F 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:BD23 28          PLP
$8F:BD24 60          RTS
}


;;; $BD25: Door ASM - scroll 1Dh = blue ;;;
{
; Door destination: Green Brinstar mainstreet
; Room $9938, door 1. Crateria -> Green Brinstar elevator
; Room $9AD9, door 6. Green Brinstar mainstreet
; Room $A011, door 2. Etecoon area spike hall
$8F:BD25 08          PHP
$8F:BD26 E2 20       SEP #$20
$8F:BD28 A9 01       LDA #$01
$8F:BD2A 8F 3D CD 7E STA $7ECD3D[$7E:CD3D]
$8F:BD2E 28          PLP
$8F:BD2F 60          RTS
}


;;; $BD30: Door ASM - scroll 2..3 = green ;;;
{
; Door destination: Brinstar super-sidehopper power bomb room
; Room $9D19, door 2. Charge beam room
$8F:BD30 08          PHP
$8F:BD31 E2 20       SEP #$20
$8F:BD33 A9 02       LDA #$02
$8F:BD35 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:BD39 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:BD3D 28          PLP
$8F:BD3E 60          RTS
}


;;; $BD3F: Door ASM - scroll 0 = red, 1 = green ;;;
{
; Door destination: Kraid's lair entrance
; Room $A471, door 0. Kraid's lair zeela room
$8F:BD3F 08          PHP
$8F:BD40 E2 20       SEP #$20
$8F:BD42 A9 00       LDA #$00
$8F:BD44 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:BD48 A9 02       LDA #$02
$8F:BD4A 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:BD4E 28          PLP
$8F:BD4F 60          RTS
}


;;; $BD50: Door ASM - scroll Bh = green ;;;
{
; Door destination: Dachora room
; Room $A07B, door 0. Dachora energy station
$8F:BD50 08          PHP
$8F:BD51 E2 20       SEP #$20
$8F:BD53 A9 02       LDA #$02
$8F:BD55 8F 2B CD 7E STA $7ECD2B[$7E:CD2B]
$8F:BD59 28          PLP
$8F:BD5A 60          RTS
}


;;; $BD5B: Door ASM - scroll 1Ch = red, 1Dh = blue ;;;
{
; Door destination: Charge beam room
; Room $A0A4, door 1. Post Spore Spawn supers hall
$8F:BD5B 08          PHP
$8F:BD5C E2 20       SEP #$20
$8F:BD5E A9 00       LDA #$00
$8F:BD60 8F 3C CD 7E STA $7ECD3C[$7E:CD3C]
$8F:BD64 A9 01       LDA #$01
$8F:BD66 8F 3D CD 7E STA $7ECD3D[$7E:CD3D]
$8F:BD6A 28          PLP
$8F:BD6B 60          RTS
}


;;; $BD6C: Door ASM - scroll 4 = red ;;;
{
; Door destination: Dachora room
; Room $9AD9, door 5. Green Brinstar mainstreet
$8F:BD6C 08          PHP
$8F:BD6D E2 20       SEP #$20
$8F:BD6F A9 00       LDA #$00
$8F:BD71 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:BD75 28          PLP
$8F:BD76 60          RTS
}


;;; $BD77: Door ASM - scroll 20h,24h..25h = green ;;;
{
; Door destination: Charge beam room
; Room $A0D2, door 0. Pink Brinstar flooded hall
$8F:BD77 08          PHP
$8F:BD78 E2 20       SEP #$20
$8F:BD7A A9 02       LDA #$02
$8F:BD7C 8F 40 CD 7E STA $7ECD40[$7E:CD40]
$8F:BD80 8F 44 CD 7E STA $7ECD44[$7E:CD44]
$8F:BD84 8F 45 CD 7E STA $7ECD45[$7E:CD45]
$8F:BD88 28          PLP
$8F:BD89 60          RTS
}


;;; $BD8A: Door ASM - scroll 2 = blue ;;;
{
; Door destination: Blue Brinstar ceiling e-tank hall
; Room $A1AD, door 0. Blue Brinstar boulder room
$8F:BD8A 08          PHP
$8F:BD8B E2 20       SEP #$20
$8F:BD8D A9 01       LDA #$01
$8F:BD8F 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:BD93 28          PLP
$8F:BD94 60          RTS
}


;;; $BD95: Door ASM - scroll 0 = green ;;;
{
; Door destination: Pre Kraid room
; Room $A641, door 0. Kraid's lair refill station
$8F:BD95 08          PHP
$8F:BD96 E2 20       SEP #$20
$8F:BD98 A9 02       LDA #$02
$8F:BD9A 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:BD9E 28          PLP
$8F:BD9F 60          RTS
}


;;; $BDA0: Door ASM - scroll 6..7 = green ;;;
{
; Door destination: Red Brinstar mainstreet
; Room $A3DD, door 0. Red Brinstar skree-duo hall
; Room $A618, door 0. Red Brinstar energy station
$8F:BDA0 08          PHP
$8F:BDA1 E2 20       SEP #$20
$8F:BDA3 A9 02       LDA #$02
$8F:BDA5 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:BDA9 8F 27 CD 7E STA $7ECD27[$7E:CD27]
$8F:BDAD 28          PLP
$8F:BDAE 60          RTS
}


;;; $BDAF: Door ASM - scroll 1 = blue, 2 = red ;;;
{
; Door destination: Maridia -> Red Brinstar room
; Room $A322, door 4. Red Brinstar -> Crateria elevator
$8F:BDAF 08          PHP
$8F:BDB0 E2 20       SEP #$20
$8F:BDB2 A9 01       LDA #$01
$8F:BDB4 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:BDB8 A9 00       LDA #$00
$8F:BDBA 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:BDBE 28          PLP
$8F:BDBF 60          RTS
}


;;; $BDC0: Door ASM - scroll 1 = blue, 3 = red ;;;
{
; Door destination: Spore Spawn's super missile shaft
; Room $9DC7, door 0. Spore Spawn
$8F:BDC0 08          PHP
$8F:BDC1 E2 20       SEP #$20
$8F:BDC3 A9 01       LDA #$01
$8F:BDC5 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:BDC9 A9 00       LDA #$00
$8F:BDCB 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:BDCF 28          PLP
$8F:BDD0 60          RTS
}


;;; $BDD1: Door ASM - scroll 0 = red, 4 = blue ;;;
{
; Door destination: n00b tube east
; Room $A6A1, door 0. Kraid's lair entrance
$8F:BDD1 08          PHP
$8F:BDD2 E2 20       SEP #$20
$8F:BDD4 A9 00       LDA #$00
$8F:BDD6 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:BDDA A9 01       LDA #$01
$8F:BDDC 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:BDE0 28          PLP
$8F:BDE1 60          RTS
}


;;; $BDE2: Door ASM - scroll 2..3 = blue ;;;
{
; Door destination: Kraid's lair kihunter hall
; Room $A70B, door 0. Kraid's lair save station
$8F:BDE2 08          PHP
$8F:BDE3 E2 20       SEP #$20
$8F:BDE5 A9 01       LDA #$01
$8F:BDE7 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:BDEB 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:BDEF 28          PLP
$8F:BDF0 60          RTS
}


;;; $BDF1: Door ASM - scroll 0..1 = green ;;;
{
; Door destination: Pre spazer room
; Room $A447, door 0. Spazer room
$8F:BDF1 08          PHP
$8F:BDF2 E2 20       SEP #$20
$8F:BDF4 A9 02       LDA #$02
$8F:BDF6 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:BDFA 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:BDFE 28          PLP
$8F:BDFF 60          RTS
}


;;; $BE00: Door ASM - scroll 1 = green ;;;
{
; Door destination: Charge beam room
; Room $A184, door 0. Spore Spawn save station
$8F:BE00 08          PHP
$8F:BE01 E2 20       SEP #$20
$8F:BE03 A9 02       LDA #$02
$8F:BE05 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:BE09 28          PLP
$8F:BE0A 60          RTS
}


;;; $BE0B: Door ASM - scroll Fh,12h = green ;;;
{
; Door destination: Red Brinstar -> Crateria elevator
; Room $A3AE, door 0. Red Brinstar power bomb wall room
$8F:BE0B 08          PHP
$8F:BE0C E2 20       SEP #$20
$8F:BE0E A9 02       LDA #$02
$8F:BE10 8F 2F CD 7E STA $7ECD2F[$7E:CD2F]
$8F:BE14 8F 32 CD 7E STA $7ECD32[$7E:CD32]
$8F:BE18 28          PLP
$8F:BE19 60          RTS
}


;;; $BE1A: Door ASM - scroll 6 = green ;;;
{
; Door destination: Red Brinstar -> Crateria elevator
; Room $A2F7, door 1. Red Brinstar damage boost hall
$8F:BE1A 08          PHP
$8F:BE1B E2 20       SEP #$20
$8F:BE1D A9 02       LDA #$02
$8F:BE1F 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:BE23 28          PLP
$8F:BE24 60          RTS
}


;;; $BE25: Door ASM - scroll 0 = green, 1 = blue ;;;
{
; Door destination: Old Kraid entrance
; Room $A107, door 0. Blue Brinstar missile room
$8F:BE25 08          PHP
$8F:BE26 E2 20       SEP #$20
$8F:BE28 A9 02       LDA #$02
$8F:BE2A 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:BE2E A9 01       LDA #$01
$8F:BE30 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:BE34 28          PLP
$8F:BE35 60          RTS
}


;;; $BE36: Door ASM - scroll 2 = green ;;;
{
; Door destination: Crateria -> Green Brinstar elevator
; Room $9AD9, door 0. Green Brinstar mainstreet
$8F:BE36 E2 20       SEP #$20
$8F:BE38 A9 02       LDA #$02
$8F:BE3A 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:BE3E 60          RTS
}
}


;;; $BE3F: Library backgrounds ;;;
{
; Room $A75D. Ice beam tripper hall
; Room $A865. Ice beam practice room
; Room $A9E5. Hi-jump room
; Room $AD1B. Speed booster room
; Room $B106. Norfair speed blockade hall
$8F:BE3F             dx 0004, B9A634, 4000,       ; Decompress $B9:A634 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A815. Ice beam mockball hall
; Room $A890. Ice beam room
; Room $A8B9. Pre ice beam shaft
; Room $A923. Norfair slope
; Room $AB64. Double lake grapple practice room
; Room $ACF0. Speed booster lavaquake
; Room $AF14. Lava dive room
; Room $B4E5. Lower Norfair rising acid room
; Room $B585. Lower Norfair south kihunter shaft
$8F:BE5A             dx 0004, B9A714, 4000,       ; Decompress $B9:A714 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Unused
$8F:BE75             dx 0004, B9A75E, 4000,       ; Decompress $B9:A75E to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $B3E1. Unused room
$8F:BE90             dx 0004, B9A7A8, 4000,       ; Decompress $B9:A7A8 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $B3A5. Pre pillars hall
$8F:BEAB             dx 0004, B9A83A, 4000,       ; Decompress $B9:A83A to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $AADE. Post Crocomire power bombs room
; Room $AB3B. Post Crocomire tidal acid cave
; Room $AC00. Single lake grapple practice room
; Room $ADDE. Wave beam room
; Room $AE07. Norfair sinking tripper hall
; Room $AEB4. Magdollite multiviola hall
; Room $AF3F. Norfair -> Lower Norfair elevator
; Room $AFA3. Norfair long lavaquake hall
; Room $AFCE. Norfair metal floor hall
; Room $AFFB. Norfair lava-spike hall
$8F:BEC6             dx 0004, B9AC83, 4000,       ; Decompress $B9:AC83 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $A7DE. Norfair mainstreet
; Room $A8F8. Crumble block platform shaft
; Room $AB07. Post Crocomire shaft
; Room $ABD2. Grapple practice shaft
; Room $AC2B. Grapple room
; Room $B139. Norfair stone zoomer shaft
$8F:BEE1             dx 0004, B9AEFF, 4000,       ; Decompress $B9:AEFF to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $B4AD. Lower Norfair wall space pirates shaft
$8F:BEFC             dx 0004, B9B2F0, 4000,       ; Decompress $B9:B2F0 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $B236. Lower Norfair mainstreet
; Room $B2DA. Ripper ii room
; Room $B457. Pillars hall
$8F:BF17             dx 0004, B9B6BB, 4000,       ; Decompress $B9:B6BB to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $B1E5. Lower Norfair chozo room
; Room $B32E. Ridley
; Room $B55A. Lower Norfair escape power bomb room
; Room $B5D5. Lower Norfair spike platform room
; Room $B698. Ridley's energy tank
; Room $B6C1. Screw attack room
$8F:BF32             dx 0004, B9BBA5, 4000,       ; Decompress $B9:BBA5 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $B37A. Pre Ridley hall
; Room $B482. Lower Norfair holtz room
; Room $B62B. Ninja space pirate hall
$8F:BF4D             dx 0004, B9BF3B, 4000,       ; Decompress $B9:BF3B to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $AC5A. Bubble Norfair reserve tank room
; Room $AEDF. Purple shaft
; Room $B051. Purple farming room
; Room $B40A. Lower Norfair multi-level one-way shaft
; Room $B510. Lower Norfair spring ball maze room
; Room $B656. Lower Norfair north kihunter shaft
$8F:BF68             dx 0004, B9C26F, 4000,       ; Decompress $B9:C26F to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $AC83. Pre Bubble Norfair reserve tank room
; Room $ACB3. Bubble Norfair mainstreet
$8F:BF83             dx 0004, B9C5C8, 4000,       ; Decompress $B9:C5C8 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000
}


;;; $BF9E..C115: Door ASM ;;;
{
;;; $BF9E: Door ASM - scroll 3..4 = red, 6..8 = blue ;;;
{
; Door destination: Lower Norfair chozo room
; Room $B283, door 0. Golden Torizo
$8F:BF9E 08          PHP
$8F:BF9F E2 20       SEP #$20
$8F:BFA1 A9 00       LDA #$00
$8F:BFA3 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:BFA7 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:BFAB A9 01       LDA #$01
$8F:BFAD 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:BFB1 8F 27 CD 7E STA $7ECD27[$7E:CD27]
$8F:BFB5 8F 28 CD 7E STA $7ECD28[$7E:CD28]
$8F:BFB9 28          PLP
$8F:BFBA 60          RTS
}


;;; $BFBB: Door ASM - scroll 1..3 = blue, 4 = green, 6 = red ;;;
{
; Door destination: Lower Norfair spring ball maze room
; Room $B55A, door 1. Lower Norfair escape power bomb room
$8F:BFBB 08          PHP
$8F:BFBC E2 20       SEP #$20
$8F:BFBE A9 01       LDA #$01
$8F:BFC0 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:BFC4 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:BFC8 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:BFCC A9 02       LDA #$02
$8F:BFCE 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:BFD2 A9 00       LDA #$00
$8F:BFD4 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:BFD8 28          PLP
$8F:BFD9 60          RTS
}


;;; $BFDA: Door ASM - scroll 0..1 = blue ;;;
{
; Door destination: Crocomire
; Room $AA82, door 0. Post Crocomire room
$8F:BFDA 08          PHP
$8F:BFDB E2 20       SEP #$20
$8F:BFDD A9 01       LDA #$01
$8F:BFDF 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:BFE3 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:BFE7 28          PLP
$8F:BFE8 60          RTS
}


;;; $BFE9: Door ASM - scroll 0 = blue, 1 = red ;;;
{
; Door destination: Speed booster lavaquake farming room
; Room $ACF0, door 0. Speed booster lavaquake
$8F:BFE9 08          PHP
$8F:BFEA E2 20       SEP #$20
$8F:BFEC A9 00       LDA #$00
$8F:BFEE 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:BFF2 A9 01       LDA #$01
$8F:BFF4 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:BFF8 28          PLP
$8F:BFF9 60          RTS
}


;;; $BFFA: Door ASM - scroll Ah = green ;;;
{
; Door destination: Ice beam mockball hall
; Room $A865, door 1. Ice beam practice room
$8F:BFFA 08          PHP
$8F:BFFB E2 20       SEP #$20
$8F:BFFD A9 02       LDA #$02
$8F:BFFF 8F 2A CD 7E STA $7ECD2A[$7E:CD2A]
$8F:C003 28          PLP
$8F:C004 60          RTS
}


;;; $C005: Unused. Door ASM - scroll 0 = blue, 2 = red ;;;
{
$8F:C005 08          PHP
$8F:C006 E2 20       SEP #$20
$8F:C008 A9 01       LDA #$01
$8F:C00A 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:C00E A9 00       LDA #$00
$8F:C010 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:C014 28          PLP
$8F:C015 60          RTS
}


;;; $C016: Door ASM - scroll 0,2 = green ;;;
{
; Door destination: Pre hi-jump room
; Room $A9E5, door 0. Hi-jump room
$8F:C016 08          PHP
$8F:C017 E2 20       SEP #$20
$8F:C019 A9 02       LDA #$02
$8F:C01B 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:C01F 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:C023 28          PLP
$8F:C024 60          RTS
}


;;; $C025: Door ASM - scroll 6..7 = blue, 8 = red ;;;
{
; Door destination: Volcano room
; Room $AE74, door 1. Pre lava dive shaft
$8F:C025 08          PHP
$8F:C026 E2 20       SEP #$20
$8F:C028 A9 01       LDA #$01
$8F:C02A 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:C02E 8F 27 CD 7E STA $7ECD27[$7E:CD27]
$8F:C032 A9 00       LDA #$00
$8F:C034 8F 28 CD 7E STA $7ECD28[$7E:CD28]
$8F:C038 28          PLP
$8F:C039 60          RTS
}


;;; $C03A: Door ASM - scroll 2 = red, 3 = blue ;;;
{
; Door destination: Pre ice beam shaft
; Room $A890, door 0. Ice beam room
$8F:C03A 08          PHP
$8F:C03B E2 20       SEP #$20
$8F:C03D A9 00       LDA #$00
$8F:C03F 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:C043 A9 01       LDA #$01
$8F:C045 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:C049 28          PLP
$8F:C04A 60          RTS
}


;;; $C04B: Door ASM - scroll 7 = green ;;;
{
; Door destination: Lower Norfair spike platform room
; Room $B62B, door 1. Ninja space pirate hall
$8F:C04B 08          PHP
$8F:C04C E2 20       SEP #$20
$8F:C04E A9 02       LDA #$02
$8F:C050 8F 27 CD 7E STA $7ECD27[$7E:CD27]
$8F:C054 28          PLP
$8F:C055 60          RTS
}


;;; $C056: Door ASM - scroll 1 = red, 2 = blue ;;;
{
; Door destination: Pre pillars hall
; Room $B2DA, door 1. Ripper ii room
; Room $B457, door 0. Pillars hall
$8F:C056 08          PHP
$8F:C057 E2 20       SEP #$20
$8F:C059 A9 00       LDA #$00
$8F:C05B 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:C05F A9 01       LDA #$01
$8F:C061 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:C065 28          PLP
$8F:C066 60          RTS
}


;;; $C067: Door ASM - scroll 0 = blue, 3 = red ;;;
{
; Door destination: Lower Norfair south kihunter shaft
; Room $B4E5, door 1. Lower Norfair rising acid room
$8F:C067 08          PHP
$8F:C068 E2 20       SEP #$20
$8F:C06A A9 00       LDA #$00
$8F:C06C 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:C070 A9 01       LDA #$01
$8F:C072 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:C076 28          PLP
$8F:C077 60          RTS
}


;;; $C078: Door ASM - scroll 1 = blue, 4 = red ;;;
{
; Door destination: Norfair rolling boulder shaft
; Room $B55A, door 0. Lower Norfair escape power bomb room
$8F:C078 08          PHP
$8F:C079 E2 20       SEP #$20
$8F:C07B A9 01       LDA #$01
$8F:C07D 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:C081 A9 00       LDA #$00
$8F:C083 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:C087 28          PLP
$8F:C088 60          RTS
}


;;; $C089: Door ASM - scroll 0 = blue, 1..3 = red ;;;
{
; Door destination: Golden Torizo
; Room $B1E5, door 0. Lower Norfair chozo room
$8F:C089 08          PHP
$8F:C08A E2 20       SEP #$20
$8F:C08C A9 01       LDA #$01
$8F:C08E 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:C092 A9 00       LDA #$00
$8F:C094 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:C098 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:C09C 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:C0A0 28          PLP
$8F:C0A1 60          RTS
}


;;; $C0A2: Door ASM - scroll 0 = green ;;;
{
; Door destination: Lower Norfair wall space pirates shaft
; Room $B40A, door 1. Lower Norfair multi-level one-way shaft
$8F:C0A2 08          PHP
$8F:C0A3 E2 20       SEP #$20
$8F:C0A5 A9 02       LDA #$02
$8F:C0A7 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:C0AB 28          PLP
$8F:C0AC 60          RTS
}


;;; $C0AD: Door ASM - scroll 0..1 = blue, 4 = red ;;;
{
; Door destination: Norfair rolling boulder shaft
; Room $B510, door 1. Lower Norfair spring ball maze room
$8F:C0AD 08          PHP
$8F:C0AE E2 20       SEP #$20
$8F:C0B0 A9 01       LDA #$01
$8F:C0B2 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:C0B6 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:C0BA A9 00       LDA #$00
$8F:C0BC 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:C0C0 28          PLP
$8F:C0C1 60          RTS
}


;;; $C0C2: Door ASM - scroll 0 = blue, 3 = red ;;;
{
; Door destination: Lower Norfair south kihunter shaft
; Room $B6EE, door 2. Norfair rolling boulder shaft
$8F:C0C2 08          PHP
$8F:C0C3 E2 20       SEP #$20
$8F:C0C5 A9 01       LDA #$01
$8F:C0C7 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:C0CB A9 00       LDA #$00
$8F:C0CD 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:C0D1 28          PLP
$8F:C0D2 60          RTS
}


;;; $C0D3: Door ASM - scroll 0 = blue ;;;
{
; Door destination: Pre Bubble Norfair reserve tank room
; Room $AC5A, door 0. Bubble Norfair reserve tank room
$8F:C0D3 08          PHP
$8F:C0D4 E2 20       SEP #$20
$8F:C0D6 A9 01       LDA #$01
$8F:C0D8 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:C0DC 28          PLP
$8F:C0DD 60          RTS
}


;;; $C0DE: Door ASM - scroll 0 = blue, 1 = red ;;;
{
; Door destination: Purple shaft
; Room $ACB3, door 3. Bubble Norfair mainstreet
$8F:C0DE 08          PHP
$8F:C0DF E2 20       SEP #$20
$8F:C0E1 A9 01       LDA #$01
$8F:C0E3 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:C0E7 A9 00       LDA #$00
$8F:C0E9 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:C0ED 28          PLP
$8F:C0EE 60          RTS
}


;;; $C0EF: Door ASM - scroll 18h = blue ;;;
{
; Door destination: Ice beam mockball hall
; Room $A8F8, door 0. Crumble block platform shaft
$8F:C0EF 08          PHP
$8F:C0F0 E2 20       SEP #$20
$8F:C0F2 A9 01       LDA #$01
$8F:C0F4 8F 38 CD 7E STA $7ECD38[$7E:CD38]
$8F:C0F8 28          PLP
$8F:C0F9 60          RTS
}


;;; $C0FA: Door ASM - scroll 2 = blue, 3 = red ;;;
{
; Door destination: Pre lava dive shaft
; Room $AFFB, door 1. Norfair lava-spike hall
$8F:C0FA 08          PHP
$8F:C0FB E2 20       SEP #$20
$8F:C0FD A9 00       LDA #$00
$8F:C0FF 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:C103 A9 01       LDA #$01
$8F:C105 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:C109 28          PLP
$8F:C10A 60          RTS
}


;;; $C10B: Door ASM - scroll Eh = red ;;;
{
; Door destination: Lower Norfair multi-level one-way shaft
; Room $B4AD, door 0. Lower Norfair wall space pirates shaft
$8F:C10B 08          PHP
$8F:C10C E2 20       SEP #$20
$8F:C10E A9 00       LDA #$00
$8F:C110 8F 2E CD 7E STA $7ECD2E[$7E:CD2E]
$8F:C114 28          PLP
$8F:C115 60          RTS
}
}


;;; $C116..C208: Main ASM ;;;
{
;;; $C116: Main ASM - scrolling sky land ;;;
{
; Room $91F8, state $9213. Landing site - default
; Room $91F8, state $922D. Landing site - event "Zebes is awake" is set
; Room $91F8, state $9247. Landing site - power bombs have been collected
; Room $93AA. Landing site power bombs cave
$8F:C116 22 8D AF 88 JSL $88AF8D[$88:AF8D]  ; Update scrolling sky land tilemap
$8F:C11A 60          RTS
}


;;; $C11B: Main ASM - scrolling sky ocean ;;;
{
; Room $93FE. Wrecked Ship entrance
; Room $94FD. Wrecked Ship back door
; Room $968F. Orange zoomer hall
$8F:C11B 22 99 AF 88 JSL $88AF99[$88:AF99]  ; Update scrolling sky ocean tilemap
$8F:C11F 60          RTS
}


;;; $C120: Main ASM - scrolling sky land, Zebes timebomb set ;;;
{
; Room $91F8, state $9261. Landing site - event "Zebes timebomb set" is set
$8F:C120 22 8D AF 88 JSL $88AF8D[$88:AF8D]  ; Update scrolling sky land tilemap
}


;;; $C124: Main ASM - shake screen and generate random explosions ;;;
{
; Room $92FD, state $9348. Crateria mainstreet - event "Zebes timebomb set" is set
; Room $96BA, state $9705. Old Tourian escape shaft - event "Zebes timebomb set" is set
; Room $9804, state $984F. Bomb Torizo - event "Zebes timebomb set" is set
; Room $9879, state $98C4. Pre Bomb Torizo hall - event "Zebes timebomb set" is set
$8F:C124 20 31 C1    JSR $C131  [$8F:C131]  ; Generate random explosion on even frames on random non-blank tile
$8F:C127 AD 40 18    LDA $1840  [$7E:1840]  ;\
$8F:C12A 09 00 80    ORA #$8000             ;} Screen shaking timer |= 8000h
$8F:C12D 8D 40 18    STA $1840  [$7E:1840]  ;/
$8F:C130 60          RTS
}


;;; $C131: Generate random explosion on even frames on random non-blank tile ;;;
{
$8F:C131 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$8F:C134 D0 4C       BNE $4C    [$C182]     ;} If time is frozen: return
$8F:C136 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$8F:C139 29 01 00    AND #$0001             ;} If [frame counter] % 2 != 0: return
$8F:C13C D0 44       BNE $44    [$C182]     ;/
$8F:C13E 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$8F:C142 48          PHA                    ;\
$8F:C143 29 FF 00    AND #$00FF             ;|
$8F:C146 18          CLC                    ;} $12 = [layer 1 X position] + [random number low]
$8F:C147 6D 11 09    ADC $0911  [$7E:0911]  ;|
$8F:C14A 85 12       STA $12    [$7E:0012]  ;/
$8F:C14C 68          PLA                    ;\
$8F:C14D EB          XBA                    ;|
$8F:C14E 29 FF 00    AND #$00FF             ;|
$8F:C151 18          CLC                    ;} $14 = [layer 1 Y position] + [random number high]
$8F:C152 6D 15 09    ADC $0915  [$7E:0915]  ;|
$8F:C155 85 14       STA $14    [$7E:0014]  ;/
$8F:C157 4A          LSR A                  ;\
$8F:C158 4A          LSR A                  ;|
$8F:C159 4A          LSR A                  ;|
$8F:C15A 4A          LSR A                  ;|
$8F:C15B E2 20       SEP #$20               ;|
$8F:C15D 48          PHA                    ;|
$8F:C15E AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$8F:C161 8D 02 42    STA $4202              ;|
$8F:C164 68          PLA                    ;|
$8F:C165 8D 03 42    STA $4203              ;|
$8F:C168 C2 20       REP #$20               ;} X = ([$14] / 10h * [room width in blocks] + [$12] / 10h) * 2 (block index)
$8F:C16A A5 12       LDA $12    [$7E:0012]  ;|
$8F:C16C 4A          LSR A                  ;|
$8F:C16D 4A          LSR A                  ;|
$8F:C16E 4A          LSR A                  ;|
$8F:C16F 4A          LSR A                  ;|
$8F:C170 18          CLC                    ;|
$8F:C171 6D 16 42    ADC $4216              ;|
$8F:C174 0A          ASL A                  ;|
$8F:C175 AA          TAX                    ;/
$8F:C176 BF 02 00 7F LDA $7F0002,x[$7F:31FE];\
$8F:C17A 29 FF 03    AND #$03FF             ;|
$8F:C17D C9 FF 00    CMP #$00FF             ;} If (block tile table index) != FFh: go to generate random explosion at ([$12], [$14])
$8F:C180 D0 27       BNE $27    [$C1A9]     ;/

$8F:C182 60          RTS
}


;;; $C183: Generate random explosion on every fourth frame ;;;
{
$8F:C183 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$8F:C186 D0 4D       BNE $4D    [$C1D5]     ;} If time is frozen: return
$8F:C188 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$8F:C18B 29 03 00    AND #$0003             ;} If [frame counter] % 4 != 0: return
$8F:C18E D0 45       BNE $45    [$C1D5]     ;/
$8F:C190 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$8F:C194 48          PHA                    ;\
$8F:C195 29 FF 00    AND #$00FF             ;|
$8F:C198 18          CLC                    ;} $12 = [layer 1 X position] + [random number low]
$8F:C199 6D 11 09    ADC $0911  [$7E:0911]  ;|
$8F:C19C 85 12       STA $12    [$7E:0012]  ;/
$8F:C19E 68          PLA                    ;\
$8F:C19F EB          XBA                    ;|
$8F:C1A0 29 FF 00    AND #$00FF             ;|
$8F:C1A3 18          CLC                    ;} $14 = [layer 1 Y position] + [random number high]
$8F:C1A4 6D 15 09    ADC $0915  [$7E:0915]  ;|
$8F:C1A7 85 14       STA $14    [$7E:0014]  ;/
}


;;; $C1A9: Generate random explosion at ([$12], [$14]) ;;;
{
; Note that if [random number] & Fh >= 8, then X is some garbage value (instead of random) for the purposes of indexing the sprite object IDs array
$8F:C1A9 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$8F:C1AD 29 0F 00    AND #$000F             ;\
$8F:C1B0 C9 08 00    CMP #$0008             ;} If [random number] & Fh < 8:
$8F:C1B3 B0 0D       BCS $0D    [$C1C2]     ;/
$8F:C1B5 AA          TAX                    ; X = [random number] & Fh
$8F:C1B6 BD DE C1    LDA $C1DE,x[$8F:C1DE]  ;\
$8F:C1B9 29 FF 00    AND #$00FF             ;} If [$C1DE + [X]] != 0:
$8F:C1BC F0 04       BEQ $04    [$C1C2]     ;/
$8F:C1BE 22 CB 90 80 JSL $8090CB[$80:90CB]  ; Queue sound [$C1DE + [X]], sound library 2, max queued sounds allowed = 6

$8F:C1C2 8A          TXA                    ;\
$8F:C1C3 29 07 00    AND #$0007             ;|
$8F:C1C6 AA          TAX                    ;|
$8F:C1C7 BD D6 C1    LDA $C1D6,x[$8F:C1D6]  ;} $16 = [$C1D6 + ([X] & 7)]
$8F:C1CA 29 FF 00    AND #$00FF             ;|
$8F:C1CD 85 16       STA $16    [$7E:0016]  ;/
$8F:C1CF 64 18       STZ $18    [$7E:0018]  ; $18 = 0
$8F:C1D1 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ; Create sprite object at position ([$12], [$14])

$8F:C1D5 60          RTS

; Sprite object IDs. 3 = small explosion, 9 = small dust cloud, Ch = smoke, 12h = short big dust cloud, 15h = big dust cloud
$8F:C1D6             db 03, 03, 09, 0C, 0C, 12, 12, 15

; Explosion sound effects. Sound library 2
$8F:C1DE             db 24, 00, 00, 25, 00, 00, 00, 00
}


;;; $C1E6: Main ASM - scroll screen right in Dachora room ;;;
{
; Room $9CB3. Dachora room

; The intent of the code is probably to scroll the screen so that it's centred when falling down the shaft;
; in practice, the conditions for the scrolling never occur
$8F:C1E6 AF 2B CD 7E LDA $7ECD2B[$7E:CD2B]  ;\
$8F:C1EA 29 FF 00    AND #$00FF             ;|
$8F:C1ED C9 02 00    CMP #$0002             ;} If scroll Bh is not green: return
$8F:C1F0 D0 16       BNE $16    [$C208]     ;/
$8F:C1F2 AD 15 09    LDA $0915  [$7E:0915]  ;\
$8F:C1F5 C9 00 05    CMP #$0500             ;} If [layer 1 Y position] >= 500h: return
$8F:C1F8 B0 0E       BCS $0E    [$C208]     ;/
$8F:C1FA AD 11 09    LDA $0911  [$7E:0911]  ;\
$8F:C1FD C9 80 03    CMP #$0380             ;} If [layer 1 X position] >= 380h: return
$8F:C200 B0 06       BCS $06    [$C208]     ;/
$8F:C202 69 03 00    ADC #$0003             ;\
$8F:C205 8D 11 09    STA $0911  [$7E:0911]  ;} Layer 1 X position += 3

$8F:C208 60          RTS
}
}


;;; $C209: Unused. PLM metadata - Crateria / Brinstar / Norfair ;;;
{
; See $E881 for the other areas
$8F:C209             dw 0051, ; "Next" item / refill station index (50h is the last used one, see "Item PLMs.asm")
                        0061, ; "Next" doorcap index (60h is the last used one, see "Door PLMs.asm")
                        0001, ; ?
                        0002, ; Number of save stations in Crateria
                        0005, ; Number of save stations in Brinstar
                        0006  ; Number of save stations in Norfair
}


;;; $C215: PLM populations ;;;
{
;                        ________________ 0: PLM ID. 0 = terminator
;                       |      __________ 2: X position in blocks
;                       |     |   _______ 3: Y position in blocks
;                       |     |  |    ___ 4: Parameter
;                       |     |  |   |
;                       rrrr, xx,yy, pppp

; Room $C98E, state $C9A0. Wrecked Ship chozo room - default
$8F:C215             dx B703, 1F,2D, C9EC, ; Scroll PLM
                        B647, 41,26, 8000, ; Upwards extension
                        B647, 41,27, 8000, ; Upwards extension
                        B703, 41,28, C9F1, ; Scroll PLM
                        0000

; Room $CA08, state $CA1A. Wrecked Ship entrance treadmill - default
$8F:C22F             dx 0000

; Room $CA52, state $CA64. Wrecked Ship attic - default
$8F:C231             dx C848, 01,06, 0080, ; Door. Grey door facing right
                        C842, 6E,06, 0081, ; Door. Grey door facing left
                        BB05, 08,08, 8000, ; Wrecked Ship attic
                        0000

; Room $CAAE, state $CAC0. Wrecked Ship attic missile tank room - default
$8F:C245             dx 0000

; Room $CAF6. Wrecked Ship mainstreet
$8F:C247             dx B703, 3E,57, CB7A, ; Scroll PLM
                        B703, 51,69, CB7D, ; Scroll PLM
                        B703, 41,57, CB80, ; Scroll PLM
                        B703, 4E,69, CB83, ; Scroll PLM
                        B703, 47,6D, CB86, ; Scroll PLM
                        EEDB, 02,59, 0080, ; Missile tank
                        C848, 41,66, 0082, ; Door. Grey door facing right
                        C842, 4E,46, 0083, ; Door. Grey door facing left
                        C87E, 46,7D, 0084, ; Door. Green door facing up
                        0000

; Room $CB8B, state $CB9D. Wrecked Ship spike platform hall - default
$8F:C27F             dx 0000

; Room $CBD5, state $CBE7. Wrecked Ship east exit - default
$8F:C281             dx B703, 07,10, CC24, ; Scroll PLM
                        B63B, 08,10, 8000, ; Rightwards extension
                        0000

; Room $CC27, state $CC39. Wrecked Ship chozo energy tank room - default
$8F:C28F             dx 0000

; Room $CC6F, state $CC81. Pre Phantoon hall - default
$8F:C291             dx B703, 40,0C, CCC0, ; Scroll PLM
                        B703, 46,0C, CCC5, ; Scroll PLM
                        DB5A, 4E,06, 0085, ; Door. Eye door, facing left
                        DB60, 4E,09, 0085, ; Eye door bottom, facing left
                        DB56, 4E,07, 0085, ; Eye door eye, facing left
                        0000

; Room $CCCB, state $CCDD. Wrecked Ship map station - default
$8F:C2B1             dx 0000

; Room $CD13. Phantoon
$8F:C2B3             dx C848, 01,06, 0086, ; Door. Grey door facing right
                        0000

; Room $CD5C, state $CD6E. Wrecked Ship first flooded room - default
$8F:C2BB             dx 0000

; Room $CDA8, state $CDBA. Wrecked Ship west super missile room - default
$8F:C2BD             dx 0000

; Room $CDF1, state $CE03. Wrecked Ship east super missile hall - default
$8F:C2BF             dx B703, 2F,07, CE3D, ; Scroll PLM
                        0000

; Room $CE40, state $CE52. Gravity suit room - default
; Room $CE8A, state $CE9C. Wrecked Ship save station - default
$8F:C2C7             dx 0000

; Room $CE8A, state $CEB6. Wrecked Ship save station - main area boss is dead
$8F:C2C9             dx B76F, 07,0B, 0000, ; Save station
                        0000

; Room $C98E, state $C9BA. Wrecked Ship chozo room - main area boss is dead
$8F:C2D1             dx B703, 1F,2D, C9EC, ; Scroll PLM
                        B647, 41,26, 8000, ; Upwards extension
                        B647, 41,27, 8000, ; Upwards extension
                        B703, 41,28, C9F1, ; Scroll PLM
                        EF7B, 53,0B, 0081, ; Reserve tank, chozo orb
                        EEDB, 3C,26, 0082, ; Missile tank
                        C848, 01,16, 9087, ; Door. Grey door facing right
                        0000

; Room $CA08, state $CA34. Wrecked Ship entrance treadmill - main area boss is dead
$8F:C2FD             dx 0000

; Room $CA52, state $CA7E. Wrecked Ship attic - main area boss is dead
$8F:C2FF             dx C848, 01,06, 0C88, ; Door. Grey door facing right
                        C842, 6E,06, 0C89, ; Door. Grey door facing left
                        C84E, 46,0E, 0C8A, ; Door. Grey door facing up
                        BB05, 08,08, 8000, ; Wrecked Ship attic
                        0000

; Room $CAAE, state $CADA. Wrecked Ship attic missile tank room - main area boss is dead
$8F:C319             dx EEDB, 2D,08, 0083, ; Missile tank
                        0000

; Room $CB8B, state $CBB7. Wrecked Ship spike platform hall - main area boss is dead
$8F:C321             dx 0000

; Room $CBD5, state $CC01. Wrecked Ship east exit - main area boss is dead
$8F:C323             dx B703, 07,10, CC24, ; Scroll PLM
                        B63B, 08,10, 8000, ; Rightwards extension
                        C890, 01,06, 008B, ; Door. Red door facing right
                        0000

; Room $CC27, state $CC53. Wrecked Ship chozo energy tank room - main area boss is dead
$8F:C337             dx EED7, 03,06, 0084, ; Energy tank
                        0000

; Room $CC6F, state $CC9B. Pre Phantoon hall - main area boss is dead
$8F:C33F             dx B703, 40,0C, CCC0, ; Scroll PLM
                        B703, 46,0C, CCC5, ; Scroll PLM
                        0000

; Room $CCCB, state $CCF7. Wrecked Ship map station - main area boss is dead
$8F:C34D             dx B6D3, 05,0A, 8000, ; Map station
                        0000

; Room $CD5C, state $CD88. Wrecked Ship first flooded room - main area boss is dead
$8F:C355             dx 0000

; Room $CDA8, state $CDD4. Wrecked Ship west super missile room - main area boss is dead
$8F:C357             dx EEDF, 02,07, 0085, ; Super missile tank
                        0000

; Room $CDF1, state $CE1D. Wrecked Ship east super missile hall - main area boss is dead
$8F:C35F             dx B703, 2F,07, CE3D, ; Scroll PLM
                        EEDF, 38,09, 0086, ; Super missile tank
                        0000

; Room $CE40, state $CE6C. Gravity suit room - main area boss is dead
$8F:C36D             dx EF5F, 07,09, 0087, ; Gravity suit, chozo orb
                        0000

; Room $CED2. n00b tube save station
$8F:C375             dx B76F, 07,0B, 0000, ; Save station
                        0000

; Room $CEFB. n00b tube
$8F:C37D             dx B703, 03,14, CF4C, ; Scroll PLM
                        B63B, 04,14, 8000, ; Rightwards extension
                        B63B, 05,14, 8000, ; Rightwards extension
                        B63B, 06,14, 8000, ; Rightwards extension
                        B703, 09,14, CF4C, ; Scroll PLM
                        B63B, 0A,14, 8000, ; Rightwards extension
                        B63B, 0B,14, 8000, ; Rightwards extension
                        B63B, 0C,14, 8000, ; Rightwards extension
                        B703, 05,1D, CF4F, ; Scroll PLM
                        B63B, 06,1D, 8000, ; Rightwards extension
                        B63B, 07,1D, 8000, ; Rightwards extension
                        B63B, 08,1D, 8000, ; Rightwards extension
                        B63B, 09,1D, 8000, ; Rightwards extension
                        B63B, 0A,1D, 8000, ; Rightwards extension
                        D70C, 02,15, 0080, ; n00b tube
                        C88A, 0E,26, 008C, ; Door. Red door facing left
                        0000

; Room $CF54. n00b tube west
$8F:C3DF             dx 0000

; Room $CF80. n00b tube east
$8F:C3E1             dx B703, 05,09, CFB5, ; Scroll PLM
                        B703, 05,10, CFBC, ; Scroll PLM
                        B703, 05,16, CFC1, ; Scroll PLM
                        B647, 0A,03, 8000, ; Upwards extension
                        B647, 0A,04, 8000, ; Upwards extension
                        B647, 0A,05, 8000, ; Upwards extension
                        B647, 0A,06, 8000, ; Upwards extension
                        B647, 0A,07, 8000, ; Upwards extension
                        B647, 0A,08, 8000, ; Upwards extension
                        B703, 0A,09, CFC6, ; Scroll PLM
                        C82A, 16,05, 8000, ; Downwards closed gate
                        C836, 16,05, 000A, ; Downwards gate shotblock
                        0000

; Room $CFC9. Maridia mainstreet
$8F:C42B             dx B703, 25,29, D012, ; Scroll PLM
                        C88A, 1E,76, 008D, ; Door. Red door facing left
                        EEDB, 0E,35, 0088, ; Missile tank
                        EEDF, 16,28, 0089, ; Super missile tank
                        0000

; Room $D017. Maridia space pirate room
$8F:C445             dx B647, 1F,26, 8000, ; Upwards extension
                        B647, 1F,27, 8000, ; Upwards extension
                        B647, 1F,28, 8000, ; Upwards extension
                        B703, 1F,29, D052, ; Scroll PLM
                        B647, 30,26, 8000, ; Upwards extension
                        B647, 30,27, 8000, ; Upwards extension
                        B647, 30,28, 8000, ; Upwards extension
                        B703, 30,29, D052, ; Scroll PLM
                        C88A, 3E,26, 008E, ; Door. Red door facing left
                        0000

; Room $D055. Tatori room
$8F:C47D             dx EED7, 1F,0A, 008A, ; Energy tank
                        EF83, 2C,1D, 008B, ; Missile tank, shot block
                        0000

; Room $D08A. Maridia green gate hall
$8F:C48B             dx C82A, 0E,07, 8000, ; Downwards closed gate
                        C836, 0E,07, 0008, ; Downwards gate shotblock
                        0000

; Room $D0B9. Mt. Doom
$8F:C499             dx 0000

; Room $D104. Maridia -> Red Brinstar room
$8F:C49B             dx B703, 20,06, D135, ; Scroll PLM
                        B703, 1E,06, D138, ; Scroll PLM
                        0000

; Room $D13B. Sandy Maridia missile and super missile room
$8F:C4A9             dx B703, 07,1F, D16A, ; Scroll PLM
                        EEDF, 04,26, 008C, ; Super missile tank
                        EEDB, 0B,27, 008D, ; Missile tank
                        0000

; Room $D16D. Sandy Maridia memu room
$8F:C4BD             dx B647, 20,16, 8000, ; Upwards extension
                        B647, 20,17, 8000, ; Upwards extension
                        B647, 20,18, 8000, ; Upwards extension
                        B703, 20,19, D1A0, ; Scroll PLM
                        B647, 0F,16, 8000, ; Upwards extension
                        B647, 0F,17, 8000, ; Upwards extension
                        B647, 0F,18, 8000, ; Upwards extension
                        B703, 0F,19, D1A0, ; Scroll PLM
                        0000

; Room $D1A3. Maridia crab shaft
$8F:C4EF             dx B703, 07,2D, D1D8, ; Scroll PLM
                        B63B, 08,2D, 8000, ; Rightwards extension
                        C872, 1E,36, 008F, ; Door. Green door facing left
                        0000

; Room $D1DD. Beach
$8F:C503             dx B647, 1F,26, 8000, ; Upwards extension
                        B647, 1F,27, 8000, ; Upwards extension
                        B647, 1F,28, 8000, ; Upwards extension
                        B703, 1F,29, D216, ; Scroll PLM
                        B647, 1D,26, 8000, ; Upwards extension
                        B647, 1D,27, 8000, ; Upwards extension
                        B647, 1D,28, 8000, ; Upwards extension
                        B703, 1D,29, D219, ; Scroll PLM
                        EEDB, 2C,28, 008E, ; Missile tank
                        0000

; Room $D21C. Maridia broken glass tube room
$8F:C53B             dx B703, 08,0E, D24D, ; Scroll PLM
                        B703, 08,11, D24D, ; Scroll PLM
                        C88A, 0E,16, 0090, ; Door. Red door facing left
                        0000

; Room $D252. Maridia broken glass tube room east
$8F:C54F             dx 0000

; Room $D27E. Plasma beam puyo room
$8F:C551             dx 0000

; Room $D2AA. Plasma beam room
$8F:C553             dx C848, 01,06, 0C91, ; Door. Grey door facing right
                        EF67, 19,26, 008F, ; Plasma beam, chozo orb
                        0000

; Room $D2D9. Sandy Maridia choot-puyo hall
$8F:C561             dx 0000

; Room $D30B. Maridia -> Crateria elevator
$8F:C563             dx B70B, 06,2C, 8000, ; Elevator platform
                        C88A, 0E,46, 0092, ; Door. Red door facing left
                        0000

; Room $D340. Sandy Maridia mainstreet
$8F:C571             dx C842, 2E,16, 0093, ; Door. Grey door facing left
                        C87E, 06,2D, 0094, ; Door. Green door facing up
                        0000

; Room $D387. Pre plasma beam shaft
$8F:C57F             dx 0000

; Room $D3B6. Maridia map station
$8F:C581             dx B6D3, 0B,0A, 8000, ; Map station
                        0000

; Room $D3DF. Sandy Maridia save station
$8F:C589             dx B76F, 07,0B, 0001, ; Save station
                        0000

; Room $D408. Maridia elevatube
$8F:C591             dx 0000

; Room $D433. Sandy Maridia quicksand top
$8F:C593             dx 0000

; Room $D461. Evir hall west
$8F:C595             dx 0000

; Room $D48E. Elevatube south
$8F:C597             dx B703, 03,14, D4BD, ; Scroll PLM
                        B63B, 04,14, 8000, ; Rightwards extension
                        B63B, 05,14, 8000, ; Rightwards extension
                        B63B, 06,14, 8000, ; Rightwards extension
                        B63B, 07,14, 8000, ; Rightwards extension
                        B63B, 08,14, 8000, ; Rightwards extension
                        B63B, 09,14, 8000, ; Rightwards extension
                        B63B, 0A,14, 8000, ; Rightwards extension
                        B63B, 0B,14, 8000, ; Rightwards extension
                        B63B, 0C,14, 8000, ; Rightwards extension
                        C884, 06,02, 0095, ; Door. Green door facing down
                        0000

; Room $D4C2. Evir hall east
$8F:C5DB             dx 0000

; Room $D4EF. Snail room quicksand items west
$8F:C5DD             dx EEDB, 06,04, 0090, ; Missile tank
                        EF7B, 0F,04, 0091, ; Reserve tank, chozo orb
                        0000

; Room $D51E. Snail room quicksand items east
$8F:C5EB             dx EEDB, 03,07, 0092, ; Missile tank
                        EEE3, 19,10, 0093, ; Power bomb tank
                        0000

; Room $D54D. Snail room quicksand fall west
$8F:C5F9             dx 0000

; Room $D57A. Snail room quicksand fall east
$8F:C5FB             dx 0000

; Room $D5A7. Snail room
$8F:C5FD             dx C890, 01,26, 0096, ; Door. Red door facing right
                        EEDB, 4C,09, 0094, ; Missile tank
                        EEDF, 5C,08, 0095, ; Super missile tank
                        0000

; Room $D5EC. Sandy Maridia quicksand bottom
$8F:C611             dx C842, 0E,06, 0097, ; Door. Grey door facing left
                        0000

; Room $D617. Mochtroid room
$8F:C619             dx 0000

; Room $D646. Pants room
$8F:C61B             dx B703, 06,32, D67D, ; Scroll PLM
                        B63B, 07,32, 8000, ; Rightwards extension
                        B63B, 08,32, 8000, ; Rightwards extension
                        B63B, 09,32, 8000, ; Rightwards extension
                        B703, 0D,0C, D67D, ; Scroll PLM
                        B647, 0D,0B, 8000, ; Upwards extension
                        B647, 0D,0A, 8000, ; Upwards extension
                        B647, 0D,09, 8000, ; Upwards extension
                        B647, 0D,08, 8000, ; Upwards extension
                        B647, 0D,07, 8000, ; Upwards extension
                        B647, 0D,06, 8000, ; Upwards extension
                        B647, 0D,05, 8000, ; Upwards extension
                        B647, 0D,04, 8000, ; Upwards extension
                        B703, 12,0E, D68A, ; Scroll PLM
                        B647, 12,0D, 8000, ; Upwards extension
                        B647, 12,0C, 8000, ; Upwards extension
                        B647, 12,0B, 8000, ; Upwards extension
                        B647, 12,0A, 8000, ; Upwards extension
                        B647, 12,09, 8000, ; Upwards extension
                        B647, 12,08, 8000, ; Upwards extension
                        B647, 12,07, 8000, ; Upwards extension
                        B703, 15,2B, D695, ; Scroll PLM
                        B63B, 16,2B, 8000, ; Rightwards extension
                        B63B, 17,2B, 8000, ; Rightwards extension
                        0000

; Room $D69A. Pants room section
$8F:C6AD             dx B703, 05,22, D6C8, ; Scroll PLM
                        B63B, 06,22, 8000, ; Rightwards extension
                        B63B, 07,22, 8000, ; Rightwards extension
                        B63B, 08,22, 8000, ; Rightwards extension
                        B63B, 09,22, 8000, ; Rightwards extension
                        B63B, 0A,12, 8000, ; Rightwards extension
                        B703, 05,1B, D6CB, ; Scroll PLM
                        B63B, 06,1B, 8000, ; Rightwards extension
                        B63B, 07,1B, 8000, ; Rightwards extension
                        0000

; Room $D6D0. Spring ball room
$8F:C6E5             dx EF57, 18,16, 0096, ; Spring ball, chozo orb
                        0000

; Room $D6FD. Maridia speed blockade quicksand bottom
$8F:C6ED             dx 0000

; Room $D72A. Maridia grapple room
$8F:C6EF             dx C88A, 6E,06, 0098, ; Door. Red door facing left
                        C872, 4E,26, 0099, ; Door. Green door facing left
                        C872, 6E,16, 009A, ; Door. Green door facing left
                        0000

; Room $D765. Snail room save station
$8F:C703             dx B76F, 05,0B, 0002, ; Save station
                        0000

; Room $D78F. Pre Draygon room
$8F:C70B             dx B703, 04,0E, D7DF, ; Scroll PLM
                        B63B, 05,0E, 8000, ; Rightwards extension
                        B63B, 06,0E, 8000, ; Rightwards extension
                        B63B, 07,0E, 8000, ; Rightwards extension
                        B63B, 08,0E, 8000, ; Rightwards extension
                        B63B, 09,0E, 8000, ; Rightwards extension
                        B63B, 0A,0E, 8000, ; Rightwards extension
                        B63B, 0B,0E, 8000, ; Rightwards extension
                        DB4C, 01,26, 009B, ; Door. Eye door, facing right
                        DB52, 01,29, 009B, ; Eye door bottom, facing right
                        DB48, 01,27, 009B, ; Eye door eye, facing right
                        EF83, 1C,06, 0097, ; Missile tank, shot block
                        0000

; Room $D7E4. Maridia speed blockade hall
$8F:C755             dx EED7, 32,05, 0098, ; Energy tank
                        0000

; Room $D81A. Draygon save station
$8F:C75D             dx B76F, 07,0B, 0003, ; Save station
                        0000

; Room $D845. Maridia missile station
$8F:C765             dx B6EB, 08,0A, 0099, ; Missile station
                        0000

; Room $D86E. Sandy Maridia quicksand fall
$8F:C76D             dx 0000

; Room $D898. Maridia speed blockade quicksand fall
$8F:C76F             dx 0000

; Room $D8C5. Shaktool
$8F:C771             dx 0000

; Room $D913. Maridia grapple wall shaft
$8F:C773             dx B703, 10,29, D951, ; Scroll PLM
                        B703, 0B,29, D956, ; Scroll PLM
                        B647, 0B,28, 8000, ; Upwards extension
                        B647, 0B,27, 8000, ; Upwards extension
                        B647, 0B,26, 8000, ; Upwards extension
                        B703, 0E,29, D95B, ; Scroll PLM
                        C848, 01,16, 009C, ; Door. Grey door facing right
                        0000

; Room $D95E. Botwoon
$8F:C79F             dx C848, 01,06, 049D, ; Door. Grey door facing right
                        0000

; Room $D9AA. Space jump room
$8F:C7A7             dx EF6F, 04,08, 009A, ; Space jump, chozo orb
                        0000

; Room $D9D4. Maridia energy station
$8F:C7AF             dx B6DF, 08,0A, 009B, ; Energy station
                        0000

; Room $D9FE. Maridia cacatac room west
$8F:C7B7             dx 0000

; Room $DA2B. Maridia cacatac room east
$8F:C7B9             dx 0000

; Room $DA60. Draygon
$8F:C7BB             dx C842, 1E,06, 009E, ; Door. Grey door facing left
                        C848, 01,16, 009F, ; Door. Grey door facing right
                        DF65, 02,0B, 8802, ; Draygon cannon, facing right
                        DF59, 02,12, 8804, ; Draygon cannon, with shield, facing right
                        DF71, 1D,0F, 8806, ; Draygon cannon, with shield, facing left
                        DF71, 1D,15, 8808, ; Draygon cannon, with shield, facing left
                        0000

; Room $DAAE. Tourian -> Crateria elevator
$8F:C7E1             dx B70B, 06,2C, 8000, ; Elevator platform
                        0000

; Room $DAE1. Metroid room 1
$8F:C7E9             dx DB44, 08,08, 0012, ; Sets Metroids cleared states when required
                        C848, 01,06, 0CA0, ; Door. Grey door facing right
                        0000

; Room $DB31. Metroid room 2
$8F:C7F7             dx DB44, 08,08, 0014, ; Sets Metroids cleared states when required
                        C842, 0E,16, 0CA1, ; Door. Grey door facing left
                        0000

; Room $DB7D. Metroid room 3
$8F:C805             dx DB44, 08,08, 0016, ; Sets Metroids cleared states when required
                        C842, 5E,06, 0CA2, ; Door. Grey door facing left
                        0000

; Room $DBCD. Metroid room 4
$8F:C813             dx DB44, 08,08, 0018, ; Sets Metroids cleared states when required
                        C84E, 06,1E, 0CA3, ; Door. Grey door facing up
                        0000

; Room $DC19. Tourian super-sidehopper room
$8F:C821             dx 0000

; Room $DC65. Torizo corpse room
$8F:C823             dx C842, 1E,06, 90A4, ; Door. Grey door facing left
                        C848, 01,06, 0CA5, ; Door. Grey door facing right
                        0000

; Room $DCB1. Shitroid room
$8F:C831             dx C842, 3E,06, 90A6, ; Door. Grey door facing left
                        0000

; Room $DCFF. Post Shitroid room
$8F:C839             dx C88A, 0E,16, 00A7, ; Door. Red door facing left
                        0000

; Room $DD2E. Tourian refill station
$8F:C841             dx B6EB, 08,0A, 009C, ; Missile station
                        B6DF, 06,0A, 009D, ; Energy station
                        0000

; Room $DD58. Mother Brain
$8F:C84F             dx D6DE, 09,05, 8000, ; Mother Brain's glass
                        0000

; Room $DDC4. Tourian eye-door room
$8F:C857             dx DB5A, 3E,06, 00A8, ; Door. Eye door, facing left
                        DB60, 3E,09, 00A8, ; Eye door bottom, facing left
                        DB56, 3E,07, 00A8, ; Eye door eye, facing left
                        0000

; Room $DDF3. Pre Mother Brain shaft
$8F:C86B             dx C890, 01,26, 00A9, ; Door. Red door facing right
                        0000

; Room $DE23. Mother Brain save station
$8F:C873             dx B76F, 05,0B, 0000, ; Save station
                        0000

; Room $DE4D. Escape room 1
$8F:C87B             dx DB44, 08,08, 0000, ; Sets Metroids cleared states when required
                        C8CA, 1F,06, 8000, ; Door. Gate that closes during escape in room after Mother Brain
                        0000

; Room $DE7A. Escape room 2
$8F:C889             dx DB44, 08,08, 0002, ; Sets Metroids cleared states when required
                        C854, 06,03, 90AA, ; Door. Grey door facing down
                        0000

; Room $DEA7. Escape room 3
$8F:C897             dx DB44, 08,08, 0004, ; Sets Metroids cleared states when required
                        C848, 01,16, 90AB, ; Door. Grey door facing right
                        0000

; Room $DEDE. Escape room 4
$8F:C8A5             dx DB44, 08,08, 0006, ; Sets Metroids cleared states when required
                        C848, 01,36, 90AC, ; Door. Grey door facing right
                        0000

; Room $DF1B. Tourian elevator save station
$8F:C8B3             dx B76F, 07,0B, 0001, ; Save station
                        0000

; Room $DF45. Ceres elevator shaft
$8F:C8BB             dx 0000

; Room $DF8D. Ceres pre elevator hall
$8F:C8BD             dx 0000

; Room $DFD7. Ceres stairs
$8F:C8BF             dx 0000

; Room $E021. Ceres baby metroid hall
$8F:C8C1             dx 0000

; Room $E06B. Pre Ceres Ridley hall
$8F:C8C3             dx 0000

; Room $E0B5. Ceres Ridley
$8F:C8C5             dx 0000
}


;;; $C8C7..C98D: Setup ASM ;;;
{
;;; $C8C7: RTS. Room setup ASM ;;;
{
; Room $C98E. Wrecked Ship chozo room
; Room $CA08. Wrecked Ship entrance treadmill
; Room $CA52. Wrecked Ship attic
; Room $CAAE. Wrecked Ship attic missile tank room
; Room $CAF6. Wrecked Ship mainstreet
; Room $CB8B. Wrecked Ship spike platform hall
; Room $CBD5. Wrecked Ship east exit
; Room $CC27. Wrecked Ship chozo energy tank room
$8F:C8C7 60          RTS
}


;;; $C8C8: Room setup ASM - spawn pre-Phantoon room enemy projectile ;;;
{
; Room $CC6F. Pre Phantoon hall
$8F:C8C8 A0 B0 A3    LDY #$A3B0             ;\
$8F:C8CB 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn pre-Phantoon room enemy projectile
$8F:C8CF 60          RTS
}


;;; $C8D0: RTS. Room setup ASM ;;;
{
; Room $CCCB. Wrecked Ship map station
; Room $CD13. Phantoon
; Room $CD5C. Wrecked Ship first flooded room
; Room $CDA8. Wrecked Ship west super missile room
; Room $CDF1. Wrecked Ship east super missile hall
; Room $CE40. Gravity suit room
; Room $CE8A, state $CEB6. Wrecked Ship save station - main area boss is dead
$8F:C8D0 60          RTS
}


;;; $C8D1: RTS. Room setup ASM ;;;
{
; Room $CED2. n00b tube save station
; Room $CEFB. n00b tube
; Room $CF54. n00b tube west
; Room $CF80. n00b tube east
; Room $CFC9. Maridia mainstreet
; Room $D017. Maridia space pirate room
; Room $D055. Tatori room
; Room $D08A. Maridia green gate hall
; Room $D0B9. Mt. Doom
; Room $D104. Maridia -> Red Brinstar room
; Room $D13B. Sandy Maridia missile and super missile room
; Room $D16D. Sandy Maridia memu room
; Room $D1A3. Maridia crab shaft
; Room $D1DD. Beach
; Room $D21C. Maridia broken glass tube room
; Room $D252. Maridia broken glass tube room east
; Room $D27E. Plasma beam puyo room
; Room $D2AA. Plasma beam room
; Room $D2D9. Sandy Maridia choot-puyo hall
; Room $D30B. Maridia -> Crateria elevator
; Room $D340. Sandy Maridia mainstreet
; Room $D387. Pre plasma beam shaft
; Room $D3B6. Maridia map station
$8F:C8D1 60          RTS
}


;;; $C8D2: RTS. Room setup ASM ;;;
{
; Room $D408. Maridia elevatube
; Room $D433. Sandy Maridia quicksand top
; Room $D461. Evir hall west
; Room $D48E. Elevatube south
; Room $D4C2. Evir hall east
; Room $D4EF. Snail room quicksand items west
; Room $D51E. Snail room quicksand items east
; Room $D54D. Snail room quicksand fall west
; Room $D57A. Snail room quicksand fall east
; Room $D5A7. Snail room
; Room $D5EC. Sandy Maridia quicksand bottom
; Room $D617. Mochtroid room
; Room $D646. Pants room
; Room $D69A. Pants room section
; Room $D6D0. Spring ball room
; Room $D6FD. Maridia speed blockade quicksand bottom
; Room $D72A. Maridia grapple room
; Room $D765. Snail room save station
; Room $D78F. Pre Draygon room
; Room $D7E4. Maridia speed blockade hall
; Room $D81A. Draygon save station
; Room $D845. Maridia missile station
; Room $D86E. Sandy Maridia quicksand fall
; Room $D898. Maridia speed blockade quicksand fall
$8F:C8D2 60          RTS
}


;;; $C8D3: Room setup ASM - Shaktool's room ;;;
{
; Room $D8C5, state $D8D7. Shaktool - default
$8F:C8D3 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:C8D7             dx  00, 00, B8EB       ;} Spawn Shaktool's room PLM
$8F:C8DB 60          RTS
}


;;; $C8DC: RTS. Room setup ASM ;;;
{
; Room $D8C5, state $D8F1. Shaktool - event "Shaktool cleared a path" is set
; Room $D913. Maridia grapple wall shaft
; Room $D95E. Botwoon
; Room $D9AA. Space jump room
$8F:C8DC 60          RTS
}


;;; $C8DD: Room setup ASM - set pausing code for Draygon ;;;
{
; Room $DA60. Draygon
$8F:C8DD A9 00 8F    LDA #$8F00             ;\
$8F:C8E0 8D 02 06    STA $0602  [$7E:0602]  ;|
$8F:C8E3 A9 F6 C8    LDA #$C8F6             ;} Pause hook = pause hook - Draygon
$8F:C8E6 8D 01 06    STA $0601  [$7E:0601]  ;/
$8F:C8E9 A9 00 8F    LDA #$8F00             ;\
$8F:C8EC 8D 05 06    STA $0605  [$7E:0605]  ;|
$8F:C8EF A9 FC C8    LDA #$C8FC             ;} Unpause hook = unpause hook - Draygon
$8F:C8F2 8D 04 06    STA $0604  [$7E:0604]  ;/
$8F:C8F5 60          RTS
}


;;; $C8F6: Pause hook - Draygon ;;;
{
$8F:C8F6 A9 04 00    LDA #$0004             ;\
$8F:C8F9 85 A7       STA $A7    [$7E:00A7]  ;} Next interrupt command = main gameplay
$8F:C8FB 6B          RTL
}


;;; $C8FC: Unpause hook - Draygon ;;;
{
$8F:C8FC AD B6 18    LDA $18B6  [$7E:18B6]  ;\
$8F:C8FF C9 08 00    CMP #$0008             ;} If HDMA object 1 (Draygon main screen layers) enabled:
$8F:C902 D0 05       BNE $05    [$C909]     ;/
$8F:C904 A9 0C 00    LDA #$000C             ;\
$8F:C907 85 A7       STA $A7    [$7E:00A7]  ;} Next interrupt command = Draygon's room

$8F:C909 6B          RTL
}


;;; $C90A: Room setup ASM - set collected map ;;;
{
; Room $DAAE. Tourian -> Crateria elevator
$8F:C90A C2 30       REP #$30
$8F:C90C AE 9F 07    LDX $079F  [$7E:079F]  ;\
$8F:C90F BF 08 D9 7E LDA $7ED908,x[$7E:D90D];|
$8F:C913 09 01 00    ORA #$0001             ;} Area map station byte |= 1
$8F:C916 9F 08 D9 7E STA $7ED908,x[$7E:D90D];/
$8F:C91A 8D 89 07    STA $0789  [$7E:0789]  ; Current area map collected flag = [area map station byte]
$8F:C91D 60          RTS
}


;;; $C91E: RTS. Room setup ASM ;;;
{
; Room $DAE1. Metroid room 1
; Room $DB31. Metroid room 2
; Room $DB7D. Metroid room 3
; Room $DBCD. Metroid room 4
; Room $DC19. Tourian super-sidehopper room
; Room $DC65. Torizo corpse room
; Room $DCB1. Shitroid room
; Room $DCFF. Post Shitroid room
; Room $DD2E. Tourian refill station
; Room $DD58. Mother Brain
; Room $DDC4. Tourian eye-door room
; Room $DDF3. Pre Mother Brain shaft
; Room $DE23. Mother Brain save station
$8F:C91E 60          RTS
}


;;; $C91F: Room setup ASM - set Zebes timebomb event and set light horizontal room shaking ;;;
{
; Room $DE4D. Escape room 1

; The Zebes timebomb set event was already marked by Mother Brain when she started the time ($A9:B313),
; no reason to do it here
$8F:C91F A9 0E 00    LDA #$000E             ;\
$8F:C922 22 FA 81 80 JSL $8081FA[$80:81FA]  ;} Mark Zebes timebomb set event
$8F:C926 A9 12 00    LDA #$0012             ;\
$8F:C929 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1, BG2 and enemies, 1 pixel displacement, horizontal
$8F:C92C A9 FF FF    LDA #$FFFF             ;\
$8F:C92F 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = FFFFh
$8F:C932 60          RTS
}


;;; $C933: Room setup ASM - set light horizontal room shaking ;;;
{
; Room $DE7A. Escape room 2
$8F:C933 A9 12 00    LDA #$0012             ;\
$8F:C936 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = room earthquake type = BG1, BG2 and enemies, 1 pixel displacement, horizontal
$8F:C939 8D E3 07    STA $07E3  [$7E:07E3]  ;/
$8F:C93C 9C E1 07    STZ $07E1  [$7E:07E1]  ; Room diagonal shake timer = 0
$8F:C93F A9 FF FF    LDA #$FFFF             ;\
$8F:C942 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = FFFFh
$8F:C945 60          RTS
}


;;; $C946: Room setup ASM - set medium horizontal room shaking ;;;
{
; Room $DEA7. Escape room 3
$8F:C946 A9 15 00    LDA #$0015             ;\
$8F:C949 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1, BG2 and enemies, 2 pixel displacement, horizontal
$8F:C94C A9 FF FF    LDA #$FFFF             ;\
$8F:C94F 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = FFFFh
$8F:C952 60          RTS
}


;;; $C953: Room setup ASM - set up rising acid and set medium horizontal room shaking ;;;
{
; Room $DEDE. Escape room 4
$8F:C953 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:C957             dx  10, 10, B968       ;} Spawn PLM to raise acid in escape room before old Tourian escape shaft
$8F:C95B A9 15 00    LDA #$0015             ;\
$8F:C95E 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = room earthquake type = BG1, BG2 and enemies, 2 pixel displacement, horizontal
$8F:C961 8D E3 07    STA $07E3  [$7E:07E3]  ;/
$8F:C964 9C E1 07    STZ $07E1  [$7E:07E1]  ; Room diagonal shake timer = 0
$8F:C967 A9 FF FF    LDA #$FFFF             ;\
$8F:C96A 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = FFFFh
$8F:C96D 60          RTS
}


;;; $C96E: Room setup ASM - turn Ceres door to solid blocks and spawn Ceres haze ;;;
{
; Room $DF45, state $DF71. Ceres elevator shaft - main area boss is dead
$8F:C96E 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:C972             dx  0F, 26, BA48       ;} Spawn PLM to turn Ceres elevator door to solid blocks during escape
}


;;; $C976: Room setup ASM - spawn Ceres haze ;;;
{
; Room $DF45, state $DF57. Ceres elevator shaft - default
; Room $DF8D. Ceres pre elevator hall
; Room $DFD7. Ceres stairs
; Room $E021. Ceres baby metroid hall
; Room $E06B. Pre Ceres Ridley hall
$8F:C976 22 C7 DD 88 JSL $88DDC7[$88:DDC7]  ; FX type 2Ch: Ceres haze
$8F:C97A 60          RTS
}


;;; $C97B: Room setup ASM - set BG1/2 tiles base address and spawn Ceres haze ;;;
{
; Room $E0B5. Ceres Ridley
$8F:C97B 08          PHP                    ;\
$8F:C97C E2 20       SEP #$20               ;|
$8F:C97E A9 66       LDA #$66               ;} BG1 tiles base address = BG2 tiles base address = $6000
$8F:C980 85 5D       STA $5D    [$7E:005D]  ;|
$8F:C982 28          PLP                    ;/
$8F:C983 22 C7 DD 88 JSL $88DDC7[$88:DDC7]  ; FX type 2Ch: Ceres haze
$8F:C987 A9 09 00    LDA #$0009             ;\
$8F:C98A 8D EB 07    STA $07EB  [$7E:07EB]  ;} Video mode for HUD and floor = 9 (mode 1 with BG3 priority)
$8F:C98D 60          RTS
}
}


;;; $C98E: Room headers, scroll data, door lists ;;;
{
; Room header format:
;      __________________________________________ Room index
;     |   _______________________________________ Area index
;     |  |    ___________________________________ X position (of top left corner) on the map
;     |  |   |   ________________________________ Y position (of top left corner) on the map
;     |  |   |  |    ____________________________ Room width (in units of screens = 16 blocks = 256 pixels)
;     |  |   |  |   |   _________________________ Room height (in units of screens = 16 blocks = 256 pixels)
;     |  |   |  |   |  |    _____________________ Up scroller
;     |  |   |  |   |  |   |   __________________ Down scroller
;     |  |   |  |   |  |   |  |    ______________ CRE bitset
;     |  |   |  |   |  |   |  |   |    __________ Door list pointer
;     |  |   |  |   |  |   |  |   |   |      ____ State conditions list
;     |  |   |  |   |  |   |  |   |   |     |
;     ii,aa, xx,yy, ww,hh, uu,dd, cc, dddd, [...]

; State conditions list format:
;      ______________ State condition
;     |     _________ State condition parameters
;     |    |      ___ State header pointer
;     |    |     |
;     eeee [...] ssss ; First state condition
;     eeee [...] ssss ; Second state condition
;     [...]           ; Other state conditions
;     E5E6            ; Default state condition (terminator)

; State header format:
;      ___________________________________________________________________________ Level data
;     |        ___________________________________________________________________ Tileset
;     |       |    _______________________________________________________________ Music data index
;     |       |   |   ____________________________________________________________ Music track
;     |       |   |  |    ________________________________________________________ FX ($83)
;     |       |   |  |   |      __________________________________________________ Enemy population ($A1)
;     |       |   |  |   |     |      ____________________________________________ Enemy set ($B4)
;     |       |   |  |   |     |     |      ______________________________________ Layer 2 scroll X
;     |       |   |  |   |     |     |     |   ___________________________________ Layer 2 scroll Y
;     |       |   |  |   |     |     |     |  |    _______________________________ Scroll
;     |       |   |  |   |     |     |     |  |   |      _________________________ Special x-ray blocks
;     |       |   |  |   |     |     |     |  |   |     |      ___________________ Main ASM
;     |       |   |  |   |     |     |     |  |   |     |     |      _____________ PLM population
;     |       |   |  |   |     |     |     |  |   |     |     |     |      _______ Library background
;     |       |   |  |   |     |     |     |  |   |     |     |     |     |      _ Setup ASM
;     |       |   |  |   |     |     |     |  |   |     |     |     |     |     |
;     llllll, tt, MM,mm, ffff, eeee, EEEE, xx,yy, ssss, xxxx, AAAA, pppp, bbbb, aaaa

; Room header. Wrecked Ship chozo room
$8F:C98E             dx 00,03, 0A,0B, 06,03, 70,A0, 00, C9D4, E629,01,C9BA, E5E6

; State header. Room $C98E. Wrecked Ship chozo room - default
$8F:C9A0             dx C48322, 05, 30,03, 9BA4, BE93, 8B87, 00,00, C9DA, 0000, 0000, C215, 0000, C8C7

; State header. Room $C98E. Wrecked Ship chozo room - main area boss is dead
$8F:C9BA             dx C48322, 04, 30,03, 9AC2, C1AE, 8C01, 00,00, C9DA, 0000, 0000, C2D1, 0000, C8C7

; Door list. Room $C98E. Wrecked Ship chozo room
$8F:C9D4             dw A18C, A198, A1A4

; Scroll data. Room $C98E. Wrecked Ship chozo room
$8F:C9DA             db 00, 00, 01, 01, 01, 02, 01, 01, 01, 01, 01, 02, 00, 01, 00, 00, 00, 02

; PLM scroll data. Room $C98E. Wrecked Ship chozo room (PLM index 0)
$8F:C9EC             db 0E,01, 0F,01, 80

; PLM scroll data. Room $C98E. Wrecked Ship chozo room (PLM index 3)
$8F:C9F1             db 04,00, 05,02, 0B,02, 10,01, 11,01, 80

; Unused PLM scroll data
$8F:C9FC             db 05,01, 80

; Unused PLM scroll data
$8F:C9FF             db 04,01, 80

; Unused PLM scroll data
$8F:CA02             db 05,00, 80

; Unused PLM scroll data
$8F:CA05             db 04,00, 80

; Room header. Wrecked Ship entrance treadmill
$8F:CA08             dx 01,03, 0C,0E, 04,01, 70,A0, 00, CA4E, E629,01,CA34, E5E6

; State header. Room $CA08. Wrecked Ship entrance treadmill - default
$8F:CA1A             dx C49D2E, 05, 30,05, 9BB4, C3E6, 8C6D, C1,C1, 0000, 0000, 0000, C22F, E117, C8C7

; State header. Room $CA08. Wrecked Ship entrance treadmill - main area boss is dead
$8F:CA34             dx C49D2E, 04, 30,06, 9AD2, C1A8, 8BED, C1,C1, 0000, 0000, 0000, C2FD, E117, C8C7

; Door list. Room $CA08. Wrecked Ship entrance treadmill
$8F:CA4E             dw A1B0, A1BC

; Room header. Wrecked Ship attic
$8F:CA52             dx 02,03, 0C,0A, 07,01, 00,00, 00, CA98, E629,01,CA7E, E5E6

; State header. Room $CA52. Wrecked Ship attic - default
$8F:CA64             dx C49EAE, 05, 30,05, 9BC4, C6F2, 8CA9, C1,FF, CA9E, 0000, 0000, C231, E168, C8C7

; State header. Room $CA52. Wrecked Ship attic - main area boss is dead
$8F:CA7E             dx C4A2E7, 04, 30,06, 9AE2, BFE6, 8B99, C1,FF, CA9E, 0000, 0000, C2FF, E168, C8C7

; Door list. Room $CA52. Wrecked Ship attic
$8F:CA98             dw A1C8, A1D4, A1E0

; Scroll data. Room $CA52. Wrecked Ship attic
$8F:CA9E             db 02, 02, 02, 02, 02, 02, 02

; Unused PLM scroll data
$8F:CAA5             db 00,01, 80

; Unused PLM scroll data
$8F:CAA8             db 03,01, 80

; Unused PLM scroll data
$8F:CAAB             db 03,02, 80

; Room header. Wrecked Ship attic missile tank room
$8F:CAAE             dx 03,03, 13,0A, 03,01, 70,A0, 00, CAF4, E629,01,CADA, E5E6

; State header. Room $CAAE. Wrecked Ship attic missile tank room - default
$8F:CAC0             dx C4A720, 05, 00,00, 9BD4, C1E1, 8C13, C1,C1, 0000, 0000, 0000, C245, E1B9, C8C7

; State header. Room $CAAE. Wrecked Ship attic missile tank room - main area boss is dead
$8F:CADA             dx C4A720, 04, 00,00, 9AF2, C5E9, 8C7B, C1,C1, 0000, 0000, 0000, C319, E1B9, C8C7

; Door list. Room $CAAE. Wrecked Ship attic missile tank room
$8F:CAF4             dw A1EC

; Room header. Wrecked Ship mainstreet
$8F:CAF6             dx 04,03, 0C,0B, 06,08, 70,A0, 00, CB3C, E629,01,CB22, E5E6

; State header. Room $CAF6. Wrecked Ship mainstreet - default
$8F:CB08             dx C4A9AC, 05, 30,05, 9BE4, BCA0, 8B6D, C1,C1, CB4A, 0000, 0000, C247, E19E, C8C7

; State header. Room $CAF6. Wrecked Ship mainstreet - main area boss is dead
$8F:CB22             dx C4BDC0, 04, 30,06, 9B02, CD17, 8D2B, C1,C1, CB4A, 0000, 0000, C247, E19E, C8C7

; Door list. Room $CAF6. Wrecked Ship mainstreet
$8F:CB3C             dw A1F8, A204, A210, A21C, A228, A234, A240

; Scroll data. Room $CAF6. Wrecked Ship mainstreet
$8F:CB4A             db 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 02, 00, 00, 00, 00, 00, 02, 00, 01, 01, 01, 00, 02, 00, 00, 00, 00, 00, 01, 00, 00, 00, 00, 00, 00, 00

; PLM scroll data. Room $CAF6. Wrecked Ship mainstreet (PLM index 0)
$8F:CB7A             db 21,01, 80

; PLM scroll data. Room $CAF6. Wrecked Ship mainstreet (PLM index 1)
$8F:CB7D             db 29,01, 80

; PLM scroll data. Room $CAF6. Wrecked Ship mainstreet (PLM index 2)
$8F:CB80             db 21,00, 80

; PLM scroll data. Room $CAF6. Wrecked Ship mainstreet (PLM index 3)
$8F:CB83             db 29,00, 80

; PLM scroll data. Room $CAF6. Wrecked Ship mainstreet (PLM index 4)
$8F:CB86             db 28,02, 2E,02, 80

; Room header. Wrecked Ship spike platform hall
$8F:CB8B             dx 05,03, 13,0F, 02,01, 70,A0, 00, CBD1, E629,01,CBB7, E5E6

; State header. Room $CB8B. Wrecked Ship spike platform hall - default
$8F:CB9D             dx C4D187, 05, 00,00, 9BF4, C1A2, 8BD9, C1,C1, 0000, 0000, 0000, C27F, E14D, C8C7

; State header. Room $CB8B. Wrecked Ship spike platform hall - main area boss is dead
$8F:CBB7             dx C4D187, 04, 00,00, 9B12, CBAE, 8CF9, C1,C1, 0000, 0000, 0000, C321, E14D, C8C7

; Door list. Room $CB8B. Wrecked Ship spike platform hall
$8F:CBD1             dw A24C, A258

; Room header. Wrecked Ship east exit
$8F:CBD5             dx 06,03, 15,0D, 01,03, 70,A0, 00, CC1B, E629,01,CC01, E5E6

; State header. Room $CBD5. Wrecked Ship east exit - default
$8F:CBE7             dx C4D3EE, 05, 30,05, 9C04, C1AB, 8BF7, C1,C1, CC21, 0000, 0000, C281, E19E, C8C7

; State header. Room $CBD5. Wrecked Ship east exit - main area boss is dead
$8F:CC01             dx C4D3EE, 04, 30,06, 9B22, CB3B, 8CEB, C1,C1, CC21, 0000, 0000, C323, E19E, C8C7

; Door list. Room $CBD5. Wrecked Ship east exit
$8F:CC1B             dw A264, A270, A27C

; Scroll data. Room $CBD5. Wrecked Ship east exit
$8F:CC21             db 00, 02, 02

; PLM scroll data. Room $CBD5. Wrecked Ship east exit (PLM index 0)
$8F:CC24             db 00,02, 80

; Room header. Wrecked Ship chozo energy tank room
$8F:CC27             dx 07,03, 12,0D, 03,02, 90,A0, 00, CC6D, E629,01,CC53, E5E6

; State header. Room $CC27. Wrecked Ship chozo energy tank room - default
$8F:CC39             dx C4D883, 05, 00,03, 9C14, C1E7, 8C27, C0,00, 0000, 0000, 0000, C28F, 0000, C8C7

; State header. Room $CC27. Wrecked Ship chozo energy tank room - main area boss is dead
$8F:CC53             dx C4D883, 04, 00,03, 9B32, BC4D, 8B5B, C0,00, 0000, 0000, 0000, C337, 0000, C8C7

; Door list. Room $CC27. Wrecked Ship chozo energy tank room
$8F:CC6D             dw A288

; Room header. Pre Phantoon hall
$8F:CC6F             dx 08,03, 0E,13, 05,01, 70,A0, 00, CCB5, E629,01,CC9B, E5E6

; State header. Room $CC6F. Pre Phantoon hall - default
$8F:CC81             dx C4E14E, 05, 30,05, 9C24, C283, 8C5B, C1,C1, CCBB, 0000, 0000, C291, E14D, C8C8

; State header. Room $CC6F. Pre Phantoon hall - main area boss is dead
$8F:CC9B             dx C4E14E, 04, 30,06, 9B42, C139, 8BAF, C1,01, CCBB, 0000, 0000, C33F, E14D, C8C8

; Door list. Room $CC6F. Pre Phantoon hall
$8F:CCB5             dw A294, A2A0, A2AC

; Scroll data. Room $CC6F. Pre Phantoon hall
$8F:CCBB             db 01, 01, 01, 01, 00

; PLM scroll data. Room $CC6F. Pre Phantoon hall (PLM index 0)
$8F:CCC0             db 03,01, 04,01, 80

; PLM scroll data. Room $CC6F. Pre Phantoon hall (PLM index 1)
$8F:CCC5             db 03,00, 80

; Unused PLM scroll data
$8F:CCC8             db 04,00, 80

; Room header. Wrecked Ship map station
$8F:CCCB             dx 09,03, 0D,13, 01,01, 70,A0, 00, CD11, E629,01,CCF7, E5E6

; State header. Room $CCCB. Wrecked Ship map station - default
$8F:CCDD             dx CE83C3, 16, 00,00, 9C34, C1ED, 8C3B, 00,00, 0000, 0000, 0000, C2B1, 0000, C8D0

; State header. Room $CCCB. Wrecked Ship map station - main area boss is dead
$8F:CCF7             dx CE83C3, 15, 00,00, 9B52, C19C, 8BC5, 00,00, 0000, 0000, 0000, C34D, 0000, C8D0

; Door list. Room $CCCB. Wrecked Ship map station
$8F:CD11             dw A2B8

; Room header. Phantoon
$8F:CD13             dx 0A,03, 13,13, 01,01, 70,A0, 00, CD59, E629,01,CD3F, E5E6

; State header. Room $CD13. Phantoon - default
$8F:CD25             dx C4E58C, 05, 27,06, 9C44, CCD4, 8D1D, 01,01, CD5B, 0000, 0000, C2B3, E0FD, C8D0

; State header. Room $CD13. Phantoon - main area boss is dead
$8F:CD3F             dx C4E58C, 04, 00,03, 9B62, C1E4, 8C1D, 01,01, CD5B, 0000, 0000, C2B3, E113, C8D0

; Door list. Room $CD13. Phantoon
$8F:CD59             dw A2C4

; Scroll data. Room $CD13. Phantoon
$8F:CD5B             db 01

; Room header. Wrecked Ship first flooded room
$8F:CD5C             dx 0B,03, 11,0F, 02,01, 70,A0, 00, CDA2, E629,01,CD88, E5E6

; State header. Room $CD5C. Wrecked Ship first flooded room - default
$8F:CD6E             dx C4E6A5, 05, 00,00, 9C54, C1A5, 8BE3, C1,C1, CDA6, 0000, 0000, C2BB, E183, C8D0

; State header. Room $CD5C. Wrecked Ship first flooded room - main area boss is dead
$8F:CD88             dx C4E6A5, 04, 00,00, 9B64, BC3A, 8B4D, C1,C1, CDA6, 0000, 0000, C355, E183, C8D0

; Door list. Room $CD5C. Wrecked Ship first flooded room
$8F:CDA2             dw A2D0, A2DC

; Scroll data. Room $CD5C. Wrecked Ship first flooded room
$8F:CDA6             db 01, 01

; Room header. Wrecked Ship west super missile room
$8F:CDA8             dx 0C,03, 0F,11, 01,01, 70,A0, 00, CDEE, E629,01,CDD4, E5E6

; State header. Room $CDA8. Wrecked Ship west super missile room - default
$8F:CDBA             dx C4E94E, 05, 00,00, 9C64, C19F, 8BCF, C1,C1, CDF0, 0000, 0000, C2BD, E183, C8D0

; State header. Room $CDA8. Wrecked Ship west super missile room - main area boss is dead
$8F:CDD4             dx C4E94E, 04, 00,00, 9B74, C69F, 8C9B, C1,C1, CDF0, 0000, 0000, C357, E183, C8D0

; Door list. Room $CDA8. Wrecked Ship west super missile room
$8F:CDEE             dw A2E8

; Scroll data. Room $CDA8. Wrecked Ship west super missile room
$8F:CDF0             db 01

; Room header. Wrecked Ship east super missile hall
$8F:CDF1             dx 0D,03, 12,11, 04,01, 70,A0, 00, CE37, E629,01,CE1D, E5E6

; State header. Room $CDF1. Wrecked Ship east super missile hall - default
$8F:CE03             dx C4EA8F, 05, 00,00, 9C74, C8C5, 8CBF, C1,C1, CE39, 0000, 0000, C2BF, E19E, C8D0

; State header. Room $CDF1. Wrecked Ship east super missile hall - main area boss is dead
$8F:CE1D             dx C4ED98, 04, 00,00, 9B84, CC51, 8D07, C1,C1, CE39, 0000, 0000, C35F, E183, C8D0

; Door list. Room $CDF1. Wrecked Ship east super missile hall
$8F:CE37             dw A2F4

; Scroll data. Room $CDF1. Wrecked Ship east super missile hall
$8F:CE39             db 01, 01, 01, 00

; PLM scroll data. Room $CDF1. Wrecked Ship east super missile hall (PLM index 0)
$8F:CE3D             db 03,01, 80

; Room header. Gravity suit room
$8F:CE40             dx 0E,03, 0A,0D, 01,01, 70,A0, 00, CE86, E629,01,CE6C, E5E6

; State header. Room $CE40. Gravity suit room - default
$8F:CE52             dx C4F0A1, 05, 00,00, 9C74, C1EA, 8C31, 01,01, 0000, 0000, 0000, C2C7, E183, C8D0

; State header. Room $CE40. Gravity suit room - main area boss is dead
$8F:CE6C             dx C4F0A1, 04, 00,00, 9B94, C280, 8C51, 01,01, 0000, 0000, 0000, C36D, E183, C8D0

; Door list. Room $CE40. Gravity suit room
$8F:CE86             dw A300, A30C

; Room header. Wrecked Ship save station
$8F:CE8A             dx 0F,03, 11,0E, 01,01, 70,A0, 00, CED0, E629,01,CEB6, E5E6

; State header. Room $CE8A. Wrecked Ship save station - default
$8F:CE9C             dx CE95C2, 16, 30,05, 9C74, CA78, 8CD9, 00,00, 0000, 0000, 0000, C2C7, 0000, 0000

; State header. Room $CE8A. Wrecked Ship save station - main area boss is dead
$8F:CEB6             dx CE95C2, 15, 30,06, 9B94, C69C, 8C91, 00,00, 0000, 0000, 0000, C2C9, 0000, C8D0

; Door list. Room $CE8A. Wrecked Ship save station
$8F:CED0             dw A318

; Room header. n00b tube save station
$8F:CED2             dx 00,04, 0C,13, 01,01, 70,A0, 00, CEF9, E5E6

; State header. Room $CED2. n00b tube save station - default
$8F:CEDF             dx CE95C2, 19, 12,05, 9C84, D526, 8E74, 00,00, 0000, 0000, 0000, C375, 0000, C8D1

; Door list. Room $CED2. n00b tube save station
$8F:CEF9             dw A324

; Room header. n00b tube
$8F:CEFB             dx 01,04, 0B,11, 01,03, 70,A0, 00, CF41, E612,0B,CF27, E5E6

; State header. Room $CEFB. n00b tube - default
$8F:CF0D             dx C9DB52, 0B, 12,05, 9C94, D529, 8E7E, 00,C0, CF49, 0000, 0000, C37D, 0000, C8D1

; State header. Room $CEFB. n00b tube - event "n00b tube is broken" is set
$8F:CF27             dx C9E129, 0B, 12,05, 9C94, D529, 8E7E, 00,C0, CF49, 0000, 0000, C37D, 0000, C8D1

; Door list. Room $CEFB. n00b tube
$8F:CF41             dw A330, A33C, A348, A354

; Scroll data. Room $CEFB. n00b tube
$8F:CF49             db 02, 02, 02

; PLM scroll data. Room $CEFB. n00b tube (PLM indices 0/4)
$8F:CF4C             db 00,02, 80

; PLM scroll data. Room $CEFB. n00b tube (PLM index 8)
$8F:CF4F             db 01,02, 02,02, 80

; Room header. n00b tube west
$8F:CF54             dx 02,04, 0A,12, 01,01, 70,A0, 00, CF7B, E5E6

; State header. Room $CF54. n00b tube west - default
$8F:CF61             dx C9E6AE, 0B, 00,00, 9CA4, D53C, 8E8C, 00,00, CF7F, 0000, 0000, C3DF, 0000, C8D1

; Door list. Room $CF54. n00b tube west
$8F:CF7B             dw A360, A36C

; Scroll data. Room $CF54. n00b tube west
$8F:CF7F             db 01

; Room header. n00b tube east
$8F:CF80             dx 03,04, 0C,11, 04,02, 70,A0, 00, CFA7, E5E6

; State header. Room $CF80. n00b tube east - default
$8F:CF8D             dx C9E809, 0B, 12,05, 9CB4, D53F, 8E96, 00,00, CFAD, 0000, 0000, C3E1, 0000, C8D1

; Door list. Room $CF80. n00b tube east
$8F:CFA7             dw A378, A384, A390

; Scroll data. Room $CF80. n00b tube east
$8F:CFAD             db 01, 01, 01, 01, 00, 00, 00, 00

; PLM scroll data. Room $CF80. n00b tube east (PLM index 0)
$8F:CFB5             db 00,01, 01,00, 04,00, 80

; PLM scroll data. Room $CF80. n00b tube east (PLM index 1)
$8F:CFBC             db 00,02, 04,01, 80

; PLM scroll data. Room $CF80. n00b tube east (PLM index 2)
$8F:CFC1             db 00,00, 04,01, 80

; PLM scroll data. Room $CF80. n00b tube east (PLM index 9)
$8F:CFC6             db 01,01, 80

; Room header. Maridia mainstreet
$8F:CFC9             dx 04,04, 0A,09, 03,08, 70,A0, 00, CFF0, E5E6

; State header. Room $CFC9. Maridia mainstreet - default
$8F:CFD6             dx C9F225, 0B, 1B,06, 9CC4, DE6D, 903A, C0,C0, CFFA, 0000, 0000, C42B, 0000, C8D1

; Door list. Room $CFC9. Maridia mainstreet
$8F:CFF0             dw A39C, A3A8, A3B4, A3C0, A3CC

; Scroll data. Room $CFC9. Maridia mainstreet
$8F:CFFA             db 02, 02, 00, 02, 02, 00, 02, 02, 01, 02, 02, 00, 02, 02, 00, 02, 02, 00, 02, 02, 02, 02, 02, 00

; PLM scroll data. Room $CFC9. Maridia mainstreet (PLM index 0)
$8F:D012             db 07,01, 0A,00, 80

; Room header. Maridia space pirate room
$8F:D017             dx 05,04, 0D,0D, 04,03, 70,A0, 00, D03E, E5E6

; State header. Room $D017. Maridia space pirate room - default
$8F:D024             dx CA8EFF, 0B, 00,00, 9CD4, E07F, 909E, C0,C0, D046, 0000, 0000, C445, 0000, C8D1

; Door list. Room $D017. Maridia space pirate room
$8F:D03E             dw A3D8, A3E4, A3F0, A3FC

; Scroll data. Room $D017. Maridia space pirate room
$8F:D046             db 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 00, 02

; PLM scroll data. Room $D017. Maridia space pirate room (PLM indices 3/7)
$8F:D052             db 0A,02, 80

; Room header. Tatori room
$8F:D055             dx 06,04, 11,0C, 03,04, 70,A0, 00, D07C, E5E6

; State header. Room $D055. Tatori room - default
$8F:D062             dx CAA113, 0B, 00,00, 9CE4, D5E2, 8EA8, 00,C0, D07E, 0000, 0000, C47D, 0000, C8D1

; Door list. Room $D055. Tatori room
$8F:D07C             dw A408

; Scroll data. Room $D055. Tatori room
$8F:D07E             db 00, 02, 02, 00, 02, 02, 00, 02, 02, 02, 02, 02

; Room header. Maridia green gate hall
$8F:D08A             dx 07,04, 0C,10, 04,01, 70,A0, 00, D0B1, E5E6

; State header. Room $D08A. Maridia green gate hall - default
$8F:D097             dx CAAF99, 0B, 1B,06, 9CF4, D635, 8EB6, C1,C1, D0B5, 0000, 0000, C48B, E248, C8D1

; Door list. Room $D08A. Maridia green gate hall
$8F:D0B1             dw A414, A420

; Scroll data. Room $D08A. Maridia green gate hall
$8F:D0B5             db 01, 01, 01, 01

; Room header. Mt. Doom
$8F:D0B9             dx 08,04, 0C,09, 06,04, 90,A0, 00, D0E0, E5E6

; State header. Room $D0B9. Mt. Doom - default
$8F:D0C6             dx CAB24F, 0B, 00,00, 9D04, CE6A, 8D41, C0,C0, D0EC, 0000, 0000, C499, 0000, C8D1

; Door list. Room $D0B9. Mt. Doom
$8F:D0E0             dw A42C, A438, A444, A450, A45C, A468

; Scroll data. Room $D0B9. Mt. Doom
$8F:D0EC             db 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 00, 02, 02, 02, 02, 00, 00, 02, 02, 02, 02, 00

; Room header. Maridia -> Red Brinstar room
$8F:D104             dx 09,04, 0C,07, 03,02, 70,A0, 00, D12B, E5E6

; State header. Room $D104. Maridia -> Red Brinstar room - default
$8F:D111             dx CACE42, 0B, 1B,06, 9D14, D3AA, 8E2C, 00,C0, D12F, 0000, 0000, C49B, 0000, C8D1

; Door list. Room $D104. Maridia -> Red Brinstar room
$8F:D12B             dw A474, A480

; Scroll data. Room $D104. Maridia -> Red Brinstar room
$8F:D12F             db 01, 00, 02, 00, 00, 02

; PLM scroll data. Room $D104. Maridia -> Red Brinstar room (PLM index 0)
$8F:D135             db 02,02, 80

; PLM scroll data. Room $D104. Maridia -> Red Brinstar room (PLM index 1)
$8F:D138             db 01,01, 80

; Room header. Sandy Maridia missile and super missile room
$8F:D13B             dx 0A,04, 0C,04, 02,03, 70,A0, 00, D162, E5E6

; State header. Room $D13B. Sandy Maridia missile and super missile room - default
$8F:D148             dx CAD474, 0B, 00,00, 9D24, CF90, 8D65, C0,00, D164, 0000, 0000, C4A9, 0000, C8D1

; Door list. Room $D13B. Sandy Maridia missile and super missile room
$8F:D162             dw A48C

; Scroll data. Room $D13B. Sandy Maridia missile and super missile room
$8F:D164             db 02, 01, 02, 00, 00, 00

; PLM scroll data. Room $D13B. Sandy Maridia missile and super missile room (PLM index 0)
$8F:D16A             db 04,01, 80

; Room header. Sandy Maridia memu room
$8F:D16D             dx 0B,04, 0E,04, 04,02, 70,A0, 00, D194, E5E6

; State header. Room $D16D. Sandy Maridia memu room - default
$8F:D17A             dx CADBC8, 0B, 00,00, 9D34, D698, 8EC4, C0,00, D198, 0000, 0000, C4BD, 0000, C8D1

; Door list. Room $D16D. Sandy Maridia memu room
$8F:D194             dw A498, A4A4

; Scroll data. Room $D16D. Sandy Maridia memu room
$8F:D198             db 02, 00, 00, 00, 01, 00, 01, 01

; PLM scroll data. Room $D16D. Sandy Maridia memu room (PLM indices 3/7)
$8F:D1A0             db 05,01, 80

; Room header. Maridia crab shaft
$8F:D1A3             dx 0C,04, 12,07, 02,04, 70,A0, 00, D1CA, E5E6

; State header. Room $D1A3. Maridia crab shaft - default
$8F:D1B0             dx CAE458, 0B, 1B,06, 9D44, CFC3, 8D77, 00,C0, D1D0, 0000, 0000, C4EF, 0000, C8D1

; Door list. Room $D1A3. Maridia crab shaft
$8F:D1CA             dw A4B0, A4BC, A4C8

; Scroll data. Room $D1A3. Maridia crab shaft
$8F:D1D0             db 02, 00, 02, 00, 01, 00, 00, 01

; PLM scroll data. Room $D1A3. Maridia crab shaft (PLM index 0)
$8F:D1D8             db 04,02, 06,01, 80

; Room header. Beach
$8F:D1DD             dx 0D,04, 12,04, 04,03, 70,A0, 00, D204, E5E6

; State header. Room $D1DD. Beach - default
$8F:D1EA             dx CAF59C, 0B, 00,00, 9D54, D75B, 8ED6, C0,00, D20A, 0000, 0000, C503, 0000, C8D1

; Door list. Room $D1DD. Beach
$8F:D204             dw A4D4, A4E0, A4EC

; Scroll data. Room $D1DD. Beach
$8F:D20A             db 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 00, 00

; PLM scroll data. Room $D1DD. Beach (PLM index 3)
$8F:D216             db 0A,02, 80

; PLM scroll data. Room $D1DD. Beach (PLM index 7)
$8F:D219             db 0A,00, 80

; Room header. Maridia broken glass tube room
$8F:D21C             dx 0E,04, 10,10, 01,02, 70,A0, 00, D243, E5E6

; State header. Room $D21C. Maridia broken glass tube room - default
$8F:D229             dx CB83DB, 0B, 1B,05, 9D64, DE17, 901A, 00,00, D24B, 0000, 0000, C53B, 0000, C8D1

; Door list. Room $D21C. Maridia broken glass tube room
$8F:D243             dw A4F8, A504, A510, A51C

; Scroll data. Room $D21C. Maridia broken glass tube room
$8F:D24B             db 01, 00

; PLM scroll data. Room $D21C. Maridia broken glass tube room (PLM indices 0/1)
$8F:D24D             db 00,02, 01,01, 80

; Room header. Maridia broken glass tube room east
$8F:D252             dx 0F,04, 11,10, 01,01, 70,A0, 00, D279, E5E6

; State header. Room $D252. Maridia broken glass tube room east - default
$8F:D25F             dx CB883A, 0B, 00,00, 9D74, D7EE, 8EEC, C0,00, D27D, 0000, 0000, C54F, 0000, C8D1

; Door list. Room $D252. Maridia broken glass tube room east
$8F:D279             dw A528, A534

; Scroll data. Room $D252. Maridia broken glass tube room east
$8F:D27D             db 01

; Room header. Plasma beam puyo room
$8F:D27E             dx 10,04, 1A,00, 01,01, 70,A0, 00, D2A5, E5E6

; State header. Room $D27E. Plasma beam puyo room - default
$8F:D28B             dx CB89E0, 0B, 00,00, 9D84, D801, 8EFA, 00,00, D2A9, 0000, 0000, C551, 0000, C8D1

; Door list. Room $D27E. Plasma beam puyo room
$8F:D2A5             dw A540, A54C

; Scroll data. Room $D27E. Plasma beam puyo room
$8F:D2A9             db 01

; Room header. Plasma beam room
$8F:D2AA             dx 11,04, 1B,00, 02,03, 70,A0, 00, D2D1, E5E6

; State header. Room $D2AA. Plasma beam room - default
$8F:D2B7             dx CB8BD4, 0B, 00,00, 9D94, D3ED, 8E42, C0,00, D2D3, 0000, 0000, C553, 0000, C8D1

; Door list. Room $D2AA. Plasma beam room
$8F:D2D1             dw A558

; Scroll data. Room $D2AA. Plasma beam room
$8F:D2D3             db 02, 02, 02, 02, 01, 01

; Room header. Sandy Maridia choot-puyo hall
$8F:D2D9             dx 12,04, 1B,05, 07,01, 70,A0, 00, D300, E5E6

; State header. Room $D2D9. Sandy Maridia choot-puyo hall - default
$8F:D2E6             dx CB9792, 0B, 00,00, 9DA4, D864, 8F0C, C0,00, D304, 0000, 0000, C561, 0000, C8D1

; Door list. Room $D2D9. Sandy Maridia choot-puyo hall
$8F:D300             dw A564, A570

; Scroll data. Room $D2D9. Sandy Maridia choot-puyo hall
$8F:D304             db 01, 01, 01, 01, 01, 01, 01

; Room header. Maridia -> Crateria elevator
$8F:D30B             dx 13,04, 22,00, 01,06, 70,A0, 00, D332, E5E6

; State header. Room $D30B. Maridia -> Crateria elevator - default
$8F:D318             dx CBA0D0, 0B, 1B,05, 9DB4, D006, 8D85, 00,C0, D33A, 0000, 0000, C563, 0000, C8D1

; Door list. Room $D30B. Maridia -> Crateria elevator
$8F:D332             dw A57C, A588, A594, A18A

; Scroll data. Room $D30B. Maridia -> Crateria elevator
$8F:D33A             db 02, 02, 02, 02, 02, 01

; Room header. Sandy Maridia mainstreet
$8F:D340             dx 14,04, 16,02, 04,06, 70,A0, 00, D367, E5E6

; State header. Room $D340. Sandy Maridia mainstreet - default
$8F:D34D             dx CBA878, 0B, 00,05, 9DC4, D957, 8F22, E0,00, D36F, 0000, 0000, C571, 0000, C8D1

; Door list. Room $D340. Sandy Maridia mainstreet
$8F:D367             dw A5A0, A5AC, A5B8, A5C4

; Scroll data. Room $D340. Sandy Maridia mainstreet
$8F:D36F             db 00, 02, 02, 00, 00, 02, 02, 00, 02, 02, 02, 02, 00, 02, 02, 02, 00, 02, 02, 02, 00, 01, 01, 01

; Room header. Pre plasma beam shaft
$8F:D387             dx 15,04, 19,00, 01,04, 70,A0, 00, D3AE, E5E6

; State header. Room $D387. Pre plasma beam shaft - default
$8F:D394             dx CBC64F, 0B, 00,05, 9DD4, DD9B, 8FE6, 00,C0, D3B2, 0000, 0000, C57F, 0000, C8D1

; Door list. Room $D387. Pre plasma beam shaft
$8F:D3AE             dw A5D0, A5DC

; Scroll data. Room $D387. Pre plasma beam shaft
$8F:D3B2             db 02, 02, 02, 02

; Room header. Maridia map station
$8F:D3B6             dx 16,04, 11,11, 01,01, 70,A0, 00, D3DD, E5E6

; State header. Room $D3B6. Maridia map station - default
$8F:D3C3             dx CE86BD, 15, 00,00, 9DE4, DE14, 9010, 00,00, 0000, 0000, 0000, C581, 0000, C8D1

; Door list. Room $D3B6. Maridia map station
$8F:D3DD             dw A5E8

; Room header. Sandy Maridia save station
$8F:D3DF             dx 17,04, 23,04, 01,01, 70,A0, 00, D406, E5E6

; State header. Room $D3DF. Sandy Maridia save station - default
$8F:D3EC             dx CE95C2, 19, 1B,05, 9DF4, DE0E, 8FFC, 00,00, 0000, 0000, 0000, C589, 0000, 0000

; Door list. Room $D3DF. Sandy Maridia save station
$8F:D406             dw A5F4

; Room header. Maridia elevatube
$8F:D408             dx 18,04, 16,05, 01,0A, 70,A0, 00, D42F, E5E6

; State header. Room $D408. Maridia elevatube - default
$8F:D415             dx CBCD9F, 0C, 00,00, 9E04, DA0A, 8F38, 00,00, 0001, 0000, E2B6, C591, 0000, C8D2

; Door list. Room $D408. Maridia elevatube
$8F:D42F             dw A600, A60C

; Room header. Sandy Maridia quicksand top
$8F:D433             dx 19,04, 1A,05, 01,01, 70,A0, 00, D45A, E5E6

; State header. Room $D433. Sandy Maridia quicksand top - default
$8F:D440             dx CBDCF3, 0C, 00,00, 9E34, DF30, 904C, 00,00, D460, 0000, 0000, C593, 0000, C8D2

; Door list. Room $D433. Sandy Maridia quicksand top
$8F:D45A             dw A618, A624, A630

; Scroll data. Room $D433. Sandy Maridia quicksand top
$8F:D460             db 02

; Room header. Evir hall west
$8F:D461             dx 1A,04, 12,10, 04,01, 70,A0, 00, D488, E5E6

; State header. Room $D461. Evir hall west - default
$8F:D46E             dx CBDE8F, 0C, 00,00, 9E44, DA3D, 8F52, C1,01, 0000, 0000, 0000, C595, E25A, C8D2

; Door list. Room $D461. Evir hall west
$8F:D488             dw A63C, A648, A654

; Room header. Elevatube south
$8F:D48E             dx 1B,04, 16,0F, 01,02, 70,A0, 00, D4B5, E5E6

; State header. Room $D48E. Elevatube south - default
$8F:D49B             dx CBE472, 0C, 00,00, 9E54, DAD0, 8F60, 00,C0, D4BB, 0000, 0000, C597, 0000, C8D2

; Door list. Room $D48E. Elevatube south
$8F:D4B5             dw A660, A66C, A678

; Scroll data. Room $D48E. Elevatube south
$8F:D4BB             db 00, 01

; PLM scroll data. Room $D48E. Elevatube south (PLM index 0)
$8F:D4BD             db 00,02, 01,02, 80

; Room header. Evir hall east
$8F:D4C2             dx 1C,04, 17,10, 03,01, 70,A0, 00, D4E9, E5E6

; State header. Room $D4C2. Evir hall east - default
$8F:D4CF             dx CBE899, 0C, 00,00, 9E64, DAD3, 8F6A, C1,01, 0000, 0000, 0000, C5DB, E25A, C8D2

; Door list. Room $D4C2. Evir hall east
$8F:D4E9             dw A684, A690, A69C

; Room header. Snail room quicksand items west
$8F:D4EF             dx 1D,04, 14,0E, 02,02, 70,A0, 00, D516, E5E6

; State header. Room $D4EF. Snail room quicksand items west - default
$8F:D4FC             dx CBEC32, 0C, 00,00, 9E74, DF96, 906C, 00,00, D51A, 0000, 0000, C5DD, 0000, C8D2

; Door list. Room $D4EF. Snail room quicksand items west
$8F:D516             dw A6A8, A6B4

; Scroll data. Room $D4EF. Snail room quicksand items west
$8F:D51A             db 02, 02, 02, 02

; Room header. Snail room quicksand items east
$8F:D51E             dx 1E,04, 17,0E, 02,02, 70,A0, 00, D545, E5E6

; State header. Room $D51E. Snail room quicksand items east - default
$8F:D52B             dx CBF580, 0C, 00,00, 9E84, DF63, 905E, 00,00, D549, 0000, 0000, C5EB, 0000, C8D2

; Door list. Room $D51E. Snail room quicksand items east
$8F:D545             dw A6C0, A6CC

; Scroll data. Room $D51E. Snail room quicksand items east
$8F:D549             db 02, 02, 02, 02

; Room header. Snail room quicksand fall west
$8F:D54D             dx 1F,04, 15,0C, 01,02, 70,A0, 00, D574, E5E6

; State header. Room $D54D. Snail room quicksand fall west - default
$8F:D55A             dx CBFEC8, 0C, 00,00, 9E94, DB66, 8F78, 00,00, D578, 0000, 0000, C5F9, 0000, C8D2

; Door list. Room $D54D. Snail room quicksand fall west
$8F:D574             dw A6D8, A6E4

; Scroll data. Room $D54D. Snail room quicksand fall west
$8F:D578             db 02, 02

; Room header. Snail room quicksand fall east
$8F:D57A             dx 20,04, 17,0C, 01,02, 70,A0, 00, D5A1, E5E6

; State header. Room $D57A. Snail room quicksand fall east - default
$8F:D587             dx CC80B8, 0C, 00,00, 9E94, DBD9, 8F86, 00,00, D5A5, 0000, 0000, C5FB, 0000, C8D2

; Door list. Room $D57A. Snail room quicksand fall east
$8F:D5A1             dw A6F0, A6FC

; Scroll data. Room $D57A. Snail room quicksand fall east
$8F:D5A5             db 02, 02

; Room header. Snail room
$8F:D5A7             dx 21,04, 14,09, 06,03, 90,A0, 00, D5CE, E5E6

; State header. Room $D5A7. Snail room - default
$8F:D5B4             dx CC82A8, 0C, 1B,05, 9EA4, D357, 8E1E, C0,00, D5DA, 0000, 0000, C5FD, 0000, C8D2

; Door list. Room $D5A7. Snail room
$8F:D5CE             dw A708, A714, A720, A72C, A738, A744

; Scroll data. Room $D5A7. Snail room
$8F:D5DA             db 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02

; Room header. Sandy Maridia quicksand bottom
$8F:D5EC             dx 22,04, 1A,07, 01,01, 70,A0, 00, D613, E5E6

; State header. Room $D5EC. Sandy Maridia quicksand bottom - default
$8F:D5F9             dx CCA13B, 0C, 00,00, 9EB4, DC3C, 8F94, C0,00, 0000, 0000, 0000, C611, 0000, C8D2

; Door list. Room $D5EC. Sandy Maridia quicksand bottom
$8F:D613             dw A750, A75C

; Room header. Mochtroid room
$8F:D617             dx 23,04, 14,08, 04,01, 70,A0, 00, D63E, E5E6

; State header. Room $D617. Mochtroid room - default
$8F:D624             dx CCA34A, 0C, 1B,05, 9EC4, DC6F, 8FA2, C0,00, D642, 0000, 0000, C619, 0000, C8D2

; Door list. Room $D617. Mochtroid room
$8F:D63E             dw A768, A774

; Scroll data. Room $D617. Mochtroid room
$8F:D642             db 02, 02, 02, 02

; Room header. Pants room
$8F:D646             dx 24,04, 1A,0D, 02,04, 70,A0, 00, D66D, E5E6

; State header. Room $D646. Pants room - default
$8F:D653             dx CCAC48, 0C, 00,00, 9ED4, D453, 8E5E, 00,C0, D675, 0000, 0000, C61B, 0000, C8D2

; Door list. Room $D646. Pants room
$8F:D66D             dw A780, A78C, A798, A7A4

; Scroll data. Room $D646. Pants room
$8F:D675             db 02, 02, 02, 02, 02, 01, 01, 00

; PLM scroll data. Room $D646. Pants room (PLM indices 0/4)
$8F:D67D             db 02,02, 03,00, 04,02, 05,00, 06,01, 07,00, 80

; PLM scroll data. Room $D646. Pants room (PLM index Dh)
$8F:D68A             db 02,00, 03,02, 04,00, 05,01, 06,00, 80

; PLM scroll data. Room $D646. Pants room (PLM index 15h)
$8F:D695             db 05,02, 07,01, 80

; Room header. Pants room section
$8F:D69A             dx 25,04, 1B,0E, 01,03, 70,A0, 00, D6C1, E5E6

; State header. Room $D69A. Pants room section - default
$8F:D6A7             dx CCB843, 0C, 00,00, 9EE4, DCE2, 8FB8, 00,C0, D6C5, 0000, 0000, C6AD, 0000, C8D2

; Door list. Room $D69A. Pants room section
$8F:D6C1             dw A7B0, A7BC

; Scroll data. Room $D69A. Pants room section
$8F:D6C5             db 02, 00, 01

; PLM scroll data. Room $D69A. Pants room section (PLM index 0)
$8F:D6C8             db 01,02, 80

; PLM scroll data. Room $D69A. Pants room section (PLM index 6)
$8F:D6CB             db 01,02, 02,01, 80

; Room header. Spring ball room
$8F:D6D0             dx 26,04, 20,0F, 02,02, 70,A0, 00, D6F7, E5E6

; State header. Room $D6D0. Spring ball room - default
$8F:D6DD             dx CCBD31, 0C, 00,00, 9EF4, DD35, 8FCA, C0,00, D6F9, 0000, 0000, C6E5, 0000, C8D2

; Door list. Room $D6D0. Spring ball room
$8F:D6F7             dw A7C8

; Scroll data. Room $D6D0. Spring ball room
$8F:D6F9             db 02, 00, 01, 01

; Room header. Maridia speed blockade quicksand bottom
$8F:D6FD             dx 27,04, 1A,0A, 04,01, 70,A0, 00, D724, E5E6

; State header. Room $D6FD. Maridia speed blockade quicksand bottom - default
$8F:D70A             dx CCC22F, 0C, 00,00, 9F04, DD38, 8FD4, 00,00, D726, 0000, 0000, C6ED, 0000, C8D2

; Door list. Room $D6FD. Maridia speed blockade quicksand bottom
$8F:D724             dw A7D4

; Scroll data. Room $D6FD. Maridia speed blockade quicksand bottom
$8F:D726             db 01, 01, 01, 01

; Room header. Maridia grapple room
$8F:D72A             dx 28,04, 22,06, 07,02, 90,A0, 00, D751, E5E6

; State header. Room $D72A. Maridia grapple room - default
$8F:D737             dx CCC9F1, 0C, 00,00, 9F14, D089, 8D97, 00,00, D757, 0000, 0000, C6EF, 0000, C8D2

; Door list. Room $D72A. Maridia grapple room
$8F:D751             dw A7E0, A7EC, A7F8

; Scroll data. Room $D72A. Maridia grapple room
$8F:D757             db 02, 02, 02, 02, 02, 02, 02, 01, 01, 01, 01, 01, 01, 01

; Room header. Snail room save station
$8F:D765             dx 29,04, 13,0B, 01,01, 70,A0, 00, D78C, E5E6

; State header. Room $D765. Snail room save station - default
$8F:D772             dx CE92CB, 19, 1B,05, 9F24, D10C, 8DA5, 00,00, D78E, 0000, 0000, C703, 0000, C8D2

; Door list. Room $D765. Snail room save station
$8F:D78C             dw A828

; Scroll data. Room $D765. Snail room save station
$8F:D78E             db 01

; Room header. Pre Draygon room
$8F:D78F             dx 2A,04, 29,07, 02,03, 90,A0, 00, D7D5, E629,01,D7BB, E5E6

; State header. Room $D78F. Pre Draygon room - default
$8F:D7A1             dx CCE5B1, 0C, 00,00, 9F34, D10F, 8DAF, 00,C0, D7D9, 0000, 0000, C70B, 0000, C8D2

; State header. Room $D78F. Pre Draygon room - main area boss is dead
$8F:D7BB             dx CCE5B1, 0C, 1B,05, 9F34, D10F, 8DAF, 00,C0, D7D9, 0000, 0000, C70B, 0000, C8D2

; Door list. Room $D78F. Pre Draygon room
$8F:D7D5             dw A834, A840

; Scroll data. Room $D78F. Pre Draygon room
$8F:D7D9             db 01, 01, 00, 00, 01, 00

; PLM scroll data. Room $D78F. Pre Draygon room (PLM index 0)
$8F:D7DF             db 00,02, 02,02, 80

; Room header. Maridia speed blockade hall
$8F:D7E4             dx 2B,04, 1A,08, 07,01, 70,A0, 00, D80B, E5E6

; State header. Room $D7E4. Maridia speed blockade hall - default
$8F:D7F1             dx CCEE0C, 0C, 1B,05, 9F44, D112, 8DB9, C0,00, D813, 0000, 0000, C755, 0000, C8D2

; Door list. Room $D7E4. Maridia speed blockade hall
$8F:D80B             dw A84C, A858, A864, A870

; Scroll data. Room $D7E4. Maridia speed blockade hall
$8F:D813             db 02, 02, 02, 02, 02, 02, 02

; Room header. Draygon save station
$8F:D81A             dx 2C,04, 29,06, 01,01, 70,A0, 00, D841, E5E6

; State header. Room $D81A. Draygon save station - default
$8F:D827             dx CE9EF6, 19, 1B,05, 9F54, D1B5, 8DCF, 00,00, 0000, 0000, 0000, C75D, 0000, C8D2

; Door list. Room $D81A. Draygon save station
$8F:D841             dw A87C, A888

; Room header. Maridia missile station
$8F:D845             dx 2D,04, 26,08, 01,01, 70,A0, 00, D86C, E5E6

; State header. Room $D845. Maridia missile station - default
$8F:D852             dx CEAB31, 17, 00,00, 9F64, D1B8, 8DD9, 00,00, 0000, 0000, 0000, C765, 0000, C8D2

; Door list. Room $D845. Maridia missile station
$8F:D86C             dw A894

; Room header. Sandy Maridia quicksand fall
$8F:D86E             dx 2E,04, 1A,06, 01,01, 70,A0, 00, D895, E5E6

; State header. Room $D86E. Sandy Maridia quicksand fall - default
$8F:D87B             dx CCFA8D, 0C, 00,00, 9F74, D1BB, 8DE3, 00,00, D897, 0000, 0000, C76D, 0000, C8D2

; Door list. Room $D86E. Sandy Maridia quicksand fall
$8F:D895             dw A8A0

; Scroll data. Room $D86E. Sandy Maridia quicksand fall
$8F:D897             db 02

; Room header. Maridia speed blockade quicksand fall
$8F:D898             dx 2F,04, 1C,09, 02,01, 70,A0, 00, D8BF, E5E6

; State header. Room $D898. Maridia speed blockade quicksand fall - default
$8F:D8A5             dx CCFB88, 0C, 00,00, 9F74, D1EE, 8DF1, 00,00, D8C3, 0000, 0000, C76F, 0000, C8D2

; Door list. Room $D898. Maridia speed blockade quicksand fall
$8F:D8BF             dw A8AC, A8B8

; Scroll data. Room $D898. Maridia speed blockade quicksand fall
$8F:D8C3             db 02, 02

; Room header. Shaktool
$8F:D8C5             dx 30,04, 1C,0F, 04,01, 70,A0, 00, D90B, E612,0D,D8F1, E5E6

; State header. Room $D8C5. Shaktool - default
$8F:D8D7             dx CCFD75, 0C, 00,00, 9F84, D281, 8DFF, C0,00, D90F, 0000, 0000, C771, 0000, C8D3

; State header. Room $D8C5. Shaktool - event "Shaktool cleared a path" is set
$8F:D8F1             dx CD8404, 0C, 00,00, 9F84, D281, 8DFF, C0,00, D90F, 0000, 0000, C771, 0000, C8DC

; Door list. Room $D8C5. Shaktool
$8F:D90B             dw A8C4, A8D0

; Scroll data. Room $D8C5. Shaktool
$8F:D90F             db 01, 01, 01, 01

; Room header. Maridia grapple wall shaft
$8F:D913             dx 31,04, 21,06, 05,03, 70,A0, 00, D93A, E5E6

; State header. Room $D913. Maridia grapple wall shaft - default
$8F:D920             dx CD8A37, 0C, 00,00, 9F94, CF2D, 8D53, 00,00, D942, 0000, 0000, C773, 0000, C8DC

; Door list. Room $D913. Maridia grapple wall shaft
$8F:D93A             dw A8DC, A8E8, A8F4, A900

; Scroll data. Room $D913. Maridia grapple wall shaft
$8F:D942             db 02, 00, 00, 00, 00, 02, 00, 00, 00, 00, 01, 00, 01, 01, 01

; PLM scroll data. Room $D913. Maridia grapple wall shaft (PLM index 0)
$8F:D951             db 05,00, 0B,01, 80

; PLM scroll data. Room $D913. Maridia grapple wall shaft (PLM index 1)
$8F:D956             db 05,01, 0B,00, 80

; PLM scroll data. Room $D913. Maridia grapple wall shaft (PLM index 5)
$8F:D95B             db 0A,01, 80

; Room header. Botwoon
$8F:D95E             dx 32,04, 18,08, 02,01, 70,A0, 00, D9A4, E629,02,D98A, E5E6

; State header. Room $D95E. Botwoon - default
$8F:D970             dx CD950E, 0C, 2A,05, 9FA4, DE5A, 9028, 00,00, D9A8, 0000, 0000, C79F, 0000, C8DC

; State header. Room $D95E. Botwoon - area mini-boss is dead
$8F:D98A             dx CD950E, 0C, 00,03, 9FA4, DE5A, 9028, 00,00, D9A8, 0000, 0000, C79F, 0000, C8DC

; Door list. Room $D95E. Botwoon
$8F:D9A4             dw A90C, A918

; Scroll data. Room $D95E. Botwoon
$8F:D9A8             db 01, 00

; Room header. Space jump room
$8F:D9AA             dx 33,04, 26,0A, 01,01, 70,A0, 00, D9D1, E5E6

; State header. Room $D9AA. Space jump room - default
$8F:D9B7             dx CD991E, 0C, 00,03, 9FB4, D450, 8E54, 00,00, D9D3, 0000, 0000, C7A7, 0000, C8DC

; Door list. Room $D9AA. Space jump room
$8F:D9D1             dw A924

; Scroll data. Room $D9AA. Space jump room
$8F:D9D3             db 01

; Room header. Maridia energy station
$8F:D9D4             dx 34,04, 2A,06, 01,01, 70,A0, 00, D9FB, E5E6

; State header. Room $D9D4. Maridia energy station - default
$8F:D9E1             dx CE98DC, 17, 00,00, 9FC4, DE11, 9006, 00,00, D9FD, 0000, 0000, C7AF, 0000, 0000

; Door list. Room $D9D4. Maridia energy station
$8F:D9FB             dw A930

; Scroll data. Room $D9D4. Maridia energy station
$8F:D9FD             db 01

; Room header. Maridia cacatac room west
$8F:D9FE             dx 35,04, 1B,06, 01,02, 70,A0, 00, DA25, E5E6

; State header. Room $D9FE. Maridia cacatac room west - default
$8F:DA0B             dx CD9B28, 0C, 00,00, 9FD4, DFD9, 907A, 00,C0, DA29, 0000, 0000, C7B7, 0000, 0000

; Door list. Room $D9FE. Maridia cacatac room west
$8F:DA25             dw A93C, A948

; Scroll data. Room $D9FE. Maridia cacatac room west
$8F:DA29             db 02, 01

; Room header. Maridia cacatac room east
$8F:DA2B             dx 36,04, 1C,06, 05,02, 70,A0, 00, DA52, E5E6

; State header. Room $DA2B. Maridia cacatac room east - default
$8F:DA38             dx CDA00D, 0C, 00,00, 9FE4, E01C, 908C, 00,00, DA56, 0000, 0000, C7B9, 0000, 0000

; Door list. Room $DA2B. Maridia cacatac room east
$8F:DA52             dw A954, A960

; Scroll data. Room $DA2B. Maridia cacatac room east
$8F:DA56             db 02, 02, 02, 02, 02, 01, 01, 01, 01, 01

; Room header. Draygon
$8F:DA60             dx 37,04, 27,09, 02,02, 70,A0, 01, DAA6, E629,01,DA8C, E5E6

; State header. Room $DA60. Draygon - default
$8F:DA72             dx CDB19D, 1C, 24,05, 9FF4, D314, 8E10, 01,01, DAAA, 0000, 0000, C7BB, E108, C8DD

; State header. Room $DA60. Draygon - main area boss is dead
$8F:DA8C             dx CDB19D, 1C, 00,03, 9FF4, 8000, 8000, 01,01, DAAA, 0000, 0000, C7BB, E113, C8DD

; Door list. Room $DA60. Draygon
$8F:DAA6             dw A96C, A978

; Scroll data. Room $DA60. Draygon
$8F:DAAA             db 02, 02, 01, 01

; Room header. Tourian -> Crateria elevator
$8F:DAAE             dx 00,05, 14,09, 01,04, 70,A0, 00, DAD5, E5E6

; State header. Room $DAAE. Tourian -> Crateria elevator - default
$8F:DABB             dx CDC4FE, 0D, 1E,05, A004, E42D, 913E, 01,C1, DADD, 0000, 0000, C7E1, E3E8, C90A

; Door list. Room $DAAE. Tourian -> Crateria elevator
$8F:DAD5             dw A984, A990, A18A, A99C

; Scroll data. Room $DAAE. Tourian -> Crateria elevator
$8F:DADD             db 02, 02, 02, 01

; Room header. Metroid room 1
$8F:DAE1             dx 01,05, 0E,0C, 06,01, 70,A0, 00, DB27, E612,10,DB0D, E5E6

; State header. Room $DAE1. Metroid room 1 - default
$8F:DAF3             dx CDC8DC, 0D, 00,00, A014, E1D8, 90CC, C1,C1, DB2B, 0000, 0000, C7E9, E403, C91E

; State header. Room $DAE1. Metroid room 1 - event "1st metroid hall cleared" is set
$8F:DB0D             dx CDC8DC, 0D, 00,00, A014, E516, 916C, C1,C1, DB2B, 0000, 0000, C7E9, E403, C91E

; Door list. Room $DAE1. Metroid room 1
$8F:DB27             dw A9A8, A9B4

; Scroll data. Room $DAE1. Metroid room 1
$8F:DB2B             db 01, 01, 01, 01, 01, 01

; Room header. Metroid room 2
$8F:DB31             dx 02,05, 0D,0C, 01,02, 70,A0, 00, DB77, E612,11,DB5D, E5E6

; State header. Room $DB31. Metroid room 2 - default
$8F:DB43             dx CDCDA0, 0D, 00,00, A024, E440, 9148, C1,C1, DB7B, 0000, 0000, C7F7, E3E8, C91E

; State header. Room $DB31. Metroid room 2 - event "1st metroid shaft cleared" is set
$8F:DB5D             dx CDCDA0, 0D, 00,00, A024, E559, 917A, C1,C1, DB7B, 0000, 0000, C7F7, E3E8, C91E

; Door list. Room $DB31. Metroid room 2
$8F:DB77             dw A9C0, A9CC

; Scroll data. Room $DB31. Metroid room 2
$8F:DB7B             db 02, 02

; Room header. Metroid room 3
$8F:DB7D             dx 03,05, 0E,0D, 06,01, 70,A0, 00, DBC3, E612,12,DBA9, E5E6

; State header. Room $DB7D. Metroid room 3 - default
$8F:DB8F             dx CDD02D, 0D, 00,00, A034, E794, 91F8, C1,C1, DBC7, 0000, 0000, C805, E403, C91E

; State header. Room $DB7D. Metroid room 3 - event "2nd metroid hall cleared" is set
$8F:DBA9             dx CDD02D, 0D, 00,00, A034, E5BF, 9196, C1,C1, DBC7, 0000, 0000, C805, E403, C91E

; Door list. Room $DB7D. Metroid room 3
$8F:DBC3             dw A9D8, A9E4

; Scroll data. Room $DB7D. Metroid room 3
$8F:DBC7             db 01, 01, 01, 01, 01, 01

; Room header. Metroid room 4
$8F:DBCD             dx 04,05, 14,0D, 01,02, 70,A0, 00, DC13, E612,13,DBF9, E5E6

; State header. Room $DBCD. Metroid room 4 - default
$8F:DBDF             dx CDD3E5, 0D, 1E,05, A044, E4A3, 915A, C1,C1, DC17, 0000, 0000, C813, E3E8, C91E

; State header. Room $DBCD. Metroid room 4 - event "2nd metroid shaft cleared" is set
$8F:DBF9             dx CDD3E5, 0D, 1E,05, A044, E652, 91A4, C1,C1, DC17, 0000, 0000, C813, E3E8, C91E

; Door list. Room $DBCD. Metroid room 4
$8F:DC13             dw A9F0, A9FC

; Scroll data. Room $DBCD. Metroid room 4
$8F:DC17             db 02, 02

; Room header. Tourian super-sidehopper room
$8F:DC19             dx 05,05, 13,0F, 02,01, 70,A0, 00, DC5F, E612,14,DC45, E5E6

; State header. Room $DC19. Tourian super-sidehopper room - default
$8F:DC2B             dx CDD5EB, 0D, 45,06, A054, E387, 9122, C1,C1, DC63, 0000, 0000, C821, E41E, C91E

; State header. Room $DC19. Tourian super-sidehopper room - event "unused" is set
$8F:DC45             dx CDD5EB, 0D, 00,00, A054, E387, 9122, C1,C1, DC63, 0000, 0000, C821, E41E, C91E

; Door list. Room $DC19. Tourian super-sidehopper room
$8F:DC5F             dw AA08, AA14

; Scroll data. Room $DC19. Tourian super-sidehopper room
$8F:DC63             db 01, 01

; Room header. Torizo corpse room
$8F:DC65             dx 06,05, 11,0F, 02,01, 70,A0, 00, DCAB, E612,14,DC91, E5E6

; State header. Room $DC65. Torizo corpse room - default
$8F:DC77             dx CDD7C4, 0D, 45,06, A064, E25B, 90DE, C1,C1, DCAF, 0000, 0000, C823, E41E, C91E

; State header. Room $DC65. Torizo corpse room - event "unused" is set
$8F:DC91             dx CDD7C4, 0D, 1E,05, A064, E25B, 90DE, C1,C1, DCAF, 0000, 0000, C823, E41E, C91E

; Door list. Room $DC65. Torizo corpse room
$8F:DCAB             dw AA20, AA2C

; Scroll data. Room $DC65. Torizo corpse room
$8F:DCAF             db 01, 01

; Room header. Shitroid room
$8F:DCB1             dx 07,05, 0D,0F, 04,01, 70,A0, 00, DCF7, E612,14,DCDD, E5E6

; State header. Room $DCB1. Shitroid room - default
$8F:DCC3             dx CDD930, 0D, 00,00, A074, E26E, 90EC, C1,C1, DCFB, 0000, 0000, C831, E41E, C91E

; State header. Room $DCB1. Shitroid room - event "unused" is set
$8F:DCDD             dx CDD930, 0D, 00,00, A074, E26E, 90EC, C1,C1, DCFB, 0000, 0000, C831, E41E, C91E

; Door list. Room $DCB1. Shitroid room
$8F:DCF7             dw AA38, AA44

; Scroll data. Room $DCB1. Shitroid room
$8F:DCFB             db 01, 01, 01, 01

; Room header. Post Shitroid room
$8F:DCFF             dx 08,05, 0C,0F, 01,02, 70,A0, 00, DD26, E5E6

; State header. Room $DCFF. Post Shitroid room - default
$8F:DD0C             dx CDDBF8, 0D, 1E,05, A084, E708, 91C4, C1,C1, DD2C, 0000, 0000, C839, E41E, C91E

; Door list. Room $DCFF. Post Shitroid room
$8F:DD26             dw AA50, AA5C, AA68

; Scroll data. Room $DCFF. Post Shitroid room
$8F:DD2C             db 02, 02

; Room header. Tourian refill station
$8F:DD2E             dx 09,05, 0B,10, 01,01, 70,A0, 00, DD55, E5E6

; State header. Room $DD2E. Tourian refill station - default
$8F:DD3B             dx CEA823, 18, 00,00, A094, E70B, 91CE, 00,00, DD57, 0000, 0000, C841, 0000, C91E

; Door list. Room $DD2E. Tourian refill station
$8F:DD55             dw AA74

; Scroll data. Room $DD2E. Tourian refill station
$8F:DD57             db 01

; Room header. Mother Brain
$8F:DD58             dx 0A,05, 0D,12, 04,01, 70,A0, 00, DDBC, E5FF,DDA2, E612,02,DD88, E5E6

; State header. Room $DD58. Mother Brain - default
$8F:DD6E             dx CDDEDE, 0E, 00,00, A0A4, E321, 9102, C1,C1, DDC0, 0000, 0000, C84F, E48A, C91E

; State header. Room $DD58. Mother Brain - event "Mother Brain's glass is broken" is set
$8F:DD88             dx CDDEDE, 0E, 00,00, A0A4, E321, 9102, C1,C1, DDC0, 0000, 0000, C84F, E48A, C91E

; State header. Room $DD58. Mother Brain - main area boss is dead
$8F:DDA2             dx CDDEDE, 0E, 00,03, A188, 8000, 8000, C1,C1, DDC0, 0000, 0000, C84F, E48A, C91E

; Door list. Room $DD58. Mother Brain
$8F:DDBC             dw AA80, AA8C

; Scroll data. Room $DD58. Mother Brain
$8F:DDC0             db 01, 01, 01, 01

; Room header. Tourian eye-door room
$8F:DDC4             dx 0B,05, 0D,10, 04,01, 70,A0, 00, DDEB, E5E6

; State header. Room $DDC4. Tourian eye-door room - default
$8F:DDD1             dx CDE20F, 0D, 00,00, A0D4, E384, 9118, C1,C1, DDEF, 0000, 0000, C857, E41E, C91E

; Door list. Room $DDC4. Tourian eye-door room
$8F:DDEB             dw AA98, AAA4

; Scroll data. Room $DDC4. Tourian eye-door room
$8F:DDEF             db 01, 01, 01, 01

; Room header. Pre Mother Brain shaft
$8F:DDF3             dx 0C,05, 11,10, 01,03, 70,A0, 00, DE1A, E5E6

; State header. Room $DDF3. Pre Mother Brain shaft - default
$8F:DE00             dx CDE518, 0D, 1E,05, A0E4, E857, 920A, C1,C1, DE20, 0000, 0000, C86B, E454, C91E

; Door list. Room $DDF3. Pre Mother Brain shaft
$8F:DE1A             dw AAB0, AABC, AAC8

; Scroll data. Room $DDF3. Pre Mother Brain shaft
$8F:DE20             db 02, 02, 02

; Room header. Mother Brain save station
$8F:DE23             dx 0D,05, 10,11, 01,01, 70,A0, 00, DE4A, E5E6

; State header. Room $DE23. Mother Brain save station - default
$8F:DE30             dx CE92CB, 19, 1E,05, A0F4, E1D5, 90C2, 00,00, DE4C, 0000, 0000, C873, 0000, C91E

; Door list. Room $DE23. Mother Brain save station
$8F:DE4A             dw AAD4

; Scroll data. Room $DE23. Mother Brain save station
$8F:DE4C             db 01

; Room header. Escape room 1
$8F:DE4D             dx 0E,05, 0B,12, 02,01, 70,A0, 00, DE74, E5E6

; State header. Room $DE4D. Escape room 1 - default
$8F:DE5A             dx CDE914, 0D, 24,07, A104, E3AA, 9130, C1,C1, DE78, 0000, E5A0, C87B, E439, C91F

; Door list. Room $DE4D. Escape room 1
$8F:DE74             dw AAE0, AAEC

; Scroll data. Room $DE4D. Escape room 1
$8F:DE78             db 02, 02

; Room header. Escape room 2
$8F:DE7A             dx 0F,05, 0B,13, 01,02, 70,A0, 00, DEA1, E5E6

; State header. Room $DE7A. Escape room 2 - default
$8F:DE87             dx CDEB5B, 0D, 00,00, A114, E59C, 9188, C1,C1, DEA5, 0000, E57C, C889, E454, C933

; Door list. Room $DE7A. Escape room 2
$8F:DEA1             dw AAF8, AB04

; Scroll data. Room $DE7A. Escape room 2
$8F:DEA5             db 02, 01

; Room header. Escape room 3
$8F:DEA7             dx 10,05, 0C,13, 06,02, 70,A0, 00, DECE, E5E6

; State header. Room $DEA7. Escape room 3 - default
$8F:DEB4             dx CDED7A, 0D, 00,00, A124, E695, 91B2, C1,C1, DED2, 0000, E5A0, C897, E46F, C946

; Door list. Room $DEA7. Escape room 3
$8F:DECE             dw AB10, AB1C

; Scroll data. Room $DEA7. Escape room 3
$8F:DED2             db 02, 02, 02, 02, 02, 02, 01, 01, 01, 01, 01, 01

; Room header. Escape room 4
$8F:DEDE             dx 11,05, 12,10, 03,06, 70,A0, 00, DF05, E5E6

; State header. Room $DEDE. Escape room 4 - default
$8F:DEEB             dx CDF534, 0D, 00,00, A134, E102, 90B0, C1,C1, DF09, 0000, E5A4, C8A5, E46F, C953

; Door list. Room $DEDE. Escape room 4
$8F:DF05             dw AB28, AB34

; Scroll data. Room $DEDE. Escape room 4
$8F:DF09             db 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 01, 01, 01

; Room header. Tourian elevator save station
$8F:DF1B             dx 12,05, 15,0C, 01,01, 70,A0, 00, DF42, E5E6

; State header. Room $DF1B. Tourian elevator save station - default
$8F:DF28             dx CE95C2, 19, 1E,05, A144, E791, 91EE, 00,00, DF44, 0000, 0000, C8B3, 0000, 0000

; Door list. Room $DF1B. Tourian elevator save station
$8F:DF42             dw AB40

; Scroll data. Room $DF1B. Tourian elevator save station
$8F:DF44             db 01

; Room header. Ceres elevator shaft
$8F:DF45             dx 00,06, 0C,0D, 01,03, 70,A0, 05, DF8B, E629,01,DF71, E5E6

; State header. Room $DF45. Ceres elevator shaft - default
$8F:DF57             dx CDB846, 11, 2D,06, A146, E88A, 9218, 00,00, 0000, 0000, E51F, C8BB, E1D4, C976

; State header. Room $DF45. Ceres elevator shaft - main area boss is dead
$8F:DF71             dx CDB846, 12, 00,00, A146, E95C, 9270, 00,00, 0000, 0000, E51F, C8BB, E1D4, C96E

; Door list. Room $DF45. Ceres elevator shaft
$8F:DF8B             dw AB4C

; Room header. Ceres pre elevator hall
$8F:DF8D             dx 01,06, 0D,0F, 02,01, 70,A0, 00, DFD3, E629,01,DFB9, E5E6

; State header. Room $DF8D. Ceres pre elevator hall - default
$8F:DF9F             dx CDBBFE, 0F, 00,00, A156, E8AD, 9226, C1,01, 0000, 0000, E525, C8BD, E4A5, C976

; State header. Room $DF8D. Ceres pre elevator hall - main area boss is dead
$8F:DFB9             dx CDBBFE, 10, 00,00, A17E, EA2F, 927E, C1,01, 0000, 0000, E525, C8BD, E4A5, C976

; Door list. Room $DF8D. Ceres pre elevator hall
$8F:DFD3             dw AB58, AB64

; Room header. Ceres stairs
$8F:DFD7             dx 02,06, 0F,0F, 01,02, 70,A0, 00, E01D, E629,01,E003, E5E6

; State header. Room $DFD7. Ceres stairs - default
$8F:DFE9             dx CDBD78, 0F, 00,00, A158, E8D0, 9234, 01,41, 0000, 0000, E524, C8BF, E4A5, C976

; State header. Room $DFD7. Ceres stairs - main area boss is dead
$8F:E003             dx CDBD78, 10, 00,00, A180, EB02, 928C, 01,C1, 0000, 0000, E524, C8BF, E4A5, C976

; Door list. Room $DFD7. Ceres stairs
$8F:E01D             dw AB70, AB7C

; Room header. Ceres baby metroid hall
$8F:E021             dx 03,06, 10,10, 02,01, 70,A0, 00, E067, E629,01,E04D, E5E6

; State header. Room $E021. Ceres baby metroid hall - default
$8F:E033             dx CDBFC9, 0F, 00,00, A15A, E8F3, 9242, C0,00, 0000, 0000, E524, C8C1, 0000, C976

; State header. Room $E021. Ceres baby metroid hall - main area boss is dead
$8F:E04D             dx CDBFC9, 10, 00,00, A182, EB75, 929A, C0,00, 0000, 0000, E524, C8C1, 0000, C976

; Door list. Room $E021. Ceres baby metroid hall
$8F:E067             dw AB88, AB94

; Room header. Pre Ceres Ridley hall
$8F:E06B             dx 04,06, 12,10, 02,01, 70,A0, 00, E0B1, E629,01,E097, E5E6

; State header. Room $E06B. Pre Ceres Ridley hall - default
$8F:E07D             dx CDC330, 0F, 00,00, A15C, E916, 9250, C1,01, 0000, 0000, E524, C8C3, E4A5, C976

; State header. Room $E06B. Pre Ceres Ridley hall - main area boss is dead
$8F:E097             dx CDC330, 10, 00,00, A184, EB98, 92A8, C1,01, 0000, 0000, E524, C8C3, E4A5, C976

; Door list. Room $E06B. Pre Ceres Ridley hall
$8F:E0B1             dw ABA0, ABAC

; Room header. Ceres Ridley
$8F:E0B5             dx 05,06, 14,10, 01,01, 70,A0, 05, E0FB, E629,01,E0E1, E5E6

; State header. Room $E0B5. Ceres Ridley - default
$8F:E0C7             dx CDC43F, 13, 24,80, A15E, E939, 925E, 00,00, 0000, 0000, E571, C8C5, 0000, C97B

; State header. Room $E0B5. Ceres Ridley - main area boss is dead
$8F:E0E1             dx CDC43F, 14, 00,00, A186, EBBB, 92B6, 00,00, 0000, 0000, E571, C8C5, 0000, C97B

; Door list. Room $E0B5. Ceres Ridley
$8F:E0FB             dw ABB8
}


;;; $E0FD: Library backgrounds ;;;
{
; Room $CD13, state $CD25. Phantoon - default
$8F:E0FD             dx 0002, 7E2000, 4800, 1000, ; Transfer 1000h from $7E:2000 to VRAM $4800
                        0000

; Room $DA60, state $DA72. Draygon - default
$8F:E108             dx 0002, 7E2000, 4800, 1000, ; Transfer 1000h from $7E:2000 to VRAM $4800
                        0000

; Room $CD13, state $CD3F. Phantoon - main area boss is dead
; Room $DA60, state $DA8C. Draygon - main area boss is dead
$8F:E113             dx 000A,                     ; Clear BG2 tilemap
                        0000

; Room $CA08. Wrecked Ship entrance treadmill
; Room $E82C. Debug room
$8F:E117             dx 0004, BA8DE7, 4000,       ; Decompress $BA:8DE7 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Unused
$8F:E132             dx 0004, BA9023, 4000,       ; Decompress $BA:9023 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $CB8B. Wrecked Ship spike platform hall
; Room $CC6F. Pre Phantoon hall
$8F:E14D             dx 0004, BA9386, 4000,       ; Decompress $BA:9386 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $CA52. Wrecked Ship attic
$8F:E168             dx 0004, BA988D, 4000,       ; Decompress $BA:988D to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $CD5C. Wrecked Ship first flooded room
; Room $CDA8. Wrecked Ship west super missile room
; Room $CDF1, state $CE1D. Wrecked Ship east super missile hall - main area boss is dead
; Room $CE40. Gravity suit room
$8F:E183             dx 0004, BA9C35, 4000,       ; Decompress $BA:9C35 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $CAF6. Wrecked Ship mainstreet
; Room $CBD5. Wrecked Ship east exit
; Room $CDF1, state $CE03. Wrecked Ship east super missile hall - default
$8F:E19E             dx 0004, BA9F12, 4000,       ; Decompress $BA:9F12 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $CAAE. Wrecked Ship attic missile tank room
$8F:E1B9             dx 0004, BAA119, 4000,       ; Decompress $BA:A119 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $DF45. Ceres elevator shaft
$8F:E1D4             dx 000A,                     ; Clear BG2 tilemap
                        0000
}


;;; $E1D8..E247: Door ASM ;;;
{
;;; $E1D8: Door ASM - start Wrecked Ship treadmill - east entrance ;;;
{
; Door destination: Wrecked Ship entrance treadmill
; Room $CAF6, door 0. Wrecked Ship mainstreet
$8F:E1D8 A0 7B 82    LDY #$827B             ;\
$8F:E1DB 22 27 80 87 JSL $878027[$87:8027]  ;} Spawn Wrecked Ship treadmill - leftwards animated tiles object
$8F:E1DF 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:E1E3             dx 04, 09, B64F        ;} Spawn Wrecked Ship entrance treadmill from east PLM
$8F:E1E7 60          RTS
}


;;; $E1E8: Door ASM - scroll 1 = blue ;;;
{
; Door destination: Wrecked Ship first flooded room
; Room $CB8B, door 0. Wrecked Ship spike platform hall
$8F:E1E8 08          PHP
$8F:E1E9 E2 20       SEP #$20
$8F:E1EB A9 01       LDA #$01
$8F:E1ED 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:E1F1 28          PLP
$8F:E1F2 60          RTS
}


;;; $E1F3: Door ASM - scroll 0 = green ;;;
{
; Door destination: Wrecked Ship east exit
; Room $CC27, door 0. Wrecked Ship chozo energy tank room
$8F:E1F3 08          PHP
$8F:E1F4 E2 20       SEP #$20
$8F:E1F6 A9 02       LDA #$02
$8F:E1F8 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:E1FC 28          PLP
$8F:E1FD 60          RTS
}


;;; $E1FE: Door ASM - scroll 3 = red, 4 = blue ;;;
{
; Door destination: Pre Phantoon hall
; Room $CD13, door 0. Phantoon
$8F:E1FE 08          PHP
$8F:E1FF E2 20       SEP #$20
$8F:E201 A9 00       LDA #$00
$8F:E203 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$8F:E207 A9 01       LDA #$01
$8F:E209 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:E20D 28          PLP
$8F:E20E 60          RTS
}


;;; $E20F: Door ASM - scroll 29h = blue ;;;
{
; Door destination: Wrecked Ship mainstreet
; Room $CDF1, door 0. Wrecked Ship east super missile hall
$8F:E20F 08          PHP
$8F:E210 E2 20       SEP #$20
$8F:E212 A9 01       LDA #$01
$8F:E214 8F 49 CD 7E STA $7ECD49[$7E:CD49]
$8F:E218 28          PLP
$8F:E219 60          RTS
}


;;; $E21A: Door ASM - scroll 28h,2E = green ;;;
{
; Door destination: Wrecked Ship mainstreet
; Room $CC6F, door 0. Pre Phantoon hall
$8F:E21A 08          PHP
$8F:E21B E2 20       SEP #$20
$8F:E21D A9 02       LDA #$02
$8F:E21F 8F 48 CD 7E STA $7ECD48[$7E:CD48]
$8F:E223 8F 4E CD 7E STA $7ECD4E[$7E:CD4E]
$8F:E227 28          PLP
$8F:E228 60          RTS
}


;;; $E229: Door ASM - scroll 6..Bh = red ;;;
{
; Door destination: Wrecked Ship chozo room
; Room $CE40, door 1. Gravity suit room
$8F:E229 08          PHP
$8F:E22A E2 20       SEP #$20
$8F:E22C A9 00       LDA #$00
$8F:E22E 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:E232 8F 27 CD 7E STA $7ECD27[$7E:CD27]
$8F:E236 8F 28 CD 7E STA $7ECD28[$7E:CD28]
$8F:E23A 8F 29 CD 7E STA $7ECD29[$7E:CD29]
$8F:E23E 8F 2A CD 7E STA $7ECD2A[$7E:CD2A]
$8F:E242 8F 2B CD 7E STA $7ECD2B[$7E:CD2B]
$8F:E246 28          PLP
$8F:E247 60          RTS
}
}


;;; $E248: Library backgrounds ;;;
{
; Room $D08A. Maridia green gate hall
$8F:E248             dx 0004, BAA475, 4000,       ; Decompress $BA:A475 to $7E:4000
                        0002, 7E4000, 4800, 1000, ; Transfer 1000h from $7E:4000 to VRAM $4800
                        0000

; Room $D461. Evir hall west
; Room $D4C2. Evir hall east
$8F:E25A             dx 0004, BAA69F, 4000,       ; Decompress $BA:A69F to $7E:4000
                        0002, 7E4000, 4800, 1000, ; Transfer 1000h from $7E:4000 to VRAM $4800
                        0000
}


;;; $E26C..B5: Door ASM ;;;
{
;;; $E26C: Door ASM - set up elevatube from south ;;;
{
; Door destination: Maridia elevatube
; Room $D48E, door 2. Elevatube south
$8F:E26C A9 00 FF    LDA #$FF00             ;\
$8F:E26F 8D E5 07    STA $07E5  [$7E:07E5]  ;} Room elevatube velocity = -100h
$8F:E272 9C E3 07    STZ $07E3  [$7E:07E3]  ; >_<;
$8F:E275 A9 C0 09    LDA #$09C0             ;\
$8F:E278 8D E3 07    STA $07E3  [$7E:07E3]  ;} Room elevatube position = 9C0h
$8F:E27B A9 E0 FF    LDA #$FFE0             ;\
$8F:E27E 8D E7 07    STA $07E7  [$7E:07E7]  ;} Room elevatube acceleration = -20h
$8F:E281 A9 00 00    LDA #$0000             ;\
$8F:E284 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus
$8F:E288 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:E28C             dx  01, 00, B8F9       ;} Spawn Maridia elevatube PLM
$8F:E290 60          RTS
}


;;; $E291: Door ASM - set up elevatube from north ;;;
{
; Door destination: Maridia elevatube
; Room $D340, door 1. Sandy Maridia mainstreet
$8F:E291 A9 00 01    LDA #$0100             ;\
$8F:E294 8D E5 07    STA $07E5  [$7E:07E5]  ;} Room elevatube velocity = 100h
$8F:E297 9C E3 07    STZ $07E3  [$7E:07E3]  ; >_<;
$8F:E29A A9 40 00    LDA #$0040             ;\
$8F:E29D 8D E3 07    STA $07E3  [$7E:07E3]  ;} Room elevatube position = 40h
$8F:E2A0 A9 20 00    LDA #$0020             ;\
$8F:E2A3 8D E7 07    STA $07E7  [$7E:07E7]  ;} Room elevatube acceleration = 20h
$8F:E2A6 A9 00 00    LDA #$0000             ;\
$8F:E2A9 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus
$8F:E2AD 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$8F:E2B1             dx 01, 00, B8F9        ;} Spawn Maridia elevatube PLM
$8F:E2B5 60          RTS
}
}


;;; $E2B6: Main ASM - elevatube ;;;
{
; Room $D408. Maridia elevatube
$8F:E2B6 A9 80 00    LDA #$0080             ;\
$8F:E2B9 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;} Samus X position = 80h
$8F:E2BC 9C F8 0A    STZ $0AF8  [$7E:0AF8]  ;/
$8F:E2BF 64 12       STZ $12    [$7E:0012]  ;\
$8F:E2C1 64 14       STZ $14    [$7E:0014]  ;|
$8F:E2C3 AD E5 07    LDA $07E5  [$7E:07E5]  ;|
$8F:E2C6 10 02       BPL $02    [$E2CA]     ;} $14.$12 = ±[room elevatube velocity] / 100h
$8F:E2C8 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$8F:E2CA 85 13       STA $13    [$7E:0013]  ;/
$8F:E2CC AD E1 07    LDA $07E1  [$7E:07E1]  ;\
$8F:E2CF 18          CLC                    ;|
$8F:E2D0 65 12       ADC $12    [$7E:0012]  ;|
$8F:E2D2 8D E1 07    STA $07E1  [$7E:07E1]  ;} Room elevatube position += [$14].[$12]
$8F:E2D5 AD E3 07    LDA $07E3  [$7E:07E3]  ;|
$8F:E2D8 65 14       ADC $14    [$7E:0014]  ;|
$8F:E2DA 8D E3 07    STA $07E3  [$7E:07E3]  ;/
$8F:E2DD A5 12       LDA $12    [$7E:0012]  ;\
$8F:E2DF A6 14       LDX $14    [$7E:0014]  ;|
$8F:E2E1 86 12       STX $12    [$7E:0012]  ;} $12.$14 = [$14].[$12]
$8F:E2E3 85 14       STA $14    [$7E:0014]  ;/
$8F:E2E5 22 63 97 94 JSL $949763[$94:9763]  ; Move Samus down by [$12].[$14], no solid enemy collision
$8F:E2E9 AD E5 07    LDA $07E5  [$7E:07E5]  ;\
$8F:E2EC 18          CLC                    ;|
$8F:E2ED 6D E7 07    ADC $07E7  [$7E:07E7]  ;|
$8F:E2F0 18          CLC                    ;} If [room elevatube velocity] + [room elevatube acceleration] <= E20h:
$8F:E2F1 69 20 0E    ADC #$0E20             ;|
$8F:E2F4 C9 41 1C    CMP #$1C41             ;|
$8F:E2F7 B0 07       BCS $07    [$E300]     ;/
$8F:E2F9 38          SEC                    ;\
$8F:E2FA E9 20 0E    SBC #$0E20             ;} Room elevatube velocity += [room elevatube acceleration]
$8F:E2FD 8D E5 07    STA $07E5  [$7E:07E5]  ;/

$8F:E300 60          RTS
}


;;; $E301..E7: Door ASM ;;;
{
;;; $E301: Door ASM - reset elevatube on north exit ;;;
{
; Door destination: Sandy Maridia mainstreet
; Room $D408, door 1. Maridia elevatube
$8F:E301 A9 01 00    LDA #$0001             ;\
$8F:E304 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$8F:E308 60          RTS
}


;;; $E309: Door ASM - reset elevatube on south exit ;;;
{
; Door destination: Elevatube south
; Room $D408, door 0. Maridia elevatube
$8F:E309 A9 02 02    LDA #$0202             ;\
$8F:E30C 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;} Scroll 0..1 = green
$8F:E310 A9 01 00    LDA #$0001             ;\
$8F:E313 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$8F:E317 60          RTS
}


;;; $E318: Door ASM - scroll Ah = red, Bh = blue ;;;
{
; Door destination: Maridia grapple wall shaft
; Room $D845, door 0. Maridia missile station
$8F:E318 08          PHP
$8F:E319 E2 20       SEP #$20
$8F:E31B A9 00       LDA #$00
$8F:E31D 8F 2A CD 7E STA $7ECD2A[$7E:CD2A]
$8F:E321 A9 01       LDA #$01
$8F:E323 8F 2B CD 7E STA $7ECD2B[$7E:CD2B]
$8F:E327 28          PLP
$8F:E328 60          RTS
}


;;; $E329: Unused. Door ASM - scroll 10h = blue, 11h = red ;;;
{
$8F:E329 08          PHP
$8F:E32A E2 20       SEP #$20
$8F:E32C A9 00       LDA #$00
$8F:E32E 8F 31 CD 7E STA $7ECD31[$7E:CD31]
$8F:E332 A9 01       LDA #$01
$8F:E334 8F 30 CD 7E STA $7ECD30[$7E:CD30]
$8F:E338 28          PLP
$8F:E339 60          RTS
}


;;; $E33A: Unused. Door ASM - scroll 4 = green ;;;
{
$8F:E33A 08          PHP
$8F:E33B E2 20       SEP #$20
$8F:E33D A9 02       LDA #$02
$8F:E33F 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:E343 28          PLP
$8F:E344 60          RTS
}


;;; $E345: Door ASM - scroll 0 = red, 4 = blue ;;;
{
; Door destination: n00b tube east
; Room $CEFB, door 2. n00b tube
$8F:E345 08          PHP
$8F:E346 E2 20       SEP #$20
$8F:E348 A9 00       LDA #$00
$8F:E34A 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:E34E A9 01       LDA #$01
$8F:E350 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:E354 28          PLP
$8F:E355 60          RTS
}


;;; $E356: Door ASM - scroll 0 = red, 1 = blue ;;;
{
; Door destination: Maridia broken glass tube room
; Room $CF80, door 2. n00b tube east
; Room $D3B6, door 0. Maridia map station
$8F:E356 08          PHP
$8F:E357 E2 20       SEP #$20
$8F:E359 A9 00       LDA #$00
$8F:E35B 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:E35F A9 01       LDA #$01
$8F:E361 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:E365 28          PLP
$8F:E366 60          RTS
}


;;; $E367: Door ASM - scroll 9 = red, Ah = blue ;;;
{
; Door destination: Red Brinstar -> Crateria elevator
; Room $D104, door 1. Maridia -> Red Brinstar room
$8F:E367 08          PHP
$8F:E368 E2 20       SEP #$20
$8F:E36A A9 00       LDA #$00
$8F:E36C 8F 29 CD 7E STA $7ECD29[$7E:CD29]
$8F:E370 A9 01       LDA #$01
$8F:E372 8F 2A CD 7E STA $7ECD2A[$7E:CD2A]
$8F:E376 28          PLP
$8F:E377 60          RTS
}


;;; $E378: Door ASM - scroll 0,2 = red, 1 = blue ;;;
{
; Door destination: n00b tube
; Room $CF54, door 0. n00b tube west
; Room $CF80, door 0. n00b tube east
$8F:E378 08          PHP
$8F:E379 E2 20       SEP #$20
$8F:E37B A9 00       LDA #$00
$8F:E37D 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:E381 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:E385 A9 01       LDA #$01
$8F:E387 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:E38B 28          PLP
$8F:E38C 60          RTS
}


;;; $E38D: Door ASM - scroll 1 = blue ;;;
{
; Door destination: Botwoon
; Room $D7E4, door 0. Maridia speed blockade hall
$8F:E38D 08          PHP
$8F:E38E E2 20       SEP #$20
$8F:E390 A9 01       LDA #$01
$8F:E392 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:E396 28          PLP
$8F:E397 60          RTS
}


;;; $E398: Door ASM - scroll 6 = blue ;;;
{
; Door destination: Maridia crab shaft
; Room $D5A7, door 0. Snail room
$8F:E398 08          PHP
$8F:E399 E2 20       SEP #$20
$8F:E39B A9 01       LDA #$01
$8F:E39D 8F 26 CD 7E STA $7ECD26[$7E:CD26]
$8F:E3A1 28          PLP
$8F:E3A2 60          RTS
}


;;; $E3A3: Door ASM - scroll 4 = red ;;;
{
; Door destination: Pants room
; Room $D4C2, door 1. Evir hall east
; Room $D69A, door 0. Pants room section
$8F:E3A3 08          PHP
$8F:E3A4 E2 20       SEP #$20
$8F:E3A6 A9 00       LDA #$00
$8F:E3A8 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:E3AC 28          PLP
$8F:E3AD 60          RTS
}


;;; $E3AE: Unused. Door ASM - scroll 1 = red ;;;
{
$8F:E3AE 08          PHP
$8F:E3AF E2 20       SEP #$20
$8F:E3B1 A9 00       LDA #$00
$8F:E3B3 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:E3B7 28          PLP
$8F:E3B8 60          RTS
}


;;; $E3B9: Door ASM - scroll 4,7 = red ;;;
{
; Door destination: Pants room
; Room $D646, door 3. Pants room
$8F:E3B9 08          PHP
$8F:E3BA E2 20       SEP #$20
$8F:E3BC A9 00       LDA #$00
$8F:E3BE 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$8F:E3C2 8F 27 CD 7E STA $7ECD27[$7E:CD27]
$8F:E3C6 28          PLP
$8F:E3C7 60          RTS
}


;;; $E3C8: Door ASM - scroll 1 = blue, 2 = red ;;;
{
; Door destination: Pants room section
; Room $D8C5, door 0. Shaktool
$8F:E3C8 08          PHP
$8F:E3C9 E2 20       SEP #$20
$8F:E3CB A9 00       LDA #$00
$8F:E3CD 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:E3D1 A9 01       LDA #$01
$8F:E3D3 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:E3D7 28          PLP
$8F:E3D8 60          RTS
}


;;; $E3D9: Door ASM - scroll 0,2 = green ;;;
{
; Door destination: Pre Draygon room
; Room $DA60, door 0. Draygon
$8F:E3D9 08          PHP
$8F:E3DA E2 20       SEP #$20
$8F:E3DC A9 02       LDA #$02
$8F:E3DE 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:E3E2 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$8F:E3E6 28          PLP
$8F:E3E7 60          RTS
}
}


;;; $E3E8: Library backgrounds ;;;
{
; Room $DAAE. Tourian -> Crateria elevator
; Room $DB31. Metroid room 2
; Room $DBCD. Metroid room 4
$8F:E3E8             dx 0004, BAAA78, 4000,       ; Decompress $BA:AA78 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $DAE1. Metroid room 1
; Room $DB7D. Metroid room 3
$8F:E403             dx 0004, BAADF0, 4000,       ; Decompress $BA:ADF0 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $DC19. Tourian super-sidehopper room
; Room $DC65. Torizo corpse room
; Room $DCB1. Shitroid room
; Room $DCFF. Post Shitroid room
; Room $DDC4. Tourian eye-door room
$8F:E41E             dx 0004, BAAFE6, 4000,       ; Decompress $BA:AFE6 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $DE4D. Escape room 1
$8F:E439             dx 0004, BAB36B, 4000,       ; Decompress $BA:B36B to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $DDF3. Pre Mother Brain shaft
; Room $DE7A. Escape room 2
$8F:E454             dx 0004, BAB5D8, 4000,       ; Decompress $BA:B5D8 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $DEA7. Escape room 3
; Room $DEDE. Escape room 4
$8F:E46F             dx 0004, BAB9A3, 4000,       ; Decompress $BA:B9A3 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $DD58. Mother Brain
$8F:E48A             dx 0004, BABDD9, 4000,       ; Decompress $BA:BDD9 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; Room $DF8D. Ceres pre elevator hall
; Room $DFD7. Ceres stairs
; Room $E06B. Pre Ceres Ridley hall
$8F:E4A5             dx 0004, BAC22A, 4000,       ; Decompress $BA:C22A to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000
}


;;; $E4C0..E51E: Door ASM ;;;
{
;;; $E4C0: Door ASM - scroll 0..1 = green ;;;
{
; Door destination: Tourian entrance
; Room $DAAE, door 1. Tourian -> Crateria elevator
$8F:E4C0 08          PHP
$8F:E4C1 E2 20       SEP #$20
$8F:E4C3 A9 02       LDA #$02
$8F:E4C5 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$8F:E4C9 8F 21 CD 7E STA $7ECD21[$7E:CD21]
$8F:E4CD 28          PLP
$8F:E4CE 60          RTS
}


;;; $E4CF: Door ASM - scroll 8 = blue, 9 = red ;;;
{
; Door destination: Old Tourian escape shaft
; Room $DEDE, door 1. Escape room 4
$8F:E4CF 08          PHP
$8F:E4D0 E2 20       SEP #$20
$8F:E4D2 A9 01       LDA #$01
$8F:E4D4 8F 38 CD 7E STA $7ECD38[$7E:CD38]
$8F:E4D8 A9 00       LDA #$00
$8F:E4DA 8F 39 CD 7E STA $7ECD39[$7E:CD39]
$8F:E4DE 28          PLP
$8F:E4DF 60          RTS
}


;;; $E4E0: Door ASM - to Ceres elevator shaft ;;;
{
; Door destination: Ceres elevator shaft
; Room $DF8D, door 0. Ceres pre elevator hall
$8F:E4E0 E2 20       SEP #$20
$8F:E4E2 A9 07       LDA #$07               ;\
$8F:E4E4 85 56       STA $56    [$7E:0056]  ;} Fake mode = 7
$8F:E4E6 8D 05 21    STA $2105              ; BG mode = 7
$8F:E4E9 C2 20       REP #$20
$8F:E4EB A9 00 01    LDA #$0100             ;\
$8F:E4EE 85 78       STA $78    [$7E:0078]  ;|
$8F:E4F0 85 7E       STA $7E    [$7E:007E]  ;} Mode 7 transformation matrix = identity
$8F:E4F2 64 7A       STZ $7A    [$7E:007A]  ;|
$8F:E4F4 64 7C       STZ $7C    [$7E:007C]  ;/
$8F:E4F6 A9 80 00    LDA #$0080             ;\
$8F:E4F9 85 80       STA $80    [$7E:0080]  ;|
$8F:E4FB A9 F0 03    LDA #$03F0             ;} Mode 7 transformation origin = (80h, 3F0h)
$8F:E4FE 85 82       STA $82    [$7E:0082]  ;/
$8F:E500 A9 01 00    LDA #$0001             ;\
$8F:E503 8D 83 07    STA $0783  [$7E:0783]  ;} Mode 7 flag = 1
$8F:E506 A9 22 00    LDA #$0022             ;\
$8F:E509 8D E1 07    STA $07E1  [$7E:07E1]  ;} Room rotation matrix index = 22h
$8F:E50C A9 3C 00    LDA #$003C             ;\
$8F:E50F 8D E3 07    STA $07E3  [$7E:07E3]  ;} Room rotation matrix timer = 60
$8F:E512 60          RTS
}


;;; $E513: Door ASM - from Ceres elevator shaft ;;;
{
; Door destination: Ceres pre elevator hall
; Room $DF45, door 0. Ceres elevator shaft
$8F:E513 E2 20       SEP #$20
$8F:E515 A9 09       LDA #$09               ;\
$8F:E517 85 56       STA $56    [$7E:0056]  ;} Fake mode = 9
$8F:E519 C2 20       REP #$20
$8F:E51B 9C 83 07    STZ $0783  [$7E:0783]  ; Mode 7 flag = 0
$8F:E51E 60          RTS
}
}


;;; $E51F..D1: Main ASM ;;;
{
;;; $E51F: Main ASM - Ceres elevator shaft ;;;
{
; Room $DF45. Ceres elevator shaft

; Handles landing on elevator and setting mode 7 rotation matrix
$8F:E51F 22 C3 AC 89 JSL $89ACC3[$89:ACC3]
$8F:E523 60          RTS
}


;;; $E524: RTS. Main ASM ;;;
{
; Room $DFD7. Ceres stairs
; Room $E021. Ceres baby metroid hall
; Room $E06B. Pre Ceres Ridley hall
$8F:E524 60          RTS
}


;;; $E525: Main ASM - spawn Ceres pre elevator hall falling debris ;;;
{
; Room $DF8D. Ceres pre elevator hall
$8F:E525 AD 3F 09    LDA $093F  [$7E:093F]  ;\
$8F:E528 F0 FA       BEQ $FA    [$E524]     ;} If [Ceres status] = before Ridley escape: return
$8F:E52A CE E1 07    DEC $07E1  [$7E:07E1]  ; Decrement room debris delay timer
$8F:E52D 10 F5       BPL $F5    [$E524]     ; If [room debris delay timer] >= 0: return
$8F:E52F A9 08 00    LDA #$0008             ;\
$8F:E532 8D E1 07    STA $07E1  [$7E:07E1]  ;} Room debris delay timer = 8
$8F:E535 A0 34 97    LDY #$9734             ; Y = $9734 (light coloured debris)
$8F:E538 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$8F:E53B 0A          ASL A                  ;} If [random number] >= 8000h:
$8F:E53C 90 03       BCC $03    [$E541]     ;/
$8F:E53E A0 42 97    LDY #$9742             ; Y = $9742 (dark coloured debris)

$8F:E541 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$8F:E544 29 0F 00    AND #$000F             ;|
$8F:E547 0A          ASL A                  ;|
$8F:E548 AA          TAX                    ;} Spawn enemy projectile [Y] with parameter [$E551 + [random number] % 10h * 2]
$8F:E549 BD 51 E5    LDA $E551,x[$8F:E56B]  ;|
$8F:E54C 22 97 80 86 JSL $868097[$86:8097]  ;/
$8F:E550 60          RTS

; Debris X positions
$8F:E551             dw 0050, 0060, 0070, 0080, 0090, 00A0, 00B0, 00C0, 00D0, 00E0, 00F0, 0110, 0130, 0150, 0170, 0190
}


;;; $E571: Main ASM - handle Ceres Ridley getaway cutscene ;;;
{
; Room $E0B5. Ceres Ridley
$8F:E571 AD 3F 09    LDA $093F  [$7E:093F]  ;\
$8F:E574 4A          LSR A                  ;} If [Ceres status] = during Ridley escape cutscene:
$8F:E575 90 04       BCC $04    [$E57B]     ;/
$8F:E577 22 AF AA A6 JSL $A6AAAF[$A6:AAAF]  ; Handle Ceres Ridley getaway cutscene

$8F:E57B 60          RTS
}


;;; $E57C: Main ASM - shake screen switching between light horizontal and medium diagonal ;;;
{
; Room $DE7A. Escape room 2

; Horizontal screen shaking with a 1/80h chance of becoming medium diagonal for 2Ah frames
$8F:E57C AD E1 07    LDA $07E1  [$7E:07E1]  ;\
$8F:E57F F0 0A       BEQ $0A    [$E58B]     ;} If [room diagonal quake timer] != 0:
$8F:E581 CE E1 07    DEC $07E1  [$7E:07E1]  ; Decrement room diagonal quake timer
$8F:E584 D0 1A       BNE $1A    [$E5A0]     ; If [room diagonal quake timer] != 0: go to BRANCH_NO_EARTHQUAKE_CHANGE
$8F:E586 A9 12 00    LDA #$0012             ; Earthquake type = BG1, BG2 and enemies, 1 pixel displacement, horizontal
$8F:E589 80 12       BRA $12    [$E59D]
                                            ; Else ([room diagonal quake timer] = 0):
$8F:E58B 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$8F:E58F C9 00 02    CMP #$0200             ;\
$8F:E592 B0 0C       BCS $0C    [$E5A0]     ;} If [random number] >= 200h: go to BRANCH_NO_EARTHQUAKE_CHANGE
$8F:E594 A9 2A 00    LDA #$002A             ;\
$8F:E597 8D E1 07    STA $07E1  [$7E:07E1]  ;} Room diagonal quake timer = 2Ah
$8F:E59A A9 17 00    LDA #$0017             ; Earthquake type = BG1, BG2 and enemies, 2 pixel displacement, diagonal

$8F:E59D 8D 3E 18    STA $183E  [$7E:183E]

; BRANCH_NO_EARTHQUAKE_CHANGE
}


;;; $E5A0: Main ASM - generate random explosion on every fourth frame ;;;
{
; Room $DE4D. Escape room 1
; Room $DEA7. Escape room 3
$8F:E5A0 20 83 C1    JSR $C183  [$8F:C183]  ; Generate random explosion on every fourth frame
$8F:E5A3 60          RTS
}


;;; $E5A4: Main ASM - shake screen switching between medium horizontal and strong diagonal ;;;
{
; Room $DEDE. Escape room 4

; Horizontal screen shaking with a 3/200h chance of becoming strong diagonal for 2Ah frames
$8F:E5A4 AD E1 07    LDA $07E1  [$7E:07E1]  ;\
$8F:E5A7 F0 0A       BEQ $0A    [$E5B3]     ;} If [room diagonal quake timer] != 0:
$8F:E5A9 CE E1 07    DEC $07E1  [$7E:07E1]  ; Decrement room diagonal quake timer
$8F:E5AC D0 1A       BNE $1A    [$E5C8]     ; If [room diagonal quake timer] != 0: go to BRANCH_NO_EARTHQUAKE_CHANGE
$8F:E5AE A9 15 00    LDA #$0015             ; Room earthquake type = BG1, BG2 and enemies, 2 pixel displacement, horizontal
$8F:E5B1 80 12       BRA $12    [$E5C5]
                                            ; Else ([room diagonal quake timer] = 0):
$8F:E5B3 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$8F:E5B7 C9 80 01    CMP #$0180             ;\
$8F:E5BA B0 0C       BCS $0C    [$E5C8]     ;} If [random number] >= 180h: go to BRANCH_NO_EARTHQUAKE_CHANGE
$8F:E5BC A9 2A 00    LDA #$002A             ;\
$8F:E5BF 8D E1 07    STA $07E1  [$7E:07E1]  ;} Room diagonal quake timer = 2Ah
$8F:E5C2 A9 1A 00    LDA #$001A             ; Room earthquake type = BG1, BG2 and enemies, 3 pixel displacement, diagonal

$8F:E5C5 8D E3 07    STA $07E3  [$7E:07E3]

; BRANCH_NO_EARTHQUAKE_CHANGE
$8F:E5C8 AD E3 07    LDA $07E3  [$7E:07E3]  ;\
$8F:E5CB 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = [room earthquake type]
$8F:E5CE 20 83 C1    JSR $C183  [$8F:C183]  ; Generate random explosion on every fourth frame
$8F:E5D1 60          RTS
}
}


;;; $E5D2..E689: Room state ASM ;;;
{
;;; $E5D2: Room state checking handler ;;;
{
;; Parameters:
;;     X: Room pointer

; A matching state conditions will return out of *this* routine by popping the return address pushed to the stack by $E5E0
$8F:E5D2 8A          TXA                    ;\
$8F:E5D3 18          CLC                    ;|
$8F:E5D4 69 0B 00    ADC #$000B             ;} X += Bh (offset to state conditions list)
$8F:E5D7 AA          TAX                    ;/

; LOOP
$8F:E5D8 BD 00 00    LDA $0000,x[$8F:DF50]  ;\
$8F:E5DB 8D B7 07    STA $07B7  [$7E:07B7]  ;} State condition = [[X]]
$8F:E5DE E8          INX                    ;\
$8F:E5DF E8          INX                    ;} X += 2
$8F:E5E0 F4 D7 E5    PEA $E5D7              ; Return to LOOP
$8F:E5E3 6C B7 07    JMP ($07B7)[$8F:E629]  ; Go to [state condition]
}


;;; $E5E6: State condition - default ;;;
{
;; Parameters:
;;     X: Pointer to after this state condition
$8F:E5E6 8E BB 07    STX $07BB  [$7E:07BB]  ; State pointer = [X]
$8F:E5E9 68          PLA                    ; Terminate processing room state checks
$8F:E5EA 6B          RTL
}


;;; $E5EB: Unused. State condition - door pointer = [[X]] ;;;
{
;; Parameters:
;;     X: Pointer to state condition arguments
;; Returns:
;;     X: Pointer to next state condition
$8F:E5EB BD 00 00    LDA $0000,x            ;\
$8F:E5EE CD 8D 07    CMP $078D  [$7E:078D]  ;} If [[X]] = [door pointer]:
$8F:E5F1 D0 07       BNE $07    [$E5FA]     ;/
$8F:E5F3 BD 02 00    LDA $0002,x            ;\
$8F:E5F6 AA          TAX                    ;} X = [[X] + 2]
$8F:E5F7 4C E6 E5    JMP $E5E6  [$8F:E5E6]  ; Go to use state pointer [X]

$8F:E5FA E8          INX                    ;\
$8F:E5FB E8          INX                    ;|
$8F:E5FC E8          INX                    ;} X += 4
$8F:E5FD E8          INX                    ;/
$8F:E5FE 60          RTS
}


;;; $E5FF: State condition - main area boss is dead ;;;
{
;; Parameters:
;;     X: Pointer to state condition arguments
;; Returns:
;;     X: Pointer to next state condition
$8F:E5FF A9 01 00    LDA #$0001             ;\
$8F:E602 22 DC 81 80 JSL $8081DC[$80:81DC]  ;} If area main boss is dead:
$8F:E606 90 07       BCC $07    [$E60F]     ;/
$8F:E608 BD 00 00    LDA $0000,x            ;\
$8F:E60B AA          TAX                    ;} X = [[X]]
$8F:E60C 4C E6 E5    JMP $E5E6  [$8F:E5E6]  ; Go to use state pointer [X]

$8F:E60F E8          INX                    ;\
$8F:E610 E8          INX                    ;} X += 2
$8F:E611 60          RTS
}


;;; $E612: State condition - event [[X]] is set ;;;
{
;; Parameters:
;;     X: Pointer to state condition arguments
;; Returns:
;;     X: Pointer to next state condition
$8F:E612 BD 00 00    LDA $0000,x[$8F:9205]  ;\
$8F:E615 29 FF 00    AND #$00FF             ;|
$8F:E618 22 33 82 80 JSL $808233[$80:8233]  ;} If event [[X]] is marked:
$8F:E61C 90 07       BCC $07    [$E625]     ;/
$8F:E61E BD 01 00    LDA $0001,x[$8F:9EAD]  ;\
$8F:E621 AA          TAX                    ;} X = [[X] + 1]
$8F:E622 4C E6 E5    JMP $E5E6  [$8F:E5E6]  ; Go to use state pointer [X]

$8F:E625 E8          INX                    ;\
$8F:E626 E8          INX                    ;} X += 3
$8F:E627 E8          INX                    ;/
$8F:E628 60          RTS
}


;;; $E629: State condition - boss [[X]] is dead ;;;
{
;; Parameters:
;;     X: Pointer to state condition arguments
;; Returns:
;;     X: Pointer to next state condition
$8F:E629 BD 00 00    LDA $0000,x[$8F:DF52]  ;\
$8F:E62C 29 FF 00    AND #$00FF             ;|
$8F:E62F 22 DC 81 80 JSL $8081DC[$80:81DC]  ;} If any of the boss bits [[X]] are set:
$8F:E633 90 07       BCC $07    [$E63C]     ;/
$8F:E635 BD 01 00    LDA $0001,x[$8F:E079]  ;\
$8F:E638 AA          TAX                    ;} X = [[X] + 1]
$8F:E639 4C E6 E5    JMP $E5E6  [$8F:E5E6]  ; Go to use state pointer [X]

$8F:E63C E8          INX                    ;\
$8F:E63D E8          INX                    ;} X += 3
$8F:E63E E8          INX                    ;/
$8F:E63F 60          RTS
}


;;; $E640: Unused. State condition - morph ball has been collected ;;;
{
;; Parameters:
;;     X: Pointer to state condition arguments
;; Returns:
;;     X: Pointer to next state condition
$8F:E640 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$8F:E643 29 04 00    AND #$0004             ;} If morph ball collected:
$8F:E646 F0 07       BEQ $07    [$E64F]     ;/
$8F:E648 BD 00 00    LDA $0000,x            ;\
$8F:E64B AA          TAX                    ;} X = [[X]]
$8F:E64C 4C E6 E5    JMP $E5E6  [$8F:E5E6]  ; Go to use state pointer [X]

$8F:E64F E8          INX                    ;\
$8F:E650 E8          INX                    ;} X += 2
$8F:E651 60          RTS
}


;;; $E652: State condition - morph ball and missiles have been collected ;;;
{
;; Parameters:
;;     X: Pointer to state condition arguments
;; Returns:
;;     X: Pointer to next state condition
$8F:E652 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$8F:E655 89 04 00    BIT #$0004             ;} If morph ball collected:
$8F:E658 F0 0C       BEQ $0C    [$E666]     ;/
$8F:E65A AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$8F:E65D F0 07       BEQ $07    [$E666]     ;} If [Samus max missiles] != 0:
$8F:E65F BD 00 00    LDA $0000,x[$8F:97C2]  ;\
$8F:E662 AA          TAX                    ;} X = [[X]]
$8F:E663 4C E6 E5    JMP $E5E6  [$8F:E5E6]  ; Go to use state pointer [X]

$8F:E666 E8          INX                    ;\
$8F:E667 E8          INX                    ;} X += 2
$8F:E668 60          RTS
}


;;; $E669: State condition - power bombs have been collected ;;;
{
;; Parameters:
;;     X: Pointer to state condition arguments
;; Returns:
;;     X: Pointer to next state condition
$8F:E669 AD D0 09    LDA $09D0  [$7E:09D0]  ;\
$8F:E66C F0 07       BEQ $07    [$E675]     ;} If [Samus max power bombs] != 0:
$8F:E66E BD 00 00    LDA $0000,x[$8F:920A]  ;\
$8F:E671 AA          TAX                    ;} X = [[X]]
$8F:E672 4C E6 E5    JMP $E5E6  [$8F:E5E6]  ; Go to use state pointer [X]

$8F:E675 E8          INX                    ;\
$8F:E676 E8          INX                    ;} X += 2
$8F:E677 60          RTS
}


;;; $E678: Unused. State condition - speed booster has been collected ;;;
{
;; Parameters:
;;     X: Pointer to state condition arguments
;; Returns:
;;     X: Pointer to next state condition
$8F:E678 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$8F:E67B 29 00 20    AND #$2000             ;} If speed booster collected:
$8F:E67E F0 07       BEQ $07    [$E687]     ;/
$8F:E680 BD 00 00    LDA $0000,x            ;\
$8F:E683 AA          TAX                    ;} X = [[X]]
$8F:E684 4C E6 E5    JMP $E5E6  [$8F:E5E6]  ; Go to use state pointer [X]

$8F:E687 E8          INX                    ;\
$8F:E688 E8          INX                    ;} X += 2
$8F:E689 60          RTS
}
}


;;; $E68A: Door closing PLMs ;;;
{
; Spawned by $82:E8EB during door transition
$8F:E68A             dw 0000, ; 0: Non-closing door facing right
                        0000, ; 1: Non-closing door facing left
                        0000, ; 2: Non-closing door facing down
                        0000, ; 3: Non-closing door facing up
                        C8BE, ; 4: Blue door closing facing right
                        C8BA, ; 5: Blue door closing facing left
                        C8C6, ; 6: Blue door closing facing down
                        C8C2, ; 7: Blue door closing facing up
                        C8D0, ; 8: Gate that closes during escape in room after Mother Brain
                        C8D0, ; 9: Gate that closes during escape in room after Mother Brain
                        C8D0, ; Ah: Gate that closes during escape in room after Mother Brain
                        C8D0  ; Bh: Gate that closes during escape in room after Mother Brain
}


;;; $E6A2: Tileset table ;;;
{
;                        _____________________ Tile table pointer
;                       |        _____________ Tiles pointer
;                       |       |        _____ Palette pointer
;                       |       |       |
$8F:E6A2             dl C1B6F6, BAC629, C2AD7C ; 0: Upper Crateria
$8F:E6AB             dl C1B6F6, BAC629, C2AE5D ; 1: Red Crateria
$8F:E6B4             dl C1BEEE, BAF911, C2AF43 ; 2: Lower Crateria
$8F:E6BD             dl C1BEEE, BAF911, C2B015 ; 3: Old Tourian
$8F:E6C6             dl C1C5CF, BBAE9E, C2B0E7 ; 4: Wrecked Ship - power on
$8F:E6CF             dl C1C5CF, BBAE9E, C2B1A6 ; 5: Wrecked Ship - power off
$8F:E6D8             dl C1CFA6, BBE6B0, C2B264 ; 6: Green/blue Brinstar
$8F:E6E1             dl C1D8DC, BCA5AA, C2B35F ; 7: Red Brinstar / Kraid's lair
$8F:E6EA             dl C1D8DC, BCA5AA, C2B447 ; 8: Pre Tourian entrance corridor
$8F:E6F3             dl C1E361, BDC3F9, C2B5E4 ; 9: Heated Norfair
$8F:E6FC             dl C1E361, BDC3F9, C2B6BB ; Ah: Unheated Norfair
$8F:E705             dl C1F4B1, BEB130, C2B83C ; Bh: Sandless Maridia
$8F:E70E             dl C2855F, BEE78D, C2B92E ; Ch: Sandy Maridia
$8F:E717             dl C29B01, BFD414, C2BAED ; Dh: Tourian
$8F:E720             dl C29B01, BFD414, C2BBC1 ; Eh: Mother Brain's room
$8F:E729             dl C2A75E, C0B004, C2C104 ; Fh: Blue Ceres
$8F:E732             dl C2A75E, C0B004, C2C1E3 ; 10h: White Ceres
$8F:E73B             dl C2A75E, C0E22A, C2C104 ; 11h: Blue Ceres elevator
$8F:E744             dl C2A75E, C0E22A, C2C1E3 ; 12h: White Ceres elevator
$8F:E74D             dl C2A75E, C18DA9, C2C104 ; 13h: Blue Ceres Ridley's room
$8F:E756             dl C2A75E, C18DA9, C2C1E3 ; 14h: White Ceres Ridley's room
$8F:E75F             dl C2A27B, C0860B, C2BC9C ; 15h: Map room / Tourian entrance
$8F:E768             dl C2A27B, C0860B, C2BD7B ; 16h: Wrecked Ship map room - power off
$8F:E771             dl C2A27B, C0860B, C2BE58 ; 17h: Blue refill room
$8F:E77A             dl C2A27B, C0860B, C2BF3D ; 18h: Yellow refill room
$8F:E783             dl C2A27B, C0860B, C2C021 ; 19h: Save room
$8F:E78C             dl C1E189, BCDFF0, C2B510 ; 1Ah: Kraid's room
$8F:E795             dl C1F3AF, BDFE2A, C2B798 ; 1Bh: Crocomire's room
$8F:E79E             dl C2960D, BF9DEA, C2BA2C ; 1Ch: Draygon's room
}


;;; $E7A7: Tileset pointers ;;;
{
$8F:E7A7             dw E6A2, E6AB, E6B4, E6BD, E6C6, E6CF, E6D8, E6E1, E6EA, E6F3, E6FC, E705, E70E, E717, E720, E729,
                        E732, E73B, E744, E74D, E756, E75F, E768, E771, E77A, E783, E78C, E795, E79E
}


;;; $E7E1: Music pointers ;;;
{
$8F:E7E1             dl CF8000, ; 0:   SPC engine
                        D0E20D, ; 3:   Title sequence
                        D1B62A, ; 6:   Empty Crateria
                        D288CA, ; 9:   Lower Crateria
                        D2D9B6, ; Ch:  Upper Crateria
                        D3933C, ; Fh:  Green Brinstar
                        D3E812, ; 12h: Red Brinstar
                        D4B86C, ; 15h: Upper Norfair
                        D4F420, ; 18h: Lower Norfair
                        D5C844, ; 1Bh: Maridia
                        D698B7, ; 1Eh: Tourian
                        D6EF9D, ; 21h: Mother Brain
                        D7BF73, ; 24h: Boss fight 1
                        D899B2, ; 27h: Boss fight 2
                        D8EA8B, ; 2Ah: Miniboss fight
                        D9B67B, ; 2Dh: Ceres
                        D9F5DD, ; 30h: Wrecked Ship
                        DAB650, ; 33h: Zebes boom
                        DAD63B, ; 36h: Intro
                        DBA40F, ; 39h: Death
                        DBDF4F, ; 3Ch: Credits
                        DCAF6C, ; 3Fh: "The last Metroid is in captivity"
                        DCFAC7, ; 42h: "The galaxy is at peace"
                        DDB104, ; 45h: Shitroid (same as boss fight 2)
                        DE81C1  ; 48h: Samus theme (same as upper Crateria)
}


;;; $E82C: Debug room ;;;
{
; Room header. Debug room
$8F:E82C             dx 00,07, 00,00, 06,02, 70,A0, 00, E853, E5E6

; State header. Room $E82C. Debug room - default
$8F:E839             dx CEAE3E, 0B, 00,00, A188, EBCE, 92C3, C1,C1, 0001, 0000, 0000, E87F, E117, 0000

; Door list. Room $E82C. Debug room
$8F:E853             dw ABC4, ABCF, ABDA, ABE5

; Unused library background. Same as the library background $B8B4 used by rooms:
;     $92FD: Crateria mainstreet
;     $93AA: Landing site power bombs cave
;     $948C: Pre moat room
;     $957D: Crab maze
;     $95FF: Moat
; Except that this one additionally (incorrectly) loads the water FX tilemap
$8F:E85B             dx 0002, 8A9080, 5880, 0F00, ; Transfer F00h from $8A:9080 to VRAM $5880
                        0004, BA8437, 4000,       ; Decompress $BA:8437 to $7E:4000
                        0002, 7E4000, 4800, 0800, ; Transfer 800h from $7E:4000 to VRAM $4800
                        0002, 7E4000, 4C00, 0800, ; Transfer 800h from $7E:4000 to VRAM $4C00
                        0000

; PLM population. Room $E82C. Debug room
$8F:E87F             dx 0000
}


;;; $E881: Unused. PLM metadata - Wrecked Ship / Maridia / Tourian (/ Ceres?) ;;;
{
; See $C209 for the other areas
$8F:E881             dw 009E, ; "Next" item / refill station index (9Dh is the last used one, see "Item PLMs.asm")
                        00AD, ; "Next" doorcap index (ACh is the last used one, see "Door PLMs.asm")
                        0081, ; ?
                        0001, ; Number of save stations in Wrecked Ship
                        0004, ; Number of save stations in Maridia
                        0002, ; Number of save stations in Tourian
                        0000  ; Number of save stations in Ceres?
}


;;; $E88F: Execute room setup ASM ;;;
{
$8F:E88F 08          PHP
$8F:E890 8B          PHB
$8F:E891 C2 30       REP #$30
$8F:E893 AE BB 07    LDX $07BB  [$7E:07BB]  ; X = [room state pointer]
$8F:E896 BD 18 00    LDA $0018,x[$8F:DF6F]  ;\
$8F:E899 F0 05       BEQ $05    [$E8A0]     ;} If (room setup ASM) != 0:
$8F:E89B 4B          PHK                    ;\
$8F:E89C AB          PLB                    ;} DB = $8F
$8F:E89D FC 18 00    JSR ($0018,x)[$8F:C976]; Execute (room setup ASM)

$8F:E8A0 AB          PLB
$8F:E8A1 28          PLP
$8F:E8A2 6B          RTL
}


;;; $E8A3: Execute door ASM ;;;
{
$8F:E8A3 08          PHP
$8F:E8A4 8B          PHB
$8F:E8A5 C2 30       REP #$30
$8F:E8A7 AE 8D 07    LDX $078D  [$7E:078D]  ; X = [door pointer]
$8F:E8AA BF 0A 00 83 LDA $83000A,x[$83:AB62];\
$8F:E8AE F0 0A       BEQ $0A    [$E8BA]     ;} If (door ASM pointer) != 0:
$8F:E8B0 85 12       STA $12    [$7E:0012]  ; $12 = (door ASM pointer)
$8F:E8B2 4B          PHK                    ;\
$8F:E8B3 AB          PLB                    ;} DB = $8F
$8F:E8B4 F4 B9 E8    PEA $E8B9              ;\
$8F:E8B7 6C 12 00    JMP ($0012)[$8F:E4E0]  ;} Execute [$12]

$8F:E8BA AB          PLB
$8F:E8BB 28          PLP
$8F:E8BC 6B          RTL
}


;;; $E8BD: Execute room main ASM ;;;
{
$8F:E8BD AE DF 07    LDX $07DF  [$7E:07DF]  ;\
$8F:E8C0 F0 0A       BEQ $0A    [$E8CC]     ;} If [room main ASM pointer] != 0:
$8F:E8C2 8B          PHB
$8F:E8C3 4B          PHK                    ;\
$8F:E8C4 AB          PLB                    ;} DB = $8F
$8F:E8C5 A2 00 00    LDX #$0000             ;\
$8F:E8C8 FC DF 07    JSR ($07DF,x)[$8F:E51F];} Execute [room main ASM pointer]
$8F:E8CB AB          PLB

$8F:E8CC 6B          RTL
}


;;; $E8CD..E99A: Main ASM ;;;
{
;;; $E8CD: Main ASM - Crocomire's room shaking ;;;
{
; Room $A98D. Crocomire
$8F:E8CD AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$8F:E8D0 89 00 02    BIT #$0200             ;} If Crocomire is marked for deletion: return
$8F:E8D3 D0 40       BNE $40    [$E915]     ;/
$8F:E8D5 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$8F:E8D8 C9 40 00    CMP #$0040             ;} If [Crocomire death sequence index] = 40h (behind wall - rumbling): go to BRANCH_BEHIND_WALL_RUMBLING
$8F:E8DB F0 65       BEQ $65    [$E942]     ;/
$8F:E8DD AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$8F:E8E0 89 00 04    BIT #$0400             ;} If [Crocomire fight flags] & 400h = 0 (always true): go to BRANCH_E916
$8F:E8E3 F0 31       BEQ $31    [$E916]     ;/
$8F:E8E5 AD EE 0F    LDA $0FEE  [$7E:0FEE]  ;\
$8F:E8E8 3A          DEC A                  ;} Decrement Crocomire rumbling Y offset
$8F:E8E9 8D EE 0F    STA $0FEE  [$7E:0FEE]  ;/
$8F:E8EC C9 F9 FF    CMP #$FFF9             ;\
$8F:E8EF 30 05       BMI $05    [$E8F6]     ;} If [Crocomire rumbling Y offset] >= -7:
$8F:E8F1 AD EE 0F    LDA $0FEE  [$7E:0FEE]  ; $12 = [Crocomire rumbling Y offset]
$8F:E8F4 80 10       BRA $10    [$E906]

$8F:E8F6 A9 07 00    LDA #$0007             ;\ Else ([Crocomire rumbling Y offset] < -7):
$8F:E8F9 18          CLC                    ;|
$8F:E8FA 6D EE 0F    ADC $0FEE  [$7E:0FEE]  ;|
$8F:E8FD 0A          ASL A                  ;|
$8F:E8FE 85 12       STA $12    [$7E:0012]  ;} $12 = -Eh - [Crocomire rumbling Y offset]
$8F:E900 AD EE 0F    LDA $0FEE  [$7E:0FEE]  ;|
$8F:E903 38          SEC                    ;|
$8F:E904 E5 12       SBC $12    [$7E:0012]  ;/

$8F:E906 85 12       STA $12    [$7E:0012]
$8F:E908 18          CLC                    ;\
$8F:E909 65 B3       ADC $B3    [$7E:00B3]  ;} BG1 Y scroll += [$12]
$8F:E90B 85 B3       STA $B3    [$7E:00B3]  ;/
$8F:E90D A9 D0 FF    LDA #$FFD0             ;\
$8F:E910 18          CLC                    ;|
$8F:E911 65 12       ADC $12    [$7E:0012]  ;} BG2 Y scroll = [$12] + 30h
$8F:E913 85 B7       STA $B7    [$7E:00B7]  ;/

$8F:E915 60          RTS                    ; Return

; BRANCH_E916
$8F:E916 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$8F:E919 C9 22 00    CMP #$0022             ;} If [Crocomire fight function index] != 22h (unused): return
$8F:E91C D0 F7       BNE $F7    [$E915]     ;/
$8F:E91E AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$8F:E921 F0 F2       BEQ $F2    [$E915]     ;} If [$0FAE] = 0: return
$8F:E923 3A          DEC A                  ;\
$8F:E924 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} Decrement $0FAE
$8F:E927 89 01 00    BIT #$0001             ;\
$8F:E92A D0 0B       BNE $0B    [$E937]     ;} If [$0FAE] % 2 = 0:
$8F:E92C AD 11 09    LDA $0911  [$7E:0911]  ;\
$8F:E92F 18          CLC                    ;|
$8F:E930 69 04 00    ADC #$0004             ;} Layer 1 X position += 4
$8F:E933 8D 11 09    STA $0911  [$7E:0911]  ;/
$8F:E936 60          RTS                    ; Return

$8F:E937 AD 11 09    LDA $0911  [$7E:0911]  ;\
$8F:E93A 38          SEC                    ;|
$8F:E93B E9 04 00    SBC #$0004             ;} Layer 1 X position -= 4
$8F:E93E 8D 11 09    STA $0911  [$7E:0911]  ;/
$8F:E941 60          RTS                    ; Return

; BRANCH_BEHIND_WALL_RUMBLING
$8F:E942 AD 15 09    LDA $0915  [$7E:0915]  ;\
$8F:E945 18          CLC                    ;|
$8F:E946 6D 1F 09    ADC $091F  [$7E:091F]  ;|
$8F:E949 18          CLC                    ;} BG1 Y scroll = [layer 1 Y position] + [BG1 Y scroll offset] + [Crocomire rumbling Y offset]
$8F:E94A 6D EE 0F    ADC $0FEE  [$7E:0FEE]  ;|
$8F:E94D 85 B3       STA $B3    [$7E:00B3]  ;/
$8F:E94F 60          RTS
}


;;; $E950: Main ASM - Ridley's room shaking ;;;
{
; Room $B32E. Ridley

; Scrolls background in circle when Ridley's tail explosion sets $10A8 (when? Doesn't seem to ever happen)
; It's actually probably a good thing if this never happens, messing with the BG scroll registers can break scrolling
$8F:E950 AD A8 10    LDA $10A8  [$7E:10A8]  ;\
$8F:E953 F0 25       BEQ $25    [$E97A]     ;} If [$10A8] = 0: return
$8F:E955 3A          DEC A                  ;\
$8F:E956 8D A8 10    STA $10A8  [$7E:10A8]  ;} Decrement $10A8
$8F:E959 0A          ASL A                  ;\
$8F:E95A AA          TAX                    ;} X = [$10A8] * 2
$8F:E95B A5 B1       LDA $B1    [$7E:00B1]  ;\
$8F:E95D 7D 7B E9    ADC $E97B,x            ;} BG1 X scroll += [$E97B + [X]]
$8F:E960 85 B1       STA $B1    [$7E:00B1]  ;/
$8F:E962 A5 B5       LDA $B5    [$7E:00B5]  ;\
$8F:E964 18          CLC                    ;|
$8F:E965 7D 7B E9    ADC $E97B,x            ;} BG2 X scroll += [$E97B + [X]]
$8F:E968 85 B5       STA $B5    [$7E:00B5]  ;/
$8F:E96A A5 B3       LDA $B3    [$7E:00B3]  ;\
$8F:E96C 18          CLC                    ;|
$8F:E96D 7D 8B E9    ADC $E98B,x            ;} BG1 Y scroll += [$E98B + [X]]
$8F:E970 85 B3       STA $B3    [$7E:00B3]  ;/
$8F:E972 A5 B7       LDA $B7    [$7E:00B7]  ;\
$8F:E974 18          CLC                    ;|
$8F:E975 7D 8B E9    ADC $E98B,x            ;} BG2 Y scroll += [$E98B + [X]]
$8F:E978 85 B7       STA $B7    [$7E:00B7]  ;/

$8F:E97A 60          RTS

; X scroll speeds
$8F:E97B             dw 0000, 0002, 0002, 0002, 0000, FFFE, FFFE, FFFE

; Y scroll speeds
$8F:E98B             dw FFFE, FFFE, 0000, 0002, 0002, 0002, 0000, FFFE
}
}


;;; $E99B: Free space ;;;
{
$8F:E99B             fillto $908000, $FF
}
