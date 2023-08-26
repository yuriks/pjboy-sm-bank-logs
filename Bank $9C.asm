;;; $8000..961F: Samus top tiles - set Ah (morph ball, spin jump, screw attack sparks) ;;;
{
;;; $8000: Samus top tiles - set Ah - entry 0 ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 0
; 1Eh: Moving right - morph ball - no springball - on ground - frame 0
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 7
; 31h: Facing right - morph ball - no springball - in air - frame 0
; 32h: Facing left  - morph ball - no springball - in air - frame 0
; 3Fh: Unused - frame 0
; 40h: Unused - frame 0
; 41h: Facing left  - morph ball - no springball - on ground - frame 7
; 79h: Facing right - morph ball - spring ball - on ground - frame 0
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 7
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 0
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 7
; 7Dh: Facing right - morph ball - spring ball - falling - frame 0
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 7
; 7Fh: Facing right - morph ball - spring ball - in air - frame 0
; 80h: Facing left  - morph ball - spring ball - in air - frame 7
; C5h: Unused - frame 7
; D7h: Facing right - crystal flash ending - frame 0
; DFh: Unused. Related to Draygon - frame 7
; E8h: Facing right - Samus drained - crouching/falling - frame 0
; |--------|--------|--------|
; |     BBB|BBB     |        |
; |   BBBAA|AABBB   |        |
; |  BBAAA2|2AAABB  |        |
; | BBAAA22|22AABBB |   A6A  |
; | B3AA222|22AAABB |   666  |
; |BBAB2222|2AAAABB3|   A6A  |
; |BAA2BB2A|AAAAB33B|        |
; |BA222BBB|ABBBABBB|        |
; |--------|--------|--------|
; |BA2222AB|BAAAABBB|
; |BAA22AAA|BAAABBBB|
; |BBAAAAAA|BAAABBBB|
; | BAAAAAB|AAABBBB |
; | BBBAAAB|ABBBBBB |
; |  BBBBB3|BBBBBB  |
; |   BBBB3|BBBBB   |
; |     BB3|BBB     |
; |--------|--------|
$9C:8000             db 07,07,1C,1F,30,3F,60,7F,60,7F,D0,FF,8C,FF,87,FF,00,07,00,1F,00,3E,00,7C,00,58,00,F0,00,ED,00,C7,
                        E0,E0,38,F8,0C,FC,0E,FE,06,FE,07,FF,0F,FF,77,FF,00,E0,00,F8,00,7C,00,3E,00,3E,00,7E,00,F9,00,FF,
                        00,00,00,00,00,00,00,1C,00,1C,00,1C,00,00,00,00,00,00,00,00,00,00,08,14,1C,00,08,14,00,00,00,00,
                        81,FF,80,FF,C0,FF,41,7F,71,7F,3F,3F,1F,1F,07,07,00,C3,00,E7,00,FF,00,7F,00,7F,00,3E,00,1E,00,06,
                        87,FF,8F,FF,8F,FF,1E,FE,7E,FE,FC,FC,F8,F8,E0,E0,00,FF,00,FF,00,FF,00,FE,00,FE,00,FC,00,F8,00,E0,
}


;;; $80A0: Samus top tiles - set Ah - entry 1 ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 2
; 1Eh: Moving right - morph ball - no springball - on ground - frame 2
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 5
; 31h: Facing right - morph ball - no springball - in air - frame 2
; 32h: Facing left  - morph ball - no springball - in air - frame 2
; 3Fh: Unused - frame 2
; 40h: Unused - frame 2
; 41h: Facing left  - morph ball - no springball - on ground - frame 5
; 79h: Facing right - morph ball - spring ball - on ground - frame 2
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 5
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 2
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 5
; 7Dh: Facing right - morph ball - spring ball - falling - frame 2
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 5
; 7Fh: Facing right - morph ball - spring ball - in air - frame 2
; 80h: Facing left  - morph ball - spring ball - in air - frame 5
; C5h: Unused - frame 5
; DFh: Unused. Related to Draygon - frame 5
; |--------|--------|--------|
; |     BBB|BBB     |        |
; |   BBBAA|AABBB   |        |
; |  BBAAA2|2AAABB  |        |
; | BBAAA22|22AABBB |   A6A  |
; | B3AA222|22AAABB |   666  |
; |BBAB2222|2AAAABB3|   A6A  |
; |BAA2BB2A|AAAAB33B|        |
; |BA222BBB|ABBBABBB|        |
; |--------|--------|--------|
; |BA2222AB|BAAAABBB|
; |BAA22AAA|BAAABBBB|
; |BBAAAAAA|BAAABBBB|
; | BAAAAAB|AAABBBB |
; | BBBAAAB|ABBBBBB |
; |  BBBBB3|BBBBBB  |
; |   BBBB3|BBBBB   |
; |     BB3|BBB     |
; |--------|--------|
$9C:80A0             db 07,07,1C,1F,30,3F,60,7F,60,7F,D0,FF,8C,FF,87,FF,00,07,00,1F,00,3E,00,7C,00,58,00,F0,00,ED,00,C7,
                        E0,E0,38,F8,0C,FC,0E,FE,06,FE,07,FF,0F,FF,77,FF,00,E0,00,F8,00,7C,00,3E,00,3E,00,7E,00,F9,00,FF,
                        00,00,00,00,00,00,00,1C,00,1C,00,1C,00,00,00,00,00,00,00,00,00,00,08,14,1C,00,08,14,00,00,00,00,
                        81,FF,80,FF,C0,FF,41,7F,71,7F,3F,3F,1F,1F,07,07,00,C3,00,E7,00,FF,00,7F,00,7F,00,3E,00,1E,00,06,
                        87,FF,8F,FF,8F,FF,1E,FE,7E,FE,FC,FC,F8,F8,E0,E0,00,FF,00,FF,00,FF,00,FE,00,FE,00,FC,00,F8,00,E0,
}


;;; $8140: Samus top tiles - set Ah - entry 2 ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 4
; 1Eh: Moving right - morph ball - no springball - on ground - frame 4
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 3
; 31h: Facing right - morph ball - no springball - in air - frame 4
; 32h: Facing left  - morph ball - no springball - in air - frame 4
; 3Fh: Unused - frame 4
; 40h: Unused - frame 4
; 41h: Facing left  - morph ball - no springball - on ground - frame 3
; 79h: Facing right - morph ball - spring ball - on ground - frame 4
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 3
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 4
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 3
; 7Dh: Facing right - morph ball - spring ball - falling - frame 4
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 3
; 7Fh: Facing right - morph ball - spring ball - in air - frame 4
; 80h: Facing left  - morph ball - spring ball - in air - frame 3
; C5h: Unused - frame 3
; DFh: Unused. Related to Draygon - frame 3
; |--------|--------|--------|
; |     BBB|BBB     |        |
; |   BBBAA|AABBB   |        |
; |  BBAAA2|2AAABB  |        |
; | BBAAA22|22AABBB |   A6A  |
; | B3AA222|22AAABB |   666  |
; |BBAB2222|2AAAABB3|   A6A  |
; |BAA2BB2A|AAAAB33B|        |
; |BA222BBB|ABBBABBB|        |
; |--------|--------|--------|
; |BA2222AB|BAAAABBB|
; |BAA22AAA|BAAABBBB|
; |BBAAAAAA|BAAABBBB|
; | BAAAAAB|AAABBBB |
; | BBBAAAB|ABBBBBB |
; |  BBBBB3|BBBBBB  |
; |   BBBB3|BBBBB   |
; |     BB3|BBB     |
; |--------|--------|
$9C:8140             db 07,07,1C,1F,30,3F,60,7F,60,7F,D0,FF,8C,FF,87,FF,00,07,00,1F,00,3E,00,7C,00,58,00,F0,00,ED,00,C7,
                        E0,E0,38,F8,0C,FC,0E,FE,06,FE,07,FF,0F,FF,77,FF,00,E0,00,F8,00,7C,00,3E,00,3E,00,7E,00,F9,00,FF,
                        00,00,00,00,00,00,00,1C,00,1C,00,1C,00,00,00,00,00,00,00,00,00,00,08,14,1C,00,08,14,00,00,00,00,
                        81,FF,80,FF,C0,FF,41,7F,71,7F,3F,3F,1F,1F,07,07,00,C3,00,E7,00,FF,00,7F,00,7F,00,3E,00,1E,00,06,
                        87,FF,8F,FF,8F,FF,1E,FE,7E,FE,FC,FC,F8,F8,E0,E0,00,FF,00,FF,00,FF,00,FE,00,FE,00,FC,00,F8,00,E0,
}


;;; $81E0: Samus top tiles - set Ah - entry 3 ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 6
; 1Eh: Moving right - morph ball - no springball - on ground - frame 6
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 1
; 31h: Facing right - morph ball - no springball - in air - frame 6
; 32h: Facing left  - morph ball - no springball - in air - frame 6
; 3Fh: Unused - frame 6
; 40h: Unused - frame 6
; 41h: Facing left  - morph ball - no springball - on ground - frame 1
; 79h: Facing right - morph ball - spring ball - on ground - frame 6
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 1
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 6
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 1
; 7Dh: Facing right - morph ball - spring ball - falling - frame 6
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 1
; 7Fh: Facing right - morph ball - spring ball - in air - frame 6
; 80h: Facing left  - morph ball - spring ball - in air - frame 1
; C5h: Unused - frame 1
; DFh: Unused. Related to Draygon - frame 1
; |--------|--------|--------|
; |     BBB|BBB     |        |
; |   BBBAA|AABBB   |        |
; |  BBAAA2|2AAABB  |        |
; | BBAAA22|22AABBB |   A6A  |
; | B3AA222|22AAABB |   666  |
; |BBAB2222|2AAAABB3|   A6A  |
; |BAA2BB2A|AAAAB33B|        |
; |BA222BBB|ABBBABBB|        |
; |--------|--------|--------|
; |BA2222AB|BAAAABBB|
; |BAA22AAA|BAAABBBB|
; |BBAAAAAA|BAAABBBB|
; | BAAAAAB|AAABBBB |
; | BBBAAAB|ABBBBBB |
; |  BBBBB3|BBBBBB  |
; |   BBBB3|BBBBB   |
; |     BB3|BBB     |
; |--------|--------|
$9C:81E0             db 07,07,1C,1F,30,3F,60,7F,60,7F,D0,FF,8C,FF,87,FF,00,07,00,1F,00,3E,00,7C,00,58,00,F0,00,ED,00,C7,
                        E0,E0,38,F8,0C,FC,0E,FE,06,FE,07,FF,0F,FF,77,FF,00,E0,00,F8,00,7C,00,3E,00,3E,00,7E,00,F9,00,FF,
                        00,00,00,00,00,00,00,1C,00,1C,00,1C,00,00,00,00,00,00,00,00,00,00,08,14,1C,00,08,14,00,00,00,00,
                        81,FF,80,FF,C0,FF,41,7F,71,7F,3F,3F,1F,1F,07,07,00,C3,00,E7,00,FF,00,7F,00,7F,00,3E,00,1E,00,06,
                        87,FF,8F,FF,8F,FF,1E,FE,7E,FE,FC,FC,F8,F8,E0,E0,00,FF,00,FF,00,FF,00,FE,00,FE,00,FC,00,F8,00,E0,
}


;;; $8280: Samus top tiles - set Ah - entry 4 ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 1
; 1Eh: Moving right - morph ball - no springball - on ground - frame 1
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 6
; 31h: Facing right - morph ball - no springball - in air - frame 1
; 32h: Facing left  - morph ball - no springball - in air - frame 1
; 3Fh: Unused - frame 1
; 40h: Unused - frame 1
; 41h: Facing left  - morph ball - no springball - on ground - frame 6
; 79h: Facing right - morph ball - spring ball - on ground - frame 1
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 6
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 1
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 6
; 7Dh: Facing right - morph ball - spring ball - falling - frame 1
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 6
; 7Fh: Facing right - morph ball - spring ball - in air - frame 1
; 80h: Facing left  - morph ball - spring ball - in air - frame 6
; C5h: Unused - frame 6
; DFh: Unused. Related to Draygon - frame 6
; |--------|--------|--------|--------|--------|
; |        |BBBAAABB|BBAAAAAB|3BB     |     BBB|
; |        |AAABBBBB|BBBAAABA|3ABBB   |   BBBAA|
; |        |AAAAAB33|BBBABBAA|BAAABB  |  BBAAAA|
; |   A6A  |AAAABBB | B33BAAA|A222ABB | BBA2222|
; |   666  |AABBBBB | 3BBBBAA|B2222AB | BA22222|
; |   A6A  |BBBBBB  |  BBBBBB|A222AABB|BBAA2222|
; |        |BBBBB   |   BBBBB|BAAAAABB|BBAAAAAA|
; |        |BBB     |     BBB|BAAAAABB|BBAAAAAA|
; |--------|--------|--------|--------|--------|
$9C:8280             db 00,00,00,00,00,00,00,1C,00,1C,00,1C,00,00,00,00,00,00,00,00,00,00,08,14,1C,00,08,14,00,00,00,00,
                        E3,FF,1F,FF,07,FF,0E,FE,3E,FE,FC,FC,F8,F8,E0,E0,00,FF,00,FF,00,FC,00,FE,00,FE,00,FC,00,F8,00,E0,
                        C1,FF,E2,FF,EC,FF,78,7F,7C,7F,3F,3F,1F,1F,07,07,00,FF,00,FF,00,FF,00,4F,00,3F,00,3F,00,1F,00,07,
                        E0,E0,B8,F8,8C,FC,06,FE,82,FE,03,FF,83,FF,83,FF,00,60,00,78,00,FC,00,8E,00,86,00,8F,00,FF,00,FF,
                        07,07,1C,1F,30,3F,60,7F,40,7F,C0,FF,C0,FF,C0,FF,00,07,00,1F,00,3F,00,70,00,60,00,F0,00,FF,00,FF,
}


;;; $8320: Samus top tiles - set Ah - entry 5 ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 3
; 1Eh: Moving right - morph ball - no springball - on ground - frame 3
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 4
; 31h: Facing right - morph ball - no springball - in air - frame 3
; 32h: Facing left  - morph ball - no springball - in air - frame 3
; 3Fh: Unused - frame 3
; 40h: Unused - frame 3
; 41h: Facing left  - morph ball - no springball - on ground - frame 4
; 79h: Facing right - morph ball - spring ball - on ground - frame 3
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 4
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 3
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 4
; 7Dh: Facing right - morph ball - spring ball - falling - frame 3
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 4
; 7Fh: Facing right - morph ball - spring ball - in air - frame 3
; 80h: Facing left  - morph ball - spring ball - in air - frame 4
; C5h: Unused - frame 4
; DFh: Unused. Related to Draygon - frame 4
; |--------|--------|--------|
; |     BBB|BBB     |        |
; |   3BBBB|BBBBB   |        |
; |  BB3BBA|AAAABB  |        |
; | BBB3AAA|AAA2ABB |   A6A  |
; | BBBBBAA|AA222AB |   666  |
; |BBBBABAA|AA222ABB|   A6A  |
; |BBBAAABA|AA222AAB|        |
; |BBBAAAAB|AA222AAB|        |
; |--------|--------|--------|
; |BBBAAAAB|BBABAB33|
; |BBBAAAAB|AA222AAB|
; |BBBBAAAB|AA222ABB|
; | BBBAABA|AA222AB |
; | BBBBABA|AAA2ABB |
; |  BBBB3A|AAAABB  |
; |   BB3BB|BBBBB   |
; |     BBB|BBB     |
; |--------|--------|
$9C:8320             db 07,07,1F,1F,3E,3F,78,7F,7C,7F,F4,FF,E2,FF,E1,FF,00,07,00,0F,00,37,00,77,00,7F,00,FF,00,FF,00,FF,
                        E0,E0,F8,F8,0C,FC,06,FE,02,FE,03,FF,01,FF,01,FF,00,E0,00,F8,00,FC,00,EE,00,C6,00,C7,00,C7,00,C7,
                        00,00,00,00,00,00,00,1C,00,1C,00,1C,00,00,00,00,00,00,00,00,00,00,08,14,1C,00,08,14,00,00,00,00,
                        E1,FF,E1,FF,F1,FF,72,7F,7A,7F,3E,3F,1F,1F,07,07,00,FF,00,FF,00,FF,00,7F,00,7F,00,3D,00,1B,00,07,
                        D7,FF,01,FF,03,FF,02,FE,06,FE,0C,FC,F8,F8,E0,E0,00,FC,00,C7,00,C7,00,C6,00,EE,00,FC,00,F8,00,E0,
}


;;; $83C0: Samus top tiles - set Ah - entry 6 ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 5
; 1Eh: Moving right - morph ball - no springball - on ground - frame 5
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 2
; 31h: Facing right - morph ball - no springball - in air - frame 5
; 32h: Facing left  - morph ball - no springball - in air - frame 5
; 3Fh: Unused - frame 5
; 40h: Unused - frame 5
; 41h: Facing left  - morph ball - no springball - on ground - frame 2
; 79h: Facing right - morph ball - spring ball - on ground - frame 5
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 2
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 5
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 2
; 7Dh: Facing right - morph ball - spring ball - falling - frame 5
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 2
; 7Fh: Facing right - morph ball - spring ball - in air - frame 5
; 80h: Facing left  - morph ball - spring ball - in air - frame 2
; C5h: Unused - frame 2
; DFh: Unused. Related to Draygon - frame 2
; |--------|--------|--------|
; |     BBB|3BB     |        |
; |   BBBAA|3ABBB   |        |
; |  BBAAAA|BAAABB  |        |
; | BBA2222|A222ABB |   A6A  |
; | BA22222|B2222AB |   666  |
; |BBAA2222|A222AABB|   A6A  |
; |BBAAAAAA|BAAAAABB|        |
; |BBAAAAAA|BAAAAABB|        |
; |--------|--------|--------|
; |BBAAAAAB|BBBAAABB|
; |BBBAAABA|AAABBBBB|
; |BBBABBAA|AAAAAB33|
; | B33BAAA|AAAABBB |
; | 3BBBBAA|AABBBBB |
; |  BBBBBB|BBBBBB  |
; |   BBBBB|BBBBB   |
; |     BBB|BBB     |
; |--------|--------|
$9C:83C0             db 07,07,1C,1F,30,3F,60,7F,40,7F,C0,FF,C0,FF,C0,FF,00,07,00,1F,00,3F,00,70,00,60,00,F0,00,FF,00,FF,
                        E0,E0,B8,F8,8C,FC,06,FE,82,FE,03,FF,83,FF,83,FF,00,60,00,78,00,FC,00,8E,00,86,00,8F,00,FF,00,FF,
                        00,00,00,00,00,00,00,1C,00,1C,00,1C,00,00,00,00,00,00,00,00,00,00,08,14,1C,00,08,14,00,00,00,00,
                        C1,FF,E2,FF,EC,FF,78,7F,7C,7F,3F,3F,1F,1F,07,07,00,FF,00,FF,00,FF,00,4F,00,3F,00,3F,00,1F,00,07,
                        E3,FF,1F,FF,07,FF,0E,FE,3E,FE,FC,FC,F8,F8,E0,E0,00,FF,00,FF,00,FC,00,FE,00,FE,00,FC,00,F8,00,E0,
}


;;; $8460: Samus top tiles - set Ah - entry 7 ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 7
; 1Eh: Moving right - morph ball - no springball - on ground - frame 7
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 0
; 31h: Facing right - morph ball - no springball - in air - frame 7
; 32h: Facing left  - morph ball - no springball - in air - frame 7
; 3Fh: Unused - frame 7
; 40h: Unused - frame 7
; 41h: Facing left  - morph ball - no springball - on ground - frame 0
; 79h: Facing right - morph ball - spring ball - on ground - frame 7
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 0
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 7
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 0
; 7Dh: Facing right - morph ball - spring ball - falling - frame 7
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 0
; 7Fh: Facing right - morph ball - spring ball - in air - frame 7
; 80h: Facing left  - morph ball - spring ball - in air - frame 0
; C5h: Unused - frame 0
; DFh: Unused. Related to Draygon - frame 0
; |--------|--------|--------|
; |     BBB|BBB     |        |
; |   3BBBB|BBBBB   |        |
; |  BB3BBA|AAAABB  |        |
; | BBB3AAA|AAA2ABB |   A6A  |
; | BBBBBAA|AA222AB |   666  |
; |BBBBABAA|AA222ABB|   A6A  |
; |BBBAAABA|AA222AAB|        |
; |BBBAAAAB|AA222AAB|        |
; |--------|--------|--------|
; |BBBAAAAB|BBABAB33|
; |BBBAAAAB|AA222AAB|
; |BBBBAAAB|AA222ABB|
; | BBBAABA|AA222AB |
; | BBBBABA|AAA2ABB |
; |  BBBB3A|AAAABB  |
; |   BB3BB|BBBBB   |
; |     BBB|BBB     |
; |--------|--------|
$9C:8460             db 07,07,1F,1F,3E,3F,78,7F,7C,7F,F4,FF,E2,FF,E1,FF,00,07,00,0F,00,37,00,77,00,7F,00,FF,00,FF,00,FF,
                        E0,E0,F8,F8,0C,FC,06,FE,02,FE,03,FF,01,FF,01,FF,00,E0,00,F8,00,FC,00,EE,00,C6,00,C7,00,C7,00,C7,
                        00,00,00,00,00,00,00,1C,00,1C,00,1C,00,00,00,00,00,00,00,00,00,00,08,14,1C,00,08,14,00,00,00,00,
                        E1,FF,E1,FF,F1,FF,72,7F,7A,7F,3E,3F,1F,1F,07,07,00,FF,00,FF,00,FF,00,7F,00,7F,00,3D,00,1B,00,07,
                        D7,FF,01,FF,03,FF,02,FE,06,FE,0C,FC,F8,F8,E0,E0,00,FC,00,C7,00,C7,00,C6,00,EE,00,FC,00,F8,00,E0,
}


;;; $8500: Samus top tiles - set Ah - entry 8 ;;;
{
; 19h: Facing right - spin jump - frame 1
; 1Ah: Facing left  - spin jump - frame 1
; 20h: Unused - frame 1
; 21h: Unused - frame 1
; 22h: Unused - frame 1
; 23h: Unused - frame 1
; 24h: Unused - frame 1
; 33h: Unused - frame 1
; 34h: Unused - frame 1
; 39h: Unused - frame 1
; 3Ah: Unused - frame 1
; 42h: Unused - frame 1
; 83h: Facing right - wall jump - frame 3
; 84h: Facing left  - wall jump - frame 3
; |--------|--------|--------|--------|
; |2BF333BB|BB31CC13|     333|333     |
; |AA3BB33A|23331C13|   33FFF|F3FF3   |
; |B3B62B3B|3BB3313 | 3FF9EE3|3333F3  |
; |33A2ABB3|BAABB33 |3FE96F33|BBB33F3 |
; |A3BABB3B|22ABAB33|3FE9EF3B|2B2BB333|
; |A23B33BA|2BA62AB3|3FEEF3B6|A22BAB3F|
; |BA33B33B|AA222AB3|FFF333A2|B2A2AB33|
; |33322A33|BA22AAB3|E93437AA|BAB2AB3F|
; |--------|--------|--------|--------|
; |  3BAB33|3BAABB33|994435BB|BABAAB3E|
; |  23BBB3|33BBB33 |3F437333|3BBABB3E|
; |  3233B2|B33333  |34433358|75BBB33F|
; |  3ABB3A|A333    | 33EF333|5785D3F3|
; | 3B3AABB|33      | F3333AB|33333F38|
; |3BA22B33|        | E9EF3A2|22ABE387|
; |333333  |        |33EF1B22|62AB3313|
; |        |        |B3F13BA2|2AB31113|
; |--------|--------|--------|--------|
$9C:8500             db 7F,FF,3E,FF,E7,FF,C7,FF,6F,FF,3E,FF,BF,FF,E3,FF,20,63,00,D9,10,A5,00,2E,00,BD,00,93,00,C9,00,04,
                        F3,E1,7B,F1,FE,FA,9E,FE,17,FF,43,FF,03,FF,83,FF,0C,CC,04,04,00,60,00,F8,00,3C,10,66,00,C6,00,CE,
                        07,07,1F,1F,79,77,D7,EF,D7,EF,CE,FF,FC,FF,6C,AF,00,00,07,07,36,3E,6C,74,6C,7D,79,7A,E0,E2,94,C3,
                        E0,E0,F8,F8,FC,FC,FE,FE,5F,FF,17,FF,87,FF,A7,FF,00,00,B0,B0,08,08,04,E4,00,58,01,9D,00,AC,01,ED,
                        37,3F,1F,3F,2E,3F,2E,3F,73,7F,C7,FF,FC,FC,00,00,00,1C,00,0E,00,02,00,1D,00,2F,00,64,00,00,00,00,
                        CF,FF,FE,FE,FC,FC,70,F0,C0,C0,00,00,00,00,00,00,00,7C,00,38,00,80,00,80,00,00,00,00,00,00,00,00,
                        CF,0B,DF,DF,9E,9C,6F,7F,7D,7F,2C,5F,DC,F7,FC,EF,34,C3,68,40,62,01,18,18,40,43,58,7A,30,34,20,A6,
                        A6,FF,EE,FF,FF,BF,DF,47,FE,FE,15,FD,1F,FD,3F,F1,01,FD,01,7D,C1,39,DA,2A,04,05,09,3A,80,30,00,60,
}


;;; $8600: Samus top tiles - set Ah - entry 9 ;;;
{
; 19h: Facing right - spin jump - frame 2
; 1Ah: Facing left  - spin jump - frame 2
; 20h: Unused - frame 2
; 21h: Unused - frame 2
; 22h: Unused - frame 2
; 23h: Unused - frame 2
; 24h: Unused - frame 2
; 33h: Unused - frame 2
; 34h: Unused - frame 2
; 39h: Unused - frame 2
; 3Ah: Unused - frame 2
; 42h: Unused - frame 2
; 4Fh: Facing left  - damage boost - frame 8
; 50h: Facing right - damage boost - frame 8
; 83h: Facing right - wall jump - frame 4
; 84h: Facing left  - wall jump - frame 4
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |      FF|33FEE3BB|BA33BAA6|2AB3    |        |        |
; |        |        |        | 3E9F333|3323B2A2|2AB3    |        |        |
; |33      |        |        |  3EF33B|BA33B2B2|ABB3    |        | F33333F|
; |FE33    |        |        |  333BB6|2AB3BBBB|BB33    |       3|333BBB33|
; |FEEF3   |        |        |   22AB6|2AB33333|333     |      FF|3BBBAAB3|
; |3FEF35  |        |        |    AB3A|AB3ABBBB|333     |     FF3|BB2B2AAB|
; |B3F357  |        |        |     333|33B2AAB3|3B3     |    33E3|BB2AA2AA|
; |B33333  |        |        |     3A2|A3BAABB3|A23     |    3EF3|BAB2BBAB|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |DD33113 |        |        |      3B|3  3333B|BB3     |   3F9F3|B2BBABBB|
; |53331C33|        |        |        |   A222A|B3      |   3E6E3|B6ABBBB8|
; |33311CC3|        |        |        |    3BB2|B3      |   3F9FF|3BBB3778|
; |BB3311C3|3       |        |        |      B2|3       |   3FE33|33BD8553|
; |AB333133|3       |        |        |     3AB|3       |   33F34|3733D332|
; |6BB33333|333     |        |        |     333|        |   3FFE4|437F3B22|
; |ABB333BA|BB33    |        |        |        |        |    39F3|433333A2|
; |AAB3BAB2|2AB3    |        |        |        |        |    3F9E|443FB3BA|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:8600             db 00,00,00,00,C0,C0,B0,F0,98,F8,DC,F8,FC,F4,FC,FC,00,00,00,00,00,00,C0,C0,F0,F0,74,70,2C,A0,00,80,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        E7,FF,5F,6F,2F,3F,3E,3F,02,1F,06,0F,07,07,04,07,38,3B,28,38,18,19,01,06,01,06,00,0D,00,00,00,02,
                        B8,FF,D8,FF,BA,FF,3F,FF,3F,FF,6F,FF,E3,FF,67,FF,01,CE,00,0A,00,CA,00,6F,00,60,00,DF,00,2E,00,BE,
                        30,F0,30,F0,70,F0,F0,F0,E0,E0,E0,E0,E0,E0,20,E0,00,60,00,60,00,E0,00,C0,00,00,00,00,00,40,00,80,
                        00,00,00,00,00,00,01,01,03,03,07,07,0D,0F,0B,0F,00,00,00,00,00,00,00,00,03,03,06,06,02,02,06,06,
                        00,00,00,00,7F,7F,FF,FF,F3,FF,D1,FF,C0,FF,AD,FF,00,00,00,00,41,41,00,1C,00,7E,00,D7,00,DB,00,EF,
                        FE,32,FB,73,F9,E1,FD,F1,7F,FB,7F,FF,7E,FF,3A,FF,C0,C0,84,04,06,06,02,C2,00,C0,80,60,00,E3,00,EE,
                        00,00,00,00,00,00,80,80,80,80,E0,E0,F0,F0,30,F0,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,60,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        9F,9F,00,1F,0E,0F,02,03,05,07,07,07,00,00,00,00,00,01,00,11,00,06,00,02,00,03,00,00,00,00,00,00,
                        E0,E0,C0,C0,C0,C0,80,80,80,80,00,00,00,00,00,00,00,C0,00,80,00,80,00,00,00,00,00,00,00,00,00,00,
                        1F,1B,11,1F,1F,1B,1B,1F,1E,1E,1C,1E,0F,0B,0E,0D,0A,0E,0E,0A,0B,0F,0C,0C,05,04,0F,0E,02,06,05,07,
                        B7,FF,9E,FE,FE,FE,F7,E1,FE,F7,7C,7F,7C,7F,3E,3F,00,BF,40,BF,06,71,16,38,48,08,B0,14,80,02,D0,1B,
}


;;; $8800: Samus top tiles - set Ah - entry Ah ;;;
{
; 19h: Facing right - spin jump - frame 3
; 1Ah: Facing left  - spin jump - frame 3
; 20h: Unused - frame 3
; 21h: Unused - frame 3
; 22h: Unused - frame 3
; 23h: Unused - frame 3
; 24h: Unused - frame 3
; 33h: Unused - frame 3
; 34h: Unused - frame 3
; 39h: Unused - frame 3
; 3Ah: Unused - frame 3
; 42h: Unused - frame 3
; 4Fh: Facing left  - damage boost - frame 7
; 50h: Facing right - damage boost - frame 7
; 83h: Facing right - wall jump - frame 5
; 84h: Facing left  - wall jump - frame 5
; |--------|--------|--------|--------|
; |33  3333|3       |    3F3F|EEF38733|
; |11333BBB|33      |   33333|333F3811|
; |CC13BAAA|B33     |  3F3BBB|BB33F331|
; |C13BA22A|BB3     | 3F3BAAA|ABBD3E31|
; |133BB622|AB33    | F33BB22|AAB53BB3|
; |33BAAA22|AB33    |3F3B22AB|BBB83AAB|
; |B3BA2BAA|B3333   |333BB22A|AB57322A|
; |B23B22AB|33BA3   |3F3B2ABB|B3753262|
; |--------|--------|--------|--------|
; |BAB3BAB3|332AB3  |3F33B62A|B383B222|
; |B33B3B33|3BB3B3  |3FE33BAA|B353AA2A|
; |33BBB33A|BB3BAB3 |3FEFF337|533333BB|
; |3B2AB3B2|AB3BA23 | 396EF33|373F3F13|
; |3B62AB32|B32A323 | 3F99E34|433E3EF1|
; |F3BAB333|3233BA3 |  FEEEF3|444339EF|
; |BA3332A3|    3B3 |  3FFFF9|9F43FE33|
; |2AB3AAB3|     33 |   333FE|933   3B|
; |--------|--------|--------|--------|
$9C:8800             db CF,CF,FF,3F,38,1F,70,3F,F8,7F,E0,FF,E4,FF,B1,FF,00,00,00,07,C0,CF,80,99,04,18,00,3C,00,B7,00,93,
                        80,80,C0,C0,E0,E0,E0,E0,70,F0,70,F0,F8,F8,E8,F8,00,00,00,00,00,80,00,C0,00,C0,00,C0,00,80,00,30,
                        0F,0F,1F,1F,3F,3F,78,7F,7C,7F,F1,FF,F8,FF,F3,FF,05,05,00,00,10,17,20,2F,40,4C,40,53,00,19,40,57,
                        37,F7,FB,F8,FF,FE,7B,EE,3F,EF,E9,EF,78,DF,F8,EF,E4,E8,10,14,08,C8,14,F4,10,E6,00,F7,30,C1,32,80,
                        BB,FF,FF,FF,FE,FF,CE,FF,C6,FF,EF,FF,B9,FF,33,FF,00,EE,00,94,00,39,00,5A,20,4C,80,B8,00,C2,00,6E,
                        CC,FC,FC,FC,F6,FE,72,FE,CA,FE,BA,FE,0E,0E,06,06,00,18,00,68,00,DC,00,D8,00,90,00,0C,00,04,00,00,
                        F8,FF,DC,FF,DF,FF,67,5F,7A,66,23,3F,3F,3E,1E,1F,44,49,60,67,79,78,1C,2C,25,3C,3E,3E,1E,1F,03,03,
                        D8,DF,F0,DF,FF,7F,FF,FD,6B,7E,1D,1B,DB,5F,E3,63,00,A8,20,8D,80,03,54,14,96,16,E3,07,6C,CC,00,81,
}


;;; $8900: Samus top tiles - set Ah - entry Bh ;;;
{
; 19h: Facing right - spin jump - frame 4
; 1Ah: Facing left  - spin jump - frame 4
; 20h: Unused - frame 4
; 21h: Unused - frame 4
; 22h: Unused - frame 4
; 23h: Unused - frame 4
; 24h: Unused - frame 4
; 33h: Unused - frame 4
; 34h: Unused - frame 4
; 39h: Unused - frame 4
; 3Ah: Unused - frame 4
; 42h: Unused - frame 4
; 4Fh: Facing left  - damage boost - frame 6
; 50h: Facing right - damage boost - frame 6
; 83h: Facing right - wall jump - frame 6
; 84h: Facing left  - wall jump - frame 6
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |BA222388|BBAB333 |        |        |        |B23A66B3|
; |        |        |BAA6AB35|DBB3FE3 |        |        |        |3A3A22B3|
; |        |        |AABBBB33|D33FEE  |        |        |        | 33BAAA3|
; |        |        |3BBB3333|33FEEF  |        |        |        | BB3BB32|
; |        |        |33333113|33FFF3  |   33333|3       |       A|3A2A3333|
; |        |        |BB331111|3D833   | 33F3FFE|F33     |      32|3AAB3BBB|
; |        |        |AA3311C1|3873    | F9FFE96|9E3F    |   33 B2|3BAB3B22|
; |        |        |ABB3CC33|3       |F9FE33FE|FFEFF   |   3ABBA|3BBB3BBA|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |6AA3333 |        |FE3443F3|3333F3  |   3B22A|B3B33B22|
; |        |        |22B33   |        |F444333B|BBBB33  |    33BB|BA333BA2|
; |        |       3|ABB3    |        |343373B6|2ABBB3  |      33|B2B33BBA|
; |        |     33E|BB3     |        |33F73BBA|BB22B33 |        |333333BB|
; |        |    23E9|33      |        |333F3DBB|B2ABBB3 |        |     333|
; |        |   A23FF|        |        |EF33D83B|ABA2AB3 |        |        |
; |        | 33BAB33|        |        |333B357B|BB2AAB3 |        |        |
; |        |3A33BB33|        |        |BBA2357B|BAAAB33 |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:8900             db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        84,FC,87,FE,3F,FF,FF,FF,FF,F9,FF,F0,3D,F0,73,F3,00,C3,11,EC,00,FC,00,70,00,00,00,C0,02,C2,0C,EC,
                        DE,FE,FA,7E,F0,7C,E4,FC,FC,FC,D8,98,B0,B0,80,80,00,F0,8C,EC,9C,9C,3C,3C,38,38,40,60,20,40,00,00,
                        00,00,00,00,00,00,00,00,1F,1F,7E,7F,7A,5D,EE,BF,00,00,00,00,00,00,00,00,00,00,17,17,5D,7E,B3,F3,
                        00,00,00,00,00,00,00,00,80,80,E0,E0,B0,70,D8,F8,00,00,00,00,00,00,00,00,00,00,80,80,50,D0,F8,F8,
                        00,00,00,00,00,00,00,00,00,01,02,03,1A,1B,16,1F,00,00,00,00,00,00,00,00,00,01,00,00,00,02,00,0F,
                        A3,FF,A3,FF,71,7F,7E,7F,8F,FF,9F,FF,DC,FF,FE,FF,0C,92,00,52,00,1E,00,6C,00,50,00,77,00,74,00,77,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,06,07,05,0E,07,1F,77,7F,BF,FF,00,00,00,00,00,00,01,01,02,03,03,13,00,1C,00,4C,
                        1E,FE,38,F8,70,F0,E0,E0,C0,C0,00,00,00,00,00,00,80,60,00,20,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        A7,E7,8F,8F,BE,BF,FE,FF,FF,FB,7B,F3,FF,FB,CF,FB,DA,C2,F0,81,49,02,30,27,14,17,C8,CD,06,11,06,E1,
                        FC,FC,FC,FC,3C,FC,CE,FE,9E,FE,46,FE,C6,FE,8E,FE,08,08,00,F0,00,78,00,C8,00,BC,00,EC,00,DC,00,F8,
                        18,1F,0F,0F,03,03,00,00,00,00,00,00,00,00,00,00,00,09,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        FC,FF,BC,FF,BE,FF,FF,FF,07,07,00,00,00,00,00,00,00,A4,00,C6,00,A7,00,03,00,00,00,00,00,00,00,00,
}


;;; $8B00: Samus top tiles - set Ah - entry Ch ;;;
{
; 19h: Facing right - spin jump - frame 5
; 1Ah: Facing left  - spin jump - frame 5
; 20h: Unused - frame 5
; 21h: Unused - frame 5
; 22h: Unused - frame 5
; 23h: Unused - frame 5
; 24h: Unused - frame 5
; 33h: Unused - frame 5
; 34h: Unused - frame 5
; 39h: Unused - frame 5
; 3Ah: Unused - frame 5
; 42h: Unused - frame 5
; 4Fh: Facing left  - damage boost - frame 5
; 50h: Facing right - damage boost - frame 5
; 83h: Facing right - wall jump - frame 7
; 84h: Facing left  - wall jump - frame 7
; |--------|--------|--------|--------|
; |2BF333BB|BB31CC13|     333|333     |
; |AA3BB33A|23331C13|   33FFF|F3FF3   |
; |B3B62B3B|3BB3313 | 3FF9EE3|3333F3  |
; |33A2ABB3|BAABB33 |3FE96F33|BBB33F3 |
; |A3BABB3B|22ABAB33|3FE9EF3B|2B2BB333|
; |A23B33BA|2BA62AB3|3FEEF3B6|A22BAB3F|
; |BA33B33B|AA222AB3|FFF333A2|B2A2AB33|
; |33322A33|BA22AAB3|E93437AA|BAB2AB3F|
; |--------|--------|--------|--------|
; |  3BAB33|3BAABB33|994435BB|BABAAB3E|
; |  23BBB3|33BBB33 |3F437333|3BBABB3E|
; |  3233B2|B33333  |34433358|75BBB33F|
; |  3ABB3A|A333    | 33EF333|5785D3F3|
; | 3B3AABB|33      | F3333AB|33333F38|
; |3BA22B33|        | E9EF3A2|22ABE387|
; |333333  |        |33EF1B22|62AB3313|
; |        |        |B3F13BA2|2AB31113|
; |--------|--------|--------|--------|
$9C:8B00             db 7F,FF,3E,FF,E7,FF,C7,FF,6F,FF,3E,FF,BF,FF,E3,FF,20,63,00,D9,10,A5,00,2E,00,BD,00,93,00,C9,00,04,
                        F3,E1,7B,F1,FE,FA,9E,FE,17,FF,43,FF,03,FF,83,FF,0C,CC,04,04,00,60,00,F8,00,3C,10,66,00,C6,00,CE,
                        07,07,1F,1F,79,77,D7,EF,D7,EF,CE,FF,FC,FF,6C,AF,00,00,07,07,36,3E,6C,74,6C,7D,79,7A,E0,E2,94,C3,
                        E0,E0,F8,F8,FC,FC,FE,FE,5F,FF,17,FF,87,FF,A7,FF,00,00,B0,B0,08,08,04,E4,00,58,01,9D,00,AC,01,ED,
                        37,3F,1F,3F,2E,3F,2E,3F,73,7F,C7,FF,FC,FC,00,00,00,1C,00,0E,00,02,00,1D,00,2F,00,64,00,00,00,00,
                        CF,FF,FE,FE,FC,FC,70,F0,C0,C0,00,00,00,00,00,00,00,7C,00,38,00,80,00,80,00,00,00,00,00,00,00,00,
                        CF,0B,DF,DF,9E,9C,6F,7F,7D,7F,2C,5F,DC,F7,FC,EF,34,C3,68,40,62,01,18,18,40,43,58,7A,30,34,20,A6,
                        A6,FF,EE,FF,FF,BF,DF,47,FE,FE,15,FD,1F,FD,3F,F1,01,FD,01,7D,C1,39,DA,2A,04,05,09,3A,80,30,00,60,
}


;;; $8C00: Samus top tiles - set Ah - entry Dh ;;;
{
; 19h: Facing right - spin jump - frame 6
; 1Ah: Facing left  - spin jump - frame 6
; 20h: Unused - frame 6
; 21h: Unused - frame 6
; 22h: Unused - frame 6
; 23h: Unused - frame 6
; 24h: Unused - frame 6
; 33h: Unused - frame 6
; 34h: Unused - frame 6
; 39h: Unused - frame 6
; 3Ah: Unused - frame 6
; 42h: Unused - frame 6
; 4Fh: Facing left  - damage boost - frame 4
; 50h: Facing right - damage boost - frame 4
; 83h: Facing right - wall jump - frame 8
; 84h: Facing left  - wall jump - frame 8
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |      FF|33FEE3BB|        |        |BA33BAA6|2AB3    |
; |        |        |        | 3E9F333|        |        |3323B2A2|2AB3    |
; |33      |        |        |  3EF33B|        | F33333F|BA33B2B2|ABB3    |
; |FE33    |        |        |  333BB6|       3|333BBB33|2AB3BBBB|BB33    |
; |FEEF3   |        |        |   22AB6|      FF|3BBBAAB3|2AB33333|333     |
; |3FEF35  |        |        |    AB3A|     FF3|BB2B2AAB|AB3ABBBB|333     |
; |B3F357  |        |        |     333|    33E3|BB2AA2AA|33B2AAB3|3B3     |
; |B33333  |        |        |     3A2|    3EF3|BAB2BBAB|A3BAABB3|A23     |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |DD33113 |        |        |      3B|   3F9F3|B2BBABBB|3  3333B|BB3     |
; |53331C33|        |        |        |   3E6E3|B6ABBBB8|   A222A|B3      |
; |33311CC3|        |        |        |   3F9FF|3BBB3778|    3BB2|B3      |
; |BB3311C3|3       |        |        |   3FE33|33BD8553|      B2|3       |
; |AB333133|3       |        |        |   33F34|3733D332|     3AB|3       |
; |6BB33333|333     |        |        |   3FFE4|437F3B22|     333|        |
; |ABB333BA|BB33    |        |        |    39F3|433333A2|        |        |
; |AAB3BAB2|2AB3    |        |        |    3F9E|443FB3BA|        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:8C00             db 00,00,00,00,C0,C0,B0,F0,98,F8,DC,F8,FC,F4,FC,FC,00,00,00,00,00,00,C0,C0,F0,F0,74,70,2C,A0,00,80,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        E7,FF,5F,6F,2F,3F,3E,3F,02,1F,06,0F,07,07,04,07,38,3B,28,38,18,19,01,06,01,06,00,0D,00,00,00,02,
                        00,00,00,00,00,00,01,01,03,03,07,07,0D,0F,0B,0F,00,00,00,00,00,00,00,00,03,03,06,06,02,02,06,06,
                        00,00,00,00,7F,7F,FF,FF,F3,FF,D1,FF,C0,FF,AD,FF,00,00,00,00,41,41,00,1C,00,7E,00,D7,00,DB,00,EF,
                        B8,FF,D8,FF,BA,FF,3F,FF,3F,FF,6F,FF,E3,FF,67,FF,01,CE,00,0A,00,CA,00,6F,00,60,00,DF,00,2E,00,BE,
                        30,F0,30,F0,70,F0,F0,F0,E0,E0,E0,E0,E0,E0,20,E0,00,60,00,60,00,E0,00,C0,00,00,00,00,00,40,00,80,
                        FE,32,FB,73,F9,E1,FD,F1,7F,FB,7F,FF,7E,FF,3A,FF,C0,C0,84,04,06,06,02,C2,00,C0,80,60,00,E3,00,EE,
                        00,00,00,00,00,00,80,80,80,80,E0,E0,F0,F0,30,F0,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,60,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1F,1B,11,1F,1F,1B,1B,1F,1E,1E,1C,1E,0F,0B,0E,0D,0A,0E,0E,0A,0B,0F,0C,0C,05,04,0F,0E,02,06,05,07,
                        B7,FF,9E,FE,FE,FE,F7,E1,FE,F7,7C,7F,7C,7F,3E,3F,00,BF,40,BF,06,71,16,38,48,08,B0,14,80,02,D0,1B,
                        9F,9F,00,1F,0E,0F,02,03,05,07,07,07,00,00,00,00,00,01,00,11,00,06,00,02,00,03,00,00,00,00,00,00,
                        E0,E0,C0,C0,C0,C0,80,80,80,80,00,00,00,00,00,00,00,C0,00,80,00,80,00,00,00,00,00,00,00,00,00,00,
}


;;; $8E00: Samus top tiles - set Ah - entry Eh ;;;
{
; 19h: Facing right - spin jump - frame 7
; 1Ah: Facing left  - spin jump - frame 7
; 20h: Unused - frame 7
; 21h: Unused - frame 7
; 22h: Unused - frame 7
; 23h: Unused - frame 7
; 24h: Unused - frame 7
; 33h: Unused - frame 7
; 34h: Unused - frame 7
; 39h: Unused - frame 7
; 3Ah: Unused - frame 7
; 42h: Unused - frame 7
; 4Fh: Facing left  - damage boost - frame 3
; 50h: Facing right - damage boost - frame 3
; 83h: Facing right - wall jump - frame 9
; 84h: Facing left  - wall jump - frame 9
; |--------|--------|--------|--------|
; |33  3333|3       |    3F3F|EEF38733|
; |11333BBB|33      |   33333|333F3811|
; |CC13BAAA|B33     |  3F3BBB|BB33F331|
; |C13BA22A|BB3     | 3F3BAAA|ABBD3E31|
; |133BB622|AB33    | F33BB22|AAB53BB3|
; |33BAAA22|AB33    |3F3B22AB|BBB83AAB|
; |B3BA2BAA|B3333   |333BB22A|AB57322A|
; |B23B22AB|33BA3   |3F3B2ABB|B3753262|
; |--------|--------|--------|--------|
; |BAB3BAB3|332AB3  |3F33B62A|B383B222|
; |B33B3B33|3BB3B3  |3FE33BAA|B353AA2A|
; |33BBB33A|BB3BAB3 |3FEFF337|533333BB|
; |3B2AB3B2|AB3BA23 | 396EF33|373F3F13|
; |3B62AB32|B32A323 | 3F99E34|433E3EF1|
; |F3BAB333|3233BA3 |  FEEEF3|444339EF|
; |BA3332A3|    3B3 |  3FFFF9|9F43FE33|
; |2AB3AAB3|     33 |   333FE|933   3B|
; |--------|--------|--------|--------|
$9C:8E00             db CF,CF,FF,3F,38,1F,70,3F,F8,7F,E0,FF,E4,FF,B1,FF,00,00,00,07,C0,CF,80,99,04,18,00,3C,00,B7,00,93,
                        80,80,C0,C0,E0,E0,E0,E0,70,F0,70,F0,F8,F8,E8,F8,00,00,00,00,00,80,00,C0,00,C0,00,C0,00,80,00,30,
                        0F,0F,1F,1F,3F,3F,78,7F,7C,7F,F1,FF,F8,FF,F3,FF,05,05,00,00,10,17,20,2F,40,4C,40,53,00,19,40,57,
                        37,F7,FB,F8,FF,FE,7B,EE,3F,EF,E9,EF,78,DF,F8,EF,E4,E8,10,14,08,C8,14,F4,10,E6,00,F7,30,C1,32,80,
                        BB,FF,FF,FF,FE,FF,CE,FF,C6,FF,EF,FF,B9,FF,33,FF,00,EE,00,94,00,39,00,5A,20,4C,80,B8,00,C2,00,6E,
                        CC,FC,FC,FC,F6,FE,72,FE,CA,FE,BA,FE,0E,0E,06,06,00,18,00,68,00,DC,00,D8,00,90,00,0C,00,04,00,00,
                        F8,FF,DC,FF,DF,FF,67,5F,7A,66,23,3F,3F,3E,1E,1F,44,49,60,67,79,78,1C,2C,25,3C,3E,3E,1E,1F,03,03,
                        D8,DF,F0,DF,FF,7F,FF,FD,6B,7E,1D,1B,DB,5F,E3,63,00,A8,20,8D,80,03,54,14,96,16,E3,07,6C,CC,00,81,
}


;;; $8F00: Samus top tiles - set Ah - entry Fh ;;;
{
; 19h: Facing right - spin jump - frame 8
; 1Ah: Facing left  - spin jump - frame 8
; 20h: Unused - frame 8
; 21h: Unused - frame 8
; 22h: Unused - frame 8
; 23h: Unused - frame 8
; 24h: Unused - frame 8
; 33h: Unused - frame 8
; 34h: Unused - frame 8
; 39h: Unused - frame 8
; 3Ah: Unused - frame 8
; 42h: Unused - frame 8
; 4Fh: Facing left  - damage boost - frame 2
; 50h: Facing right - damage boost - frame 2
; 83h: Facing right - wall jump - frame Ah
; 84h: Facing left  - wall jump - frame Ah
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |BA222388|BBAB333 |        |B23A66B3|        |        |
; |        |        |BAA6AB35|DBB3FE3 |        |3A3A22B3|        |        |
; |        |        |AABBBB33|D33FEE  |        | 33BAAA3|        |        |
; |        |        |3BBB3333|33FEEF  |        | BB3BB32|        |        |
; |        |        |33333113|33FFF3  |       A|3A2A3333|   33333|3       |
; |        |        |BB331111|3D833   |      32|3AAB3BBB| 33F3FFE|F33     |
; |        |        |AA3311C1|3873    |   33 B2|3BAB3B22| F9FFE96|9E3F    |
; |        |        |ABB3CC33|3       |   3ABBA|3BBB3BBA|F9FE33FE|FFEFF   |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |6AA3333 |        |   3B22A|B3B33B22|FE3443F3|3333F3  |
; |        |        |22B33   |        |    33BB|BA333BA2|F444333B|BBBB33  |
; |        |       3|ABB3    |        |      33|B2B33BBA|343373B6|2ABBB3  |
; |        |     33E|BB3     |        |        |333333BB|33F73BBA|BB22B33 |
; |        |    23E9|33      |        |        |     333|333F3DBB|B2ABBB3 |
; |        |   A23FF|        |        |        |        |EF33D83B|ABA2AB3 |
; |        | 33BAB33|        |        |        |        |333B357B|BB2AAB3 |
; |        |3A33BB33|        |        |        |        |BBA2357B|BAAAB33 |
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:8F00             db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        84,FC,87,FE,3F,FF,FF,FF,FF,F9,FF,F0,3D,F0,73,F3,00,C3,11,EC,00,FC,00,70,00,00,00,C0,02,C2,0C,EC,
                        DE,FE,FA,7E,F0,7C,E4,FC,FC,FC,D8,98,B0,B0,80,80,00,F0,8C,EC,9C,9C,3C,3C,38,38,40,60,20,40,00,00,
                        00,00,00,00,00,00,00,00,00,01,02,03,1A,1B,16,1F,00,00,00,00,00,00,00,00,00,01,00,00,00,02,00,0F,
                        A3,FF,A3,FF,71,7F,7E,7F,8F,FF,9F,FF,DC,FF,FE,FF,0C,92,00,52,00,1E,00,6C,00,50,00,77,00,74,00,77,
                        00,00,00,00,00,00,00,00,1F,1F,7E,7F,7A,5D,EE,BF,00,00,00,00,00,00,00,00,00,00,17,17,5D,7E,B3,F3,
                        00,00,00,00,00,00,00,00,80,80,E0,E0,B0,70,D8,F8,00,00,00,00,00,00,00,00,00,00,80,80,50,D0,F8,F8,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,06,07,05,0E,07,1F,77,7F,BF,FF,00,00,00,00,00,00,01,01,02,03,03,13,00,1C,00,4C,
                        1E,FE,38,F8,70,F0,E0,E0,C0,C0,00,00,00,00,00,00,80,60,00,20,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        18,1F,0F,0F,03,03,00,00,00,00,00,00,00,00,00,00,00,09,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        FC,FF,BC,FF,BE,FF,FF,FF,07,07,00,00,00,00,00,00,00,A4,00,C6,00,A7,00,03,00,00,00,00,00,00,00,00,
                        A7,E7,8F,8F,BE,BF,FE,FF,FF,FB,7B,F3,FF,FB,CF,FB,DA,C2,F0,81,49,02,30,27,14,17,C8,CD,06,11,06,E1,
                        FC,FC,FC,FC,3C,FC,CE,FE,9E,FE,46,FE,C6,FE,8E,FE,08,08,00,F0,00,78,00,C8,00,BC,00,EC,00,DC,00,F8,
}


;;; $9100: Samus top tiles - set Ah - entry 10h ;;;
{
; 65h: Unused. Related to movement type Dh - frame 1
; 66h: Unused. Related to movement type Dh - frame 1
; 81h: Facing right - screw attack - frames 1..3
; 82h: Facing left  - screw attack - frames 1..3
; 83h: Facing right - wall jump - frames 17h..19h
; 84h: Facing left  - wall jump - frames 17h..19h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |      44|        |        |        |   4    |   4    |        |444     |
; |    444 |        |        |        |   4    |   4    |        |   4 4  |
; |  444   |        |       4|  4     |   4    | 44     |        |        |
; | 4      |        |       4| 4      |   4    |4       |  44    |        |
; | 4      |        |       4|4       | 44     |4       |4444    |       4|
; | 4      |      4 |     44 |4       |  4     |44      |    4   |        |
; |44      |       4|   444  | 4   444|  44    | 44     |    4   |        |
; |        |        |   4    |  4 4  4|        |  4     |    4   |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |
; |       4|        |
; |      4 |        |
; |        |        |
; |        |   4444 |
; |        |   4   4|
; |4       |   4   4|
; |        |   4    |
; |--------|--------|
$9C:9100             db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,03,00,0E,00,38,00,40,00,40,00,40,00,C0,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,01,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,01,00,01,00,06,00,1C,00,10,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,40,00,80,00,80,00,47,00,29,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00,10,00,10,00,10,00,60,00,20,00,30,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00,10,00,60,00,80,00,80,00,C0,00,60,00,20,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,30,00,F0,00,08,00,08,00,08,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,E0,00,14,00,00,00,00,00,01,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,02,00,00,00,00,00,00,00,80,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,1E,00,11,00,11,00,10,00,
}


;;; $9240: Samus top tiles - set Ah - entry 11h ;;;
{
; 65h: Unused. Related to movement type Dh - frame 2
; 66h: Unused. Related to movement type Dh - frame 2
; 81h: Facing right - screw attack - frames 7..9
; 82h: Facing left  - screw attack - frames 7..9
; 83h: Facing right - wall jump - frames 1Dh..1Fh
; 84h: Facing left  - wall jump - frames 1Dh..1Fh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |       4|        |    4   |    444 |        |        |      4 |        |
; |       4|        |     4  |        |        |        |      4 |  4     |
; |       4|        |  44    |   4    |        |  4     |      44|  444   |
; |       4|        |   4    |   44   |   4    |  444   |        | 4  4   |
; |   4  44|     4  |  4     |    4   |    4   |     444|        | 4   4  |
; |    44  |    4   |  4     |   4    |     4  |       4|        |4    4  |
; |        |    4   |  44444 |        |     4  |      4 |        |     4  |
; |        |4444    |      44|        |    4   |      4 |        |     4  |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |
; |        |  44    |        |
; |        | 44     |    4444|
; |    4   |        |   4    |
; |     4  |        |   44   |
; |       4|        |    444 |
; |        |        |      4 |
; |        |        |      4 |
; |--------|--------|--------|
$9C:9240             db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,01,00,01,00,01,00,13,00,0C,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,04,00,08,00,08,00,F0,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,08,00,04,00,30,00,10,00,20,00,20,00,3E,00,03,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,0E,00,00,00,10,00,18,00,08,00,10,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00,08,00,04,00,04,00,08,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,38,00,07,00,01,00,02,00,02,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,02,00,03,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,38,00,48,00,44,00,84,00,04,00,04,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,08,00,04,00,01,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,30,00,60,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,0F,00,10,00,18,00,0E,00,02,00,02,00,
}


;;; $93A0: Samus top tiles - set Ah - entry 12h ;;;
{
; 65h: Unused. Related to movement type Dh - frame 3
; 66h: Unused. Related to movement type Dh - frame 3
; 81h: Facing right - screw attack - frames Dh..Fh
; 82h: Facing left  - screw attack - frames Dh..Fh
; 83h: Facing right - wall jump - frames 23h..25h
; 84h: Facing left  - wall jump - frames 23h..25h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |     4  |        |        |        |        | 4      |     4  |        |
; |      44|        |        |        |        | 44     |    4   |        |
; |       4|        |        |        |   4    |  4     |   4    |        |
; |  444444|        |        |       4|   44   |        |        |        |
; |  4     |    4444|444     |       4|    4   |   44   |        |   4    |
; |4 4     |        |     4  |        |     4  |     4  |        |   4    |
; | 4      |        |      4 |        |     4  |        |        |  44    |
; |        |        |        |        |     4  |        |        | 44     |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |
; |        |        |        |
; |        | 4444   |        |
; |        |44  44  |        |
; |4       |     4  |      4 |
; | 4 444  |        |        |
; |     4  |        |        |
; |     4  |        |        |
; |--------|--------|--------|
$9C:93A0             db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,04,00,03,00,01,00,3F,00,20,00,A0,00,40,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,0F,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,E0,00,04,00,02,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,01,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00,18,00,08,00,04,00,04,00,04,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,40,00,60,00,20,00,00,00,18,00,04,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,04,00,08,00,10,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00,10,00,30,00,60,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,5C,00,04,00,04,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,78,00,CC,00,04,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,00,00,00,00,00,00,
}


;;; $9500: Samus top tiles - set Ah - entry 13h ;;;
{
; 65h: Unused. Related to movement type Dh - frame 4
; 66h: Unused. Related to movement type Dh - frame 4
; 81h: Facing right - screw attack - frames 13h..15h
; 82h: Facing left  - screw attack - frames 13h..15h
; 83h: Facing right - wall jump - frames 29h..2Bh
; 84h: Facing left  - wall jump - frames 29h..2Bh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |     44 |        |        |        |        |        |      44|        |
; |    4   |        |        |  4     |        |        |     4 4|        |
; |    4   |        |        |  4     |        |        |   44  4|      4 |
; |    4   |        |        |  4     |        |        |        |  44    |
; |        |        |        |  4444  |        | 4 4    |        |  4     |
; |        |     44 |        |     4  |      4 |        |        | 4      |
; |        |  4444  |        |        |        |        |        | 4      |
; |        |        |      4 |        |      4 |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:9500             db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,06,00,08,00,08,00,08,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,06,00,3C,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,20,00,20,00,3C,00,04,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,00,00,02,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,50,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,03,00,05,00,19,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,30,00,20,00,40,00,40,00,00,00,
}


;;; $9600: Samus top tiles - set Ah - entry 14h ;;;
{
; 1Bh: Facing right - space jump - frames 1..8
; 1Ch: Facing left  - space jump - frames 1..8
; 65h: Unused. Related to movement type Dh - frame 5
; 66h: Unused. Related to movement type Dh - frame 5
; 81h: Facing right - screw attack - frames 4..6
; 81h: Facing right - screw attack - frames Ah..Ch
; 81h: Facing right - screw attack - frames 10h..12h
; 81h: Facing right - screw attack - frames 16h..18h
; 82h: Facing left  - screw attack - frames 4..6
; 82h: Facing left  - screw attack - frames Ah..Ch
; 82h: Facing left  - screw attack - frames 10h..12h
; 82h: Facing left  - screw attack - frames 16h..18h
; 83h: Facing right - wall jump - frames Dh..14h
; 83h: Facing right - wall jump - frames 1Ah..1Ch
; 83h: Facing right - wall jump - frames 20h..22h
; 83h: Facing right - wall jump - frames 26h..28h
; 83h: Facing right - wall jump - frames 2Ch..2Eh
; 84h: Facing left  - wall jump - frames Dh..14h
; 84h: Facing left  - wall jump - frames 1Ah..1Ch
; 84h: Facing left  - wall jump - frames 20h..22h
; 84h: Facing left  - wall jump - frames 26h..28h
; 84h: Facing left  - wall jump - frames 2Ch..2Eh
; |--------|
; |        |
; |        |
; |        |
; |        |
; |        |
; |        |
; |        |
; |        |
; |--------|
$9C:9600             db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}
}


;;; $9620..9AFF: Samus top tiles - set Bh (morphing transition, unused morph ball bounce) ;;;
{
;;; $9620: Samus top tiles - set Bh - entry 0 ;;;
{
; Unused
; |--------|
; |        |
; | 1    1 |
; |  1  1  |
; |   1    |
; |    1   |
; |  1  1  |
; | 1    1 |
; |        |
; |--------|
$9C:9620             db 00,00,42,00,24,00,10,00,08,00,24,00,42,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $9640: Samus top tiles - set Bh - entry 1 ;;;
{
; 1Dh: Facing right - morph ball - no springball - on ground - frame 9
; 1Eh: Moving right - morph ball - no springball - on ground - frame 9
; 1Fh: Moving left  - morph ball - no springball - on ground - frame 9
; 31h: Facing right - morph ball - no springball - in air - frame 9
; 32h: Facing left  - morph ball - no springball - in air - frame 9
; 3Fh: Unused - frame 9
; 40h: Unused - frame 9
; 41h: Facing left  - morph ball - no springball - on ground - frame 9
; 79h: Facing right - morph ball - spring ball - on ground - frame 9
; 7Ah: Facing left  - morph ball - spring ball - on ground - frame 9
; 7Bh: Moving right - morph ball - spring ball - on ground - frame 9
; 7Ch: Moving left  - morph ball - spring ball - on ground - frame 9
; 7Dh: Facing right - morph ball - spring ball - falling - frame 9
; 7Eh: Facing left  - morph ball - spring ball - falling - frame 9
; 7Fh: Facing right - morph ball - spring ball - in air - frame 9
; 80h: Facing left  - morph ball - spring ball - in air - frame 9
; C5h: Unused - frame 9
; DFh: Unused. Related to Draygon - frame 9
; |--------|--------|--------|
; |        |        |        |
; |        |        |B       |
; |      BB|BBBBB   |BB      |
; |    3BBB|BBBBBB3 |BBB     |
; |  BBB3AA|AAAAA3BB|BBB     |
; | BBBAAB2|2222BAAB|BBB     |
; |BBBAA22A|22BA22AA|BB      |
; |BBBAAA22|AB222AAA|B       |
; |--------|--------|--------|
; |BBBBAAAA|ABAAAAAB|
; | BBBBBAA|ABAAABBB|
; |  BBBBBB|B3BBBBBB|
; |    BBBB|B3BBBBB |
; |      BB|B3BBB   |
; |        |        |
; |        |        |
; |        |        |
; |--------|--------|
$9C:9640             db 00,00,00,00,03,03,0F,0F,3C,3F,72,7F,E0,FF,E0,FF,00,00,00,00,00,03,00,07,00,3B,00,7E,00,F9,00,FC,
                        00,00,00,00,F8,F8,FE,FE,07,FF,09,FF,20,FF,40,FF,00,00,00,00,00,F8,00,FC,00,FB,00,0F,00,33,00,C7,
                        00,00,80,80,C0,C0,E0,E0,E0,E0,E0,E0,C0,C0,80,80,00,00,00,80,00,C0,00,E0,00,E0,00,E0,00,C0,00,80,
                        F0,FF,7C,7F,3F,3F,0F,0F,03,03,00,00,00,00,00,00,00,FF,00,7F,00,3F,00,0F,00,03,00,00,00,00,00,00,
                        41,FF,47,FF,FF,FF,FE,FE,F8,F8,00,00,00,00,00,00,00,FF,00,FF,00,BF,00,BE,00,B8,00,00,00,00,00,00,
}


;;; $96E0: Samus top tiles - set Bh - entry 2 ;;;
{
; Unused
; |--------|--------|--------|
; |       B|BB      |BBBBBBB |
; |      BB|BBB     | BBBBB  |
; |     BBB|BBBB    |  BBB   |
; |     BBB|AABB    |        |
; |    BBBA|AAAB3   |        |
; |    BBBA|A2A3B   |        |
; |   BBBAA|22BABB  |        |
; |   BBBAA|2A2ABB  |        |
; |--------|--------|--------|
; |   BBBAA|A22ABB  |
; |   333BB|B22ABB  |
; |   BBBAA|2B2ABB  |
; |   BBBAA|2A2ABB  |
; |   BBBAA|22BABB  |
; |    BBBA|A2A3B   |
; |    BBBA|AAAB3   |
; |     BBB|AABB    |
; |--------|--------|
$9C:96E0             db 01,01,03,03,07,07,07,07,0E,0F,0E,0F,1C,1F,1C,1F,00,01,00,03,00,07,00,07,00,0F,00,0F,00,1F,00,1F,
                        C0,C0,E0,E0,F0,F0,30,F0,18,F8,18,F8,2C,FC,0C,FC,00,C0,00,E0,00,F0,00,F0,00,F0,00,A8,00,3C,00,5C,
                        FE,FE,7C,7C,38,38,00,00,00,00,00,00,00,00,00,00,00,FE,00,7C,00,38,00,00,00,00,00,00,00,00,00,00,
                        1C,1F,1F,1F,1C,1F,1C,1F,1C,1F,0E,0F,0E,0F,07,07,00,1F,00,03,00,1F,00,1F,00,1F,00,0F,00,0F,00,07,
                        0C,FC,8C,FC,4C,FC,0C,FC,2C,FC,18,F8,18,F8,30,F0,00,9C,00,9C,00,5C,00,5C,00,3C,00,A8,00,F0,00,F0,
}


;;; $9780: Samus top tiles - set Bh - entry 3 ;;;
{
; 38h: Facing left  - morphing transition - frame 1
; 3Eh: Facing left  - unmorphing transition - frame 0
; D4h: Facing left  - crystal flash - frame 0
; D8h: Facing left  - crystal flash ending - frame 1
; DCh: Unused - frame 2
; DEh: Unused - frame 0
; E9h: Facing left  - Samus drained - crouching/falling - frame 0
; |--------|--------|--------|--------|
; |        |        |BA2622B3|3BBA2BBB|
; |     333|33      |BAA22AB3|33BBA23B|
; |   33FFF|F333    |BBAAABB3| 323BBA3|
; |  3FEEE3|3BB333  |3BBBBB33|  3233BB|
; | 3FEEF3B|ABABB33 |B3BBB33 | BBAAB3B|
; |3F9EEF3A|2A2ABB3 |333333  |33333333|
; |3F6EF3B2|266AAB33|        |        |
; |FFFFF3A2|B2A2ABB3|        |        |
; |--------|--------|--------|--------|
; |E9EFF3AA|BAB2ABBB|
; |E6EEF3BB|BABABBBA|
; |FEFFF333|3BBBBB3A|
; |3FF333BB|B3333B3B|
; |B33BEF3B|BBBBB3BB|
; |ABB9EF3B|2AABBB33|
; |223FF3BA|2BB22BB3|
; |BAB3F3BB|AB262AB3|
; |--------|--------|
$9C:9780             db 00,00,07,07,1F,1F,31,3F,67,7F,E6,DF,CE,FF,FC,FF,00,00,00,00,07,07,1E,1E,3C,3D,5C,7D,78,5A,F8,FA,
                        00,00,C0,C0,F0,F0,FC,FC,5E,FE,0E,FE,07,FF,87,FF,00,00,00,00,80,80,00,60,00,F8,00,5C,60,1C,00,AE,
                        83,FF,83,FF,C7,FF,FF,FF,FE,FE,FC,FC,00,00,00,00,10,C2,00,E6,00,FE,00,7C,00,B8,00,00,00,00,00,00,
                        E7,FF,F3,FF,5D,7F,2F,3F,67,7F,FF,FF,00,00,00,00,00,77,00,39,00,0E,00,03,00,7D,00,00,00,00,00,00,
                        5C,BF,0F,FF,BF,FF,FF,FF,F7,FF,77,EF,3E,FF,BF,FF,B8,FB,F8,BB,F8,F8,60,63,0C,9D,0C,FD,18,1B,08,EB,
                        A7,FF,AE,FF,FE,FF,FF,FF,FF,FF,1F,FF,67,FF,43,FF,00,EF,00,FF,00,7D,00,85,00,FB,00,7C,00,66,10,C6,
}


;;; $9840: Samus top tiles - set Bh - entry 4 ;;;
{
; 38h: Facing left  - morphing transition - frame 0
; 3Eh: Facing left  - unmorphing transition - frame 1
; D4h: Facing left  - crystal flash - frame 1
; D4h: Facing left  - crystal flash - frame 3
; D4h: Facing left  - crystal flash - frames Ch..Dh
; D8h: Facing left  - crystal flash ending - frame 2
; DCh: Unused - frame 1
; DEh: Unused - frame 1
; E9h: Facing left  - Samus drained - crouching/falling - frame 1
; |--------|--------|--------|--------|--------|--------|
; |     333|333     |3BAABB33| A3BAB33|BB31CC13|2BF333BB|
; |   33FFF|F3FF3   |33BBB33 |BBB3BBB3|23331C13|AA3BB33A|
; | 3FF9EE3|3333F3  |333333  |33333333|3BB3313 |B3B62B3B|
; |3FE96F33|BBB33F3 |        |        |BAABB33 |33A2ABB3|
; |3FE9EF3B|2B2BB333|        |        |22ABAB33|A3BABB3B|
; |3FEEF3B6|A22BAB3F|        |        |2BA62AB3|A23B33BA|
; |FFF333A2|B2A2AB33|        |        |AA222AB3|BA33B33B|
; |E93437AA|BAB2AB3F|        |        |BA22AAB3|33322A33|
; |--------|--------|--------|--------|--------|--------|
; |994435BB|BABAAB3E|
; |3F437333|3BBABB3E|
; |34433358|75BBB33F|
; | 33EF333|5785D3F3|
; | F3333AB|33333F38|
; | E9EF3A2|22ABE387|
; |33EF1B22|62AB3313|
; |B3F13BA2|2AB31113|
; |--------|--------|
$9C:9840             db 07,07,1F,1F,79,77,D7,EF,D7,EF,CE,FF,FC,FF,6C,AF,00,00,07,07,36,3E,6C,74,6C,7D,79,7A,E0,E2,94,C3,
                        E0,E0,F8,F8,FC,FC,FE,FE,5F,FF,17,FF,87,FF,A7,FF,00,00,B0,B0,08,08,04,E4,00,58,01,9D,00,AC,01,ED,
                        CF,FF,FE,FE,FC,FC,00,00,00,00,00,00,00,00,00,00,00,7C,00,38,00,00,00,00,00,00,00,00,00,00,00,00,
                        37,7F,FF,FF,FF,FF,00,00,00,00,00,00,00,00,00,00,00,5C,00,EE,00,00,00,00,00,00,00,00,00,00,00,00,
                        F3,E1,7B,F1,FE,FA,9E,FE,17,FF,43,FF,03,FF,83,FF,0C,CC,04,04,00,60,00,F8,00,3C,10,66,00,C6,00,CE,
                        7F,FF,3E,FF,E7,FF,C7,FF,6F,FF,3E,FF,BF,FF,E3,FF,20,63,00,D9,10,A5,00,2E,00,BD,00,93,00,C9,00,04,
                        CF,0B,DF,DF,9E,9C,6F,7F,7D,7F,2C,5F,DC,F7,FC,EF,34,C3,68,40,62,01,18,18,40,43,58,7A,30,34,20,A6,
                        A6,FF,EE,FF,FF,BF,DF,47,FE,FE,15,FD,1F,FD,3F,F1,01,FD,01,7D,C1,39,DA,2A,04,05,09,3A,80,30,00,60,
}


;;; $9940: Samus top tiles - set Bh - entry 5 ;;;
{
; 37h: Facing right - morphing transition - frame 1
; 3Dh: Facing right - unmorphing transition - frame 0
; D3h: Facing right - crystal flash - frame 0
; D7h: Facing right - crystal flash ending - frame 1
; DBh: Unused - frame 2
; DDh: Unused - frame 0
; E8h: Facing right - Samus drained - crouching/falling - frame 1
; |--------|--------|--------|--------|
; |        |        |BA2622B3|3BBA2BBB|
; |     333|33      |BAA22AB3|33BBA23B|
; |   33FFF|F333    |BBAAABB3| 323BBA3|
; |  3FEEE3|3BB333  |3BBBBB33|  3233BB|
; | 3FEEF3B|ABABB33 |B3BBB33 | BBAAB3B|
; |3F9EEF3A|2A2ABB3 |333333  |33333333|
; |3F6EF3B2|266AAB33|        |        |
; |FFFFF3A2|B2A2ABB3|        |        |
; |--------|--------|--------|--------|
; |E9EFF3AA|BAB2ABBB|
; |E6EEF3BB|BABABBBA|
; |FEFFF333|3BBBBB3A|
; |3FF333BB|B3333B3B|
; |B33BEF3B|BBBBB3BB|
; |ABB9EF3B|2AABBB33|
; |223FF3BA|2BB22BB3|
; |BAB3F3BB|AB262AB3|
; |--------|--------|
$9C:9940             db 00,00,07,07,1F,1F,31,3F,67,7F,E6,DF,CE,FF,FC,FF,00,00,00,00,07,07,1E,1E,3C,3D,5C,7D,78,5A,F8,FA,
                        00,00,C0,C0,F0,F0,FC,FC,5E,FE,0E,FE,07,FF,87,FF,00,00,00,00,80,80,00,60,00,F8,00,5C,60,1C,00,AE,
                        83,FF,83,FF,C7,FF,FF,FF,FE,FE,FC,FC,00,00,00,00,10,C2,00,E6,00,FE,00,7C,00,B8,00,00,00,00,00,00,
                        E7,FF,F3,FF,5D,7F,2F,3F,67,7F,FF,FF,00,00,00,00,00,77,00,39,00,0E,00,03,00,7D,00,00,00,00,00,00,
                        5C,BF,0F,FF,BF,FF,FF,FF,F7,FF,77,EF,3E,FF,BF,FF,B8,FB,F8,BB,F8,F8,60,63,0C,9D,0C,FD,18,1B,08,EB,
                        A7,FF,AE,FF,FE,FF,FF,FF,FF,FF,1F,FF,67,FF,43,FF,00,EF,00,FF,00,7D,00,85,00,FB,00,7C,00,66,10,C6,
}


;;; $9A00: Samus top tiles - set Bh - entry 6 ;;;
{
; 37h: Facing right - morphing transition - frame 0
; 3Dh: Facing right - unmorphing transition - frame 1
; D3h: Facing right - crystal flash - frame 1
; D3h: Facing right - crystal flash - frame 3
; D3h: Facing right - crystal flash - frames Ch..Dh
; D7h: Facing right - crystal flash ending - frame 2
; DBh: Unused - frame 1
; DDh: Unused - frame 1
; E8h: Facing right - Samus drained - crouching/falling - frame 2
; |--------|--------|--------|--------|--------|--------|
; |     333|333     |3BAABB33| A3BAB33|BB31CC13|2BF333BB|
; |   33FFF|F3FF3   |33BBB33 |BBB3BBB3|23331C13|AA3BB33A|
; | 3FF9EE3|3333F3  |333333  |33333333|3BB3313 |B3B62B3B|
; |3FE96F33|BBB33F3 |        |        |BAABB33 |33A2ABB3|
; |3FE9EF3B|2B2BB333|        |        |22ABAB33|A3BABB3B|
; |3FEEF3B6|A22BAB3F|        |        |2BA62AB3|A23B33BA|
; |FFF333A2|B2A2AB33|        |        |AA222AB3|BA33B33B|
; |E93437AA|BAB2AB3F|        |        |BA22AAB3|33322A33|
; |--------|--------|--------|--------|--------|--------|
; |994435BB|BABAAB3E|
; |3F437333|3BBABB3E|
; |34433358|75BBB33F|
; | 33EF333|5785D3F3|
; | F3333AB|33333F38|
; | E9EF3A2|22ABE387|
; |33EF1B22|62AB3313|
; |B3F13BA2|2AB31113|
; |--------|--------|
$9C:9A00             db 07,07,1F,1F,79,77,D7,EF,D7,EF,CE,FF,FC,FF,6C,AF,00,00,07,07,36,3E,6C,74,6C,7D,79,7A,E0,E2,94,C3,
                        E0,E0,F8,F8,FC,FC,FE,FE,5F,FF,17,FF,87,FF,A7,FF,00,00,B0,B0,08,08,04,E4,00,58,01,9D,00,AC,01,ED,
                        CF,FF,FE,FE,FC,FC,00,00,00,00,00,00,00,00,00,00,00,7C,00,38,00,00,00,00,00,00,00,00,00,00,00,00,
                        37,7F,FF,FF,FF,FF,00,00,00,00,00,00,00,00,00,00,00,5C,00,EE,00,00,00,00,00,00,00,00,00,00,00,00,
                        F3,E1,7B,F1,FE,FA,9E,FE,17,FF,43,FF,03,FF,83,FF,0C,CC,04,04,00,60,00,F8,00,3C,10,66,00,C6,00,CE,
                        7F,FF,3E,FF,E7,FF,C7,FF,6F,FF,3E,FF,BF,FF,E3,FF,20,63,00,D9,10,A5,00,2E,00,BD,00,93,00,C9,00,04,
                        CF,0B,DF,DF,9E,9C,6F,7F,7D,7F,2C,5F,DC,F7,FC,EF,34,C3,68,40,62,01,18,18,40,43,58,7A,30,34,20,A6,
                        A6,FF,EE,FF,FF,BF,DF,47,FE,FE,15,FD,1F,FD,3F,F1,01,FD,01,7D,C1,39,DA,2A,04,05,09,3A,80,30,00,60,
}
}


;;; $9B00..B2BF: Samus top tiles - set 3 (facing clockwise - grappling - in air - upside up) ;;;
{
;;; $9B00: Samus top tiles - set 3 - entry 0 ;;;
{
; 5Dh: Unused - frame 18h
; 5Dh: Unused - frame 38h
; 5Eh: Unused - frame 18h
; 5Eh: Unused - frame 38h
; 5Fh: Unused - frame 18h
; 5Fh: Unused - frame 38h
; 60h: Unused - frame 18h
; 60h: Unused - frame 38h
; 61h: Unused - frame 18h
; 61h: Unused - frame 38h
; B2h: Facing clockwise     - grapple - in air - frame 18h
; B2h: Facing clockwise     - grapple - in air - frame 38h
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        | 88     |        |
; |        |        |   5 333|333     |D33     |3DDDDDD3|
; |        |        |  388FF3|3F33    |53D     |35555553|
; |     BB |        | 3FFFF33|333F3   |877     |38888873|
; |  33BAAA|B       |113FF333|3333F3  |588     |35555553|
; | 3BBA622|AB3     |C13F3333|3333FF3 |D35     |3DDDDDD3|
; |3BBAB2A2|B85     |CC3F3333|3333FFF3|333     |33333333|
; |3BB2ABB5|753333  |CCFF3333|3333FFEF| 88     |        |
; |--------|--------|--------|--------|--------|--------|
; |3BAB2B57|33BBB333|CCFF3333|3333FFEF|
; |3BBBB383|BA262AB3|C13FF333|333FFF6E|
; | 3BB3533|BA2AAAB3|313FFFF3|333FEE9E|
; | 333D33B|AAAAB333| 33FEEFF|3383FE9E|
; |  33D3BB|ABB3BB33|  33FE9F|35344FE3|
; |   3333B|B333AA3 |    3EE3|F344FE3 |
; |        |        |        |        |
; |        |        |        |        |
; |--------|--------|--------|--------|
$9C:9B00             db 00,00,00,00,00,00,06,06,38,3F,70,7F,E8,FF,E7,FE,00,00,00,00,00,00,00,06,00,0F,04,38,00,7A,01,6E,
                        00,00,00,00,00,00,00,00,80,80,60,E0,A0,80,FC,BC,00,00,00,00,00,00,00,00,00,80,00,C0,20,C0,C0,00,
                        00,00,17,07,27,27,7F,7F,FF,3F,7F,3F,3F,3F,3F,3F,00,00,10,00,06,1E,3C,3C,18,18,90,90,D0,D0,F0,F0,
                        00,00,E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FF,FF,FD,FF,00,00,00,00,40,40,10,10,08,08,0C,0C,0E,0E,0F,0F,
                        00,00,E0,60,E0,40,60,60,80,00,E0,40,E0,E0,00,00,00,60,80,80,A0,20,60,80,80,60,A0,80,00,00,00,60,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        D7,FD,FD,FD,7F,7B,7F,77,3F,37,1F,1F,00,00,00,00,03,74,00,7A,04,30,08,09,08,0B,00,01,00,00,00,00,
                        FF,FF,83,FF,83,FF,0F,FF,7F,FF,F2,FE,00,00,00,00,00,38,10,C6,00,DE,00,F8,00,EC,00,8C,00,00,00,00,
                        3F,3F,7F,3F,FF,BF,73,7F,3B,3D,09,0F,00,00,00,00,F0,F0,98,98,1E,1E,1F,1F,0D,0F,06,06,00,00,00,00,
                        FD,FF,FC,FF,F2,FD,DA,DD,E5,A7,CA,CE,00,00,00,00,0F,0F,1F,1D,1D,1F,0D,2F,5E,06,BC,8C,00,00,00,00,
}


;;; $9C40: Samus top tiles - set 3 - entry 1 ;;;
{
; 5Dh: Unused - frame 17h
; 5Dh: Unused - frame 37h
; 5Eh: Unused - frame 17h
; 5Eh: Unused - frame 37h
; 5Fh: Unused - frame 17h
; 5Fh: Unused - frame 37h
; 60h: Unused - frame 17h
; 60h: Unused - frame 37h
; 61h: Unused - frame 17h
; 61h: Unused - frame 37h
; B2h: Facing clockwise     - grapple - in air - frame 17h
; B2h: Facing clockwise     - grapple - in air - frame 37h
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        |88      |        |
; |        |        |     333|3       |335     |    3333|
; |        |        |   33333|3FF33   |3D8     |33333DD3|
; |        |        |  3FF333|33FFFF3 |587     |3DDDD553|
; |     B3 |        | 78F3333|333FFEF |87D     |35555873|
; |   33AA3|3  33333|3FF33333|333FFEFE|53D     |3D888553|
; | 33BA2B7|533AAAB3|33F33333|3333FF6E|3D38    |33D555DD|
; |3BBA2B37|5BA2AAB3|13F33333|333FFE9E|  D     | 3DDDD  |
; |--------|--------|--------|--------|--------|--------|
; |BBAA2B58|326AABB3|113F3333|333FFFE9|
; |BAABB573|BA2BB333|CCFF3333|33383FFE|
; |BB2AB553|BAAB33AA|CCCFFF3F|333334FE|
; |BBAAB353|BAA333  |1C13FFFF|FF3544  |
; |33BBB3D3|BBB3    |31113FEE|9FF3    |
; | 3BBB3D3|BBB     |    33FE|E3      |
; |  33B333|33      |        |        |
; |   333  |        |        |        |
; |--------|--------|--------|--------|
$9C:9C40             db 00,00,00,00,00,00,00,00,06,06,19,1F,73,7F,E7,FF,00,00,00,00,00,00,00,00,00,04,00,06,01,1A,01,74,
                        00,00,00,00,00,00,00,00,00,00,9F,9F,E3,7F,C3,7F,00,00,00,00,00,00,00,00,00,00,00,00,80,1E,80,6E,
                        00,00,07,07,1F,1F,3F,3F,5F,5F,FF,FF,FF,FF,FF,7F,00,00,00,00,00,00,18,18,50,30,60,60,20,20,20,20,
                        00,00,80,80,F8,F8,FE,FE,FA,FE,FA,FF,FC,FF,FA,FD,00,00,00,00,60,60,3C,3C,1E,1E,1F,1F,0F,0D,1D,1F,
                        00,00,E0,C0,C0,80,A0,20,60,40,E0,40,E0,A0,20,00,00,C0,20,00,40,60,A0,40,60,A0,A0,20,40,50,20,20,
                        00,00,0F,0F,FF,F9,FF,81,FB,83,C7,81,FF,C0,7C,40,00,00,00,00,06,06,7E,78,7A,04,46,78,3F,23,3C,3C,
                        C6,FC,9F,FB,CF,F9,CF,FD,FF,FD,7F,7D,3F,3F,1C,1C,02,F5,06,F8,06,D8,02,F8,02,3A,02,3A,00,08,00,00,
                        87,FF,9F,FF,9C,FF,9C,FC,F0,F0,E0,E0,C0,C0,00,00,20,1E,00,D8,00,F3,00,E0,00,E0,00,E0,00,00,00,00,
                        FF,3F,3F,3F,1F,1F,BF,1F,FC,8F,0E,0F,00,00,00,00,10,10,F0,F0,FD,FD,4F,4F,07,07,03,03,00,00,00,00,
                        FD,FE,EE,EF,FA,FB,F0,E0,F0,70,40,C0,00,00,00,00,1E,1F,07,17,07,03,DC,C0,60,E0,80,80,00,00,00,00,
}


;;; $9D80: Samus top tiles - set 3 - entry 2 ;;;
{
; 5Dh: Unused - frame 16h
; 5Dh: Unused - frame 36h
; 5Eh: Unused - frame 16h
; 5Eh: Unused - frame 36h
; 5Fh: Unused - frame 16h
; 5Fh: Unused - frame 36h
; 60h: Unused - frame 16h
; 60h: Unused - frame 36h
; 61h: Unused - frame 16h
; 61h: Unused - frame 36h
; B2h: Facing clockwise     - grapple - in air - frame 16h
; B2h: Facing clockwise     - grapple - in air - frame 36h
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |
; |        |        |        |        |     333|3       |
; |        |        |        |        |   33333|3FF33   |
; |        |  83    |        |        |  3FF333|33FFFF3 |
; |        |3335    |     B3 |        | 78F3333|333FFEF |
; |     333|3D388   |   33AA3|3  33333|3FF33333|333FFEFE|
; |   333DD|D3577   | 33BA2B7|533AAAB3|33F33333|3333FF6E|
; |  3DDD55|5383D   |3BBA2B37|5BA2AAB3|13F33333|333FFE9E|
; |--------|--------|--------|--------|--------|--------|
; |  3D5588|753533  |BBAA2B58|326AABB3|113F3333|333FFFE9|
; |  358885|5D3D88  |BAABB573|BA2BB333|CCFF3333|33383FFE|
; |   3555D|D       |BB2AB553|BAAB33AA|CCCFFF3F|333334FE|
; |   3DDD |        |BBAAB353|BAA333  |1C13FFFF|FF3544  |
; |    3   |        |33BBB3D3|BBB3    |31113FEE|9FF3    |
; |        |        | 3BBB3D3|BBB     |    33FE|E3      |
; |        |        |  33B333|33      |        |        |
; |        |        |   333  |        |        |        |
; |--------|--------|--------|--------|--------|--------|
$9C:9D80             db 00,00,00,00,00,00,00,00,00,00,07,07,1F,1C,3F,20,00,00,00,00,00,00,00,00,00,00,00,00,03,03,1F,1C,
                        00,00,00,00,00,00,10,10,F0,E0,E0,A0,F8,58,D8,50,00,00,00,00,00,00,00,20,10,00,40,58,B8,80,88,28,
                        00,00,00,00,00,00,00,00,06,06,19,1F,73,7F,E7,FF,00,00,00,00,00,00,00,00,00,04,00,06,01,1A,01,74,
                        00,00,00,00,00,00,00,00,00,00,9F,9F,E3,7F,C3,7F,00,00,00,00,00,00,00,00,00,00,00,00,80,1E,80,6E,
                        00,00,07,07,1F,1F,3F,3F,5F,5F,FF,FF,FF,FF,FF,7F,00,00,00,00,00,00,18,18,50,30,60,60,20,20,20,20,
                        00,00,80,80,F8,F8,FE,FE,FA,FE,FA,FF,FC,FF,FA,FD,00,00,00,00,60,60,3C,3C,1E,1E,1F,1F,0F,0D,1D,1F,
                        3C,20,31,20,1F,10,1E,10,08,08,00,00,00,00,00,00,1C,13,11,0E,0F,01,0E,0E,00,00,00,00,00,00,00,00,
                        FC,AC,F0,20,80,00,00,00,00,00,00,00,00,00,00,00,D0,00,D0,5C,80,80,00,00,00,00,00,00,00,00,00,00,
                        C6,FC,9F,FB,CF,F9,CF,FD,FF,FD,7F,7D,3F,3F,1C,1C,02,F5,06,F8,06,D8,02,F8,02,3A,02,3A,00,08,00,00,
                        87,FF,9F,FF,9C,FF,9C,FC,F0,F0,E0,E0,C0,C0,00,00,20,1E,00,D8,00,F3,00,E0,00,E0,00,E0,00,00,00,00,
                        FF,3F,3F,3F,1F,1F,BF,1F,FC,8F,0E,0F,00,00,00,00,10,10,F0,F0,FD,FD,4F,4F,07,07,03,03,00,00,00,00,
                        FD,FE,EE,EF,FA,FB,F0,E0,F0,70,40,C0,00,00,00,00,1E,1F,07,17,07,03,DC,C0,60,E0,80,80,00,00,00,00,
}


;;; $9F00: Samus top tiles - set 3 - entry 3 ;;;
{
; 5Dh: Unused - frame 15h
; 5Dh: Unused - frame 35h
; 5Eh: Unused - frame 15h
; 5Eh: Unused - frame 35h
; 5Fh: Unused - frame 15h
; 5Fh: Unused - frame 35h
; 60h: Unused - frame 15h
; 60h: Unused - frame 35h
; 61h: Unused - frame 15h
; 61h: Unused - frame 35h
; B2h: Facing clockwise     - grapple - in air - frame 15h
; B2h: Facing clockwise     - grapple - in air - frame 35h
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |
; |        |        |        |        |    3333|FF33F   |
; |        |        |        |        |  33F333|FFFEFF  |
; |        |        |        |  83    | 3F33333|3FF6EEE |
; |     B3 |        |        |3335    | FF33333|33FFF9EE|
; |   33AA3|3  33333|     333|3D388   |3FF33333|333FEE93|
; | 33BA2B7|533AAAB3|   333DD|D3577   |83F33333|333FEFFE|
; |3BBA2B37|5BA2AAB3|  3DDD55|5383D   |7FF33333|3333344E|
; |--------|--------|--------|--------|--------|--------|
; |BBAA2B58|326AABB3|  3D5588|753533  |FFF33333|333834F |
; |BAABB573|BA2BB333|  358885|5D3D88  |13FF3333|333534  |
; |BB2AB553|BAAB33AA|   3555D|D       |113FF33F|FFF33   |
; |BBAAB353|BAA333  |   3DDD |        |111FFFFF|E9F3    |
; |33BBB3D3|BBB3    |    3   |        |1CC33FFE|EEE     |
; | 3BBB3D3|BBB     |        |        |31CC13FF|FE      |
; |  33B333|33      |        |        | 31C3333|        |
; |   333  |        |        |        |  33    |        |
; |--------|--------|--------|--------|--------|--------|
$9C:9F00             db 00,00,00,00,00,00,00,00,06,06,19,1F,73,7F,E7,FF,00,00,00,00,00,00,00,00,00,04,00,06,01,1A,01,74,
                        00,00,00,00,00,00,00,00,00,00,9F,9F,E3,7F,C3,7F,00,00,00,00,00,00,00,00,00,00,00,00,80,1E,80,6E,
                        00,00,00,00,00,00,00,00,00,00,07,07,1F,1C,3F,20,00,00,00,00,00,00,00,00,00,00,00,00,03,03,1F,1C,
                        00,00,00,00,00,00,10,10,F0,E0,E0,A0,F8,58,D8,50,00,00,00,00,00,00,00,20,10,00,40,58,B8,80,88,28,
                        00,00,0F,0F,3F,3F,7F,7F,7F,7F,FF,FF,7F,7F,FF,FF,00,00,00,00,08,08,20,20,60,60,60,60,20,A0,E0,60,
                        00,00,F8,F8,EC,FC,E0,FE,FC,FB,F3,FD,F6,FF,F8,F9,00,00,C8,C8,FC,FC,7E,6E,3B,3F,1C,1E,1F,1F,07,01,
                        C6,FC,9F,FB,CF,F9,CF,FD,FF,FD,7F,7D,3F,3F,1C,1C,02,F5,06,F8,06,D8,02,F8,02,3A,02,3A,00,08,00,00,
                        87,FF,9F,FF,9C,FF,9C,FC,F0,F0,E0,E0,C0,C0,00,00,20,1E,00,D8,00,F3,00,E0,00,E0,00,E0,00,00,00,00,
                        3C,20,31,20,1F,10,1E,10,08,08,00,00,00,00,00,00,1C,13,11,0E,0F,01,0E,0E,00,00,00,00,00,00,00,00,
                        FC,AC,F0,20,80,00,00,00,00,00,00,00,00,00,00,00,D0,00,D0,5C,80,80,00,00,00,00,00,00,00,00,00,00,
                        FF,FF,FF,7F,FF,3F,FF,1F,9E,1F,CF,87,6F,4F,30,30,E0,E0,30,30,19,19,1F,1F,67,67,33,33,10,10,00,00,
                        EA,EA,F8,E8,F8,F8,70,B0,00,E0,80,C0,00,00,00,00,06,12,14,00,E0,E0,A0,E0,E0,E0,C0,C0,00,00,00,00,
}


;;; $A080: Samus top tiles - set 3 - entry 4 ;;;
{
; 5Dh: Unused - frame 14h
; 5Dh: Unused - frame 34h
; 5Eh: Unused - frame 14h
; 5Eh: Unused - frame 34h
; 5Fh: Unused - frame 14h
; 5Fh: Unused - frame 34h
; 60h: Unused - frame 14h
; 60h: Unused - frame 34h
; 61h: Unused - frame 14h
; 61h: Unused - frame 34h
; B2h: Facing clockwise     - grapple - in air - frame 14h
; B2h: Facing clockwise     - grapple - in air - frame 34h
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |   3    |        |        |
; |        |        |        |  333   |    3333|FF33F   |
; |        |        |        | 3BB33  |  33F333|FFFEFF  |
; |       8|        |    BB3D|33AAB33 | 3F33333|3FF6EEE |
; |      8D|3       |  BBB2D5|3A2AAB33| FF33333|33FFF9EE|
; |     8D3|D7      | BB22B55|B26AB33 |3FF33333|333FEE93|
; |     33D|785     | BA2A283|A22B3BA |83F33333|333FEFFE|
; |    3D33|853     |3BA2AB73|BABB3A  |7FF33333|3333344E|
; |--------|--------|--------|--------|--------|--------|
; |   3D573|333D8   |3BABBB83|BAAB3   |FFF33333|333834F |
; |  3D5785|33D8    |3BAAAB53|BAB3    |13FF3333|333534  |
; | 3D5785D|338     |3BBBBB53|3BB3    |113FF33F|FFF33   |
; | 3D785D3|3       |3BBBB3D3|BB3     |111FFFFF|E9F3    |
; |  3D5D33|        | 3BBB3DD|33      |1CC33FFE|EEE     |
; |   3D33 |        |  3333D3|        |31CC13FF|FE      |
; |    33  |        |   3333 |        | 31C3333|        |
; |        |        |        |        |  33    |        |
; |--------|--------|--------|--------|--------|--------|
$9C:A080             db 00,00,00,00,00,00,00,00,01,00,03,01,07,06,0F,0B,00,00,00,00,00,00,00,01,01,03,02,06,01,01,04,04,
                        00,00,00,00,00,00,00,00,80,80,C0,40,A0,80,60,20,00,00,00,00,00,00,00,00,00,00,C0,80,A0,40,40,80,
                        00,00,00,00,00,00,0F,0E,3B,3C,67,7C,41,7D,C7,FF,00,00,00,00,00,00,01,0D,03,3A,03,64,00,6A,02,6C,
                        10,10,38,38,7C,7C,CE,FE,87,FF,8E,FE,1C,FE,B8,FC,00,00,00,00,00,30,00,38,00,5C,20,98,00,96,00,F4,
                        00,00,0F,0F,3F,3F,7F,7F,7F,7F,FF,FF,7F,7F,FF,FF,00,00,00,00,08,08,20,20,60,60,60,60,20,A0,E0,60,
                        00,00,F8,F8,EC,FC,E0,FE,FC,FB,F3,FD,F6,FF,F8,F9,00,00,C8,C8,FC,FC,7E,6E,3B,3F,1C,1E,1F,1F,07,01,
                        1F,13,3D,24,7B,48,77,51,3F,23,1E,16,0C,0C,00,00,0E,08,1D,12,3B,25,36,2A,1C,14,08,08,00,00,00,00,
                        F0,E0,E0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,10,18,20,30,00,20,00,00,00,00,00,00,00,00,00,00,
                        DD,FD,C7,FD,FF,FD,FF,FD,7F,7C,3F,3D,1E,1E,00,00,00,7E,02,7C,02,7C,02,7A,03,3B,02,02,00,00,00,00,
                        98,F8,B0,F0,F0,F0,E0,E0,C0,C0,00,00,00,00,00,00,00,F0,00,E0,00,60,00,C0,00,00,00,00,00,00,00,00,
                        FF,FF,FF,7F,FF,3F,FF,1F,9E,1F,CF,87,6F,4F,30,30,E0,E0,30,30,19,19,1F,1F,67,67,33,33,10,10,00,00,
                        EA,EA,F8,E8,F8,F8,70,B0,00,E0,80,C0,00,00,00,00,06,12,14,00,E0,E0,A0,E0,E0,E0,C0,C0,00,00,00,00,
}


;;; $A200: Samus top tiles - set 3 - entry 5 ;;;
{
; 5Dh: Unused - frame 13h
; 5Dh: Unused - frame 33h
; 5Eh: Unused - frame 13h
; 5Eh: Unused - frame 33h
; 5Fh: Unused - frame 13h
; 5Fh: Unused - frame 33h
; 60h: Unused - frame 13h
; 60h: Unused - frame 33h
; 61h: Unused - frame 13h
; 61h: Unused - frame 33h
; B2h: Facing clockwise     - grapple - in air - frame 13h
; B2h: Facing clockwise     - grapple - in air - frame 33h
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |   3    |        |        |
; |        |        |        |  333   |    3333|FF33F   |
; |     83 |        |        | 3BB33  |  33F333|FFFEFF  |
; |     83D|78      |    BB3D|33AAB33 | 3F33333|3FF6EEE |
; |     D53|7853    |  BBB2D5|3A2AAB33| FF33333|33FFF9EE|
; |     338|5338    | BB22B55|B26AB33 |3FF33333|333FEE93|
; |     D53|3D3     | BA2A283|A22B3BA |83F33333|333FEFFE|
; |    D575|D33     |3BA2AB73|BABB3A  |7FF33333|3333344E|
; |--------|--------|--------|--------|--------|--------|
; |    D585|D3      |3BABBB83|BAAB3   |FFF33333|333834F |
; |   D5885|D3      |3BAAAB53|BAB3    |13FF3333|333534  |
; |   D585D|33      |3BBBBB53|3BB3    |113FF33F|FFF33   |
; |  3D585D|3       |3BBBB3D3|BB3     |111FFFFF|E9F3    |
; |   335DD|3       | 3BBB3DD|33      |1CC33FFE|EEE     |
; |     333|        |  3333D3|        |31CC13FF|FE      |
; |        |        |   3333 |        | 31C3333|        |
; |        |        |        |        |  33    |        |
; |--------|--------|--------|--------|--------|--------|
$9C:A200             db 00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
                        00,00,00,00,00,00,80,80,B0,90,E0,60,E0,A0,E0,60,00,00,00,00,00,00,80,40,A0,40,80,10,40,40,80,80,
                        00,00,00,00,00,00,0F,0E,3B,3C,67,7C,41,7D,C7,FF,00,00,00,00,00,00,01,0D,03,3A,03,64,00,6A,02,6C,
                        10,10,38,38,7C,7C,CE,FE,87,FF,8E,FE,1C,FE,B8,FC,00,00,00,00,00,30,00,38,00,5C,20,98,00,96,00,F4,
                        00,00,0F,0F,3F,3F,7F,7F,7F,7F,FF,FF,7F,7F,FF,FF,00,00,00,00,08,08,20,20,60,60,60,60,20,A0,E0,60,
                        00,00,F8,F8,EC,FC,E0,FE,FC,FB,F3,FD,F6,FF,F8,F9,00,00,C8,C8,FC,FC,7E,6E,3B,3F,1C,1E,1F,1F,07,01,
                        0D,00,19,00,1B,00,3B,20,1F,18,07,07,00,00,00,00,0D,0A,19,16,1B,15,1B,15,07,03,00,00,00,00,00,00,
                        C0,40,C0,40,C0,C0,80,80,80,80,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        DD,FD,C7,FD,FF,FD,FF,FD,7F,7C,3F,3D,1E,1E,00,00,00,7E,02,7C,02,7C,02,7A,03,3B,02,02,00,00,00,00,
                        98,F8,B0,F0,F0,F0,E0,E0,C0,C0,00,00,00,00,00,00,00,F0,00,E0,00,60,00,C0,00,00,00,00,00,00,00,00,
                        FF,FF,FF,7F,FF,3F,FF,1F,9E,1F,CF,87,6F,4F,30,30,E0,E0,30,30,19,19,1F,1F,67,67,33,33,10,10,00,00,
                        EA,EA,F8,E8,F8,F8,70,B0,00,E0,80,C0,00,00,00,00,06,12,14,00,E0,E0,A0,E0,E0,E0,C0,C0,00,00,00,00,
}


;;; $A380: Samus top tiles - set 3 - entry 6 ;;;
{
; 5Dh: Unused - frame 12h
; 5Dh: Unused - frame 32h
; 5Eh: Unused - frame 12h
; 5Eh: Unused - frame 32h
; 5Fh: Unused - frame 12h
; 5Fh: Unused - frame 32h
; 60h: Unused - frame 12h
; 60h: Unused - frame 32h
; 61h: Unused - frame 12h
; 61h: Unused - frame 32h
; B2h: Facing clockwise     - grapple - in air - frame 12h
; B2h: Facing clockwise     - grapple - in air - frame 32h
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |33FF    |
; |        |        |        |33      |    33FF|FFEEEE  |
; |     83 |        |       3|3333    |  333F3F|FFF699E3|
; |     83D|78      |       3|B2B333  | 33F3333|3FFFE9E3|
; |     D53|7853    |    B53B|A6AB3A  | 3333333|33FEEEFE|
; |     338|5338    |   BA75B|22BB32  |3F333333|333F34F |
; |     D53|3D3     | 3A2A583|22BB3   |3FF33333|3333844 |
; |    D575|D33     | 322A583|AAAB3   |3FF33333|333354  |
; |--------|--------|--------|--------|--------|--------|
; |    D585|D3      |3B22AB53|AABB    |83F33333|333353  |
; |   D5885|D3      |3BAABB53|BBBB    |7FFF3333|3FFFFF  |
; |   D585D|33      |3BBBAADD|3BB     |3FFFF333|3FF9F3  |
; |  3D585D|3       | BBABBBD|D33     |33333FFF|FEEEE   |
; |   335DD|3       | 3BBBBB3|D3      |3111FFFF|FEF3    |
; |     333|        |  3BBB3B|33      |31CC1333|3333    |
; |        |        |   33B33|3       | 33CCC11|33      |
; |        |        |    333 |        |   33CC3|3       |
; |--------|--------|--------|--------|--------|--------|
$9C:A380             db 00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
                        00,00,00,00,00,00,80,80,B0,90,E0,60,E0,A0,E0,60,00,00,00,00,00,00,80,40,A0,40,80,10,40,40,80,80,
                        00,00,00,00,01,01,01,01,0F,0B,17,1D,45,79,45,79,00,00,00,00,00,00,00,00,04,09,06,19,04,2A,04,0A,
                        00,00,C0,C0,F0,F0,BC,FC,18,FC,38,FC,38,F8,18,F8,00,00,00,00,00,00,00,A0,40,B4,00,30,00,30,00,F0,
                        00,00,0F,0F,3F,3F,7F,7F,7F,7F,FF,FF,FF,FF,FF,FF,00,00,03,03,05,05,10,10,00,00,40,40,60,60,60,60,
                        F0,F0,C0,FC,ED,F3,F5,FB,E2,FF,FA,FA,F0,F0,F8,F0,30,30,FC,FC,F2,EE,7A,7E,3F,3F,16,12,06,08,0C,00,
                        0D,00,19,00,1B,00,3B,20,1F,18,07,07,00,00,00,00,0D,0A,19,16,1B,15,1B,15,07,03,00,00,00,00,00,00,
                        C0,40,C0,40,C0,C0,80,80,80,80,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        C7,FD,CF,FD,F3,FC,6F,7E,7F,7F,3F,3F,1F,1F,0E,0E,02,4C,02,7C,03,7F,01,7F,00,3E,00,1D,00,04,00,00,
                        30,F0,F0,F0,E0,E0,E0,60,C0,40,C0,C0,80,80,00,00,00,F0,00,F0,00,60,80,80,80,80,00,00,00,00,00,00,
                        7F,7F,FF,FF,FF,FF,FF,FF,FF,8F,CF,87,63,60,19,19,20,A0,F0,70,78,78,07,07,0F,0F,30,30,1C,1C,06,06,
                        FC,F4,FC,FC,FC,EC,80,F8,B0,F0,F0,F0,C0,C0,80,80,08,00,7C,7C,68,78,F8,F8,E0,E0,00,00,00,00,00,00,
}


;;; $A500: Samus top tiles - set 3 - entry 7 ;;;
{
; 5Dh: Unused - frame 11h
; 5Dh: Unused - frame 31h
; 5Eh: Unused - frame 11h
; 5Eh: Unused - frame 31h
; 5Fh: Unused - frame 11h
; 5Fh: Unused - frame 31h
; 60h: Unused - frame 11h
; 60h: Unused - frame 31h
; 61h: Unused - frame 11h
; 61h: Unused - frame 31h
; B2h: Facing clockwise     - grapple - in air - frame 11h
; B2h: Facing clockwise     - grapple - in air - frame 31h
; |--------|--------|--------|--------|--------|--------|
; |       3|3       |      33|FFFEE   | D33333 |        |
; |      3B|333     |    333F|FEE69E3 | D575D3 |        |
; |     3BA|ABB3    |   3FFFF|FFFEE9E3|D5585D3 |        |
; |    33A2|AAB33   |  333333|3FFEFFEF|D585D33 |        |
; |   33AA6|AB3A3   |  3F3333|33FFF4F |D585D3  | 8      |
; | BA753A2|2B3B3   | 3333333|3333344 |DD85D3  |D3DD785 |
; | A2B83BA|AB33    | 3333333|3333344 |33D5D3  | D378D38|
; |BA22583B|ABB     | 3F33333|333353  | 33333  | 3585338|
; |--------|--------|--------|--------|--------|--------|
; |BA6AB5D3|BBB     | 3FF3333|333F3F  |
; |BABBBDD3|3B3     | 8FF3333|33FFF3  |
; |3BBA2BDD|333     |57FF3333|3FEEE   |
; |3BA2BBBD|D3      | 3F3FFFF|FFEFE   |
; | BBBABBD|33      |  3133FF|FFFF3   |
; | 3BBBBB3|3       |  1CCC13|3333    |
; |  333B3 |        |  3CCCCC|13      |
; |    33  |        |   3CCCC|3       |
; |--------|--------|--------|--------|
$9C:A500             db 01,01,03,03,06,07,0C,0F,18,1F,5C,77,16,77,8B,F3,00,00,00,01,00,03,00,02,01,06,18,62,00,5B,08,C5,
                        80,80,E0,E0,70,F0,38,F8,68,F8,78,F8,70,F0,60,E0,00,00,00,00,00,E0,00,E0,00,D0,00,50,00,C0,00,E0,
                        03,03,0F,0F,1F,1F,3F,3F,3F,3F,7F,7F,7F,7F,7F,7F,00,00,01,01,0F,0F,00,00,10,10,00,00,00,00,20,20,
                        E0,F8,8A,F6,E5,FB,ED,FF,FA,FA,F8,F8,F8,F8,FC,F4,F8,F8,F4,EC,FA,FE,7F,7F,3E,3A,06,00,06,00,08,00,
                        7E,3E,7E,12,EE,02,DE,06,DC,04,DC,04,FC,C4,7C,7C,40,40,7C,44,EC,94,D8,A8,D8,A8,D8,E8,38,28,00,00,
                        00,00,00,00,00,00,00,00,00,00,FA,48,76,32,6E,46,00,00,00,00,00,00,00,00,00,40,BA,B4,54,4D,28,11,
                        8F,F9,BF,F9,E7,FC,CF,FE,77,7E,7F,7F,3E,3E,0C,0C,26,DA,06,FE,03,77,01,6F,01,7F,00,3E,00,04,00,00,
                        E0,E0,E0,E0,E0,E0,C0,40,C0,C0,80,80,00,00,00,00,00,E0,00,40,00,00,80,80,00,00,00,00,00,00,00,00,
                        7F,7F,3F,3F,FF,7F,7F,7F,3F,2F,23,01,20,20,10,10,30,30,30,70,F0,30,2F,2F,03,03,1C,1C,1F,1F,0F,0F,
                        FC,FC,FC,FC,C0,F8,D0,F8,F8,F8,F0,F0,C0,40,80,80,14,14,38,38,78,78,F8,F8,F0,F0,00,00,00,00,00,00,
}


;;; $A640: Samus top tiles - set 3 - entry 8 ;;;
{
; 5Dh: Unused - frame 10h
; 5Dh: Unused - frame 30h
; 5Dh: Unused - frames 40h..41h
; 5Eh: Unused - frame 10h
; 5Eh: Unused - frame 30h
; 5Eh: Unused - frames 40h..41h
; 5Fh: Unused - frame 10h
; 5Fh: Unused - frame 30h
; 5Fh: Unused - frames 40h..41h
; 60h: Unused - frame 10h
; 60h: Unused - frame 30h
; 60h: Unused - frames 40h..41h
; 61h: Unused - frame 10h
; 61h: Unused - frame 30h
; 61h: Unused - frames 40h..41h
; B2h: Facing clockwise     - grapple - in air - frame 10h
; B2h: Facing clockwise     - grapple - in air - frame 30h
; B2h: Facing clockwise     - grapple - in air - frames 40h..41h
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |3FFEEE3 | 333333 |        |
; |        |333333  |       3|FEE699E3| D575D3 |        |
; |        |3BB3BA  |      3F|FFFFEEFE| D585D3 |        |
; |        |3AA3BA  |     3FF|FFFFEF4F| D585D3 |        |
; |       3|B2AB33  |    3F33|333FF344| D585D3 |        |
; |       3|B6AAB3  |   33333|33333834| D585D3 |83D78538|
; |     353|B22AB3  |   3F333|33333353| D585D3 |83378338|
; |     B75|3AAAB3  |   33333|3333333F| 333333 | D585D3 |
; |--------|--------|--------|--------|--------|--------|
; |    BAB8|3BBABB  |   33333|33333FF3|
; |    A225|833BBB  |   3F333|3333FF9E|
; |    A2AB|5533BB  |   3FF33|3333FEEE|
; |    A62B|BDD333  |    8FF3|333FFEF3|
; |    BABA|2BDDD3  |   57FFF|FFFFFF3 |
; |    3BA2|BBB333  |    3F33|3FF3333 |
; |     3BB|AB333   |     311|CCC113  |
; |      3B|B333    |      1C|CCCC3   |
; |--------|--------|--------|--------|
$9C:A640             db 00,00,00,00,00,00,00,00,01,01,01,01,07,05,07,06,00,00,00,00,00,00,00,00,00,00,00,00,02,00,03,04,
                        00,00,FC,FC,F8,FC,98,FC,9C,FC,8C,FC,8C,FC,8C,FC,00,00,00,00,00,6C,00,6C,00,B0,40,B8,00,98,00,78,
                        00,00,01,01,03,03,07,07,0F,0F,1F,1F,1F,1F,1F,1F,00,00,00,00,01,01,03,03,04,04,00,00,08,08,00,00,
                        E2,FE,8D,F3,F2,FF,F5,FD,FC,FC,FA,FA,FF,FD,FF,FF,7C,7C,F2,EE,FF,FF,FF,FD,1B,18,01,04,02,00,01,01,
                        7E,7E,7E,12,6E,02,6E,02,6E,02,6E,02,6E,02,7E,7E,00,00,7C,44,6C,54,6C,54,6C,54,6C,54,6C,54,00,00,
                        00,00,00,00,00,00,00,00,00,00,76,52,76,76,6E,02,00,00,00,00,00,00,00,00,00,00,34,A9,10,89,6C,54,
                        0A,0E,01,0E,01,0F,01,0F,0A,0F,0C,0F,07,07,03,03,00,0F,01,08,00,0B,04,09,00,0F,00,06,00,03,00,01,
                        EC,FC,7C,7C,FC,3C,FC,9C,7C,C4,FC,FC,78,F8,F0,F0,00,7C,00,9C,C0,0C,60,E0,38,78,00,E0,00,C0,00,80,
                        1F,1F,1F,1F,1F,1F,07,07,1F,0F,0F,0F,07,04,02,00,00,00,08,08,0C,0C,06,0E,1F,07,04,04,00,00,01,01,
                        FF,FF,FE,FD,F8,FF,FB,FF,FE,FE,FE,FE,1C,04,08,08,06,06,0D,0F,0F,0F,1E,1E,FC,FC,60,60,E0,E0,F0,F0,
}


;;; $A780: Samus top tiles - set 3 - entry 9 ;;;
{
; 5Dh: Unused - frame Fh
; 5Dh: Unused - frame 2Fh
; 5Eh: Unused - frame Fh
; 5Eh: Unused - frame 2Fh
; 5Fh: Unused - frame Fh
; 5Fh: Unused - frame 2Fh
; 60h: Unused - frame Fh
; 60h: Unused - frame 2Fh
; 61h: Unused - frame Fh
; 61h: Unused - frame 2Fh
; B2h: Facing clockwise     - grapple - in air - frame Fh
; B2h: Facing clockwise     - grapple - in air - frame 2Fh
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |EEE33   | D33333 |        |
; |       3|33333   |     3FF|699EE   | D575D3 |        |
; |       3|BAA3BA  |    3FEE|FEEE4F  |D5585D3 |        |
; |       3|BAA3BA  |    3FFF|FFEF44  |D585D33 |        |
; |       3|B2AB33  |   33FFF|FFF334  |D585D3  | 8      |
; |       3|B6AAB3  |   3F333|333833  |DD85D3  |D3DD785 |
; |       3|B22ABB  |  3F3333|333333F |33D5D3  | D378D38|
; |      35|33A2ABB |  333333|33333F3 | 33333  | 3585338|
; |--------|--------|--------|--------|--------|--------|
; |      B7|53BBABB |  3F3333|3333F9E |
; |      AB|8333BBB |  333333|333FFEEE|
; |     B22|5853333 |  333333|3333FEF3|
; |     BA2|ABBDD3D |   3F333|333FFF3 |
; |      A6|2BABDD3 |   3FFF3|33FFF33 |
; |      BA|BABBB33 |   58FFF|FFF3333 |
; |      3B|AABBB33 |   53FF3|331CC1  |
; |        |3BBB33  |     331|CCCCC3  |
; |--------|--------|--------|--------|
$9C:A780             db 00,00,01,01,01,01,01,01,01,01,01,01,01,01,03,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,
                        00,00,F8,F8,98,FC,98,FC,9C,FC,8C,FC,8C,FC,C6,FE,00,00,00,00,00,EC,00,EC,00,B0,40,B8,00,9C,00,2E,
                        00,00,07,07,0C,0F,0F,0F,1F,1F,1F,1F,3F,3F,3F,3F,00,00,03,03,07,07,07,07,07,07,08,08,10,10,00,00,
                        18,F8,60,98,84,F4,D0,F0,F8,F8,EC,EC,FE,FE,FE,FE,E0,E0,98,78,FC,F4,FC,F0,E4,E0,00,10,02,02,04,04,
                        7E,3E,7E,12,EE,02,DE,06,DC,04,DC,04,FC,C4,7C,7C,40,40,7C,44,EC,94,D8,A8,D8,A8,D8,E8,38,28,00,00,
                        00,00,00,00,00,00,00,00,00,00,FA,48,76,32,6E,46,00,00,00,00,00,00,00,00,00,40,BA,B4,54,4D,28,11,
                        03,03,01,03,04,07,04,07,00,03,02,03,03,03,00,00,01,02,00,03,00,04,00,06,01,02,00,03,00,01,00,00,
                        F6,7E,7E,7E,BE,1E,7E,E4,5E,F2,BE,FE,3E,FE,FC,FC,80,3E,00,8E,A0,40,1A,FA,0C,7C,00,F8,00,F8,00,70,
                        3F,3F,3F,3F,3F,3F,1F,1F,1F,1F,17,07,1F,0F,07,06,10,10,00,00,00,00,08,08,0E,0E,17,0F,16,06,00,00,
                        FC,FA,F8,FF,FB,FF,FE,FE,FE,FE,FE,FE,E4,C0,04,04,0A,0E,1F,1F,0E,0E,1C,1C,38,38,E0,E0,18,18,F8,F8,
}


;;; $A8C0: Samus top tiles - set 3 - entry Ah ;;;
{
; 5Dh: Unused - frame Eh
; 5Dh: Unused - frame 2Eh
; 5Eh: Unused - frame Eh
; 5Eh: Unused - frame 2Eh
; 5Fh: Unused - frame Eh
; 5Fh: Unused - frame 2Eh
; 60h: Unused - frame Eh
; 60h: Unused - frame 2Eh
; 61h: Unused - frame Eh
; 61h: Unused - frame 2Eh
; B2h: Facing clockwise     - grapple - in air - frame Eh
; B2h: Facing clockwise     - grapple - in air - frame 2Eh
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        |      EE|9E3     |
; |        |        |    3333|33      |    FF6F|9EFF    |
; |     83 |        |    32AB|BA3     |    FEEF|EF44    |
; |     83D|78      |    32AB|B3A     |   3FFFF|FF344   |
; |     D53|7853    |    3A6A|BB33    |  3FFFF3|F3833   |
; |     338|5338    |    3B22|ABB3    |  3FF333|33353F  |
; |     D53|3D3     |    3BBA|BABB    |  3F3333|333FF3  |
; |    D575|D33     |   3733B|BBBB3   |  3F3333|333FF2E |
; |--------|--------|--------|--------|--------|--------|
; |    D585|D3      |   BB873|33333   |  333333|333FFEE |
; |   D5885|D3      |  BB2B78|5DDDD   |  F33333|333FEFF |
; |   D585D|33      |  BA2ABB|BBDD3   |   33333|333FFF3 |
; |  3D585D|3       |  3B62AA|BB333   |   3F333|33FFF33 |
; |   335DD|3       |   3BABA|BBB33   |    FFF3|3FFF313 |
; |     333|        |   3BBBB|BBB33   |    8FFF|F3F31C3 |
; |        |        |    333B|B333    |    38F3|311CC3  |
; |        |        |      33|33      |     331|CCCC3   |
; |--------|--------|--------|--------|--------|--------|
$9C:A8C0             db 00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
                        00,00,00,00,00,00,80,80,B0,90,E0,60,E0,A0,E0,60,00,00,00,00,00,00,80,40,A0,40,80,10,40,40,80,80,
                        00,00,0F,0F,09,0F,09,0F,08,0F,0C,0F,0E,0F,1F,1F,00,00,00,00,00,03,00,03,02,05,00,04,00,07,08,01,
                        00,00,C0,C0,A0,E0,C0,E0,F0,F0,70,F0,B0,F0,F8,F8,00,00,00,00,00,C0,00,A0,00,C0,00,E0,00,F0,00,F0,
                        00,03,0D,0F,09,0F,1F,1F,3F,3F,3F,3F,3F,3F,3F,3F,03,03,0F,0D,0F,0F,0F,0F,1E,1E,18,18,10,10,10,10,
                        A0,60,B0,70,40,C0,E0,E0,D8,D8,FC,EC,FC,FC,F8,FE,40,C0,70,F0,F0,C0,D8,C0,80,A0,14,04,18,18,1A,1A,
                        0D,00,19,00,1B,00,3B,20,1F,18,07,07,00,00,00,00,0D,0A,19,16,1B,15,1B,15,07,03,00,00,00,00,00,00,
                        C0,40,C0,40,C0,C0,80,80,80,80,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        1B,1B,36,3E,23,3F,30,3F,1A,1F,1F,1F,0F,0F,03,03,02,1C,02,35,00,37,08,13,00,0F,00,0F,00,01,00,00,
                        F8,F8,F8,00,F8,C8,F8,F8,F8,F8,F8,F8,F0,F0,C0,C0,00,00,F8,78,30,F0,00,C0,00,E0,00,E0,00,80,00,00,
                        3F,3F,3F,3F,1F,1F,1F,1F,0F,0F,07,07,0B,0B,07,06,00,00,20,20,00,00,08,08,0E,0E,07,0F,02,06,00,00,
                        F8,FE,F6,FE,FE,FE,FE,FE,FE,FA,FA,F2,E4,84,08,08,1E,1E,1E,1E,1C,1C,38,38,70,70,A4,A4,18,18,F0,F0,
}


;;; $AA40: Samus top tiles - set 3 - entry Bh ;;;
{
; 5Dh: Unused - frame Dh
; 5Dh: Unused - frame 2Dh
; 5Eh: Unused - frame Dh
; 5Eh: Unused - frame 2Dh
; 5Fh: Unused - frame Dh
; 5Fh: Unused - frame 2Dh
; 60h: Unused - frame Dh
; 60h: Unused - frame 2Dh
; 61h: Unused - frame Dh
; 61h: Unused - frame 2Dh
; B2h: Facing clockwise     - grapple - in air - frame Dh
; B2h: Facing clockwise     - grapple - in air - frame 2Dh
; |--------|--------|--------|--------|--------|--------|
; |        |        |    33  |        |   FFEEE|E       |
; |        |        |   33A3 |        |  3FE9EF|F4      |
; |     83 |        |  333BA3|        |  FF6EEF|444     |
; |     83D|78      | 33BA333|3       | 3FEFFEF|333F    |
; |     D53|7853    |33BA2ABB|33      | 3FFFFFF|333F3   |
; |     338|5338    |3BBA622A|B33     | 3FFF333|333FEE  |
; |     D53|3D3     | 33BA2AA|AB33    | 3FF3333|333F9E3 |
; |    D575|D33     |  33BAAB|33333   |  F33333|33FFEF3 |
; |--------|--------|--------|--------|--------|--------|
; |    D585|D3      |   35533|33DDD33 |  F33333|333FFF3 |
; |   D5885|D3      |    B878|55DDDB3 |  F33333|333FFF33|
; |   D585D|33      |    BAAB|BBBBBB3 |   33333|333FF313|
; |  3D585D|3       |    BA2A|BABBB33 |   33333|33FFF1C1|
; |   335DD|3       |     A62|BABBB33 |    3333|3FFF3CC3|
; |     333|        |     3AA|BABB33  |     FFF|FF31CCC |
; |        |        |      3B|BBB33   |       8|8311CC3 |
; |        |        |        |3333    |        | 31CC3  |
; |--------|--------|--------|--------|--------|--------|
$9C:AA40             db 00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
                        00,00,00,00,00,00,80,80,B0,90,E0,60,E0,A0,E0,60,00,00,00,00,00,00,80,40,A0,40,80,10,40,40,80,80,
                        0C,0C,1A,1E,3D,3F,77,7F,E3,FF,E0,FF,70,7F,39,3F,00,00,00,04,00,06,00,18,00,37,08,71,00,1B,00,0F,
                        00,00,00,00,00,00,80,80,C0,C0,E0,E0,70,F0,F8,F8,00,00,00,00,00,00,00,00,00,00,00,80,00,C0,00,00,
                        18,1F,35,3B,31,3F,6D,7F,7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,1B,1F,3F,37,3F,3F,3F,3F,38,38,30,30,20,20,
                        00,80,80,80,00,00,F0,F0,F8,F8,F0,FC,FA,F6,F6,FE,80,80,C0,80,E0,00,10,10,10,10,1C,1C,14,1C,3C,3C,
                        0D,00,19,00,1B,00,3B,20,1F,18,07,07,00,00,00,00,0D,0A,19,16,1B,15,1B,15,07,03,00,00,00,00,00,00,
                        C0,40,C0,40,C0,C0,80,80,80,80,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        1F,13,0A,0A,09,0F,08,0F,00,07,04,07,03,03,00,00,0C,00,02,0D,00,0F,00,0D,02,04,00,03,00,01,00,00,
                        FE,C6,FE,06,FE,FE,BE,FE,BE,FE,BC,FC,F8,F8,F0,F0,38,38,F8,3C,00,FC,00,F8,00,F8,00,F0,00,E0,00,00,
                        3F,3F,3F,3F,1F,1F,1F,1F,0F,0F,07,07,00,00,00,00,20,20,20,20,00,00,00,00,00,00,07,07,00,01,00,00,
                        FE,FE,FF,FF,FF,FD,FD,F8,F9,F9,F0,E0,72,42,64,44,1C,1C,1C,1C,18,18,3A,3A,76,76,CE,CE,0C,8C,18,18,
}


;;; $ABC0: Samus top tiles - set 3 - entry Ch ;;;
{
; 5Dh: Unused - frame Ch
; 5Dh: Unused - frame 2Ch
; 5Eh: Unused - frame Ch
; 5Eh: Unused - frame 2Ch
; 5Fh: Unused - frame Ch
; 5Fh: Unused - frame 2Ch
; 60h: Unused - frame Ch
; 60h: Unused - frame 2Ch
; 61h: Unused - frame Ch
; 61h: Unused - frame 2Ch
; B2h: Facing clockwise     - grapple - in air - frame Ch
; B2h: Facing clockwise     - grapple - in air - frame 2Ch
; |--------|--------|--------|--------|--------|--------|
; |        |        |    33  |        |   FFEEE|E       |
; |        |        |   33A3 |        |  3FE9EF|F4      |
; |        |        |  333BA3|        |  FF6EEF|444     |
; |       8|        | 33BA333|3       | 3FEFFEF|333F    |
; |      8D|3       |33BA2ABB|33      | 3FFFFFF|333F3   |
; |     8D3|D7      |3BBA622A|B33     | 3FFF333|333FEE  |
; |     33D|785     | 33BA2AA|AB33    | 3FF3333|333F9E3 |
; |    3D33|853     |  33BAAB|33333   |  F33333|33FFEF3 |
; |--------|--------|--------|--------|--------|--------|
; |   3D573|333D8   |   35533|33DDD33 |  F33333|333FFF3 |
; |  3D5785|33D8    |    B878|55DDDB3 |  F33333|333FFF33|
; | 3D5785D|338     |    BAAB|BBBBBB3 |   33333|333FF313|
; | 3D785D3|3       |    BA2A|BABBB33 |   33333|33FFF1C1|
; |  3D5D33|        |     A62|BABBB33 |    3333|3FFF3CC3|
; |   3D33 |        |     3AA|BABB33  |     FFF|FF31CCC |
; |    33  |        |      3B|BBB33   |       8|8311CC3 |
; |        |        |        |3333    |        | 31CC3  |
; |--------|--------|--------|--------|--------|--------|
$9C:ABC0             db 00,00,00,00,00,00,00,00,01,00,03,01,07,06,0F,0B,00,00,00,00,00,00,00,01,01,03,02,06,01,01,04,04,
                        00,00,00,00,00,00,00,00,80,80,C0,40,A0,80,60,20,00,00,00,00,00,00,00,00,00,00,C0,80,A0,40,40,80,
                        0C,0C,1A,1E,3D,3F,77,7F,E3,FF,E0,FF,70,7F,39,3F,00,00,00,04,00,06,00,18,00,37,08,71,00,1B,00,0F,
                        00,00,00,00,00,00,80,80,C0,C0,E0,E0,70,F0,F8,F8,00,00,00,00,00,00,00,00,00,00,00,80,00,C0,00,00,
                        18,1F,35,3B,31,3F,6D,7F,7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,1B,1F,3F,37,3F,3F,3F,3F,38,38,30,30,20,20,
                        00,80,80,80,00,00,F0,F0,F8,F8,F0,FC,FA,F6,F6,FE,80,80,C0,80,E0,00,10,10,10,10,1C,1C,14,1C,3C,3C,
                        1F,13,3D,24,7B,48,77,51,3F,23,1E,16,0C,0C,00,00,0E,08,1D,12,3B,25,36,2A,1C,14,08,08,00,00,00,00,
                        F0,E0,E0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,10,18,20,30,00,20,00,00,00,00,00,00,00,00,00,00,
                        1F,13,0A,0A,09,0F,08,0F,00,07,04,07,03,03,00,00,0C,00,02,0D,00,0F,00,0D,02,04,00,03,00,01,00,00,
                        FE,C6,FE,06,FE,FE,BE,FE,BE,FE,BC,FC,F8,F8,F0,F0,38,38,F8,3C,00,FC,00,F8,00,F8,00,F0,00,E0,00,00,
                        3F,3F,3F,3F,1F,1F,1F,1F,0F,0F,07,07,00,00,00,00,20,20,20,20,00,00,00,00,00,00,07,07,00,01,00,00,
                        FE,FE,FF,FF,FF,FD,FD,F8,F9,F9,F0,E0,72,42,64,44,1C,1C,1C,1C,18,18,3A,3A,76,76,CE,CE,0C,8C,18,18,
}


;;; $AD40: Samus top tiles - set 3 - entry Dh ;;;
{
; 5Dh: Unused - frame Bh
; 5Dh: Unused - frame 2Bh
; 5Eh: Unused - frame Bh
; 5Eh: Unused - frame 2Bh
; 5Fh: Unused - frame Bh
; 5Fh: Unused - frame 2Bh
; 60h: Unused - frame Bh
; 60h: Unused - frame 2Bh
; 61h: Unused - frame Bh
; 61h: Unused - frame 2Bh
; B2h: Facing clockwise     - grapple - in air - frame Bh
; B2h: Facing clockwise     - grapple - in air - frame 2Bh
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        |    3   |        |
; |        |        |  33    |        |  EEFFF4|        |
; |        |        | 3BA2333|3       |  E9E444|3F      |
; |       8|        | 333BB3B|333333  | E9EEF33|533E    |
; |      8D|3       | 3BAABBB|BB33D33 | F6FFF33|33F9E3  |
; |     8D3|D7      | 3BA22AA|AB33DB33|FEFFFF33|3FFEF3  |
; |     33D|785     | 3BAA62A|BB35DBB3|3FFF3333|33FEEF3 |
; |    3D33|853     | 33BAAAA|B38DBBB3|33FF3333|333FFF33|
; |--------|--------|--------|--------|--------|--------|
; |   3D573|333D8   |  3BBBAB|378BABAB| FF33333|333FF313|
; |  3D5785|33D8    |    3BB3|87BBA2BB| 3F33333|3333F313|
; | 3D5785D|338     |      35|8BA2BAB3| 3F33333|333FFCCC|
; | 3D785D3|3       |      3D|5A26AB3 |  333333|333F3CC1|
; |  3D5D33|        |       D|BBAAB3  |   3F333|3FF3CCC1|
; |   3D33 |        |        |33333   |   333F3|FFF31C1 |
; |    33  |        |        |        |     33F|87F311  |
; |        |        |        |        |       3| 33     |
; |--------|--------|--------|--------|--------|--------|
$9C:AD40             db 00,00,00,00,00,00,00,00,01,00,03,01,07,06,0F,0B,00,00,00,00,00,00,00,01,01,03,02,06,01,01,04,04,
                        00,00,00,00,00,00,00,00,80,80,C0,40,A0,80,60,20,00,00,00,00,00,00,00,00,00,00,C0,80,A0,40,40,80,
                        00,00,30,30,67,7F,7F,7F,67,7F,60,7F,60,7F,70,7F,00,00,00,00,00,30,00,0D,00,3F,00,33,04,39,00,1F,
                        00,00,00,00,80,80,FC,FC,FE,F6,7F,F7,FF,E7,DF,CF,00,00,00,00,00,00,00,00,08,C8,08,CC,18,CE,10,BE,
                        08,08,0E,3E,10,28,27,5F,5F,7F,BF,FF,FF,FF,FF,FF,00,00,3F,3E,2F,38,5C,7C,7C,5C,FC,FC,70,70,30,30,
                        00,00,00,00,C0,C0,E0,70,F4,EC,EC,FC,E6,FE,FF,FF,00,00,00,00,40,40,90,10,28,38,78,78,3C,3C,1C,1C,
                        1F,13,3D,24,7B,48,77,51,3F,23,1E,16,0C,0C,00,00,0E,08,1D,12,3B,25,36,2A,1C,14,08,08,00,00,00,00,
                        F0,E0,E0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,10,18,20,30,00,20,00,00,00,00,00,00,00,00,00,00,
                        3D,3F,0F,0F,03,02,03,02,01,00,00,00,00,00,00,00,00,1F,00,06,01,00,01,01,01,01,00,00,00,00,00,00,
                        D5,DF,73,7F,4B,7F,86,7E,CC,FC,F8,F8,00,00,00,00,40,3F,40,BB,00,EE,90,4C,00,F8,00,00,00,00,00,00,
                        7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,1F,1F,07,07,01,01,60,60,20,20,20,20,00,00,08,08,02,02,01,01,00,00,
                        FF,FD,FF,FD,F8,F8,F9,F8,F1,F0,FA,F0,7C,70,60,60,18,18,08,08,1F,1F,16,16,6E,6E,E4,E4,60,A0,00,00,
}


;;; $AEC0: Samus top tiles - set 3 - entry Eh ;;;
{
; 5Dh: Unused - frame Ah
; 5Dh: Unused - frame 2Ah
; 5Eh: Unused - frame Ah
; 5Eh: Unused - frame 2Ah
; 5Fh: Unused - frame Ah
; 5Fh: Unused - frame 2Ah
; 60h: Unused - frame Ah
; 60h: Unused - frame 2Ah
; 61h: Unused - frame Ah
; 61h: Unused - frame 2Ah
; B2h: Facing clockwise     - grapple - in air - frame Ah
; B2h: Facing clockwise     - grapple - in air - frame 2Ah
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        |    3   |        |
; |        |        |  33    |        |  EEFFF4|        |
; |        |        | 3BA2333|3       |  E9E444|3F      |
; |        |  83    | 333BB3B|333333  | E9EEF33|533E    |
; |        |3335    | 3BAABBB|BB33D33 | F6FFF33|33F9E3  |
; |     333|3D388   | 3BA22AA|AB33DB33|FEFFFF33|3FFEF3  |
; |   333DD|D3577   | 3BAA62A|BB35DBB3|3FFF3333|33FEEF3 |
; |  3DDD55|5383D   | 33BAAAA|B38DBBB3|33FF3333|333FFF33|
; |--------|--------|--------|--------|--------|--------|
; |  3D5588|753533  |  3BBBAB|378BABAB| FF33333|333FF313|
; |  358885|5D3D88  |    3BB3|87BBA2BB| 3F33333|3333F313|
; |   3555D|D       |      35|8BA2BAB3| 3F33333|333FFCCC|
; |   3DDD |        |      3D|5A26AB3 |  333333|333F3CC1|
; |    3   |        |       D|BBAAB3  |   3F333|3FF3CCC1|
; |        |        |        |33333   |   333F3|FFF31C1 |
; |        |        |        |        |     33F|87F311  |
; |        |        |        |        |       3| 33     |
; |--------|--------|--------|--------|--------|--------|
$9C:AEC0             db 00,00,00,00,00,00,00,00,00,00,07,07,1F,1C,3F,20,00,00,00,00,00,00,00,00,00,00,00,00,03,03,1F,1C,
                        00,00,00,00,00,00,10,10,F0,E0,E0,A0,F8,58,D8,50,00,00,00,00,00,00,00,20,10,00,40,58,B8,80,88,28,
                        00,00,30,30,67,7F,7F,7F,67,7F,60,7F,60,7F,70,7F,00,00,00,00,00,30,00,0D,00,3F,00,33,04,39,00,1F,
                        00,00,00,00,80,80,FC,FC,FE,F6,7F,F7,FF,E7,DF,CF,00,00,00,00,00,00,00,00,08,C8,08,CC,18,CE,10,BE,
                        08,08,0E,3E,10,28,27,5F,5F,7F,BF,FF,FF,FF,FF,FF,00,00,3F,3E,2F,38,5C,7C,7C,5C,FC,FC,70,70,30,30,
                        00,00,00,00,C0,C0,E0,70,F4,EC,EC,FC,E6,FE,FF,FF,00,00,00,00,40,40,90,10,28,38,78,78,3C,3C,1C,1C,
                        3C,20,31,20,1F,10,1E,10,08,08,00,00,00,00,00,00,1C,13,11,0E,0F,01,0E,0E,00,00,00,00,00,00,00,00,
                        FC,AC,F0,20,80,00,00,00,00,00,00,00,00,00,00,00,D0,00,D0,5C,80,80,00,00,00,00,00,00,00,00,00,00,
                        3D,3F,0F,0F,03,02,03,02,01,00,00,00,00,00,00,00,00,1F,00,06,01,00,01,01,01,01,00,00,00,00,00,00,
                        D5,DF,73,7F,4B,7F,86,7E,CC,FC,F8,F8,00,00,00,00,40,3F,40,BB,00,EE,90,4C,00,F8,00,00,00,00,00,00,
                        7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,1F,1F,07,07,01,01,60,60,20,20,20,20,00,00,08,08,02,02,01,01,00,00,
                        FF,FD,FF,FD,F8,F8,F9,F8,F1,F0,FA,F0,7C,70,60,60,18,18,08,08,1F,1F,16,16,6E,6E,E4,E4,60,A0,00,00,
}


;;; $B040: Samus top tiles - set 3 - entry Fh ;;;
{
; 5Dh: Unused - frame 9
; 5Dh: Unused - frame 29h
; 5Eh: Unused - frame 9
; 5Eh: Unused - frame 29h
; 5Fh: Unused - frame 9
; 5Fh: Unused - frame 29h
; 60h: Unused - frame 9
; 60h: Unused - frame 29h
; 61h: Unused - frame 9
; 61h: Unused - frame 29h
; B2h: Facing clockwise     - grapple - in air - frame 9
; B2h: Facing clockwise     - grapple - in air - frame 29h
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        |88      |        |
; |  33    |        |        |        |335     |    3333|
; | 3BA2333|3       | 3EF443F|3EE3    |3D8     |33333DD3|
; | 333BB3B|333333  |3EF44353|F9EF33  |587     |3DDDD553|
; | 3BAABBB|BB33D33 |E9EF3833|FFEEF33 |87D     |35555873|
; | 3BA22AA|AB33DB33|E9EEF333|3FFFF313|53D     |3D888553|
; | 3BAA62A|BB35DBB3|E6FFF333|333FF31C|3D38    |33D555DD|
; | 33BAAAA|B38DBBB3|FEFF3333|3333FFCC|  D     | 3DDDD  |
; |--------|--------|--------|--------|--------|--------|
; |  3BBBAB|378BABAB|FEFF3333|3333FFCC|
; |    3BB3|87BBA2BB|3FFF3333|3333F3CC|
; |      35|8BA2BAB3| 3FF3333|3333F31C|
; |      3D|5A26AB3 |  3F3333|333FF311|
; |       D|BBAAB3  |   3F333|33FFFF3 |
; |        |33333   |    33F3|3FF873  |
; |        |        |     333|333 5   |
; |        |        |        |        |
; |--------|--------|--------|--------|
$9C:B040             db 00,00,30,30,67,7F,7F,7F,67,7F,60,7F,60,7F,70,7F,00,00,00,00,00,30,00,0D,00,3F,00,33,04,39,00,1F,
                        00,00,00,00,80,80,FC,FC,FE,F6,7F,F7,FF,E7,DF,CF,00,00,00,00,00,00,00,00,08,C8,08,CC,18,CE,10,BE,
                        00,00,00,00,53,73,A7,E5,5B,BB,4F,BF,3F,FF,BF,FF,00,00,00,00,3D,31,7A,60,B0,F4,B8,F8,F8,B8,F0,F0,
                        00,00,00,00,90,F0,DC,BC,CE,FE,FF,FD,FE,FC,FC,FC,00,00,00,00,60,60,B0,F0,F8,F8,78,78,19,19,0F,0F,
                        00,00,E0,C0,C0,80,A0,20,60,40,E0,40,E0,A0,20,00,00,C0,20,00,40,60,A0,40,60,A0,A0,20,40,50,20,20,
                        00,00,0F,0F,FF,F9,FF,81,FB,83,C7,81,FF,C0,7C,40,00,00,00,00,06,06,7E,78,7A,04,46,78,3F,23,3C,3C,
                        3D,3F,0F,0F,03,02,03,02,01,00,00,00,00,00,00,00,00,1F,00,06,01,00,01,01,01,01,00,00,00,00,00,00,
                        D5,DF,73,7F,4B,7F,86,7E,CC,FC,F8,F8,00,00,00,00,40,3F,40,BB,00,EE,90,4C,00,F8,00,00,00,00,00,00,
                        BF,FF,FF,FF,7F,7F,3F,3F,1F,1F,0F,0F,07,07,00,00,F0,F0,70,70,30,30,10,10,08,08,02,02,00,00,00,00,
                        FC,FC,FC,FC,FE,FC,FF,FC,FE,FE,EC,EC,E8,E0,00,00,0F,0F,0B,0B,09,09,18,18,3C,3C,68,70,08,00,00,00,
}


;;; $B180: Samus top tiles - set 3 - entry 10h ;;;
{
; Unused
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        | 88     |        |
; |        |        |        |        |D33     |3DDDDDD3|
; |        |        | 3EF443F|3EE3    |53D     |35555553|
; | 33333  |B33333  |3EF44353|F9EF33  |877     |38888873|
; |3A2A3333|33DBBB3 |E9EF3833|FFEEF33 |588     |35555553|
; |3333BBB3|335DAAB3|E9EEF333|3FFFF313|D35     |3DDDDDD3|
; |3BAAA2AB|B35BBBB3|E6FFF333|333FF31C|333     |33333333|
; |3BA2262B|358BBABB|FEFF3333|3333FFCC| 88     |        |
; |--------|--------|--------|--------|--------|--------|
; |3BAA22AB|385BA2B3|FEFF3333|3333FFCC|
; | 3BBBAB3|38BBBAB3|3FFF3333|3333F3CC|
; |  33BBB5|8BA2AAB3| 3FF3333|3333F31C|
; |    3335|7B22AB3 |  3F3333|333FF311|
; |       3|BAAABB  |   3F333|33FFFF3 |
; |        | BBB3   |    33F3|3FF873  |
; |        |        |     333|333 5   |
; |        |        |        |        |
; |--------|--------|--------|--------|
$9C:B180             db 00,00,00,00,00,00,7C,7C,8F,FF,FF,FF,C1,FF,C1,FF,00,00,00,00,00,00,00,00,00,50,00,0E,00,7B,04,61,
                        00,00,00,00,00,00,FC,FC,FE,DE,F3,CF,FF,DF,DB,9F,00,00,00,00,00,00,00,80,20,3C,30,1E,20,9E,40,3F,
                        00,00,00,00,53,73,A7,E5,5B,BB,4F,BF,3F,FF,BF,FF,00,00,00,00,3D,31,7A,60,B0,F4,B8,F8,F8,B8,F0,F0,
                        00,00,00,00,90,F0,DC,BC,CE,FE,FF,FD,FE,FC,FC,FC,00,00,00,00,60,60,B0,F0,F8,F8,78,78,19,19,0F,0F,
                        00,00,E0,60,E0,40,60,60,80,00,E0,40,E0,E0,00,00,00,60,80,80,A0,20,60,80,80,60,A0,80,00,00,00,60,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        C1,FF,7B,7F,3F,3E,0F,0E,01,01,00,00,00,00,00,00,00,73,00,3E,01,0E,01,00,00,00,00,00,00,00,00,00,
                        B3,9F,BB,BF,43,7F,C6,FE,8C,FC,78,78,00,00,00,00,20,5A,00,7E,00,EE,80,4C,00,FC,00,70,00,00,00,00,
                        BF,FF,FF,FF,7F,7F,3F,3F,1F,1F,0F,0F,07,07,00,00,F0,F0,70,70,30,30,10,10,08,08,02,02,00,00,00,00,
                        FC,FC,FC,FC,FE,FC,FF,FC,FE,FE,EC,EC,E8,E0,00,00,0F,0F,0B,0B,09,09,18,18,3C,3C,68,70,08,00,00,00,
}
}


;;; $B2C0..D2BF: Samus top tiles - set 4 (facing anticlockwise - grappling - in air - upside up) ;;;
{
;;; $B2C0: Samus top tiles - set 4 - entry 0 ;;;
{
; 62h: Unused - frame 8
; 62h: Unused - frame 28h
; B3h: Facing anticlockwise - grapple - in air - frame 8
; B3h: Facing anticlockwise - grapple - in air - frame 28h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |      B2|        |        | 3B33B3 |A       | 88     |        |
; |        |  333B3B|   5 333|333     |  332AB |B       |D33     |3DDDDDD3|
; |        |  BB333B|  388FF3|3F33    |   3AAB |33      |53D     |35555553|
; |        |3BBBB33B| 3FFFF33|333F3   |    B33 |AB3     |877     |38888873|
; |     3 3|3BA2ABBA|113FF333|3333F3  |        |2A33    |588     |35555553|
; |    3353|BA6AAB3B|C13F3333|3333FF3 |        |A2AB3   |D35     |3DDDDDD3|
; |  333353|A22ABB3B|CC3F3333|3333FFF3|        |AA2B3   |333     |33333333|
; |  3BB383|3AABBB33|CCFF3333|3333FFEF|        |BAAA33  | 88     |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 33AAB38|3BAB33  |CCFF3333|3333FFEF|3BAA22AB|        |
; | 3A22AB7|3BBB    |C13FF333|333FFF6E| 3BBBAB3|        |
; | BBA6BB7|73B3    |313FFFF3|333FEE9E|  33BBB5|        |
; | 3AB22AB|833     | 33FEEFF|3383FE9E|    3335| 33333  |
; | 3BA2AAB|D3      |  33FE9F|35344FE3|       3|3A2A3333|
; | 3BABBAB|DD      |    3EE3|F344FE3 |        |3333BBB3|
; |  33BAB3|3       |        |        |        |3BAAA2AB|
; |    333 |        |        |        |        |3BA2262B|
; |--------|--------|--------|--------|--------|--------|
$9C:B2C0             db 00,00,00,00,00,00,00,00,05,05,0F,0D,3F,3D,3D,3D,00,00,00,00,00,00,00,00,00,00,02,00,02,00,00,1A,
                        02,03,3F,3F,3F,3F,FF,FF,C6,FF,87,FF,0F,FF,9F,FF,00,02,00,05,00,31,00,79,00,6F,20,DD,00,9D,00,7C,
                        00,00,17,07,27,27,7F,7F,FF,3F,7F,3F,3F,3F,3F,3F,00,00,10,00,06,1E,3C,3C,18,18,90,90,D0,D0,F0,F0,
                        00,00,E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FF,FF,FD,FF,00,00,00,00,40,40,10,10,08,08,0C,0C,0E,0E,0F,0F,
                        7E,7E,32,3E,12,1E,0E,0E,00,00,00,00,00,00,00,00,00,24,00,06,00,0E,00,08,00,00,00,00,00,00,00,00,
                        00,80,80,80,C0,C0,60,E0,30,F0,18,F8,18,F8,8C,FC,00,80,00,80,00,00,00,C0,00,40,00,B0,00,D0,00,F0,
                        00,00,E0,60,E0,40,60,60,80,00,E0,40,E0,E0,00,00,00,60,80,80,A0,20,60,80,80,60,A0,80,00,00,00,60,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        66,7E,43,7F,67,7F,51,7F,61,7F,6D,7F,3B,3F,0E,0E,00,1D,01,26,09,76,00,33,00,37,00,3F,00,0E,00,00,
                        DC,FC,F0,F0,F0,F0,60,60,C0,40,C0,00,80,80,00,00,00,70,00,70,80,20,00,80,80,80,C0,C0,00,00,00,00,
                        3F,3F,7F,3F,FF,BF,73,7F,3B,3D,09,0F,00,00,00,00,F0,F0,98,98,1E,1E,1F,1F,0D,0F,06,06,00,00,00,00,
                        FD,FF,FC,FF,F2,FD,DA,DD,E5,A7,CA,CE,00,00,00,00,0F,0F,1F,1D,1D,1F,0D,2F,5E,06,BC,8C,00,00,00,00,
                        C1,FF,7B,7F,3F,3E,0F,0E,01,01,00,00,00,00,00,00,00,73,00,3E,01,0E,01,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,7C,7C,8F,FF,FF,FF,C1,FF,C1,FF,00,00,00,00,00,00,00,00,00,50,00,0E,00,7B,04,61,
}


;;; $B480: Samus top tiles - set 4 - entry 1 ;;;
{
; 62h: Unused - frame 9
; 62h: Unused - frame 29h
; B3h: Facing anticlockwise - grapple - in air - frame 9
; B3h: Facing anticlockwise - grapple - in air - frame 29h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |      B2|        |        |88      |        | 3B33B3 |A       |
; |        |  333B3B|   5 333|333     |335     |    3333|  332AB |B       |
; |        |  BB333B|  388FF3|3F33    |3D8     |33333DD3|   3AAB |33      |
; |        |3BBBB33B| 3FFFF33|333F3   |587     |3DDDD553|    B33 |AB3     |
; |     3 3|3BA2ABBA|113FF333|3333F3  |87D     |35555873|        |2A33    |
; |    3353|BA6AAB3B|C13F3333|3333FF3 |53D     |3D888553|        |A2AB3   |
; |  333353|A22ABB3B|CC3F3333|3333FFF3|3D38    |33D555DD|        |AA2B3   |
; |  3BB383|3AABBB33|CCFF3333|3333FFEF|  D     | 3DDDD  |        |BAAA33  |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 33AAB38|3BAB33  |CCFF3333|3333FFEF|3BAA22AB|        |
; | 3A22AB7|3BBB    |C13FF333|333FFF6E| 3BBBAB3|        |
; | BBA6BB7|73B3    |313FFFF3|333FEE9E|  33BBB5|        |
; | 3AB22AB|833     | 33FEEFF|3383FE9E|    3335| 33333  |
; | 3BA2AAB|D3      |  33FE9F|35344FE3|       3|3A2A3333|
; | 3BABBAB|DD      |    3EE3|F344FE3 |        |3333BBB3|
; |  33BAB3|3       |        |        |        |3BAAA2AB|
; |    333 |        |        |        |        |3BA2262B|
; |--------|--------|--------|--------|--------|--------|
$9C:B480             db 00,00,00,00,00,00,00,00,05,05,0F,0D,3F,3D,3D,3D,00,00,00,00,00,00,00,00,00,00,02,00,02,00,00,1A,
                        02,03,3F,3F,3F,3F,FF,FF,C6,FF,87,FF,0F,FF,9F,FF,00,02,00,05,00,31,00,79,00,6F,20,DD,00,9D,00,7C,
                        00,00,17,07,27,27,7F,7F,FF,3F,7F,3F,3F,3F,3F,3F,00,00,10,00,06,1E,3C,3C,18,18,90,90,D0,D0,F0,F0,
                        00,00,E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FF,FF,FD,FF,00,00,00,00,40,40,10,10,08,08,0C,0C,0E,0E,0F,0F,
                        00,00,E0,C0,C0,80,A0,20,60,40,E0,40,E0,A0,20,00,00,C0,20,00,40,60,A0,40,60,A0,A0,20,40,50,20,20,
                        00,00,0F,0F,FF,F9,FF,81,FB,83,C7,81,FF,C0,7C,40,00,00,00,00,06,06,7E,78,7A,04,46,78,3F,23,3C,3C,
                        7E,7E,32,3E,12,1E,0E,0E,00,00,00,00,00,00,00,00,00,24,00,06,00,0E,00,08,00,00,00,00,00,00,00,00,
                        00,80,80,80,C0,C0,60,E0,30,F0,18,F8,18,F8,8C,FC,00,80,00,80,00,00,00,C0,00,40,00,B0,00,D0,00,F0,
                        66,7E,43,7F,67,7F,51,7F,61,7F,6D,7F,3B,3F,0E,0E,00,1D,01,26,09,76,00,33,00,37,00,3F,00,0E,00,00,
                        DC,FC,F0,F0,F0,F0,60,60,C0,40,C0,00,80,80,00,00,00,70,00,70,80,20,00,80,80,80,C0,C0,00,00,00,00,
                        3F,3F,7F,3F,FF,BF,73,7F,3B,3D,09,0F,00,00,00,00,F0,F0,98,98,1E,1E,1F,1F,0D,0F,06,06,00,00,00,00,
                        FD,FF,FC,FF,F2,FD,DA,DD,E5,A7,CA,CE,00,00,00,00,0F,0F,1F,1D,1D,1F,0D,2F,5E,06,BC,8C,00,00,00,00,
                        C1,FF,7B,7F,3F,3E,0F,0E,01,01,00,00,00,00,00,00,00,73,00,3E,01,0E,01,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,7C,7C,8F,FF,FF,FF,C1,FF,C1,FF,00,00,00,00,00,00,00,00,00,50,00,0E,00,7B,04,61,
}


;;; $B640: Samus top tiles - set 4 - entry 2 ;;;
{
; 62h: Unused - frame Ah
; 62h: Unused - frame 2Ah
; B3h: Facing anticlockwise - grapple - in air - frame Ah
; B3h: Facing anticlockwise - grapple - in air - frame 2Ah
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |22B3    |        |753533  |  3D5588|
; |        |   3333 |     333|3       |A2B3    |        |5D3D88  |  358885|
; |    333 |33BBB3BB|   33333|3FF33   |AAB3    |2       |D       |   3555D|
; |  3B3353|3BAABB33|  3FF333|33FFFF3 |B333    |BA      |        |   3DDD |
; | 3BBB353|BA62AB3B| 78F3333|333FFEF |332B3   |3B      |        |    3   |
; |3AAAB383|A22AAB3B|3FF33333|333FFEFE|3AAAB   |A3      |        |        |
; |BB22A383|AAAABBBA|33F33333|3333FF6E| BAB3   |2B3     |        |        |
; |3AA6BB73|BABBB3BA|13F33333|333FFE9E|  33    |6A3     |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3B22AB73|BBB333BA|113F3333|333FFFE9|        |        |  3BBBAB|        |
; |BBA2AB83|B33   3B|CCFF3333|33383FFE|        |        |    3BB3|  33    |
; |3BBBABD3|3      3|CCCFFF3F|333334FE|        |        |      35| 3BA2333|
; | 3BBBDD3|        |1C13FFFF|FF3544  |  83    |        |      3D| 333BB3B|
; |  33333 |        |31113FEE|9FF3    |3335    |        |       D| 3BAABBB|
; |        |        |    33FE|E3      |3D388   |     333|        | 3BA22AA|
; |        |        |        |        |D3577   |   333DD|        | 3BAA62A|
; |        |        |        |        |5383D   |  3DDD55|        | 33BAAAA|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:B640             db 00,00,00,00,0E,0E,3F,3D,7F,7D,8D,FD,C5,FD,8F,FF,00,00,00,00,00,00,02,10,02,38,00,7A,00,CA,12,6C,
                        00,00,1E,1E,FF,FF,CF,FF,87,FF,07,FF,0E,FF,BE,FF,00,00,00,00,00,3B,00,7C,20,CD,00,9D,00,FF,00,FB,
                        00,00,07,07,1F,1F,3F,3F,5F,5F,FF,FF,FF,FF,FF,7F,00,00,00,00,00,00,18,18,50,30,60,60,20,20,20,20,
                        00,00,80,80,F8,F8,FE,FE,FA,FE,FA,FF,FC,FF,FA,FD,00,00,00,00,60,60,3C,3C,1E,1E,1F,1F,0F,0D,1D,1F,
                        30,F0,30,F0,30,F0,F0,F0,D8,F8,88,F8,58,78,30,30,00,20,00,A0,00,E0,00,80,00,10,00,78,00,70,00,00,
                        00,00,00,00,00,80,80,C0,C0,C0,40,C0,60,E0,20,E0,00,00,00,00,00,00,00,C0,00,40,00,80,00,40,80,40,
                        FC,AC,F0,20,80,00,00,00,00,00,00,00,00,00,00,00,D0,00,D0,5C,80,80,00,00,00,00,00,00,00,00,00,00,
                        3C,20,31,20,1F,10,1E,10,08,08,00,00,00,00,00,00,1C,13,11,0E,0F,01,0E,0E,00,00,00,00,00,00,00,00,
                        C7,FF,C5,FD,F7,FD,7F,79,3E,3E,00,00,00,00,00,00,02,4C,00,EE,02,7E,06,3E,00,00,00,00,00,00,00,00,
                        FE,FF,E3,E3,81,81,00,00,00,00,00,00,00,00,00,00,00,E3,00,81,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,3F,3F,3F,1F,1F,BF,1F,FC,8F,0E,0F,00,00,00,00,10,10,F0,F0,FD,FD,4F,4F,07,07,03,03,00,00,00,00,
                        FD,FE,EE,EF,FA,FB,F0,E0,F0,70,40,C0,00,00,00,00,1E,1F,07,17,07,03,DC,C0,60,E0,80,80,00,00,00,00,
                        00,00,00,00,00,00,10,10,F0,E0,E0,A0,F8,58,D8,50,00,00,00,00,00,00,00,20,10,00,40,58,B8,80,88,28,
                        00,00,00,00,00,00,00,00,00,00,07,07,1F,1C,3F,20,00,00,00,00,00,00,00,00,00,00,00,00,03,03,1F,1C,
                        3D,3F,0F,0F,03,02,03,02,01,00,00,00,00,00,00,00,00,1F,00,06,01,00,01,01,01,01,00,00,00,00,00,00,
                        00,00,30,30,67,7F,7F,7F,67,7F,60,7F,60,7F,70,7F,00,00,00,00,00,30,00,0D,00,3F,00,33,04,39,00,1F,
}


;;; $B840: Samus top tiles - set 4 - entry 3 ;;;
{
; 62h: Unused - frame Bh
; 62h: Unused - frame 2Bh
; B3h: Facing anticlockwise - grapple - in air - frame Bh
; B3h: Facing anticlockwise - grapple - in air - frame 2Bh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |22B3    |        |753533  |  3D5588|
; |        |   3333 |     333|3       |A2B3    |        |5D3D88  |  358885|
; |    333 |33BBB3BB|   33333|3FF33   |AAB3    |2       |D       |   3555D|
; |  3B3353|3BAABB33|  3FF333|33FFFF3 |B333    |BA      |        |   3DDD |
; | 3BBB353|BA62AB3B| 78F3333|333FFEF |332B3   |3B      |        |    3   |
; |3AAAB383|A22AAB3B|3FF33333|333FFEFE|3AAAB   |A3      |        |        |
; |BB22A383|AAAABBBA|33F33333|3333FF6E| BAB3   |2B3     |        |        |
; |3AA6BB73|BABBB3BA|13F33333|333FFE9E|  33    |6A3     |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3B22AB73|BBB333BA|113F3333|333FFFE9|        |        |  3BBBAB|        |
; |BBA2AB83|B33   3B|CCFF3333|33383FFE|        |        |    3BB3|  33    |
; |3BBBABD3|3      3|CCCFFF3F|333334FE|        |        |      35| 3BA2333|
; | 3BBBDD3|        |1C13FFFF|FF3544  |  83    |        |      3D| 333BB3B|
; |  33333 |        |31113FEE|9FF3    |3335    |        |       D| 3BAABBB|
; |        |        |    33FE|E3      |3D388   |     333|        | 3BA22AA|
; |        |        |        |        |D3577   |   333DD|        | 3BAA62A|
; |        |        |        |        |5383D   |  3DDD55|        | 33BAAAA|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:B840             db 00,00,00,00,0E,0E,3F,3D,7F,7D,8D,FD,C5,FD,8F,FF,00,00,00,00,00,00,02,10,02,38,00,7A,00,CA,12,6C,
                        00,00,1E,1E,FF,FF,CF,FF,87,FF,07,FF,0E,FF,BE,FF,00,00,00,00,00,3B,00,7C,20,CD,00,9D,00,FF,00,FB,
                        00,00,07,07,1F,1F,3F,3F,5F,5F,FF,FF,FF,FF,FF,7F,00,00,00,00,00,00,18,18,50,30,60,60,20,20,20,20,
                        00,00,80,80,F8,F8,FE,FE,FA,FE,FA,FF,FC,FF,FA,FD,00,00,00,00,60,60,3C,3C,1E,1E,1F,1F,0F,0D,1D,1F,
                        30,F0,30,F0,30,F0,F0,F0,D8,F8,88,F8,58,78,30,30,00,20,00,A0,00,E0,00,80,00,10,00,78,00,70,00,00,
                        00,00,00,00,00,80,80,C0,C0,C0,40,C0,60,E0,20,E0,00,00,00,00,00,00,00,C0,00,40,00,80,00,40,80,40,
                        FC,AC,F0,20,80,00,00,00,00,00,00,00,00,00,00,00,D0,00,D0,5C,80,80,00,00,00,00,00,00,00,00,00,00,
                        3C,20,31,20,1F,10,1E,10,08,08,00,00,00,00,00,00,1C,13,11,0E,0F,01,0E,0E,00,00,00,00,00,00,00,00,
                        C7,FF,C5,FD,F7,FD,7F,79,3E,3E,00,00,00,00,00,00,02,4C,00,EE,02,7E,06,3E,00,00,00,00,00,00,00,00,
                        FE,FF,E3,E3,81,81,00,00,00,00,00,00,00,00,00,00,00,E3,00,81,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,3F,3F,3F,1F,1F,BF,1F,FC,8F,0E,0F,00,00,00,00,10,10,F0,F0,FD,FD,4F,4F,07,07,03,03,00,00,00,00,
                        FD,FE,EE,EF,FA,FB,F0,E0,F0,70,40,C0,00,00,00,00,1E,1F,07,17,07,03,DC,C0,60,E0,80,80,00,00,00,00,
                        00,00,00,00,00,00,10,10,F0,E0,E0,A0,F8,58,D8,50,00,00,00,00,00,00,00,20,10,00,40,58,B8,80,88,28,
                        00,00,00,00,00,00,00,00,00,00,07,07,1F,1C,3F,20,00,00,00,00,00,00,00,00,00,00,00,00,03,03,1F,1C,
                        3D,3F,0F,0F,03,02,03,02,01,00,00,00,00,00,00,00,00,1F,00,06,01,00,01,01,01,01,00,00,00,00,00,00,
                        00,00,30,30,67,7F,7F,7F,67,7F,60,7F,60,7F,70,7F,00,00,00,00,00,30,00,0D,00,3F,00,33,04,39,00,1F,
}


;;; $BA40: Samus top tiles - set 4 - entry 4 ;;;
{
; 62h: Unused - frame Ch
; 62h: Unused - frame 2Ch
; B3h: Facing anticlockwise - grapple - in air - frame Ch
; B3h: Facing anticlockwise - grapple - in air - frame 2Ch
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |   B3BB3|333D8   |   3D573|        |
; |        |        |    3333|FF33F   |   332B3|33D8    |  3D5785|        |
; |        |        |  33F333|FFFEFF  |   3AAAB|338     | 3D5785D|        |
; |        |        | 3F33333|3FF6EEE |    BAB3|3       | 3D785D3|        |
; |    333 |        | FF33333|33FFF9EE|     33 |        |  3D5D33|3       |
; |  3A3353|3       |3FF33333|333FEE93|        |        |   3D33 |D7      |
; | 3BBB353|BABB3   |83F33333|333FEFFE|        |        |    33  |785     |
; |3BAAB353|AA62B33 |7FF33333|3333344E|        |        |        |853     |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |BB22A383|B262AB3A|FFF33333|333834F |        |        |    33  |
; |3BA6BB73|BA22AB3A|13FF3333|333534  |        |        |   33A3 |
; |3B22AB73|BAAAAB33|113FF33F|FFF33   |        |        |  333BA3|
; |BBA2AB83|BBBB3333|111FFFFF|E9F3    |       8|3       | 33BA333|
; |3BBBABD3|33333BA3|1CC33FFE|EEE     |      8D|33      |33BA2ABB|
; | 3BBBD33|   AA2B3|31CC13FF|FE      |     8D3|B33     |3BBA622A|
; |  33333 |   B62B3| 31C3333|        |     33D|AB33    | 33BA2AA|
; |        |   3AAA3|  33    |        |    3D33|33333   |  33BAAB|
; |--------|--------|--------|--------|--------|--------|--------|
$9C:BA40             db 00,00,00,00,00,00,00,00,0E,0E,2F,3D,7F,7D,CF,FD,00,00,00,00,00,00,00,00,00,00,02,10,02,38,02,78,
                        00,00,00,00,00,00,00,00,00,00,80,80,B8,F8,0E,FE,00,00,00,00,00,00,00,00,00,00,00,00,00,F0,20,C8,
                        00,00,0F,0F,3F,3F,7F,7F,7F,7F,FF,FF,7F,7F,FF,FF,00,00,00,00,08,08,20,20,60,60,60,60,20,A0,E0,60,
                        00,00,F8,F8,EC,FC,E0,FE,FC,FB,F3,FD,F6,FF,F8,F9,00,00,C8,C8,FC,FC,7E,6E,3B,3F,1C,1E,1F,1F,07,01,
                        1F,1F,1B,1F,11,1F,0B,0F,06,06,00,00,00,00,00,00,00,16,00,02,00,0F,00,0E,00,00,00,00,00,00,00,00,
                        F0,E0,E0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,10,18,20,30,00,20,00,00,00,00,00,00,00,00,00,00,
                        1F,13,3D,24,7B,48,77,51,3F,23,1E,16,0C,0C,00,00,0E,08,1D,12,3B,25,36,2A,1C,14,08,08,00,00,00,00,
                        00,00,00,00,00,00,00,00,80,80,C0,40,A0,80,60,20,00,00,00,00,00,00,00,00,00,00,C0,80,A0,40,40,80,
                        C5,FD,CF,FF,C7,FF,C5,FD,F7,FD,7F,7B,3E,3E,00,00,00,CA,12,6C,02,4C,00,EE,02,7E,04,3C,00,00,00,00,
                        86,FF,86,FF,87,FF,FF,FF,FD,FF,03,1F,13,1F,11,1F,20,8D,00,CD,00,FC,00,F0,00,06,00,1A,08,12,00,0E,
                        FF,FF,FF,7F,FF,3F,FF,1F,9E,1F,CF,87,6F,4F,30,30,E0,E0,30,30,19,19,1F,1F,67,67,33,33,10,10,00,00,
                        EA,EA,F8,E8,F8,F8,70,B0,00,E0,80,C0,00,00,00,00,06,12,14,00,E0,E0,A0,E0,E0,E0,C0,C0,00,00,00,00,
                        00,00,00,00,00,00,00,00,01,00,03,01,07,06,0F,0B,00,00,00,00,00,00,00,01,01,03,02,06,01,01,04,04,
                        00,00,00,00,00,00,80,80,C0,C0,E0,E0,70,F0,F8,F8,00,00,00,00,00,00,00,00,00,00,00,80,00,C0,00,00,
                        0C,0C,1A,1E,3D,3F,77,7F,E3,FF,E0,FF,70,7F,39,3F,00,00,00,04,00,06,00,18,00,37,08,71,00,1B,00,0F,
}


;;; $BC20: Samus top tiles - set 4 - entry 5 ;;;
{
; 62h: Unused - frame Dh
; 62h: Unused - frame 2Dh
; B3h: Facing anticlockwise - grapple - in air - frame Dh
; B3h: Facing anticlockwise - grapple - in air - frame 2Dh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |33FF    |   3AAAB|        |    33  |    D585|
; |        |        |    33FF|FFEEEE  |   B62AB|        |   33A3 |   D5885|
; |        |        |  333F3F|FFF699E3|   3A2A3|        |  333BA3|   D585D|
; |        |        | 33F3333|3FFFE9E3|  3BBAB3|3       | 33BA333|  3D585D|
; |        |        | 3333333|33FEEEFE|  3333B |33      |33BA2ABB|   335DD|
; |    3333|        |3F333333|333F34F |  3A2B3 |B33     |3BBA622A|     333|
; |  33BBAB|3       |3FF33333|3333844 |  3AABB |AB33    | 33BA2AA|        |
; |  3BAAAA|533     |3FF33333|333354  |   3B33 |33333   |  33BAAB|        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 3BB22BA|53BBB   |83F33333|333353  |D3      |        |        |
; | 3BAB2AA|8DAABB  |7FFF3333|3FFFFF  |D3      |        |        |
; | BAA62BB|7326ABB |3FFFF333|3FF9F3  |33      |        |     83 |
; | 3BA2AB7|83A22AB3|33333FFF|FEEEE   |3       |78      |     83D|
; | 3BABA58|3BAA2B33|3111FFFF|FEF3    |3       |7853    |     D53|
; |  3BBBD3|3BBBBB3B|31CC1333|3333    |        |5338    |     338|
; |   33DD3|33333B3B| 33CCC11|33      |        |3D3     |     D53|
; |     33 |  33BBB3|   33CC3|3       |        |D33     |    D575|
; |--------|--------|--------|--------|--------|--------|--------|
$9C:BC20             db 00,00,00,00,00,00,00,00,00,00,0F,0F,3D,3F,30,3F,00,00,00,00,00,00,00,00,00,00,00,00,00,0F,00,1F,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,E0,60,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,
                        00,00,0F,0F,3F,3F,7F,7F,7F,7F,FF,FF,FF,FF,FF,FF,00,00,03,03,05,05,10,10,00,00,40,40,60,60,60,60,
                        F0,F0,C0,FC,ED,F3,F5,FB,E2,FF,FA,FA,F0,F0,F8,F0,30,30,FC,FC,F2,EE,7A,7E,3F,3F,16,12,06,08,0C,00,
                        11,1F,11,1F,11,1F,3B,3F,3E,3E,26,3E,26,3E,1E,1E,00,0F,08,13,00,0A,00,1E,00,02,00,14,00,1E,00,08,
                        00,00,00,00,00,00,80,80,C0,C0,E0,E0,70,F0,F8,F8,00,00,00,00,00,00,00,00,00,00,00,80,00,C0,00,00,
                        0C,0C,1A,1E,3D,3F,77,7F,E3,FF,E0,FF,70,7F,39,3F,00,00,00,04,00,06,00,18,00,37,08,71,00,1B,00,0F,
                        0D,00,19,00,1B,00,3B,20,1F,18,07,07,00,00,00,00,0D,0A,19,16,1B,15,1B,15,07,03,00,00,00,00,00,00,
                        72,7F,68,7F,43,7F,63,7F,6A,7C,3F,3D,1F,19,06,06,00,33,00,3B,08,73,01,36,02,3D,02,1E,06,06,00,00,
                        F8,78,4C,3C,C6,FE,43,7F,C7,FF,FF,FF,FF,FF,3F,3F,80,38,40,FC,90,0E,00,A6,00,74,00,7D,00,05,00,0E,
                        7F,7F,FF,FF,FF,FF,FF,FF,FF,8F,CF,87,63,60,19,19,20,A0,F0,70,78,78,07,07,0F,0F,30,30,1C,1C,06,06,
                        FC,F4,FC,FC,FC,EC,80,F8,B0,F0,F0,F0,C0,C0,80,80,08,00,7C,7C,68,78,F8,F8,E0,E0,00,00,00,00,00,00,
                        C0,40,C0,40,C0,C0,80,80,80,80,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,80,80,B0,90,E0,60,E0,A0,E0,60,00,00,00,00,00,00,80,40,A0,40,80,10,40,40,80,80,
                        00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
}


;;; $BE00: Samus top tiles - set 4 - entry 6 ;;;
{
; 62h: Unused - frame Eh
; 62h: Unused - frame 2Eh
; B3h: Facing anticlockwise - grapple - in air - frame Eh
; B3h: Facing anticlockwise - grapple - in air - frame 2Eh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |33FF    |D3      |   3AAAB|    D585|        |
; |        |        |    33FF|FFEEEE  |D3      |   B62AB|   D5885|        |
; |        |        |  333F3F|FFF699E3|33      |   3A2A3|   D585D|        |
; |        |        | 33F3333|3FFFE9E3|3       |  3BBAB3|  3D585D|78      |
; |        |        | 3333333|33FEEEFE|3       |  3333B |   335DD|7853    |
; |    3333|        |3F333333|333F34F |        |  3A2B3 |     333|5338    |
; |  33BBAB|3       |3FF33333|3333844 |        |  3AABB |        |3D3     |
; |  3BAAAA|533     |3FF33333|333354  |        |   3B33 |        |D33     |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 3BB22BA|53BBB   |83F33333|333353  |        |        |        |
; | 3BAB2AA|8DAABB  |7FFF3333|3FFFFF  |        |33      |    3333|
; | BAA62BB|7326ABB |3FFFF333|3FF9F3  |     83 |BA3     |    32AB|
; | 3BA2AB7|83A22AB3|33333FFF|FEEEE   |     83D|B3A     |    32AB|
; | 3BABA58|3BAA2B33|3111FFFF|FEF3    |     D53|BB33    |    3A6A|
; |  3BBBD3|3BBBBB3B|31CC1333|3333    |     338|ABB3    |    3B22|
; |   33DD3|33333B3B| 33CCC11|33      |     D53|BABB    |    3BBA|
; |     33 |  33BBB3|   33CC3|3       |    D575|BBBB3   |   3733B|
; |--------|--------|--------|--------|--------|--------|--------|
$9C:BE00             db 00,00,00,00,00,00,00,00,00,00,0F,0F,3D,3F,30,3F,00,00,00,00,00,00,00,00,00,00,00,00,00,0F,00,1F,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,E0,60,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,
                        00,00,0F,0F,3F,3F,7F,7F,7F,7F,FF,FF,FF,FF,FF,FF,00,00,03,03,05,05,10,10,00,00,40,40,60,60,60,60,
                        F0,F0,C0,FC,ED,F3,F5,FB,E2,FF,FA,FA,F0,F0,F8,F0,30,30,FC,FC,F2,EE,7A,7E,3F,3F,16,12,06,08,0C,00,
                        C0,40,C0,40,C0,C0,80,80,80,80,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        11,1F,11,1F,11,1F,3B,3F,3E,3E,26,3E,26,3E,1E,1E,00,0F,08,13,00,0A,00,1E,00,02,00,14,00,1E,00,08,
                        0D,00,19,00,1B,00,3B,20,1F,18,07,07,00,00,00,00,0D,0A,19,16,1B,15,1B,15,07,03,00,00,00,00,00,00,
                        00,00,00,00,00,00,80,80,B0,90,E0,60,E0,A0,E0,60,00,00,00,00,00,00,80,40,A0,40,80,10,40,40,80,80,
                        72,7F,68,7F,43,7F,63,7F,6A,7C,3F,3D,1F,19,06,06,00,33,00,3B,08,73,01,36,02,3D,02,1E,06,06,00,00,
                        F8,78,4C,3C,C6,FE,43,7F,C7,FF,FF,FF,FF,FF,3F,3F,80,38,40,FC,90,0E,00,A6,00,74,00,7D,00,05,00,0E,
                        7F,7F,FF,FF,FF,FF,FF,FF,FF,8F,CF,87,63,60,19,19,20,A0,F0,70,78,78,07,07,0F,0F,30,30,1C,1C,06,06,
                        FC,F4,FC,FC,FC,EC,80,F8,B0,F0,F0,F0,C0,C0,80,80,08,00,7C,7C,68,78,F8,F8,E0,E0,00,00,00,00,00,00,
                        00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
                        00,00,C0,C0,A0,E0,C0,E0,F0,F0,70,F0,B0,F0,F8,F8,00,00,00,00,00,C0,00,A0,00,C0,00,E0,00,F0,00,F0,
                        00,00,0F,0F,09,0F,09,0F,08,0F,0C,0F,0E,0F,1F,1F,00,00,00,00,00,03,00,03,02,05,00,04,00,07,08,01,
}


;;; $BFE0: Samus top tiles - set 4 - entry 7 ;;;
{
; 62h: Unused - frame Fh
; 62h: Unused - frame 2Fh
; B3h: Facing anticlockwise - grapple - in air - frame Fh
; B3h: Facing anticlockwise - grapple - in air - frame 2Fh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |      33|FFFEE   |BA2AB3  |       3|        |        |
; |     333|33      |    333F|FEE69E3 |3BAB3   |      33|33333   |       3|
; |    3BBA|BB3     |   3FFFF|FFFEE9E3|23B3    |      3A|BAA3BA  |       3|
; |   3BB26|ABB3    |  333333|3FFEFFEF|AB3     |      BA|BAA3BA  |       3|
; |   BBAB2|BA33    |  3F3333|33FFF4F |BB      |      3B|B2AB33  |       3|
; |  3BA22B|A33D3   | 3333333|3333344 |33      |       3|B6AAB3  |       3|
; |  3BA2AB|B8D3B3  | 3333333|3333344 |        |        |B22ABB  |       3|
; |  3BBABB|733AAB  | 3F33333|333353  |        |        |33A2ABB |      35|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |   3B358|33A26A3 | 3FF3333|333F3F  | D33333 |        |
; |   33DD3|3BA222B | 8FF3333|33FFF3  | D575D3 |        |
; |    3333|3BBA2AB3|57FF3333|3FEEE   |D5585D3 |        |
; |        |33BBBB33| 3F3FFFF|FFEFE   |D585D33 |        |
; |        | 333B3B3|  3133FF|FFFF3   |D585D3  | 8      |
; |        | 3BB33B3|  1CCC13|3333    |DD85D3  |D3DD785 |
; |        |3BAAB33 |  3CCCCC|13      |33D5D3  | D378D38|
; |        |3A62AB  |   3CCCC|3       | 33333  | 3585338|
; |--------|--------|--------|--------|--------|--------|
$9C:BFE0             db 00,00,07,07,0E,0F,1C,1F,1A,1F,31,3F,31,3F,3B,3F,00,00,00,00,00,07,01,0C,00,1E,00,19,00,1B,00,1F,
                        00,00,C0,C0,E0,E0,70,F0,B0,F0,78,E8,BC,9C,E4,FC,00,00,00,00,00,C0,00,E0,00,C0,10,90,20,E8,80,1C,
                        03,03,0F,0F,1F,1F,3F,3F,3F,3F,7F,7F,7F,7F,7F,7F,00,00,01,01,0F,0F,00,00,10,10,00,00,00,00,20,20,
                        E0,F8,8A,F6,E5,FB,ED,FF,FA,FA,F8,F8,F8,F8,FC,F4,F8,F8,F4,EC,FA,FE,7F,7F,3E,3A,06,00,06,00,08,00,
                        8C,FC,D8,F8,70,F0,60,E0,C0,C0,C0,C0,00,00,00,00,00,D8,00,70,00,20,00,C0,00,C0,00,00,00,00,00,00,
                        01,01,03,03,02,03,02,03,03,03,01,01,00,00,00,00,00,00,00,00,00,01,00,03,00,01,00,00,00,00,00,00,
                        00,00,F8,F8,98,FC,98,FC,9C,FC,8C,FC,8C,FC,C6,FE,00,00,00,00,00,EC,00,EC,00,B0,40,B8,00,9C,00,2E,
                        00,00,01,01,01,01,01,01,01,01,01,01,01,01,03,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,
                        1E,1C,1F,19,0F,0F,00,00,00,00,00,00,00,00,00,00,02,09,06,06,00,00,00,00,00,00,00,00,00,00,00,00,
                        C2,FE,C2,FE,E3,FF,FF,FF,7F,7F,7F,7F,CE,FE,84,FC,08,24,00,62,00,76,00,3C,00,0A,00,32,00,78,20,4C,
                        7F,7F,3F,3F,FF,7F,7F,7F,3F,2F,23,01,20,20,10,10,30,30,30,70,F0,30,2F,2F,03,03,1C,1C,1F,1F,0F,0F,
                        FC,FC,FC,FC,C0,F8,D0,F8,F8,F8,F0,F0,C0,40,80,80,14,14,38,38,78,78,F8,F8,F0,F0,00,00,00,00,00,00,
                        7E,3E,7E,12,EE,02,DE,06,DC,04,DC,04,FC,C4,7C,7C,40,40,7C,44,EC,94,D8,A8,D8,A8,D8,E8,38,28,00,00,
                        00,00,00,00,00,00,00,00,00,00,FA,48,76,32,6E,46,00,00,00,00,00,00,00,00,00,40,BA,B4,54,4D,28,11,
}


;;; $C1A0: Samus top tiles - set 4 - entry 8 ;;;
{
; 62h: Unused - frame 10h
; 62h: Unused - frame 30h
; 62h: Unused - frames 40h..41h
; B3h: Facing anticlockwise - grapple - in air - frame 10h
; B3h: Facing anticlockwise - grapple - in air - frame 30h
; B3h: Facing anticlockwise - grapple - in air - frames 40h..41h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |3FFEEE3 |62B3B3  |   33BBA| 333333 |        |
; |        | 33     |       3|FEE699E3|ABAB3   |   3A3B2| D575D3 |        |
; |      33|3BB33   |      3F|FFFFEEFE|BB3     |  BAA23A| D585D3 |        |
; |     3BB|B2AAB3  |     3FF|FFFFEF4F|33      |  3BAB33| D585D3 |        |
; |    33BA|AB6AB3  |    3F33|333FF344|        |   3BB3 | D585D3 |        |
; |    3BAB|2B2BBB3 |   33333|33333834|        |    33  | D585D3 |83D78538|
; |    3BAB|ABABBB3 |   3F333|33333353|        |        | D585D3 |83378338|
; |    3BBB|BBB85B3 |   33333|3333333F|        |        | 333333 | D585D3 |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |    33D5|7853333 |   33333|33333FF3|        |        |
; |    333D|3333AA3 |   3F333|3333FF9E|333333  |        |
; |      33|3BAA22B3|   3FF33|3333FEEE|3BB3BA  |        |
; |        |3BB262BB|    8FF3|333FFEF3|3AA3BA  |        |
; |        |33BA2AB3|   57FFF|FFFFFF3 |B2AB33  |       3|
; |        |333AAAB |    3F33|3FF3333 |B6AAB3  |       3|
; |      33|3B3B333 |     311|CCC113  |B22AB3  |     353|
; |      3B|AA333B3 |      1C|CCCC3   |3AAAB3  |     B75|
; |--------|--------|--------|--------|--------|--------|
$9C:C1A0             db 00,00,00,00,03,03,07,07,0E,0F,0D,0F,0D,0F,0F,0F,00,00,00,00,00,00,00,03,00,03,00,07,00,07,00,07,
                        00,00,60,60,F8,F8,8C,FC,4C,FC,5E,FE,5E,FE,EE,E6,00,00,00,00,00,60,00,B8,20,D8,00,5C,00,FC,08,F4,
                        00,00,01,01,03,03,07,07,0F,0F,1F,1F,1F,1F,1F,1F,00,00,00,00,01,01,03,03,04,04,00,00,08,08,00,00,
                        E2,FE,8D,F3,F2,FF,F5,FD,FC,FC,FA,FA,FF,FD,FF,FF,7C,7C,F2,EE,FF,FF,FF,FD,1B,18,01,04,02,00,01,01,
                        3C,FC,58,F8,E0,E0,C0,C0,00,00,00,00,00,00,00,00,80,28,00,F0,00,C0,00,00,00,00,00,00,00,00,00,00,
                        1E,1F,16,1F,22,3F,37,3F,1E,1E,0C,0C,00,00,00,00,00,07,00,0A,00,39,00,1C,00,0C,00,00,00,00,00,00,
                        7E,7E,7E,12,6E,02,6E,02,6E,02,6E,02,6E,02,7E,7E,00,00,7C,44,6C,54,6C,54,6C,54,6C,54,6C,54,00,00,
                        00,00,00,00,00,00,00,00,00,00,76,52,76,76,6E,02,00,00,00,00,00,00,00,00,00,00,34,A9,10,89,6C,54,
                        0F,0C,0F,0E,03,03,00,00,00,00,00,00,03,03,03,03,03,02,01,01,00,00,00,00,00,00,00,00,00,00,00,01,
                        BE,9E,F2,FE,C3,FF,E3,FF,E3,FF,E2,FE,FE,FE,3E,FE,A0,40,00,0C,00,72,08,63,00,36,00,1E,00,50,00,C4,
                        1F,1F,1F,1F,1F,1F,07,07,1F,0F,0F,0F,07,04,02,00,00,00,08,08,0C,0C,06,0E,1F,07,04,04,00,00,01,01,
                        FF,FF,FE,FD,F8,FF,FB,FF,FE,FE,FE,FE,1C,04,08,08,06,06,0D,0F,0F,0F,1E,1E,FC,FC,60,60,E0,E0,F0,F0,
                        00,00,FC,FC,F8,FC,98,FC,9C,FC,8C,FC,8C,FC,8C,FC,00,00,00,00,00,6C,00,6C,00,B0,40,B8,00,98,00,78,
                        00,00,00,00,00,00,00,00,01,01,01,01,07,05,07,06,00,00,00,00,00,00,00,00,00,00,00,00,02,00,03,04,
}


;;; $C360: Samus top tiles - set 4 - entry 9 ;;;
{
; 62h: Unused - frame 11h
; 62h: Unused - frame 31h
; B3h: Facing anticlockwise - grapple - in air - frame 11h
; B3h: Facing anticlockwise - grapple - in air - frame 31h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |EEE33   |3BAAAB3 | 33B3BAB| D33333 |        |
; |        |        |     3FF|699EE   |B3B3BB3 |BA33A6A2| D575D3 |        |
; |        |        |    3FEE|FEEE4F  |B33B33  |AA2BA22A|D5585D3 |        |
; |        |        |    3FFF|FFEF44  |B3BA3   |BABBABBB|D585D33 |        |
; |       3|BBBB3   |   33FFF|FFF334  |3333    |3B333333|D585D3  | 8      |
; |      3B|ABABB3  |   3F333|333833  |        |        |DD85D3  |D3DD785 |
; |     3BA|A2A6AB3 |  3F3333|333333F |        |        |33D5D3  | D378D38|
; |     3BA|B2B2ABB |  333333|33333F3 |        |        | 33333  | 3585338|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |     3BA|BABABBBB|  3F3333|3333F9E |3       |       3|
; |     3DB|BBBBB333|  333333|333FFEEE|333     |      3B|
; |     33D|87785553|  333333|3333FEF3|ABB3    |     3BA|
; |      33|3333D33 |   3F333|333FFF3 |AAB33   |    33A2|
; |       3|3BBBBB3 |   3FFF3|33FFF33 |AB3A3   |   33AA6|
; |       3|BBA22A3 |   58FFF|FFF3333 |2B3B3   | BA753A2|
; |       3|BAA62A3 |   53FF3|331CC1  |AB33    | A2B83BA|
; |    3333|3AA22A3 |     331|CCCCC3  |ABB     |BA22583B|
; |--------|--------|--------|--------|--------|--------|
$9C:C360             db 00,00,00,00,00,00,00,00,01,01,03,03,06,07,06,07,00,00,00,00,00,00,00,00,00,00,00,01,00,03,00,03,
                        00,00,00,00,00,00,00,00,F8,F8,5C,FC,06,FE,A6,FE,00,00,00,00,00,00,00,00,00,F0,00,F8,10,AC,00,AE,
                        00,00,07,07,0C,0F,0F,0F,1F,1F,1F,1F,3F,3F,3F,3F,00,00,03,03,07,07,07,07,07,07,08,08,10,10,00,00,
                        18,F8,60,98,84,F4,D0,F0,F8,F8,EC,EC,FE,FE,FE,FE,E0,E0,98,78,FC,F4,FC,F0,E4,E0,00,10,02,02,04,04,
                        C6,FE,FE,FE,FC,FC,E8,F8,F0,F0,00,00,00,00,00,00,00,7C,00,AC,00,90,00,B0,00,00,00,00,00,00,00,00,
                        7D,7F,B0,FF,10,FF,B7,FF,FF,FF,00,00,00,00,00,00,00,17,04,CA,00,D9,00,FF,00,40,00,00,00,00,00,00,
                        7E,3E,7E,12,EE,02,DE,06,DC,04,DC,04,FC,C4,7C,7C,40,40,7C,44,EC,94,D8,A8,D8,A8,D8,E8,38,28,00,00,
                        00,00,00,00,00,00,00,00,00,00,FA,48,76,32,6E,46,00,00,00,00,00,00,00,00,00,40,BA,B4,54,4D,28,11,
                        06,07,07,05,07,06,03,03,01,01,01,01,01,01,0F,0F,00,03,02,03,01,01,00,00,00,00,00,00,00,00,00,00,
                        AF,FF,FF,FF,6F,61,FE,F6,FE,FE,C2,FE,82,FE,82,FE,00,FF,00,F8,6E,90,08,08,00,7C,00,E4,10,E4,00,64,
                        3F,3F,3F,3F,3F,3F,1F,1F,1F,1F,17,07,1F,0F,07,06,10,10,00,00,00,00,08,08,0E,0E,17,0F,16,06,00,00,
                        FC,FA,F8,FF,FB,FF,FE,FE,FE,FE,FE,FE,E4,C0,04,04,0A,0E,1F,1F,0E,0E,1C,1C,38,38,E0,E0,18,18,F8,F8,
                        80,80,E0,E0,70,F0,38,F8,68,F8,78,F8,70,F0,60,E0,00,00,00,00,00,E0,00,E0,00,D0,00,50,00,C0,00,E0,
                        01,01,03,03,06,07,0C,0F,18,1F,5C,77,16,77,8B,F3,00,00,00,01,00,03,00,02,01,06,18,62,00,5B,08,C5,
}


;;; $C520: Samus top tiles - set 4 - entry Ah ;;;
{
; 62h: Unused - frame 12h
; 62h: Unused - frame 32h
; B3h: Facing anticlockwise - grapple - in air - frame 12h
; B3h: Facing anticlockwise - grapple - in air - frame 32h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |       3|33      |      EE|9E3     |D3      |        |    D585|        |
; |     33B|BBB3    |    FF6F|9EFF    |D3      |   333  |   D5885|        |
; |     3BA|ABAB3   |    FEEF|EF44    |33      |  3BAB33|   D585D|        |
; |    3BBA|A2ABB3  |   3FFFF|FF344   |3       |  3AAA3A|  3D585D|78      |
; |    3BAB|2B26AB  |  3FFFF3|F3833   |3       |  3BA2BA|   335DD|7853    |
; |    3BBB|ABAABB  |  3FF333|33353F  |        |   3BBBA|     333|5338    |
; |    3D58|3BBBAB  |  3F3333|333FF3  |        |     33B|        |3D3     |
; |    3335|778333  |  3F3333|333FF2E |        |       3|        |D33     |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |    3B33|335553  |  333333|333FFEE |        |        |        |
; |   3BBBA|BB333   |  F33333|333FEFF |        |33      |        |
; |3333BAA2|ABB3    |   33333|333FFF3 |     83 |3333    |       3|
; |BBB33A62|AB3     |   3F333|33FFF33 |     83D|B2B333  |       3|
; |26A3BB2A|BB3     |    FFF3|3FFF313 |     D53|A6AB3A  |    B53B|
; |A22B33AB|B3      |    8FFF|F3F31C3 |     338|22BB32  |   BA75B|
; |BBAA3333|3       |    38F3|311CC3  |     D53|22BB3   | 3A2A583|
; |33333BA3|        |     331|CCCC3   |    D575|AAAB3   | 322A583|
; |--------|--------|--------|--------|--------|--------|--------|
$9C:C520             db 01,01,07,07,06,07,0E,0F,0D,0F,0F,0F,0E,08,0F,0E,00,00,00,01,00,03,00,07,00,07,00,07,06,05,01,00,
                        C0,C0,F0,F0,58,F8,1C,FC,44,FC,4C,FC,F4,FC,DC,DC,00,00,00,E0,00,F0,00,B8,10,4C,00,FC,00,7C,C0,20,
                        00,03,0D,0F,09,0F,1F,1F,3F,3F,3F,3F,3F,3F,3F,3F,03,03,0F,0D,0F,0F,0F,0F,1E,1E,18,18,10,10,10,10,
                        A0,60,B0,70,40,C0,E0,E0,D8,D8,FC,EC,FC,FC,F8,FE,40,C0,70,F0,F0,C0,D8,C0,80,A0,14,04,18,18,1A,1A,
                        C0,40,C0,40,C0,C0,80,80,80,80,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,1C,1C,37,3F,22,3F,32,3F,1E,1F,07,07,01,01,00,00,00,00,00,1C,00,1D,00,1B,00,0F,00,01,00,00,
                        0D,00,19,00,1B,00,3B,20,1F,18,07,07,00,00,00,00,0D,0A,19,16,1B,15,1B,15,07,03,00,00,00,00,00,00,
                        00,00,00,00,00,00,80,80,B0,90,E0,60,E0,A0,E0,60,00,00,00,00,00,00,80,40,A0,40,80,10,40,40,80,80,
                        0F,0F,1E,1F,F8,FF,F8,FF,1C,FF,1D,FF,CF,FF,FD,FF,00,04,00,0F,00,0E,02,E4,40,2D,00,93,00,F0,00,06,
                        FC,C4,F8,F8,70,F0,60,E0,E0,E0,C0,C0,80,80,00,00,38,00,00,C0,00,E0,00,C0,00,C0,00,80,00,00,00,00,
                        3F,3F,3F,3F,1F,1F,1F,1F,0F,0F,07,07,0B,0B,07,06,00,00,20,20,00,00,08,08,0E,0E,07,0F,02,06,00,00,
                        F8,FE,F6,FE,FE,FE,FE,FE,FE,FA,FA,F2,E4,84,08,08,1E,1E,1E,1E,1C,1C,38,38,70,70,A4,A4,18,18,F0,F0,
                        00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
                        00,00,C0,C0,F0,F0,BC,FC,18,FC,38,FC,38,F8,18,F8,00,00,00,00,00,00,00,A0,40,B4,00,30,00,30,00,F0,
                        00,00,00,00,01,01,01,01,0F,0B,17,1D,45,79,45,79,00,00,00,00,00,00,00,00,04,09,06,19,04,2A,04,0A,
}


;;; $C700: Samus top tiles - set 4 - entry Bh ;;;
{
; 62h: Unused - frame 13h
; 62h: Unused - frame 33h
; B3h: Facing anticlockwise - grapple - in air - frame 13h
; B3h: Facing anticlockwise - grapple - in air - frame 33h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        | 33     |   FFEEE|E       |D3      |    D585|        |        |
; |       3|BBBB3   |  3FE9EF|F4      |D3      |   D5885|        |        |
; |      3B|BAABB3  |  FF6EEF|444     |33      |   D585D|        |     83 |
; |      3B|ABABAB3 | 3FEFFEF|333F    |3       |  3D585D|78      |     83D|
; |     3BB|BB2ABA3 | 3FFFFFF|333F3   |3       |   335DD|7853    |     D53|
; |     383|BAB26BB3| 3FFF333|333FEE  |        |     333|5338    |     338|
; |     338|3BA2ABB3| 3FF3333|333F9E3 |        |        |3D3     |     D53|
; |33  3333|73ABBB3 |  F33333|33FFEF3 |        |        |D33     |    D575|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |BB333BBB|3833BB3 |  F33333|333FFF3 |   BB3BA|        |   3    |        |
; |AAB3BBAB|B35333  |  F33333|333FFF33|    3BA2|        |  333   |        |
; |22B3BA62|AB353   |   33333|333FF313|     3BB|        | 3BB33  |        |
; |AAB3B22A|AB33    |   33333|33FFF1C1|      3B|        |33AAB33 |    BB3D|
; |BB33BAAA|B3      |    3333|3FFF3CC3|       3|   333  |3A2AAB33|  BBB2D5|
; |33333BBB|3       |     FFF|FF31CCC |        |  3BAB3 |B26AB33 | BB22B55|
; |  BAB333|        |       8|8311CC3 |        |  BA2A33|A22B3BA | BA2A283|
; |        |        |        | 31CC3  |        |  3AAB33|BABB3A  |3BA2AB73|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:C700             db 00,00,01,01,03,03,03,03,07,07,05,05,06,06,CF,CF,00,00,00,00,00,01,00,01,00,03,00,02,00,01,00,00,
                        60,60,F8,F8,9C,FC,56,FE,CA,FE,A7,FF,C7,FF,DE,FE,00,00,00,F0,00,F8,00,FC,00,DC,08,E6,00,6E,80,3C,
                        18,1F,35,3B,31,3F,6D,7F,7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,1B,1F,3F,37,3F,3F,3F,3F,38,38,30,30,20,20,
                        00,80,80,80,00,00,F0,F0,F8,F8,F0,FC,FA,F6,F6,FE,80,80,C0,80,E0,00,10,10,10,10,1C,1C,14,1C,3C,3C,
                        C0,40,C0,40,C0,C0,80,80,80,80,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        0D,00,19,00,1B,00,3B,20,1F,18,07,07,00,00,00,00,0D,0A,19,16,1B,15,1B,15,07,03,00,00,00,00,00,00,
                        00,00,00,00,00,00,80,80,B0,90,E0,60,E0,A0,E0,60,00,00,00,00,00,00,80,40,A0,40,80,10,40,40,80,80,
                        00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
                        FF,FF,3D,FF,38,FF,38,FF,F8,FF,FF,FF,2F,3F,00,00,00,C7,00,EF,02,2C,00,E9,00,CF,00,07,00,38,00,00,
                        BE,BE,FC,DC,78,E8,70,F0,C0,C0,80,80,00,00,00,00,00,4C,20,80,10,C0,00,C0,00,80,00,00,00,00,00,00,
                        3F,3F,3F,3F,1F,1F,1F,1F,0F,0F,07,07,00,00,00,00,20,20,20,20,00,00,00,00,00,00,07,07,00,01,00,00,
                        FE,FE,FF,FF,FF,FD,FD,F8,F9,F9,F0,E0,72,42,64,44,1C,1C,1C,1C,18,18,3A,3A,76,76,CE,CE,0C,8C,18,18,
                        1E,1F,0C,0F,07,07,03,03,01,01,00,00,00,00,00,00,00,1B,00,06,00,03,00,01,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,1C,1C,36,3E,23,3F,27,3F,00,00,00,00,00,00,00,00,00,00,00,1C,00,34,00,1C,
                        10,10,38,38,7C,7C,CE,FE,87,FF,8E,FE,1C,FE,B8,FC,00,00,00,00,00,30,00,38,00,5C,20,98,00,96,00,F4,
                        00,00,00,00,00,00,0F,0E,3B,3C,67,7C,41,7D,C7,FF,00,00,00,00,00,00,01,0D,03,3A,03,64,00,6A,02,6C,
}


;;; $C900: Samus top tiles - set 4 - entry Ch ;;;
{
; 62h: Unused - frame 14h
; 62h: Unused - frame 34h
; B3h: Facing anticlockwise - grapple - in air - frame 14h
; B3h: Facing anticlockwise - grapple - in air - frame 34h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        | 33     |   FFEEE|E       |   BB3BA|        |333D8   |   3D573|
; |       3|BBBB3   |  3FE9EF|F4      |    3BA2|        |33D8    |  3D5785|
; |      3B|BAABB3  |  FF6EEF|444     |     3BB|        |338     | 3D5785D|
; |      3B|ABABAB3 | 3FEFFEF|333F    |      3B|        |3       | 3D785D3|
; |     3BB|BB2ABA3 | 3FFFFFF|333F3   |       3|   333  |        |  3D5D33|
; |     383|BAB26BB3| 3FFF333|333FEE  |        |  3BAB3 |        |   3D33 |
; |     338|3BA2ABB3| 3FF3333|333F9E3 |        |  BA2A33|        |    33  |
; |33  3333|73ABBB3 |  F33333|33FFEF3 |        |  3AAB33|        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |BB333BBB|3833BB3 |  F33333|333FFF3 |        |        |   3    |        |
; |AAB3BBAB|B35333  |  F33333|333FFF33|        |        |  333   |        |
; |22B3BA62|AB353   |   33333|333FF313|        |        | 3BB33  |        |
; |AAB3B22A|AB33    |   33333|33FFF1C1|        |       8|33AAB33 |    BB3D|
; |BB33BAAA|B3      |    3333|3FFF3CC3|3       |      8D|3A2AAB33|  BBB2D5|
; |33333BBB|3       |     FFF|FF31CCC |D7      |     8D3|B26AB33 | BB22B55|
; |  BAB333|        |       8|8311CC3 |785     |     33D|A22B3BA | BA2A283|
; |        |        |        | 31CC3  |853     |    3D33|BABB3A  |3BA2AB73|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:C900             db 00,00,01,01,03,03,03,03,07,07,05,05,06,06,CF,CF,00,00,00,00,00,01,00,01,00,03,00,02,00,01,00,00,
                        60,60,F8,F8,9C,FC,56,FE,CA,FE,A7,FF,C7,FF,DE,FE,00,00,00,F0,00,F8,00,FC,00,DC,08,E6,00,6E,80,3C,
                        18,1F,35,3B,31,3F,6D,7F,7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,1B,1F,3F,37,3F,3F,3F,3F,38,38,30,30,20,20,
                        00,80,80,80,00,00,F0,F0,F8,F8,F0,FC,FA,F6,F6,FE,80,80,C0,80,E0,00,10,10,10,10,1C,1C,14,1C,3C,3C,
                        1E,1F,0C,0F,07,07,03,03,01,01,00,00,00,00,00,00,00,1B,00,06,00,03,00,01,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,1C,1C,36,3E,23,3F,27,3F,00,00,00,00,00,00,00,00,00,00,00,1C,00,34,00,1C,
                        F0,E0,E0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,10,18,20,30,00,20,00,00,00,00,00,00,00,00,00,00,
                        1F,13,3D,24,7B,48,77,51,3F,23,1E,16,0C,0C,00,00,0E,08,1D,12,3B,25,36,2A,1C,14,08,08,00,00,00,00,
                        FF,FF,3D,FF,38,FF,38,FF,F8,FF,FF,FF,2F,3F,00,00,00,C7,00,EF,02,2C,00,E9,00,CF,00,07,00,38,00,00,
                        BE,BE,FC,DC,78,E8,70,F0,C0,C0,80,80,00,00,00,00,00,4C,20,80,10,C0,00,C0,00,80,00,00,00,00,00,00,
                        3F,3F,3F,3F,1F,1F,1F,1F,0F,0F,07,07,00,00,00,00,20,20,20,20,00,00,00,00,00,00,07,07,00,01,00,00,
                        FE,FE,FF,FF,FF,FD,FD,F8,F9,F9,F0,E0,72,42,64,44,1C,1C,1C,1C,18,18,3A,3A,76,76,CE,CE,0C,8C,18,18,
                        00,00,00,00,00,00,00,00,80,80,C0,40,A0,80,60,20,00,00,00,00,00,00,00,00,00,00,C0,80,A0,40,40,80,
                        00,00,00,00,00,00,00,00,01,00,03,01,07,06,0F,0B,00,00,00,00,00,00,00,01,01,03,02,06,01,01,04,04,
                        10,10,38,38,7C,7C,CE,FE,87,FF,8E,FE,1C,FE,B8,FC,00,00,00,00,00,30,00,38,00,5C,20,98,00,96,00,F4,
                        00,00,00,00,00,00,0F,0E,3B,3C,67,7C,41,7D,C7,FF,00,00,00,00,00,00,01,0D,03,3A,03,64,00,6A,02,6C,
}


;;; $CB00: Samus top tiles - set 4 - entry Dh ;;;
{
; 62h: Unused - frame 15h
; 62h: Unused - frame 35h
; B3h: Facing anticlockwise - grapple - in air - frame 15h
; B3h: Facing anticlockwise - grapple - in air - frame 35h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |    3   |        |   3BA2A| 3BA3   |753533  |  3D5588|
; |        |        |  EEFFF4|        |    3BAA| BA2B3  |5D3D88  |  358885|
; |        |3 33    |  E9E444|3F      |     3BB| AAB33  |D       |   3555D|
; |      3B|BBB33   | E9EEF33|533E    |     333| BBB333 |        |   3DDD |
; |      3B|BAAB33  | F6FFF33|33F9E3  |     3A2|  33BA33|        |    3   |
; |     3BB|ABAAB3  |FEFFFF33|3FFEF3  |      BA|  3BA2BB|        |        |
; |3   383B|B22BAB3 |3FFF3333|33FEEF3 |       3|   BA2AB|        |        |
; |B3 33373|AB2BAB3 |33FF3333|333FFF33|        |   3BA2A|        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |A33BB337|BA26BB3 | FF33333|333FF313|        |        |326AABB3|        |
; |B3BAAB38|7B2ABB3 | 3F33333|3333F313|        |        |BA2BB333|        |
; |33A22AB3|83BB33  | 3F33333|333FFCCC|        |        |BAAB33AA|        |
; |3B222AA3|53BB3   |  333333|333F3CC1|  83    |        |BAA333  |        |
; |3B2AABB3|5333    |   3F333|3FF3CCC1|3335    |        |BBB3    |        |
; |3BABBB33|3       |   333F3|FFF31C1 |3D388   |     333|BBB     |3  33333|
; |33BB3   |        |     33F|87F311  |D3577   |   333DD|33      |533AAAB3|
; |        |        |       3| 33     |5383D   |  3DDD55|        |5BA2AAB3|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:CB00             db 00,00,00,00,00,00,03,03,03,03,07,07,8B,8B,DF,DF,00,00,00,00,00,00,00,01,00,01,00,03,00,05,02,80,
                        00,00,00,00,B0,B0,F8,F8,9C,FC,4C,FC,96,FE,56,FE,00,00,00,00,00,00,00,E0,00,F0,00,F8,00,9C,00,DC,
                        08,08,0E,3E,10,28,27,5F,5F,7F,BF,FF,FF,FF,FF,FF,00,00,3F,3E,2F,38,5C,7C,7C,5C,FC,FC,70,70,30,30,
                        00,00,00,00,C0,C0,E0,70,F4,EC,EC,FC,E6,FE,FF,FF,00,00,00,00,40,40,90,10,28,38,78,78,3C,3C,1C,1C,
                        18,1F,0C,0F,07,07,07,07,04,07,02,03,01,01,00,00,00,0D,00,07,00,03,00,00,00,02,00,03,00,00,00,00,
                        68,78,4C,7C,1C,7C,7E,7E,3B,3F,33,3F,11,1F,18,1F,00,30,00,68,00,70,00,70,00,0C,00,1B,00,1B,00,0D,
                        FC,AC,F0,20,80,00,00,00,00,00,00,00,00,00,00,00,D0,00,D0,5C,80,80,00,00,00,00,00,00,00,00,00,00,
                        3C,20,31,20,1F,10,1E,10,08,08,00,00,00,00,00,00,1C,13,11,0E,0F,01,0E,0E,00,00,00,00,00,00,00,00,
                        7F,FF,E6,FE,C3,FF,C1,FF,C7,FF,DF,FF,F8,F8,00,00,01,98,00,BD,00,26,00,46,00,5E,00,7C,00,30,00,00,
                        8E,FE,CE,FE,7C,7C,F8,78,F0,70,80,80,00,00,00,00,10,CC,80,5C,00,B0,80,30,80,00,00,00,00,00,00,00,
                        7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,1F,1F,07,07,01,01,60,60,20,20,20,20,00,00,08,08,02,02,01,01,00,00,
                        FF,FD,FF,FD,F8,F8,F9,F8,F1,F0,FA,F0,7C,70,60,60,18,18,08,08,1F,1F,16,16,6E,6E,E4,E4,60,A0,00,00,
                        00,00,00,00,00,00,10,10,F0,E0,E0,A0,F8,58,D8,50,00,00,00,00,00,00,00,20,10,00,40,58,B8,80,88,28,
                        00,00,00,00,00,00,00,00,00,00,07,07,1F,1C,3F,20,00,00,00,00,00,00,00,00,00,00,00,00,03,03,1F,1C,
                        87,FF,9F,FF,9C,FF,9C,FC,F0,F0,E0,E0,C0,C0,00,00,20,1E,00,D8,00,F3,00,E0,00,E0,00,E0,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,9F,9F,E3,7F,C3,7F,00,00,00,00,00,00,00,00,00,00,00,00,80,1E,80,6E,
}


;;; $CD00: Samus top tiles - set 4 - entry Eh ;;;
{
; 62h: Unused - frame 16h
; 62h: Unused - frame 36h
; B3h: Facing anticlockwise - grapple - in air - frame 16h
; B3h: Facing anticlockwise - grapple - in air - frame 36h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |    3   |        |   3BA2A| 3BA3   |753533  |  3D5588|
; |        |        |  EEFFF4|        |    3BAA| BA2B3  |5D3D88  |  358885|
; |        |3 33    |  E9E444|3F      |     3BB| AAB33  |D       |   3555D|
; |      3B|BBB33   | E9EEF33|533E    |     333| BBB333 |        |   3DDD |
; |      3B|BAAB33  | F6FFF33|33F9E3  |     3A2|  33BA33|        |    3   |
; |     3BB|ABAAB3  |FEFFFF33|3FFEF3  |      BA|  3BA2BB|        |        |
; |3   383B|B22BAB3 |3FFF3333|33FEEF3 |       3|   BA2AB|        |        |
; |B3 33373|AB2BAB3 |33FF3333|333FFF33|        |   3BA2A|        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |A33BB337|BA26BB3 | FF33333|333FF313|        |        |326AABB3|        |
; |B3BAAB38|7B2ABB3 | 3F33333|3333F313|        |        |BA2BB333|        |
; |33A22AB3|83BB33  | 3F33333|333FFCCC|        |        |BAAB33AA|        |
; |3B222AA3|53BB3   |  333333|333F3CC1|  83    |        |BAA333  |        |
; |3B2AABB3|5333    |   3F333|3FF3CCC1|3335    |        |BBB3    |        |
; |3BABBB33|3       |   333F3|FFF31C1 |3D388   |     333|BBB     |3  33333|
; |33BB3   |        |     33F|87F311  |D3577   |   333DD|33      |533AAAB3|
; |        |        |       3| 33     |5383D   |  3DDD55|        |5BA2AAB3|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:CD00             db 00,00,00,00,00,00,03,03,03,03,07,07,8B,8B,DF,DF,00,00,00,00,00,00,00,01,00,01,00,03,00,05,02,80,
                        00,00,00,00,B0,B0,F8,F8,9C,FC,4C,FC,96,FE,56,FE,00,00,00,00,00,00,00,E0,00,F0,00,F8,00,9C,00,DC,
                        08,08,0E,3E,10,28,27,5F,5F,7F,BF,FF,FF,FF,FF,FF,00,00,3F,3E,2F,38,5C,7C,7C,5C,FC,FC,70,70,30,30,
                        00,00,00,00,C0,C0,E0,70,F4,EC,EC,FC,E6,FE,FF,FF,00,00,00,00,40,40,90,10,28,38,78,78,3C,3C,1C,1C,
                        18,1F,0C,0F,07,07,07,07,04,07,02,03,01,01,00,00,00,0D,00,07,00,03,00,00,00,02,00,03,00,00,00,00,
                        68,78,4C,7C,1C,7C,7E,7E,3B,3F,33,3F,11,1F,18,1F,00,30,00,68,00,70,00,70,00,0C,00,1B,00,1B,00,0D,
                        FC,AC,F0,20,80,00,00,00,00,00,00,00,00,00,00,00,D0,00,D0,5C,80,80,00,00,00,00,00,00,00,00,00,00,
                        3C,20,31,20,1F,10,1E,10,08,08,00,00,00,00,00,00,1C,13,11,0E,0F,01,0E,0E,00,00,00,00,00,00,00,00,
                        7F,FF,E6,FE,C3,FF,C1,FF,C7,FF,DF,FF,F8,F8,00,00,01,98,00,BD,00,26,00,46,00,5E,00,7C,00,30,00,00,
                        8E,FE,CE,FE,7C,7C,F8,78,F0,70,80,80,00,00,00,00,10,CC,80,5C,00,B0,80,30,80,00,00,00,00,00,00,00,
                        7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,1F,1F,07,07,01,01,60,60,20,20,20,20,00,00,08,08,02,02,01,01,00,00,
                        FF,FD,FF,FD,F8,F8,F9,F8,F1,F0,FA,F0,7C,70,60,60,18,18,08,08,1F,1F,16,16,6E,6E,E4,E4,60,A0,00,00,
                        00,00,00,00,00,00,10,10,F0,E0,E0,A0,F8,58,D8,50,00,00,00,00,00,00,00,20,10,00,40,58,B8,80,88,28,
                        00,00,00,00,00,00,00,00,00,00,07,07,1F,1C,3F,20,00,00,00,00,00,00,00,00,00,00,00,00,03,03,1F,1C,
                        87,FF,9F,FF,9C,FF,9C,FC,F0,F0,E0,E0,C0,C0,00,00,20,1E,00,D8,00,F3,00,E0,00,E0,00,E0,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,9F,9F,E3,7F,C3,7F,00,00,00,00,00,00,00,00,00,00,00,00,80,1E,80,6E,
}


;;; $CF00: Samus top tiles - set 4 - entry Fh ;;;
{
; 62h: Unused - frame 17h
; 62h: Unused - frame 37h
; B3h: Facing anticlockwise - grapple - in air - frame 17h
; B3h: Facing anticlockwise - grapple - in air - frame 37h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |  33333A| 333333 |        |33BBB333|
; |        |        |        |        |  3A23B2|  3BAB3 |        |BA262AB3|
; |        |        | 3EF443F|3EE3    |  BA33AA|  3AAB3 |        |BA2AAAB3|
; |        |        |3EF44353|F9EF33  |   33BBA|  3A2AB |        |AAAAB333|
; |        |        |E9EF3833|FFEEF33 |     3BB|  BA62B3|  BBA3  |ABB3BB33|
; |      33|3       |E9EEF333|3FFFF313|      3B|  3A2AB3| 3BA2BB |B333AA3 |
; |333333BB|BB3     |E6FFF333|333FF31C|        |  3BAAA3| 3BA2A3 |        |
; |3BB335BB|AA33    |FEFF3333|3333FFCC|        |  3BBBB3| 3BBB33 |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |AAAB38BB|BAB33   |FEFF3333|3333FFCC|        |88      |        |
; |262A38B2|26233   |3FFF3333|3333F3CC|        |335     |    3333|
; |222A37BB|ABAB3   | 3FF3333|3333F31C|        |3D8     |33333DD3|
; |AAAB37B2|2BAB3   |  3F3333|333FF311|        |587     |3DDDD553|
; |BBBB38BA|ABB3    |   3F333|33FFFF3 |B       |87D     |35555873|
; |BBB3353B|BBB3    |    33F3|3FF873  |AB3     |53D     |3D888553|
; |   3353B|B333    |     333|333 5   |B85     |3D38    |33D555DD|
; |    3333|3       |        |        |753333  |  D     | 3DDDD  |
; |--------|--------|--------|--------|--------|--------|--------|
$9C:CF00             db 00,00,00,00,00,00,00,00,00,00,03,03,FF,FF,FF,FB,00,00,00,00,00,00,00,00,00,00,00,00,00,03,04,63,
                        00,00,00,00,00,00,00,00,00,00,80,80,E0,E0,30,F0,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,C0,
                        00,00,00,00,53,73,A7,E5,5B,BB,4F,BF,3F,FF,BF,FF,00,00,00,00,3D,31,7A,60,B0,F4,B8,F8,F8,B8,F0,F0,
                        00,00,00,00,90,F0,DC,BC,CE,FE,FF,FD,FE,FC,FC,FC,00,00,00,00,60,60,B0,F0,F8,F8,78,78,19,19,0F,0F,
                        3E,3F,26,3F,2C,3F,1E,1F,07,07,03,03,00,00,00,00,00,01,00,12,00,33,00,07,00,03,00,01,00,00,00,00,
                        7E,7E,36,3E,26,3E,22,3E,23,3F,23,3F,31,3F,3F,3F,00,00,00,1C,00,1C,00,16,08,32,00,16,00,1E,00,1E,
                        00,00,00,00,00,00,00,00,34,3C,66,7E,62,7E,7E,7E,00,00,00,00,00,00,00,00,00,38,00,36,00,34,00,38,
                        FF,FF,83,FF,83,FF,0F,FF,7F,FF,F2,FE,00,00,00,00,00,38,10,C6,00,DE,00,F8,00,EC,00,8C,00,00,00,00,
                        1B,FB,0A,FB,0F,FF,1E,FF,FA,FB,FF,FB,1F,1B,0F,0F,00,F7,40,16,04,13,04,F2,00,F7,04,E1,04,01,00,00,
                        B8,F8,18,F8,58,F8,58,F8,70,F0,F0,F0,F0,F0,80,80,00,E0,40,00,00,F0,00,70,00,E0,00,E0,00,80,00,00,
                        BF,FF,FF,FF,7F,7F,3F,3F,1F,1F,0F,0F,07,07,00,00,F0,F0,70,70,30,30,10,10,08,08,02,02,00,00,00,00,
                        FC,FC,FC,FC,FE,FC,FF,FC,FE,FE,EC,EC,E8,E0,00,00,0F,0F,0B,0B,09,09,18,18,3C,3C,68,70,08,00,00,00,
                        00,00,00,00,00,00,00,00,80,80,60,E0,A0,80,FC,BC,00,00,00,00,00,00,00,00,00,80,00,C0,20,C0,C0,00,
                        00,00,E0,C0,C0,80,A0,20,60,40,E0,40,E0,A0,20,00,00,C0,20,00,40,60,A0,40,60,A0,A0,20,40,50,20,20,
                        00,00,0F,0F,FF,F9,FF,81,FB,83,C7,81,FF,C0,7C,40,00,00,00,00,06,06,7E,78,7A,04,46,78,3F,23,3C,3C,
}


;;; $D0E0: Samus top tiles - set 4 - entry 10h ;;;
{
; Unused
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |  33333A| 333333 |        | 88     |
; |        |        |        |        |  3A23B2|  3BAB3 |        |D33     |
; |        |        | 3EF443F|3EE3    |  BA33AA|  3AAB3 |        |53D     |
; |        |        |3EF44353|F9EF33  |   33BBA|  3A2AB |        |877     |
; |        |        |E9EF3833|FFEEF33 |     3BB|  BA62B3|  BBA3  |588     |
; |      33|3       |E9EEF333|3FFFF313|      3B|  3A2AB3| 3BA2BB |D35     |
; |333333BB|BB3     |E6FFF333|333FF31C|        |  3BAAA3| 3BA2A3 |333     |
; |3BB335BB|AA33    |FEFF3333|3333FFCC|        |  3BBBB3| 3BBB33 | 88     |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |AAAB38BB|BAB33   |FEFF3333|3333FFCC|        |33BBB333|        |
; |262A38B2|26233   |3FFF3333|3333F3CC|3DDDDDD3|BA262AB3|        |
; |222A37BB|ABAB3   | 3FF3333|3333F31C|35555553|BA2AAAB3|        |
; |AAAB37B2|2BAB3   |  3F3333|333FF311|38888873|AAAAB333|        |
; |BBBB38BA|ABB3    |   3F333|33FFFF3 |35555553|ABB3BB33|B       |
; |BBB3353B|BBB3    |    33F3|3FF873  |3DDDDDD3|B333AA3 |AB3     |
; |   3353B|B333    |     333|333 5   |33333333|        |B85     |
; |    3333|3       |        |        |        |        |753333  |
; |--------|--------|--------|--------|--------|--------|--------|
$9C:D0E0             db 00,00,00,00,00,00,00,00,00,00,03,03,FF,FF,FF,FB,00,00,00,00,00,00,00,00,00,00,00,00,00,03,04,63,
                        00,00,00,00,00,00,00,00,00,00,80,80,E0,E0,30,F0,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,C0,
                        00,00,00,00,53,73,A7,E5,5B,BB,4F,BF,3F,FF,BF,FF,00,00,00,00,3D,31,7A,60,B0,F4,B8,F8,F8,B8,F0,F0,
                        00,00,00,00,90,F0,DC,BC,CE,FE,FF,FD,FE,FC,FC,FC,00,00,00,00,60,60,B0,F0,F8,F8,78,78,19,19,0F,0F,
                        3E,3F,26,3F,2C,3F,1E,1F,07,07,03,03,00,00,00,00,00,01,00,12,00,33,00,07,00,03,00,01,00,00,00,00,
                        7E,7E,36,3E,26,3E,22,3E,23,3F,23,3F,31,3F,3F,3F,00,00,00,1C,00,1C,00,16,08,32,00,16,00,1E,00,1E,
                        00,00,00,00,00,00,00,00,34,3C,66,7E,62,7E,7E,7E,00,00,00,00,00,00,00,00,00,38,00,36,00,34,00,38,
                        00,00,E0,60,E0,40,60,60,80,00,E0,40,E0,E0,00,00,00,60,80,80,A0,20,60,80,80,60,A0,80,00,00,00,60,
                        1B,FB,0A,FB,0F,FF,1E,FF,FA,FB,FF,FB,1F,1B,0F,0F,00,F7,40,16,04,13,04,F2,00,F7,04,E1,04,01,00,00,
                        B8,F8,18,F8,58,F8,58,F8,70,F0,F0,F0,F0,F0,80,80,00,E0,40,00,00,F0,00,70,00,E0,00,E0,00,80,00,00,
                        BF,FF,FF,FF,7F,7F,3F,3F,1F,1F,0F,0F,07,07,00,00,F0,F0,70,70,30,30,10,10,08,08,02,02,00,00,00,00,
                        FC,FC,FC,FC,FE,FC,FF,FC,FE,FE,EC,EC,E8,E0,00,00,0F,0F,0B,0B,09,09,18,18,3C,3C,68,70,08,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        FF,FF,83,FF,83,FF,0F,FF,7F,FF,F2,FE,00,00,00,00,00,38,10,C6,00,DE,00,F8,00,EC,00,8C,00,00,00,00,
                        00,00,00,00,00,00,00,00,80,80,60,E0,A0,80,FC,BC,00,00,00,00,00,00,00,00,00,80,00,C0,20,C0,C0,00,
}
}


;;; $D2C0..EA7F: Samus top tiles - set 7 (standing, crouching, drained) ;;;
{
;;; $D2C0: Samus top tiles - set 7 - entry 0 ;;;
{
; E9h: Facing left  - Samus drained - crouching/falling - frame 8
; E9h: Facing left  - Samus drained - crouching/falling - frame 1Ah
; E9h: Facing left  - Samus drained - crouching/falling - frame 1Dh
; |--------|--------|--------|--------|--------|--------|--------|
; |  EEFFFF|F3      |BB33    |     33B|        | 3A233B |        |
; | E969FEF|FF3     |2BAB3   |    33BA|        |3A22AB  | 33BB33 |
; |EFFEEFFF|FFF33   |6A2BB3  |    3BAA|     3B3|3A2AB3  | 3BAAB3 |
; |F4FEF333|333333  |2A2BA3  |    3B2A|  BABAAB|3AB33   | 3A62A3 |
; |443EF333|3333FF3 |ABABA3  |    3B2B| 333A22B|333     | 3A22A3 |
; |438F3333|333333E |333333  |    3BA3|  3A3AA3|3       | 3BAAB3 |
; |353F3333|333333F |587853  |    3B35|  33ABB3|        | 3BB3BB3|
; |EF333333|33333383|33333   |     35D|     33 |        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:D2C0             db 0F,3F,2D,57,67,FF,AF,BF,2F,3F,5F,5F,FF,BF,7F,FF,3F,3F,57,6F,FF,FF,F8,B8,D8,18,90,30,50,10,C0,C0,
                        C0,C0,E0,E0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,80,80,C0,C0,E0,E0,00,00,0C,0C,02,02,02,02,00,02,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        00,00,00,00,07,07,29,3F,71,7F,29,3F,37,3F,06,06,00,00,00,00,00,02,00,3F,00,09,00,16,00,0E,00,00,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D3E0: Samus top tiles - set 7 - entry 1 ;;;
{
; E9h: Facing left  - Samus drained - crouching/falling - frame 7
; E9h: Facing left  - Samus drained - crouching/falling - frame 9
; E9h: Facing left  - Samus drained - crouching/falling - frame Bh
; E9h: Facing left  - Samus drained - crouching/falling - frame Eh
; E9h: Facing left  - Samus drained - crouching/falling - frame 13h
; E9h: Facing left  - Samus drained - crouching/falling - frame 17h
; |--------|--------|--------|--------|--------|--------|--------|
; |  EEFFFF|F3      |BB33    |     33B|        | 3A233B |        |
; | E969FEF|FF3     |2BAB3   |    33BA|        |3A22AB  | 33BB33 |
; |EFFEEFFF|FFF33   |6A2BB3  |    3BAA|     3B3|3A2AB3  | 3BAAB3 |
; |F4FEF333|333333  |2A2BA3  |    3B2A|  BABAAB|3AB33   | 3A62A3 |
; |443EF333|3333FF3 |ABABA3  |    3B2B| 333A22B|333     | 3A22A3 |
; |438F3333|333333E |333333  |    3BA3|  3A3AA3|3       | 3BAAB3 |
; |353F3333|333333F |587853  |    3B35|  33ABB3|        | 3BB3BB3|
; |EF333333|33333383|33333   |     35D|     33 |        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:D3E0             db 0F,3F,2D,57,67,FF,AF,BF,2F,3F,5F,5F,FF,BF,7F,FF,3F,3F,57,6F,FF,FF,F8,B8,D8,18,90,30,50,10,C0,C0,
                        C0,C0,E0,E0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,80,80,C0,C0,E0,E0,00,00,0C,0C,02,02,02,02,00,02,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        00,00,00,00,07,07,29,3F,71,7F,29,3F,37,3F,06,06,00,00,00,00,00,02,00,3F,00,09,00,16,00,0E,00,00,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D500: Samus top tiles - set 7 - entry 2 ;;;
{
; E9h: Facing left  - Samus drained - crouching/falling - frame Ah
; |--------|--------|--------|--------|--------|--------|--------|
; |  EEFFFF|F3      |BB33    |     33B|        | 3A233B |        |
; | E969FEF|FF3     |2BAB3   |    33BA|        |3A22AB  | 33BB33 |
; |EFFEEFFF|FFF33   |6A2BB3  |    3BAA|     3B3|3A2AB3  | 3BAAB3 |
; |F4FEF333|333333  |2A2BA3  |    3B2A|  BABAAB|3AB33   | 3A62A3 |
; |443EF333|3333FF3 |ABABA3  |    3B2B| 333A22B|333     | 3A22A3 |
; |438F3333|333333E |333333  |    3BA3|  3A3AA3|3       | 3BAAB3 |
; |353F3333|333333F |587853  |    3B35|  33ABB3|        | 3BB3BB3|
; |EF333333|33333383|33333   |     35D|     33 |        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:D500             db 0F,3F,2D,57,67,FF,AF,BF,2F,3F,5F,5F,FF,BF,7F,FF,3F,3F,57,6F,FF,FF,F8,B8,D8,18,90,30,50,10,C0,C0,
                        C0,C0,E0,E0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,80,80,C0,C0,E0,E0,00,00,0C,0C,02,02,02,02,00,02,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        00,00,00,00,07,07,29,3F,71,7F,29,3F,37,3F,06,06,00,00,00,00,00,02,00,3F,00,09,00,16,00,0E,00,00,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D620: Samus top tiles - set 7 - entry 3 ;;;
{
; E8h: Facing right - Samus drained - crouching/falling - frame 8
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |  EEFFFF|F3      |   33   |    3   | 3A233B |BB33    |     33B|        |
; | E969FEF|FF3     |  3DD3  |    3D  |3A22AB  |2BAB3   |    33BA| 33BB33 |
; |EFFEEFFF|FFF33   | 3D75D3 |    53  |3A2AB3  |6A2BB3  |    3BAA| 3BAAB3 |
; |F4FEF333|333333  |3D5875D3|    3D3 |3AB33   |2A2BA3  |    3B2A| 3A62A3 |
; |443EF333|3333FF3 |33D5875D|33D3853 |333     |ABABA3  |    3B2B| 3A22A3 |
; |438F3333|333333E | 33D5873|  3D53  |3       |333333  |    3BA3| 3BAAB3 |
; |353F3333|333333F |  33D533|   33   |        |587853  |    3B35| 3BB3BB3|
; |EF333333|33333383|   33338|        |        |33333   |     35D|  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:D620             db 0F,3F,2D,57,67,FF,AF,BF,2F,3F,5F,5F,FF,BF,7F,FF,3F,3F,57,6F,FF,FF,F8,B8,D8,18,90,30,50,10,C0,C0,
                        C0,C0,E0,E0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,80,80,C0,C0,E0,E0,00,00,0C,0C,02,02,02,02,00,02,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D760: Samus top tiles - set 7 - entry 4 ;;;
{
; E8h: Facing right - Samus drained - crouching/falling - frame 9
; E8h: Facing right - Samus drained - crouching/falling - frame Bh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |  EEFFFF|F3      |   33   |    3   |BB33    |     33B| 3A233B |        |
; | E969FEF|FF3     |  3DD3  |    3D  |2BAB3   |    33BA|3A22AB  | 33BB33 |
; |EFFEEFFF|FFF33   | 3D75D3 |    53  |6A2BB3  |    3BAA|3A2AB3  | 3BAAB3 |
; |F4FEF333|333333  |3D5875D3|    3D3 |2A2BA3  |    3B2A|3AB33   | 3A62A3 |
; |443EF333|3333FF3 |33D5875D|33D3853 |ABABA3  |    3B2B|333     | 3A22A3 |
; |438F3333|333333E | 33D5873|  3D53  |333333  |    3BA3|3       | 3BAAB3 |
; |353F3333|333333F |  33D533|   33   |587853  |    3B35|        | 3BB3BB3|
; |EF333333|33333383|   33338|        |33333   |     35D|        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:D760             db 0F,3F,2D,57,67,FF,AF,BF,2F,3F,5F,5F,FF,BF,7F,FF,3F,3F,57,6F,FF,FF,F8,B8,D8,18,90,30,50,10,C0,C0,
                        C0,C0,E0,E0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,80,80,C0,C0,E0,E0,00,00,0C,0C,02,02,02,02,00,02,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D8A0: Samus top tiles - set 7 - entry 5 ;;;
{
; E8h: Facing right - Samus drained - crouching/falling - frame Ah
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |  EEFFFF|F3      |   33   |    3   |BB33    |     33B| 3A233B |        |
; | E969FEF|FF3     |  3DD3  |    3D  |2BAB3   |    33BA|3A22AB  | 33BB33 |
; |EFFEEFFF|FFF33   | 3D75D3 |    53  |6A2BB3  |    3BAA|3A2AB3  | 3BAAB3 |
; |F4FEF333|333333  |3D5875D3|    3D3 |2A2BA3  |    3B2A|3AB33   | 3A62A3 |
; |443EF333|3333FF3 |33D5875D|33D3853 |ABABA3  |    3B2B|333     | 3A22A3 |
; |438F3333|333333E | 33D5873|  3D53  |333333  |    3BA3|3       | 3BAAB3 |
; |353F3333|333333F |  33D533|   33   |587853  |    3B35|        | 3BB3BB3|
; |EF333333|33333383|   33338|        |33333   |     35D|        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:D8A0             db 0F,3F,2D,57,67,FF,AF,BF,2F,3F,5F,5F,FF,BF,7F,FF,3F,3F,57,6F,FF,FF,F8,B8,D8,18,90,30,50,10,C0,C0,
                        C0,C0,E0,E0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,80,80,C0,C0,E0,E0,00,00,0C,0C,02,02,02,02,00,02,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D9E0: Samus top tiles - set 7 - entry 6 ;;;
{
; EBh: Facing left  - Samus drained - standing - frame 0
; |--------|--------|--------|--------|--------|--------|--------|
; | 3EEEEFF|FF3     |BB33    |     33B|        | 3A233B |        |
; | 44F969E|FFF3    |2BAB3   |    33BA|        |3A22AB  | 33BB33 |
; |343FEFFF|FFFF3   |6A2BB3  |    3BAA|     3B3|3A2AB3  | 3BAAB3 |
; |438FF333|333333  |2A2BA3  |    3B2A|  BABAAB|3AB33   | 3A62A3 |
; |357FF333|3333FF3 |ABABA3  |    3B2B| 333A22B|333     | 3A22A3 |
; |E73F3333|333333E |333333  |    3BA3|  3A3AA3|3       | 3BAAB3 |
; |F3333333|333333F |587853  |    3B35|  33ABB3|        | 3BB3BB3|
; |33333333|33333383|33333   |     35D|     33 |        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:D9E0             db 43,7F,1A,15,B7,BF,5F,5F,FF,BF,7F,FF,FF,FF,FF,FF,3F,3F,75,1B,5F,1F,98,38,78,18,D0,90,80,80,00,00,
                        E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,C0,C0,E0,E0,F0,F0,00,00,0C,0C,02,02,02,02,00,02,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        00,00,00,00,07,07,29,3F,71,7F,29,3F,37,3F,06,06,00,00,00,00,00,02,00,3F,00,09,00,16,00,0E,00,00,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $DB00: Samus top tiles - set 7 - entry 7 ;;;
{
; E9h: Facing left  - Samus drained - crouching/falling - frame Fh
; E9h: Facing left  - Samus drained - crouching/falling - frame 14h
; E9h: Facing left  - Samus drained - crouching/falling - frame 16h
; EBh: Facing left  - Samus drained - standing - frame 1
; EBh: Facing left  - Samus drained - standing - frame 3
; |--------|--------|--------|--------|--------|--------|--------|
; | 3EEEEFF|FF3     |BB33    |     33B|        | 3A233B |        |
; | 44F969E|FFF3    |2BAB3   |    33BA|        |3A22AB  | 33BB33 |
; |343FEFFF|FFFF3   |6A2BB3  |    3BAA|     3B3|3A2AB3  | 3BAAB3 |
; |438FF333|333333  |2A2BA3  |    3B2A|  BABAAB|3AB33   | 3A62A3 |
; |357FF333|3333FF3 |ABABA3  |    3B2B| 333A22B|333     | 3A22A3 |
; |E73F3333|333333E |333333  |    3BA3|  3A3AA3|3       | 3BAAB3 |
; |F3333333|333333F |587853  |    3B35|  33ABB3|        | 3BB3BB3|
; |33333333|33333383|33333   |     35D|     33 |        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:DB00             db 43,7F,1A,15,B7,BF,5F,5F,FF,BF,7F,FF,FF,FF,FF,FF,3F,3F,75,1B,5F,1F,98,38,78,18,D0,90,80,80,00,00,
                        E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,C0,C0,E0,E0,F0,F0,00,00,0C,0C,02,02,02,02,00,02,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        00,00,00,00,07,07,29,3F,71,7F,29,3F,37,3F,06,06,00,00,00,00,00,02,00,3F,00,09,00,16,00,0E,00,00,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $DC20: Samus top tiles - set 7 - entry 8 ;;;
{
; EBh: Facing left  - Samus drained - standing - frame 2
; |--------|--------|--------|--------|--------|--------|--------|
; | 3EEEEFF|FF3     |BB33    |     33B|        | 3A233B |        |
; | 44F969E|FFF3    |2BAB3   |    33BA|        |3A22AB  | 33BB33 |
; |343FEFFF|FFFF3   |6A2BB3  |    3BAA|     3B3|3A2AB3  | 3BAAB3 |
; |438FF333|333333  |2A2BA3  |    3B2A|  BABAAB|3AB33   | 3A62A3 |
; |357FF333|3333FF3 |ABABA3  |    3B2B| 333A22B|333     | 3A22A3 |
; |E73F3333|333333E |333333  |    3BA3|  3A3AA3|3       | 3BAAB3 |
; |F3333333|333333F |587853  |    3B35|  33ABB3|        | 3BB3BB3|
; |33333333|33333383|33333   |     35D|     33 |        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:DC20             db 43,7F,1A,15,B7,BF,5F,5F,FF,BF,7F,FF,FF,FF,FF,FF,3F,3F,75,1B,5F,1F,98,38,78,18,D0,90,80,80,00,00,
                        E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,C0,C0,E0,E0,F0,F0,00,00,0C,0C,02,02,02,02,00,02,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        00,00,00,00,07,07,29,3F,71,7F,29,3F,37,3F,06,06,00,00,00,00,00,02,00,3F,00,09,00,16,00,0E,00,00,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $DD40: Samus top tiles - set 7 - entry 9 ;;;
{
; EAh: Facing right - Samus drained - standing - frame 0
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 3EEEEFF|FF3     |   33   |    3   |BB33    |     33B| 3A233B |        |
; | 44F969E|FFF3    |  3DD3  |    3D  |2BAB3   |    33BA|3A22AB  | 33BB33 |
; |343FEFFF|FFFF3   | 3D75D3 |    53  |6A2BB3  |    3BAA|3A2AB3  | 3BAAB3 |
; |438FF333|333333  |3D5875D3|    3D3 |2A2BA3  |    3B2A|3AB33   | 3A62A3 |
; |357FF333|3333FF3 |33D5875D|33D3853 |ABABA3  |    3B2B|333     | 3A22A3 |
; |E73F3333|333333E | 33D5873|  3D53  |333333  |    3BA3|3       | 3BAAB3 |
; |F3333333|333333F |  33D533|   33   |587853  |    3B35|        | 3BB3BB3|
; |33333333|33333383|   33338|        |33333   |     35D|        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:DD40             db 43,7F,1A,15,B7,BF,5F,5F,FF,BF,7F,FF,FF,FF,FF,FF,3F,3F,75,1B,5F,1F,98,38,78,18,D0,90,80,80,00,00,
                        E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,C0,C0,E0,E0,F0,F0,00,00,0C,0C,02,02,02,02,00,02,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $DE80: Samus top tiles - set 7 - entry Ah ;;;
{
; EAh: Facing right - Samus drained - standing - frame 1
; EAh: Facing right - Samus drained - standing - frame 3
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 3EEEEFF|FF3     |   33   |    3   |BB33    |     33B| 3A233B |        |
; | 44F969E|FFF3    |  3DD3  |    3D  |2BAB3   |    33BA|3A22AB  | 33BB33 |
; |343FEFFF|FFFF3   | 3D75D3 |    53  |6A2BB3  |    3BAA|3A2AB3  | 3BAAB3 |
; |438FF333|333333  |3D5875D3|    3D3 |2A2BA3  |    3B2A|3AB33   | 3A62A3 |
; |357FF333|3333FF3 |33D5875D|33D3853 |ABABA3  |    3B2B|333     | 3A22A3 |
; |E73F3333|333333E | 33D5873|  3D53  |333333  |    3BA3|3       | 3BAAB3 |
; |F3333333|333333F |  33D533|   33   |587853  |    3B35|        | 3BB3BB3|
; |33333333|33333383|   33338|        |33333   |     35D|        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:DE80             db 43,7F,1A,15,B7,BF,5F,5F,FF,BF,7F,FF,FF,FF,FF,FF,3F,3F,75,1B,5F,1F,98,38,78,18,D0,90,80,80,00,00,
                        E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,C0,C0,E0,E0,F0,F0,00,00,0C,0C,02,02,02,02,00,02,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $DFC0: Samus top tiles - set 7 - entry Bh ;;;
{
; EAh: Facing right - Samus drained - standing - frame 2
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 3EEEEFF|FF3     |   33   |    3   |BB33    |     33B| 3A233B |        |
; | 44F969E|FFF3    |  3DD3  |    3D  |2BAB3   |    33BA|3A22AB  | 33BB33 |
; |343FEFFF|FFFF3   | 3D75D3 |    53  |6A2BB3  |    3BAA|3A2AB3  | 3BAAB3 |
; |438FF333|333333  |3D5875D3|    3D3 |2A2BA3  |    3B2A|3AB33   | 3A62A3 |
; |357FF333|3333FF3 |33D5875D|33D3853 |ABABA3  |    3B2B|333     | 3A22A3 |
; |E73F3333|333333E | 33D5873|  3D53  |333333  |    3BA3|3       | 3BAAB3 |
; |F3333333|333333F |  33D533|   33   |587853  |    3B35|        | 3BB3BB3|
; |33333333|33333383|   33338|        |33333   |     35D|        |  331AB3|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |333F3333|33333353|
; | 3FE3333|33333F3 |
; |  F9F333|33333333|
; |  FFF331|1333333 |
; |    3311|1111113 |
; |       3|331113  |
; |        |  331   |
; |        |        |
; |--------|--------|
$9C:DFC0             db 43,7F,1A,15,B7,BF,5F,5F,FF,BF,7F,FF,FF,FF,FF,FF,3F,3F,75,1B,5F,1F,98,38,78,18,D0,90,80,80,00,00,
                        E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FC,FE,FE,FE,FD,FD,C0,C0,E0,E0,F0,F0,00,00,0C,0C,02,02,02,02,00,02,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        F0,F0,58,F8,1C,FC,14,FC,54,FC,FC,FC,AC,24,F8,F8,00,C0,00,70,80,58,00,58,00,F8,00,00,A8,50,00,00,
                        07,07,0E,0F,0C,0F,0C,0F,0D,0F,0D,0F,0F,0E,07,04,00,01,00,03,00,07,00,05,00,05,00,06,01,04,03,01,
                        4E,7E,84,FC,8C,FC,B8,F8,E0,E0,80,80,00,00,00,00,00,22,00,4C,00,58,00,60,00,00,00,00,00,00,00,00,
                        00,00,7E,7E,66,7E,42,7E,42,7E,66,7E,7F,7F,3B,37,00,00,00,18,00,3C,10,24,00,24,00,3C,00,36,00,06,
                        FF,FF,6F,7F,3F,2F,3F,3E,0F,0C,01,01,00,00,00,00,10,10,30,30,28,38,38,38,00,00,00,00,00,00,00,00,
                        FF,FD,FE,FE,FF,FF,FE,7E,FE,02,FC,C4,38,30,00,00,02,00,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $E100: Samus top tiles - set 7 - entry Ch ;;;
{
; 1: Facing right - normal - frame 0
; 1: Facing right - normal - frame 5
; 27h: Facing right - crouching - frame 0
; 27h: Facing right - crouching - frame 5
; 47h: Unused - frame 0
; 47h: Unused - frame 5
; 89h: Facing right - ran into a wall - frame 0
; 89h: Facing right - ran into a wall - frame 5
; A8h: Facing right - grappling - frame 0
; A8h: Facing right - grappling - frame 5
; B4h: Facing right - grappling - crouching - frame 0
; B4h: Facing right - grappling - crouching - frame 5
; |--------|--------|--------|--------|--------|--------|
; |F3BA2B2B|ABF3    |     FFF|FF      |        |        |
; |F3BBABAB|B3FF    |   3EF69|9EF     |D33     |3DDDDDD3|
; |F3333BBD|5DFE    |  3FFFFF|FFFF    |53D3    |35555553|
; |FF358785|33FFB   | 3FF3333|334F    |7383    |38888873|
; |5F3DD333|B3F33   | F33ABAB|3344    |5353    |35555553|
; |8D133BAA|BB33BBB | 33B2A2A|B734    |D3D3    |3DDDDDD3|
; |  13BA62|AB333BAB|F3BA2A22|AB53    |333     |33333333|
; |  33BA22|AB3 3A26|33B22B6A|AB3F    |        |        |
; |--------|--------|--------|--------|--------|--------|
; |   3BBAA|AB3 3BAA|F3BA2B2B|ABF3    |
; |     B33|BB   3BB|F3BBABAB|B3FF    |
; |     3AA|33    33|F3333BBD|5DFE    |
; |      BB|33      |FF358785|33FFB   |
; |        |        |5F3DD333|B3F33   |
; |        |        |8D133BAA|BB33BBB |
; |        |        |  13BA62|AB333BAB|
; |        |        |  33BA22|AB3 3A26|
; |--------|--------|--------|--------|
$9C:E100             db E5,FF,F5,FF,FF,FE,F5,E4,FF,67,7C,1F,38,1F,38,3F,80,B5,80,BF,81,87,D5,CA,D8,58,40,C7,02,0C,00,0C,
                        70,F0,F0,F0,E0,30,F8,F8,F8,F8,FE,FE,7D,FF,68,EF,20,E0,30,B0,F0,70,30,38,20,A0,00,CE,00,C7,01,C4,
                        07,07,15,1E,3F,3F,7F,7F,75,7F,70,7F,E0,FF,E4,FF,07,07,0E,0D,1F,1F,30,30,40,4F,00,15,80,B4,02,25,
                        C0,C0,A0,60,F0,F0,D0,D0,C0,C0,E0,E0,70,D0,70,F0,C0,C0,60,E0,F0,F0,30,10,30,00,50,80,20,C0,10,D0,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        1C,1F,07,07,04,07,03,03,00,00,00,00,00,00,00,00,00,0F,00,04,00,03,00,03,00,00,00,00,00,00,00,00,
                        6C,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,C7,00,C3,00,00,00,00,00,00,00,00,00,00,00,00,
                        E5,FF,F5,FF,FF,FE,F5,E4,FF,67,7C,1F,38,1F,38,3F,80,B5,80,BF,81,87,D5,CA,D8,58,40,C7,02,0C,00,0C,
                        70,F0,F0,F0,E0,30,F8,F8,F8,F8,FE,FE,7D,FF,68,EF,20,E0,30,B0,F0,70,30,38,20,A0,00,CE,00,C7,01,C4,
}


;;; $E240: Samus top tiles - set 7 - entry Dh ;;;
{
; 1: Facing right - normal - frame 1
; 1: Facing right - normal - frame 3
; 1: Facing right - normal - frame 6
; 1: Facing right - normal - frame 8
; 27h: Facing right - crouching - frame 1
; 27h: Facing right - crouching - frame 3
; 27h: Facing right - crouching - frame 6
; 27h: Facing right - crouching - frame 8
; 47h: Unused - frame 1
; 47h: Unused - frame 3
; 47h: Unused - frame 6
; 47h: Unused - frame 8
; 89h: Facing right - ran into a wall - frame 1
; 89h: Facing right - ran into a wall - frame 3
; 89h: Facing right - ran into a wall - frame 6
; 89h: Facing right - ran into a wall - frame 8
; A8h: Facing right - grappling - frame 1
; A8h: Facing right - grappling - frame 3
; A8h: Facing right - grappling - frame 6
; A8h: Facing right - grappling - frame 8
; B4h: Facing right - grappling - crouching - frame 1
; B4h: Facing right - grappling - crouching - frame 3
; B4h: Facing right - grappling - crouching - frame 6
; B4h: Facing right - grappling - crouching - frame 8
; |--------|--------|--------|--------|--------|--------|
; |F3BA2B2B|ABF3    |     FFF|EF      |        |        |
; |F3BBBBBB|BBFE    |   FEF29|9EE     |D33     |3DDDDDD3|
; |F33333D5|5DFE    |  FF3333|FFFE    |53D3    |3555D553|
; |F335878D|33FFB   | F33BBBB|334F    |8383    |35885853|
; |8F333BBB|B3F33   | F3BABAB|B334    |53D3    |35D55553|
; |5D133BAA|AB33BBB | 3BB2A2A|B734    |D3D3    |3DDDDDD3|
; | 313BA62|AB333BAB|F3BA2A22|AB53    |333     |33333333|
; |  33BA22|AB3 3226|33B22B6A|AB3F    |        |        |
; |--------|--------|--------|--------|--------|--------|
; |   B3BAA|AB3 3BA2|F3BA2B2B|ABF3    |
; |     333|33   3BB|F3BBBBBB|BBFE    |
; |     3BA|33    33|F33333D5|5DFE    |
; |      3B|33      |F335878D|33FFB   |
; |        |        |8F333BBB|B3F33   |
; |        |        |5D133BAA|AB33BBB |
; |        |        | 313BA62|AB333BAB|
; |        |        |  33BA22|AB3 3226|
; |--------|--------|--------|--------|
$9C:E240             db E5,FF,FF,FF,FF,FC,F5,E4,7F,7F,FC,1F,78,5F,38,3F,80,B5,80,BF,83,82,95,8B,40,C7,C0,47,02,0C,00,0C,
                        70,F0,E0,F0,E0,30,F8,F8,F8,F8,7E,FE,7D,FF,68,EF,20,E0,30,F0,F0,70,30,38,20,A0,00,CE,00,C7,01,C0,
                        07,07,15,1E,3F,3F,7F,7F,75,7F,70,7F,E0,FF,E4,FF,07,07,1C,1D,30,30,40,4F,40,5F,00,35,80,B4,02,25,
                        40,C0,80,60,E0,F0,D0,D0,E0,E0,E0,E0,70,D0,70,F0,C0,C0,60,E0,F0,F0,30,10,10,80,50,80,20,C0,10,D0,
                        00,00,E0,60,F0,50,50,50,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,00,A0,A0,20,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,CB,81,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,08,4A,34,7E,20,7E,7E,00,00,00,00,
                        1C,1F,07,07,06,07,03,03,00,00,00,00,00,00,00,00,00,17,00,00,00,03,00,01,00,00,00,00,00,00,00,00,
                        6C,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,C6,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        E5,FF,FF,FF,FF,FC,F5,E4,7F,7F,FC,1F,78,5F,38,3F,80,B5,80,BF,83,82,95,8B,40,C7,C0,47,02,0C,00,0C,
                        70,F0,E0,F0,E0,30,F8,F8,F8,F8,7E,FE,7D,FF,68,EF,20,E0,30,F0,F0,70,30,38,20,A0,00,CE,00,C7,01,C0,
}


;;; $E380: Samus top tiles - set 7 - entry Eh ;;;
{
; 1: Facing right - normal - frame 2
; 27h: Facing right - crouching - frame 2
; 47h: Unused - frame 2
; 89h: Facing right - ran into a wall - frame 2
; A8h: Facing right - grappling - frame 2
; B4h: Facing right - grappling - crouching - frame 2
; |--------|--------|--------|--------|--------|--------|
; |F3BA2B2B|ABF3    |     FFF|EE      |        |        |
; |F3BBBBBB|B3FE    |   FEFA9|9EE     |D33     |3DDDDDD3|
; |F33333D8|85FE    |  FF333F|FF5E    |53D3    |3DDDD553|
; |5F358778|33FFB   | 333BBB3|F34F    |8383    |35885853|
; |8D133BBB|B3F33   | F3BABAB|3534    |D353    |3DD5D5D3|
; |5D13BBAA|AB33BBB | 3BA2A2A|B734    |D3D3    |3DDDDDD3|
; |  13BA62|AB333BAB|F3BA2A22|AB5E    |333     |33333333|
; |   3BA22|AB3 3226|33B22B6A|AB33    |        |        |
; |--------|--------|--------|--------|--------|--------|
; |   B3BAA|AB3 3BA2|F3BA2B2B|ABF3    |
; |     333|33   3BB|F3BBBBBB|B3FE    |
; |     3BA|B3    33|F33333D8|85FE    |
; |      3B|B3      |5F358778|33FFB   |
; |        |        |8D133BBB|B3F33   |
; |        |        |5D13BBAA|AB33BBB |
; |        |        |  13BA62|AB333BAB|
; |        |        |   3BA22|AB3 3226|
; |--------|--------|--------|--------|
$9C:E380             db E5,FF,FF,FF,FE,FC,F6,66,7F,1F,FC,1F,38,1F,18,1F,80,B5,80,BF,82,83,D6,49,40,C7,C0,4F,02,0C,00,0C,
                        70,F0,E0,F0,60,30,F8,F8,F8,F8,7E,FE,7D,FF,68,EF,20,E0,30,B0,70,B0,30,38,20,A0,00,CE,00,C7,01,C0,
                        07,07,15,1E,3F,3F,7F,7F,75,7F,60,7F,E0,FF,E4,FF,07,07,1C,1F,31,31,00,0E,40,5F,00,35,80,B4,02,25,
                        00,C0,80,60,E0,D0,D0,D0,E0,A0,E0,E0,60,D0,70,F0,C0,C0,60,E0,F0,D0,B0,90,50,00,50,80,30,D0,00,C0,
                        00,00,E0,60,F0,50,50,50,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,00,A0,A0,80,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,CB,81,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,78,4A,34,7E,6A,7E,7E,00,00,00,00,
                        1C,1F,07,07,06,07,03,03,00,00,00,00,00,00,00,00,00,17,00,00,00,03,00,01,00,00,00,00,00,00,00,00,
                        6C,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,C6,00,03,00,80,00,80,00,00,00,00,00,00,00,00,
                        E5,FF,FF,FF,FE,FC,F6,66,7F,1F,FC,1F,38,1F,18,1F,80,B5,80,BF,82,83,D6,49,40,C7,C0,4F,02,0C,00,0C,
                        70,F0,E0,F0,60,30,F8,F8,F8,F8,7E,FE,7D,FF,68,EF,20,E0,30,B0,70,B0,30,38,20,A0,00,CE,00,C7,01,C0,
}


;;; $E4C0: Samus top tiles - set 7 - entry Fh ;;;
{
; 2: Facing left  - normal - frame 0
; 2: Facing left  - normal - frame 5
; 28h: Facing left  - crouching - frame 0
; 28h: Facing left  - crouching - frame 5
; 48h: Unused - frame 0
; 48h: Unused - frame 5
; 8Ah: Facing left  - ran into a wall - frame 0
; 8Ah: Facing left  - ran into a wall - frame 5
; A9h: Facing left  - grappling - frame 0
; A9h: Facing left  - grappling - frame 5
; B5h: Facing left  - grappling - crouching - frame 0
; B5h: Facing left  - grappling - crouching - frame 5
; |--------|--------|--------|--------|--------|--------|
; |    33BA|B2B2BB3F|      FE|FFF     |        |        |
; |    FF3B|BABABB3F|     FE9|96FE3   |D33     |3DDDDDD3|
; |    EF35|DBBB333F|    FFFF|FFFFF3  |53D3    |35555553|
; |    EF33|58785D3F|    F433|3333FF3 |7383    |38888873|
; |    3F3B|333333DD|    443B|BABA33F |5353    |35555553|
; | BB333BA|AAAB3138|    43BB|A2A2B333|D3D3    |3DDDDDD3|
; |B2A333A2|26AB31  |    35BA|22A2AB3F|333     |33333333|
; |AA3AB3A2|22A333  |    F3BA|A6B2AB33|        |        |
; |--------|--------|--------|--------|--------|--------|
; |B326AB3A|2AB31   |    33BA|B2B2BB3F|
; |3BA2A33B|AB3     |    FF3B|BABABB3F|
; |33BAA3B3|B3      |    EF35|DBBB333F|
; | 33BB3AB|3       |    EF33|58785D3F|
; |    33BB|        |    3F3B|333333DD|
; |        |        | BB333BA|AAAB3138|
; |        |        |B2A333A2|26AB31  |
; |        |        |AA3AB3A2|22A333  |
; |--------|--------|--------|--------|
$9C:E4C0             db 0E,0F,0F,0F,07,0E,07,0F,0F,0F,7E,7F,9C,FF,2C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A2,00,DA,
                        AF,FF,AF,FF,FF,7F,AF,23,FF,FC,1E,FA,1C,F8,1C,FC,01,AD,01,FD,81,F1,AD,55,03,03,00,F1,40,30,00,20,
                        02,03,05,06,0F,0F,0B,0B,03,03,07,07,0E,0B,0E,0F,03,03,06,07,0F,0F,0C,08,0C,01,08,03,04,03,08,0B,
                        E0,E0,A8,78,FC,FC,FE,FE,AE,FE,0F,FF,07,FF,27,FF,E0,E0,70,B0,F8,F8,0C,0C,02,F2,00,A8,01,2D,40,AC,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        C6,FF,C7,FF,E7,FF,7D,7F,0F,0F,00,00,00,00,00,00,10,8D,00,69,00,3A,00,1B,00,03,00,00,00,00,00,00,
                        38,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        0E,0F,0F,0F,07,0E,07,0F,0F,0F,7E,7F,9C,FF,2C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A2,00,DA,
                        AF,FF,AF,FF,FF,7F,AF,23,FF,FC,1E,FA,1C,F8,1C,FC,01,AD,01,FD,81,F1,AD,55,03,03,00,F1,40,30,00,20,
}


;;; $E600: Samus top tiles - set 7 - entry 10h ;;;
{
; 2: Facing left  - normal - frame 1
; 2: Facing left  - normal - frame 3
; 2: Facing left  - normal - frame 6
; 2: Facing left  - normal - frame 8
; 28h: Facing left  - crouching - frame 1
; 28h: Facing left  - crouching - frame 3
; 28h: Facing left  - crouching - frame 6
; 28h: Facing left  - crouching - frame 8
; 48h: Unused - frame 1
; 48h: Unused - frame 3
; 48h: Unused - frame 6
; 48h: Unused - frame 8
; 8Ah: Facing left  - ran into a wall - frame 1
; 8Ah: Facing left  - ran into a wall - frame 3
; 8Ah: Facing left  - ran into a wall - frame 6
; 8Ah: Facing left  - ran into a wall - frame 8
; A9h: Facing left  - grappling - frame 1
; A9h: Facing left  - grappling - frame 3
; A9h: Facing left  - grappling - frame 6
; A9h: Facing left  - grappling - frame 8
; B5h: Facing left  - grappling - crouching - frame 1
; B5h: Facing left  - grappling - crouching - frame 3
; B5h: Facing left  - grappling - crouching - frame 6
; B5h: Facing left  - grappling - crouching - frame 8
; |--------|--------|--------|--------|--------|--------|
; |    33BA|B2B2BB3F|      FE|FFF     |        |        |
; |    FF3B|BABABB3F|     EE9|92FEF   |D33     |3DDDDDD3|
; |    EF35|DBB3333F|    EFF3|33333F  |53D3    |35555553|
; |    FF33|58885D3F|    F433|BBBB3F3 |8383    |38888873|
; |    3F3B|BB333338|    453B|BABAB3F |53D3    |35555553|
; | BB333BA|AABB3135|    43BB|A2AABB33|D3D3    |3DDDDDD3|
; |B2A333AA|26AB31  |    35BA|22A2AB3F|333     |33333333|
; |AB3AB3A2|22A333  |    F3BA|A6B2AB33|        |        |
; |--------|--------|--------|--------|--------|--------|
; |B326AB3A|2AB31   |    33BA|B2B2BB3F|
; |3BA2A33B|AB3     |    FF3B|BABABB3F|
; | 3BAB3A3|B3      |    EF35|DBB3333F|
; |  33B3AB|3       |    FF33|58885D3F|
; |    3333|        |    3F3B|BB333338|
; |        |        | BB333BA|AABB3135|
; |        |        |B2A333AA|26AB31  |
; |        |        |AB3AB3A2|22A333  |
; |--------|--------|--------|--------|
$9C:E600             db 0E,0F,0F,0F,07,0E,0F,0F,0F,0F,7E,7F,9C,FF,6C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A3,00,DA,
                        AF,FF,AF,FF,FF,7F,8F,03,FE,FE,3F,FA,1C,F8,1C,FC,01,AD,01,FD,81,E1,8D,75,00,C1,01,F0,40,30,00,20,
                        02,03,01,06,07,0F,0B,0B,07,03,07,07,0E,0B,0E,0F,03,03,06,07,0E,0E,0C,08,0C,01,08,03,04,03,08,0B,
                        E0,E0,A8,78,FC,FC,FE,FE,AE,FE,0F,FF,07,FF,27,FF,E0,E0,38,B8,04,04,04,F4,02,FA,00,BC,01,2D,40,AC,
                        00,00,E0,60,F0,50,50,50,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,00,A0,A0,20,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        C6,FF,C7,FF,6D,7F,3D,3F,0F,0F,00,00,00,00,00,00,10,8D,00,69,00,3A,00,0B,00,00,00,00,00,00,00,00,
                        38,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        0E,0F,0F,0F,07,0E,0F,0F,0F,0F,7E,7F,9C,FF,6C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A3,00,DA,
                        AF,FF,AF,FF,FF,7F,8F,03,FE,FE,3F,FA,1C,F8,1C,FC,01,AD,01,FD,81,E1,8D,75,00,C1,01,F0,40,30,00,20,
}


;;; $E740: Samus top tiles - set 7 - entry 11h ;;;
{
; 2: Facing left  - normal - frame 2
; 28h: Facing left  - crouching - frame 2
; 48h: Unused - frame 2
; 8Ah: Facing left  - ran into a wall - frame 2
; A9h: Facing left  - grappling - frame 2
; B5h: Facing left  - grappling - crouching - frame 2
; |--------|--------|--------|--------|--------|--------|
; |    F33A|B2B2BB3F|      EE|FFF     |        |        |
; |    EF3B|BABABB3F|     EE9|9AFEF   |D33     |3DDDDDD3|
; |    EF35|DD33333F|    E5F3|33333F  |53D3    |35555553|
; |    FF33|D5885D35|    F4 3|BBBB3FF |8383    |38888873|
; |    3F3B|333333D8|    453B|BABAB3F |D353    |35555553|
; | BB333BB|AAAB313D|    43BB|AAAAAB33|D3D3    |3DDDDDD3|
; |B2A3B3BA|26AB31  |    E5BA|22A2AB3F|333     |33333333|
; |AB3ABBA2|22A333  |    33BA|A6B2AB33|        |        |
; |--------|--------|--------|--------|--------|--------|
; |B322A33A|2AB3    |    F33A|B2B2BB3F|
; |3BA2B33B|AB3     |    EF3B|BABABB3F|
; | 3BAB3A3|B3      |    EF35|DD33333F|
; |  33B3BB|3       |    FF33|D5885D35|
; |    3333|        |    3F3B|333333D8|
; |        |        | BB333BB|AAAB313D|
; |        |        |B2A3B3BA|26AB31  |
; |        |        |AB3ABBA2|22A333  |
; |--------|--------|--------|--------|
$9C:E740             db 0E,0F,07,0F,07,0E,0F,0F,0F,0F,7F,7F,9E,FF,6C,FF,08,09,0C,0D,0D,0C,0C,0C,04,05,00,63,00,AB,00,DE,
                        AF,FF,AF,FF,FF,3F,CF,02,FE,FC,1F,FA,1C,F8,1C,FC,01,AD,01,FD,C1,C1,CD,B4,02,03,01,F1,40,30,00,20,
                        00,03,01,06,07,0B,09,09,07,03,07,07,06,0B,0E,0F,03,03,06,07,0E,0A,0C,08,0C,01,08,03,0C,0B,00,03,
                        E0,E0,A8,78,FC,FC,FE,FE,AE,FE,07,FF,07,FF,27,FF,E0,E0,38,F8,04,04,06,F6,02,FA,00,FC,01,2D,40,AC,
                        00,00,E0,60,F0,50,50,50,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,00,A0,A0,80,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        C6,FF,CF,FF,6D,7F,3F,3F,0F,0F,00,00,00,00,00,00,00,89,00,69,00,3A,00,0B,00,00,00,00,00,00,00,00,
                        30,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        0E,0F,07,0F,07,0E,0F,0F,0F,0F,7F,7F,9E,FF,6C,FF,08,09,0C,0D,0D,0C,0C,0C,04,05,00,63,00,AB,00,DE,
                        AF,FF,AF,FF,FF,3F,CF,02,FE,FC,1F,FA,1C,F8,1C,FC,01,AD,01,FD,C1,C1,CD,B4,02,03,01,F1,40,30,00,20,
}


;;; $E880: Samus top tiles - set 7 - entry 12h ;;;
{
; 1: Facing right - normal - frame 7
; 27h: Facing right - crouching - frame 7
; 47h: Unused - frame 7
; 89h: Facing right - ran into a wall - frame 7
; A8h: Facing right - grappling - frame 7
; B4h: Facing right - grappling - crouching - frame 7
; |--------|--------|--------|--------|--------|--------|
; |     FFF|EE      |333 3BA2|     333|        |        |
; |   FEFA9|9EE     |B3   3BB|     3BA|D33     |3DDDDDD3|
; |  FFBBB3|FF5E    |B3    33|      3B|53D3    |3DDDD553|
; | F3BABAB|334F    |33      |       3|8383    |35885853|
; | FBAAAAA|B734    |        |        |D353    |3DD5D5D3|
; | 3BA2A62|AB34    |        |        |D3D3    |3DDDDDD3|
; |F3B22B2A|AB5E    |        |        |333     |33333333|
; |33BA2B2B|AB33    |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|
; |F3BBBBBB|B3FE    |
; |F33333D8|85F9    |
; |F3358778|33FE    |
; |5F333BBB|B3FF    |
; |8D13BAAA|ABF33   |
; |D313BA62|AB33BBB |
; |  33BA22|AB333BAB|
; |   B3BAA|AB3 3226|
; |--------|--------|
$9C:E880             db 07,07,15,1E,3F,3F,75,7F,60,7F,60,7F,E4,FF,E5,FF,07,07,1C,1F,30,3E,40,5F,40,7F,02,34,80,A5,00,35,
                        00,C0,80,60,E0,D0,D0,D0,E0,E0,60,E0,60,D0,70,F0,C0,C0,60,E0,F0,D0,30,10,50,80,10,C0,30,D0,00,C0,
                        EC,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,06,00,83,00,80,00,00,00,00,00,00,00,00,00,00,
                        07,07,06,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,03,00,01,00,00,00,00,00,00,00,00,00,00,
                        00,00,E0,60,F0,50,50,50,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,00,A0,A0,80,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,CB,81,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,78,4A,34,7E,6A,7E,7E,00,00,00,00,
                        FF,FF,FE,FC,F6,E6,FF,7F,78,1F,F8,5F,38,3F,1C,1F,80,BF,82,83,96,89,C0,47,40,CF,82,8C,00,0C,00,17,
                        E0,F0,70,20,E0,F0,F0,F0,78,F8,7E,FE,7D,FF,68,EF,30,B0,60,B0,30,30,30,B0,20,E0,00,CE,00,C7,01,C0,
}


;;; $E980: Samus top tiles - set 7 - entry 13h ;;;
{
; 2: Facing left  - normal - frame 7
; 28h: Facing left  - crouching - frame 7
; 48h: Unused - frame 7
; 8Ah: Facing left  - ran into a wall - frame 7
; A9h: Facing left  - grappling - frame 7
; B5h: Facing left  - grappling - crouching - frame 7
; |--------|--------|--------|--------|--------|--------|
; |      EE|FFF     |AB3     |B326A33B|        |        |
; |     EE9|9AFEF   |B3      |3BA2B3A3|D33     |3DDDDDD3|
; |    E5F3|BBBB3F  |3       | 3BBA3BB|53D3    |35555553|
; |    F43B|BABABFF |        |  33BB33|8383    |38888873|
; |    43BB|AAAAABF |        |    33  |D353    |35555553|
; |    43BA|26A2AB33|        |        |D3D3    |3DDDDDD3|
; |    E5BA|A2B2AB3F|        |        |333     |33333333|
; |    33BA|B2B2BB33|        |        |        |        |
; |--------|--------|--------|--------|--------|--------|
; |    E33B|BBBBBB3F|
; |    9F35|5D33333F|
; |    EF33|D878533F|
; |    FF3B|BBBB3335|
; |    3FBA|2ABB33D8|
; | BB333B2|62AB313D|
; |B2A3B3A2|22A331  |
; |AB3ABB3A|2AB313  |
; |--------|--------|
$9C:E980             db 00,03,01,06,07,0B,0B,0B,07,07,06,07,06,0B,0E,0F,03,03,06,07,0E,0A,0C,09,08,03,08,03,0C,0B,00,03,
                        E0,E0,A8,78,FC,FC,AE,FE,06,FE,07,FF,27,FF,AF,FF,E0,E0,38,F8,04,F4,06,FE,02,FE,40,2C,01,AD,00,AC,
                        60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        C7,FF,CD,FF,77,7F,3F,3F,0C,0C,00,00,00,00,00,00,10,89,00,6A,00,3B,00,0C,00,00,00,00,00,00,00,00,
                        00,00,E0,60,F0,50,50,50,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,00,A0,A0,80,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        07,0F,0F,06,07,0F,0F,0F,0E,0F,7E,7F,9C,FF,6E,FF,08,09,05,0C,0C,0C,0C,0D,04,07,00,62,00,AA,00,DD,
                        FF,FF,FF,3F,AF,27,FF,FE,3E,FC,1F,FA,1C,F8,3C,F4,01,FD,C1,41,A9,D1,01,F0,02,73,81,31,00,20,00,60,
}
}


;;; $EA80..FA7F: Samus bottom tiles - set 9 (space jump) ;;;
{
;;; $EA80: Samus bottom tiles - set 9 - entry 0 ;;;
{
; 1Bh: Facing right - space jump - frame 1
; 1Ch: Facing left  - space jump - frame 1
; 81h: Facing right - screw attack - frame 1
; 81h: Facing right - screw attack - frame 9
; 81h: Facing right - screw attack - frame 11h
; 82h: Facing left  - screw attack - frame 1
; 82h: Facing left  - screw attack - frame 9
; 82h: Facing left  - screw attack - frame 11h
; 83h: Facing right - wall jump - frame Dh
; 83h: Facing right - wall jump - frame 17h
; 83h: Facing right - wall jump - frame 1Fh
; 83h: Facing right - wall jump - frame 27h
; 84h: Facing left  - wall jump - frame Dh
; 84h: Facing left  - wall jump - frame 17h
; 84h: Facing left  - wall jump - frame 1Fh
; 84h: Facing left  - wall jump - frame 27h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3333F   |        |3    3  |2BB3BA22|2BB3BA22|22AABA18|      33|3333F   |
; |E99999EF|        |3 3     |AA3ABBAA|AA3ABBAA|2BABBB18|    33EE|E99999EF|
; |FEFEFE99|EF      | 3 3 3  |BBBA2BBB|BBBA2BBB|BAB2BB1C|  3F9EFF|FEFEFE99|
; |99EEEFFE|EEF     |BB 3333 |BBBA2ABB|BBBA2ABB|AB2BBB1C| 3F9EFFE|99EEEFFE|
; |4499EEEF|FFFF    |BB3 B333|ABBAB222|ABBAB222|22ABBA1C|3FE9FFEF|4499EEEF|
; |E94499EE|EFFFF   | B3 BBBB|A23BABBA|A23BABBA|AABBB1CB|3F9EF444|E94499EE|
; |F9E994FF|EEFFFF  | BB33BAB|BABBBABB|BABBBABB|BBBB11BB|FF9444E9|F9E994FF|
; |FEF9E99E|FFFFFF  | BB33BBA|ABC2BAAA|ABC2BAAA|ABB11CB3|F994FFEE|FEF9E99E|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |FFFFEE34|EFFFFFF |  BB33BA|BABB1BBB|BABB1BBB|BC1CCBA3|F9E4FFFF|FFFFEE34|
; |55FFFEEB|E33FFFF |  BBBBBB|ABB3B11C|ABB3B11C|1CBBA2AB|3F4FFFF5|55FFFEEB|
; |7788FFFE|3F333FFF|   BABBB|BAAB33BB|BAAB33BB|B3BBA2B |344FF588|7788FFFE|
; |CB8773FF|FF 333FF|   ABBAB|BBB22A3B|BBB22A3B|BBAA2AB | FFF5BBC|CB8773FF|
; |BBCB7738|FF3 33FF|    ABAA|ABBBAAAA|ABBBAAAA|AA22AB  | FFFECBB|BBCB7738|
; |2AB11783|3F33 33 |     ABB|A22ABBBB|A22ABBBB|B2ABA   | F9E1BA2|2AB11783|
; |62ABC173|3FF 3  3|       A|BBA22A2A|BBA22A2A|AABA    |FFECBA26|62ABC173|
; |22AAB185|  3 3  3|        | BBBBBBB| BBBBBBB|BA      |FFFCBA26|22AAB185|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:EA80             db F8,F8,7D,83,AB,FC,C6,3F,31,0F,4C,83,DB,A3,B6,E9,08,08,83,FF,FC,FF,3F,FF,CF,3F,B3,CF,A7,FB,E9,FF,
                        00,00,00,00,40,C0,20,E0,F0,F0,78,F8,3C,FC,FC,FC,00,00,00,00,C0,C0,E0,E0,F0,F0,F8,F8,FC,FC,FC,FC,
                        84,84,A0,A0,54,54,DE,DE,EF,EF,6F,6F,7D,7F,7E,7F,00,00,00,00,00,00,00,C0,00,C8,00,4F,00,67,00,67,
                        78,FF,2C,FF,E7,FF,E3,FF,68,FF,36,FF,BB,FF,48,DF,00,6C,00,DF,00,F7,00,F7,00,F8,00,9F,00,FF,20,EF,
                        78,FF,2C,FF,E7,FF,E3,FF,68,FF,36,FF,BB,FF,48,DF,00,6C,00,DF,00,F7,00,F7,00,F8,00,9F,00,FF,20,EF,
                        0A,FC,5E,FC,AE,FC,5E,FC,1A,FC,3D,F9,FF,F3,7B,E3,00,3D,00,7D,01,ED,01,DD,01,3D,02,FB,00,F3,04,E6,
                        03,03,0C,0F,3B,37,76,6F,DD,EF,E8,D8,E1,C2,EC,8F,00,00,03,03,17,1F,2F,3F,6F,7F,5F,78,DE,E3,9F,EF,
                        F8,F8,7D,83,AB,FC,C6,3F,31,0F,4C,83,DB,A3,B6,E9,08,08,83,FF,FC,FF,3F,FF,CF,3F,B3,CF,A7,FB,E9,FF,
                        F2,FE,F9,3F,CE,CF,5F,5F,DE,DE,3D,E5,17,F3,0D,F8,FD,FC,FE,3F,CF,3F,9B,E3,2C,F1,04,62,8A,38,01,3A,
                        7E,FE,7E,FE,FF,FF,DF,DF,EF,EF,F6,F6,E9,E9,29,29,FE,FE,9E,9E,47,47,C3,C3,C3,C3,40,40,60,60,00,00,
                        3E,3F,3F,3F,17,1F,0D,1F,04,0F,03,07,00,01,00,00,00,33,00,3F,00,1F,00,1F,00,0F,00,07,00,01,00,00,
                        BF,F7,7E,F8,9F,FF,E3,FF,70,FF,0F,FF,C0,FF,7F,7F,00,F7,01,E9,00,F3,00,E5,00,FF,00,9F,00,E5,00,7F,
                        BF,F7,7E,F8,9F,FF,E3,FF,70,FF,0F,FF,C0,FF,7F,7F,00,F7,01,E9,00,F3,00,E5,00,FF,00,9F,00,E5,00,7F,
                        A5,87,B1,3F,F2,FE,C2,FE,04,FC,90,F8,20,F0,80,C0,58,DE,40,7B,00,BA,00,F6,00,CC,00,B8,00,F0,00,C0,
                        CF,AF,DF,DE,9C,98,7E,76,73,7B,6C,57,C8,EF,E8,EF,BF,EF,7F,5E,7C,1B,79,77,7C,7F,50,76,F1,FC,F1,FC,
                        F2,FE,F9,3F,CE,CF,5F,5F,DE,DE,3D,E5,17,F3,0D,F8,FD,FC,FE,3F,CF,3F,9B,E3,2C,F1,04,62,8A,38,01,3A,
}


;;; $EC80: Samus bottom tiles - set 9 - entry 1 ;;;
{
; 1Bh: Facing right - space jump - frame 2
; 1Ch: Facing left  - space jump - frame 2
; 81h: Facing right - screw attack - frame 2
; 81h: Facing right - screw attack - frame Ah
; 81h: Facing right - screw attack - frame 12h
; 82h: Facing left  - screw attack - frame 2
; 82h: Facing left  - screw attack - frame Ah
; 82h: Facing left  - screw attack - frame 12h
; 83h: Facing right - wall jump - frame Eh
; 83h: Facing right - wall jump - frame 18h
; 83h: Facing right - wall jump - frame 20h
; 83h: Facing right - wall jump - frame 28h
; 84h: Facing left  - wall jump - frame Eh
; 84h: Facing left  - wall jump - frame 18h
; 84h: Facing left  - wall jump - frame 20h
; 84h: Facing left  - wall jump - frame 28h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |BB2ABABC|9BA2B   |     399|FEEEFFEE|    B3BB|        |        |        |
; |22A3AB39|BBA2A   |    3EEE|EF9F9494|3333333B|        |        |        |
; |AA3A33C9|3A22A   |    EEFE|F9499EE3|    BBBB|        |        |        |
; |B32ABC9B|BA2AA   |   33FEF|49EE9EEE|  3BBBBB|        |FF3     |    FFFF|
; |322CC9BB|BA2AB   |   3EFF4|EF9EFFFF|     BBB|        |EFEFF3  | FFEEEEF|
; |3CB3B3AB|A2AA    |   FEFF4|9EFFFF87|        |       F|FFFFFFF3|FE9EEEFF|
; |AAB3B2BA|22AB    |  3E9F4F|EEFF5885|        |      FE|FFFF3   |99EFFFEE|
; |BBA22BB2|BAB     |  3E9E4F|EFF57BCC|        |     FE9|EEFF33  |9FFEEEFF|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |AAABB22B|ABB     |  3F944F|3FF8CC1B|        |BCC11C58|FF3F333 | 3BBBABB|
; |BBBA2BBA|BB      |  33E944|FF55C92A|3       |2BBAA91D|4EFF   3|  22ABAB|
; |BABBBAAB|B       |   FF9E4|FF5BC226|33      |6ABB22C1|FFFFF33 |   AB3AA|
; |BBBBABB |        |    FFE4|FF5C1A26|133     |2ABBB2BC|FFFFFF33| 33 B33B|
; |BBBBB   |        |     F33|FF31CAA2|1B33    |AABAA2AB|3F333F3 |   33BA2|
; |        |        |        |3FAA9B3B|CCAB    |A3BABAAB|77875  3|3333B3AB|
; |        |        |        | F2CABA3|CC2A    |B2B2BABB|5B5578  |  3BB3BA|
; |        |        |        |  3B33B2|9AA2B   |2BB2BABB|111C558 | 33BBBAB|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:EC80             db CA,FE,17,FE,2D,FC,CB,F9,87,E3,BD,BF,3A,FF,C6,FF,01,DF,00,2D,02,D3,04,9F,18,1F,40,6B,00,EB,00,E6,
                        C8,78,C0,F8,80,F8,80,F8,88,F8,00,F0,10,F0,A0,E0,00,E8,00,E8,00,48,00,D8,00,D8,00,B0,00,30,00,E0,
                        07,04,08,0F,02,0F,1D,1F,16,1E,16,1E,2D,35,29,35,00,03,07,07,0F,0F,07,07,0F,0E,1F,1E,17,1D,17,1D,
                        8C,FF,7A,D0,D9,87,48,37,6F,DF,BD,7D,39,F0,7C,EC,FF,FF,D5,FA,A6,DE,B7,7F,DF,FF,7D,FE,F9,F6,FB,E7,
                        0F,0F,FF,FF,0F,0F,3F,3F,07,07,00,00,00,00,00,00,00,0B,00,01,00,0F,00,1F,00,07,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,01,01,02,03,05,06,00,00,00,00,00,00,00,00,00,00,01,01,03,03,06,07,
                        00,00,00,00,00,00,E0,E0,5C,FC,FF,FF,F8,F8,3C,FC,00,00,00,00,00,00,C0,C0,F8,F8,FE,FE,F0,F0,F0,F0,
                        00,00,00,00,00,00,0F,0F,61,7F,A3,DF,DC,3F,E3,7F,00,00,00,00,00,00,0F,0F,7F,7F,DF,FF,3F,FF,7F,FF,
                        19,FF,E6,FF,B9,FF,F6,FE,F8,F8,00,00,00,00,00,00,00,F9,00,F7,00,FF,00,FE,00,F8,00,00,00,00,00,00,
                        60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,E0,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        39,31,34,38,1C,1A,0C,0E,07,07,00,00,00,00,00,00,17,19,0B,0C,1B,1E,0F,0E,04,04,00,00,00,00,00,00,
                        E3,E1,F4,C3,F0,D7,E8,C7,F0,E7,CF,F7,45,6F,3E,3F,6C,7D,F8,CD,E9,D8,F1,D4,C8,CE,40,7D,50,5E,00,12,
                        00,00,80,80,C0,C0,E0,60,F0,70,10,30,00,30,88,78,00,00,00,00,00,00,00,00,00,40,C0,F0,C0,D0,00,E8,
                        9A,80,67,F8,31,FC,3A,FE,21,FF,69,FF,AB,FF,6B,FF,66,E5,01,7D,82,72,01,7B,00,FB,00,BF,00,AF,00,6F,
                        FE,FE,31,71,FE,FE,FF,FF,FE,FE,D9,D1,F8,48,EC,00,D0,D0,F0,70,F8,F8,FC,FC,44,44,D8,20,B8,44,1C,12,
                        7B,7F,05,3F,0C,1F,6F,6F,1C,1F,FD,FF,3E,3F,7D,7F,00,3F,00,0F,00,1B,00,09,00,06,00,0B,00,1B,00,1F,
}


;;; $EE80: Samus bottom tiles - set 9 - entry 2 ;;;
{
; 1Bh: Facing right - space jump - frame 3
; 1Ch: Facing left  - space jump - frame 3
; 81h: Facing right - screw attack - frame 3
; 81h: Facing right - screw attack - frame Bh
; 81h: Facing right - screw attack - frame 13h
; 82h: Facing left  - screw attack - frame 3
; 82h: Facing left  - screw attack - frame Bh
; 82h: Facing left  - screw attack - frame 13h
; 83h: Facing right - wall jump - frame Fh
; 83h: Facing right - wall jump - frame 19h
; 83h: Facing right - wall jump - frame 21h
; 83h: Facing right - wall jump - frame 29h
; 84h: Facing left  - wall jump - frame Fh
; 84h: Facing left  - wall jump - frame 19h
; 84h: Facing left  - wall jump - frame 21h
; 84h: Facing left  - wall jump - frame 29h
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |2ABB2ABA|BCBBABAB|        |  FFF 33| F9EFEFE|4BEF8335|88CCCBB3|3B      |
; |2ABB2BBA|B1B3AB2B|        |FFFFF3  | E9FEEF9|3EFF3878|11111CBB|AABB    |
; |ABBA2BAA|B13AABAB|      FF|FFF 33  | 9EFE949|EEF37711|ABBBA11C|B22AB   |
; |BB22BABB|1B32AB2B|     FFF|FF333 33|F9FEE99E|EFF771CB|BBBBBB11|CAA2AA  |
; |3AAAABB2|B3B2BA2B|    FFFF|FF33 3  |39EE9499|FF87B1BA|AB2BBBB1|CBBA2BA |
; |B3BBB3BC|BBABB2AB|   FFFFF|F3  33F3|39FE94EF|FF88CBAA|AAB2ABBB|1BBA2AB |
; |BABBB2AB|ABABB2BB|  FEFFEF|F FFFFF |39E9499E|F57BBA22|2BAB2ABB|CC3BA2AA|
; |2ABBAABA|BABBAAB |  EEFEEF|EE3FF33 |3EF94EFF|F57CB262|22BA2ABA|B1BBABAB|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |    3BBA|ABBBABA | F9EFEFE|4BEF8335|3EFEF49E|F58CB266|2ABB2ABA|BCBBABAB|
; |   33BAB|BBBAAB  | E9FEEF9|3EFF3878|3EFFE4EE|FF8BBA22|2ABB2BBA|B1B3AB2B|
; |3 333BBB|3BBBBA  | 9EFE949|EEF37711| 3EFF44F|FF5BCBAA|ABBA2BAA|B13AABAB|
; |   3BB33|3BABA   |F9FEE99E|EFF771CB| 39EFF4F|FFF5E1BB|BB22BABB|1B32AB2B|
; |  33  33|BBBA    |39EE9499|FF87B1BA|  F99E44|4FFFFECC|3AAAABB2|B3B2BA2B|
; | 3  33BB|BB      |39FE94EF|FF88CBAA|  3FE999|E44FF9EF|B3BBB3BC|BBABB2AB|
; |  3BBBBB|        |39E9499E|F57BBA22|   3FFF9|9F4FFFFF|BABBB2AB|ABABB2BB|
; |33 BB   |        |3EF94EFF|F57CB262|    33FF|F33   FF|2ABBAABA|BABBAAB |
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:EE80             db 32,FF,36,FF,64,FF,CB,FF,86,FF,FE,FE,B9,FF,32,FF,00,77,00,77,00,F7,00,CF,00,7E,01,BB,00,FB,00,7F,
                        B5,BF,F5,BF,E5,BF,E5,7F,E9,FF,D9,FF,5B,FF,B2,FE,40,FF,00,AD,00,9F,00,4D,00,AD,00,FB,00,FB,00,FE,
                        00,00,00,00,03,03,07,07,0F,0F,1F,1F,2D,3F,09,3F,00,00,00,00,03,03,07,07,0F,0F,1F,1F,3F,3F,3F,3F,
                        3B,3B,FC,FC,EC,EC,FB,FB,F4,F4,CF,CF,BE,BE,3E,FE,38,38,F8,F8,E0,E0,C0,C0,C0,C0,82,82,BE,BE,D8,D8,
                        6A,5F,33,5E,55,38,E6,B9,CB,B0,E9,B3,D6,A1,B3,E7,5F,7F,5E,7F,3A,7D,B9,FF,34,7B,37,7B,29,77,6F,77,
                        57,76,BA,FA,3F,FC,7D,F9,DE,DB,C4,C7,F8,BF,E8,AF,B1,78,72,75,EC,E0,FA,E3,D0,EB,C8,FF,E0,9C,F2,98,
                        07,07,FB,03,76,F8,FF,FC,5F,FE,27,FF,53,FF,22,FF,38,FE,04,07,01,F9,00,FC,00,DE,00,EF,00,77,00,37,
                        C0,C0,30,F0,88,F8,00,7C,64,7E,E2,7E,30,3F,F5,BF,00,40,00,F0,00,98,80,EC,80,F6,00,76,C0,DB,00,BF,
                        0E,0F,1D,1F,BF,BF,1F,1F,33,33,4F,4F,3F,3F,D8,D8,00,07,00,07,00,07,00,0C,00,00,00,03,00,1F,00,18,
                        74,FE,E4,FC,F8,FC,D0,F8,E0,F0,C0,C0,00,00,00,00,00,FE,00,FC,00,7C,00,78,00,F0,00,C0,00,00,00,00,
                        6A,5F,33,5E,55,38,E6,B9,CB,B0,E9,B3,D6,A1,B3,E7,5F,7F,5E,7F,3A,7D,B9,FF,34,7B,37,7B,29,77,6F,77,
                        57,76,BA,FA,3F,FC,7D,F9,DE,DB,C4,C7,F8,BF,E8,AF,B1,78,72,75,EC,E0,FA,E3,D0,EB,C8,FF,E0,9C,F2,98,
                        AA,F9,B0,FB,59,79,6D,5D,38,24,37,38,1F,1E,0F,0F,7D,7B,7F,7B,3F,39,1F,3D,27,3C,18,1F,0E,0F,03,03,
                        C8,8F,D8,DF,F4,D7,F7,EB,78,7C,1D,9B,DF,5F,E3,E3,D3,B8,C0,FC,E8,DF,F8,EB,FF,7F,FB,9F,7F,DF,83,83,
                        32,FF,36,FF,64,FF,CB,FF,86,FF,FE,FE,B9,FF,32,FF,00,77,00,77,00,F7,00,CF,00,7E,01,BB,00,FB,00,7F,
                        B5,BF,F5,BF,E5,BF,E5,7F,E9,FF,D9,FF,5B,FF,B2,FE,40,FF,00,AD,00,9F,00,4D,00,AD,00,FB,00,FB,00,FE,
}


;;; $F080: Samus bottom tiles - set 9 - entry 3 ;;;
{
; 1Bh: Facing right - space jump - frame 4
; 1Ch: Facing left  - space jump - frame 4
; 81h: Facing right - screw attack - frame 4
; 81h: Facing right - screw attack - frame Ch
; 81h: Facing right - screw attack - frame 14h
; 82h: Facing left  - screw attack - frame 4
; 82h: Facing left  - screw attack - frame Ch
; 82h: Facing left  - screw attack - frame 14h
; 83h: Facing right - wall jump - frame 10h
; 83h: Facing right - wall jump - frame 1Ah
; 83h: Facing right - wall jump - frame 22h
; 83h: Facing right - wall jump - frame 2Ah
; 84h: Facing left  - wall jump - frame 10h
; 84h: Facing left  - wall jump - frame 1Ah
; 84h: Facing left  - wall jump - frame 22h
; 84h: Facing left  - wall jump - frame 2Ah
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |   BBBBB|BA33B2BB|C911933 |1B75FF4E|23AA22A9| 3      |
; |        |        |   BABBA|BAC2332B|BBBB333 |BB75FEEF|2ABAAABC|3  3   3|
; |      33|33      |   BBBBB|BBB22323|ABBBB3  |C585FEFF|BA3BBBB9|3 3   2B|
; |     F3F|F9F33   |   BABAB|A339AA32|2ABB    |9583FFFF|33AABB2C|B33  A2B|
; |    FFF9|99EE3E3 |   BABAB|ABBCC33A|BBB     |5753FFFF|233332C9|BBB3BBAB|
; |   FF994|EFFFFEE3|    BABA|B2339CBB|        |383333 3|BAA22B91|B33A33BB|
; |   39E44|444FEFE9|    BAB2|AABB39CB|        |85 33 3 |BBBBBC13|BBAABA62|
; |   F444F|EE44EEE9|     BAB|2AAB33C9|        |5 33    |CBBC91C5|AAB2BAB2|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |  FFFFFF|FEEE49EF|     BBA|B2ABB3BB|      3 |FFFEF   |99F     |        |
; | FFFFFFF|FEFF99EE|      BB|A22AAABB|     3  |FEFF3   |F99     |        |
; |32A35F5F|FFFEE4FE|       B|BA2222AA|    33B |FFFF3   |EEEF    |        |
; |BCA1CFF8|5FFFE99F|        | BBAA222|    333B|3FE33   |EF9F    |        |
; |3C911CCC|75FFEE9F|        |  BBBAAB|    B33B|3F33F   |EFEE    |        |
; |2ABA229C|B8FFEE4F|        |        |   3BB33| 333    |EFFEF   |        |
; |AB326621|B88FEE9E|        |        |   BBB3B|  3     |FEFEF   |3       |
; |ABA226A9|CB7FEF4E|        |        |   BABBB| 3      |FEFEF   |93      |
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:F080             db 00,00,00,00,03,03,07,07,0F,0E,1E,18,18,14,11,11,00,00,00,00,00,00,05,05,0E,0F,19,1E,07,0C,1F,11,
                        00,00,00,00,C0,C0,F8,B8,CA,3E,79,FF,15,1E,01,CE,00,00,00,00,00,00,A0,E0,34,F4,FE,FE,FE,1F,FE,CF,
                        1F,1F,16,1F,1F,1F,15,1F,15,1F,0A,0F,0A,0F,05,07,00,1F,00,1F,00,1F,00,1F,00,1F,00,0F,00,0E,00,07,
                        BB,FF,8D,DF,E5,FF,72,EF,66,E7,BB,F3,3D,F9,1D,FC,00,CB,20,E1,00,E0,00,9C,18,F9,04,8F,02,F7,02,73,
                        7E,06,FE,FE,7C,FC,30,F0,E0,E0,00,00,00,00,00,00,80,C8,00,F0,00,F8,00,70,00,E0,00,00,00,00,00,00,
                        FC,6D,F9,EF,5B,0F,DF,1F,FF,5F,BD,BD,5A,1A,B0,30,3F,4D,3F,CF,DF,AF,4F,AF,EF,0F,00,40,40,80,80,00,
                        41,FE,22,FE,BF,FE,CC,FE,79,FC,87,FC,FB,F9,6D,60,00,33,01,7F,00,DF,01,3D,02,03,00,E6,04,FC,93,FA,
                        40,40,91,91,A1,A3,E1,E7,FD,FF,EF,FF,C8,FF,2A,FF,00,00,00,00,00,01,00,85,00,EF,00,93,02,FC,00,EE,
                        3F,3F,7F,7F,9F,F5,96,A6,B8,80,22,FC,61,FE,41,FE,3F,3F,7F,7F,0F,25,4E,EF,47,67,01,73,0C,C0,04,E3,
                        85,F3,BC,F3,E2,FB,F7,79,F3,BD,B1,BD,92,9D,74,7D,FB,F7,F3,FF,FF,FB,F9,7F,FD,3F,3F,FD,1D,FF,BF,DD,
                        06,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,07,00,03,00,01,00,00,00,00,00,00,00,00,00,00,
                        9F,FF,03,FF,80,FF,60,7F,39,3F,00,00,00,00,00,00,00,BB,00,9F,00,C3,00,78,00,3F,00,00,00,00,00,00,
                        02,02,04,04,0E,0E,0F,0F,0F,0F,1F,1F,1F,1F,17,1F,00,00,00,00,00,02,00,01,00,09,00,0C,00,1D,00,1F,
                        E8,F8,B8,F8,F8,F8,D8,F8,F8,F8,70,70,20,20,40,40,F8,F8,F0,F0,F0,F0,60,60,48,48,00,00,00,00,00,00,
                        E0,20,E0,80,10,F0,70,D0,40,F0,68,F8,A8,F8,A8,F8,20,E0,80,E0,F0,F0,D0,F0,F0,F0,F8,F8,F8,F8,F8,F8,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,C0,40,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,
}


;;; $F280: Samus bottom tiles - set 9 - entry 4 ;;;
{
; 1Bh: Facing right - space jump - frame 5
; 1Ch: Facing left  - space jump - frame 5
; 81h: Facing right - screw attack - frame 5
; 81h: Facing right - screw attack - frame Dh
; 81h: Facing right - screw attack - frame 15h
; 82h: Facing left  - screw attack - frame 5
; 82h: Facing left  - screw attack - frame Dh
; 82h: Facing left  - screw attack - frame 15h
; 83h: Facing right - wall jump - frame 11h
; 83h: Facing right - wall jump - frame 1Bh
; 83h: Facing right - wall jump - frame 23h
; 83h: Facing right - wall jump - frame 2Bh
; 84h: Facing left  - wall jump - frame 11h
; 84h: Facing left  - wall jump - frame 1Bh
; 84h: Facing left  - wall jump - frame 23h
; 84h: Facing left  - wall jump - frame 2Bh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3333F   |        |3    3  |2BB3BA22|2BB3BA22|22AABA18|      33|3333F   |
; |E99999EF|        |3 3     |AA3ABBAA|AA3ABBAA|2BABBB18|    33EE|E99999EF|
; |FEFEFE99|EF      | 3 3 3  |BBBA2BBB|BBBA2BBB|BAB2BB1C|  3F9EFF|FEFEFE99|
; |99EEEFFE|EEF     |BB 3333 |BBBA2ABB|BBBA2ABB|AB2BBB1C| 3F9EFFE|99EEEFFE|
; |4499EEEF|FFFF    |BB3 B333|ABBAB222|ABBAB222|22ABBA1C|3FE9FFEF|4499EEEF|
; |E94499EE|EFFFF   | B3 BBBB|A23BABBA|A23BABBA|AABBB1CB|3F9EF444|E94499EE|
; |F9E994FF|EEFFFF  | BB33BAB|BABBBABB|BABBBABB|BBBB11BB|FF9444E9|F9E994FF|
; |FEF9E99E|FFFFFF  | BB33BBA|ABC2BAAA|ABC2BAAA|ABB11CB3|F994FFEE|FEF9E99E|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |FFFFEE34|EFFFFFF |  BB33BA|BABB1BBB|BABB1BBB|BC1CCBA3|F9E4FFFF|FFFFEE34|
; |55FFFEEB|E33FFFF |  BBBBBB|ABB3B11C|ABB3B11C|1CBBA2AB|3F4FFFF5|55FFFEEB|
; |7788FFFE|3F333FFF|   BABBB|BAAB33BB|BAAB33BB|B3BBA2B |344FF588|7788FFFE|
; |CB8773FF|FF 333FF|   ABBAB|BBB22A3B|BBB22A3B|BBAA2AB | FFF5BBC|CB8773FF|
; |BBCB7738|FF3 33FF|    ABAA|ABBBAAAA|ABBBAAAA|AA22AB  | FFFECBB|BBCB7738|
; |2AB11783|3F33 33 |     ABB|A22ABBBB|A22ABBBB|B2ABA   | F9E1BA2|2AB11783|
; |62ABC173|3FF 3  3|       A|BBA22A2A|BBA22A2A|AABA    |FFECBA26|62ABC173|
; |22AAB185|  3 3  3|        | BBBBBBB| BBBBBBB|BA      |FFFCBA26|22AAB185|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:F280             db F8,F8,7D,83,AB,FC,C6,3F,31,0F,4C,83,DB,A3,B6,E9,08,08,83,FF,FC,FF,3F,FF,CF,3F,B3,CF,A7,FB,E9,FF,
                        00,00,00,00,40,C0,20,E0,F0,F0,78,F8,3C,FC,FC,FC,00,00,00,00,C0,C0,E0,E0,F0,F0,F8,F8,FC,FC,FC,FC,
                        84,84,A0,A0,54,54,DE,DE,EF,EF,6F,6F,7D,7F,7E,7F,00,00,00,00,00,00,00,C0,00,C8,00,4F,00,67,00,67,
                        78,FF,2C,FF,E7,FF,E3,FF,68,FF,36,FF,BB,FF,48,DF,00,6C,00,DF,00,F7,00,F7,00,F8,00,9F,00,FF,20,EF,
                        78,FF,2C,FF,E7,FF,E3,FF,68,FF,36,FF,BB,FF,48,DF,00,6C,00,DF,00,F7,00,F7,00,F8,00,9F,00,FF,20,EF,
                        0A,FC,5E,FC,AE,FC,5E,FC,1A,FC,3D,F9,FF,F3,7B,E3,00,3D,00,7D,01,ED,01,DD,01,3D,02,FB,00,F3,04,E6,
                        03,03,0C,0F,3B,37,76,6F,DD,EF,E8,D8,E1,C2,EC,8F,00,00,03,03,17,1F,2F,3F,6F,7F,5F,78,DE,E3,9F,EF,
                        F8,F8,7D,83,AB,FC,C6,3F,31,0F,4C,83,DB,A3,B6,E9,08,08,83,FF,FC,FF,3F,FF,CF,3F,B3,CF,A7,FB,E9,FF,
                        F2,FE,F9,3F,CE,CF,5F,5F,DE,DE,3D,E5,17,F3,0D,F8,FD,FC,FE,3F,CF,3F,9B,E3,2C,F1,04,62,8A,38,01,3A,
                        7E,FE,7E,FE,FF,FF,DF,DF,EF,EF,F6,F6,E9,E9,29,29,FE,FE,9E,9E,47,47,C3,C3,C3,C3,40,40,60,60,00,00,
                        3E,3F,3F,3F,17,1F,0D,1F,04,0F,03,07,00,01,00,00,00,33,00,3F,00,1F,00,1F,00,0F,00,07,00,01,00,00,
                        BF,F7,7E,F8,9F,FF,E3,FF,70,FF,0F,FF,C0,FF,7F,7F,00,F7,01,E9,00,F3,00,E5,00,FF,00,9F,00,E5,00,7F,
                        BF,F7,7E,F8,9F,FF,E3,FF,70,FF,0F,FF,C0,FF,7F,7F,00,F7,01,E9,00,F3,00,E5,00,FF,00,9F,00,E5,00,7F,
                        A5,87,B1,3F,F2,FE,C2,FE,04,FC,90,F8,20,F0,80,C0,58,DE,40,7B,00,BA,00,F6,00,CC,00,B8,00,F0,00,C0,
                        CF,AF,DF,DE,9C,98,7E,76,73,7B,6C,57,C8,EF,E8,EF,BF,EF,7F,5E,7C,1B,79,77,7C,7F,50,76,F1,FC,F1,FC,
                        F2,FE,F9,3F,CE,CF,5F,5F,DE,DE,3D,E5,17,F3,0D,F8,FD,FC,FE,3F,CF,3F,9B,E3,2C,F1,04,62,8A,38,01,3A,
}


;;; $F480: Samus bottom tiles - set 9 - entry 5 ;;;
{
; 1Bh: Facing right - space jump - frame 6
; 1Ch: Facing left  - space jump - frame 6
; 81h: Facing right - screw attack - frame 6
; 81h: Facing right - screw attack - frame Eh
; 81h: Facing right - screw attack - frame 16h
; 82h: Facing left  - screw attack - frame 6
; 82h: Facing left  - screw attack - frame Eh
; 82h: Facing left  - screw attack - frame 16h
; 83h: Facing right - wall jump - frame 12h
; 83h: Facing right - wall jump - frame 1Ch
; 83h: Facing right - wall jump - frame 24h
; 83h: Facing right - wall jump - frame 2Ch
; 84h: Facing left  - wall jump - frame 12h
; 84h: Facing left  - wall jump - frame 1Ch
; 84h: Facing left  - wall jump - frame 24h
; 84h: Facing left  - wall jump - frame 2Ch
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |BB2ABABC|9BA2B   |     399|FEEEFFEE|        |BCC11C58|FF3F333 |        |
; |22A3AB39|BBA2A   |    3EEE|EF9F9494|3       |2BBAA91D|4EFF   3|        |
; |AA3A33C9|3A22A   |    EEFE|F9499EE3|33      |6ABB22C1|FFFFF33 |        |
; |B32ABC9B|BA2AA   |   33FEF|49EE9EEE|133     |2ABBB2BC|FFFFFF33|        |
; |322CC9BB|BA2AB   |   3EFF4|EF9EFFFF|1B33    |AABAA2AB|3F333F3 |        |
; |3CB3B3AB|A2AA    |   FEFF4|9EFFFF87|CCAB    |A3BABAAB|77875  3|       F|
; |AAB3B2BA|22AB    |  3E9F4F|EEFF5885|CC2A    |B2B2BABB|5B5578  |      FE|
; |BBA22BB2|BAB     |  3E9E4F|EFF57BCC|9AA2B   |2BB2BABB|111C558 |     FE9|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |AAABB22B|ABB     |  3F944F|3FF8CC1B|    B3BB| 3BBBABB|        |        |
; |BBBA2BBA|BB      |  33E944|FF55C92A|3333333B|  22ABAB|        |        |
; |BABBBAAB|B       |   FF9E4|FF5BC226|    BBBB|   AB3AA|        |        |
; |BBBBABB |        |    FFE4|FF5C1A26|  3BBBBB| 33 B33B|FF3     |    FFFF|
; |BBBBB   |        |     F33|FF31CAA2|     BBB|   33BA2|EFEFF3  | FFEEEEF|
; |        |        |        |3FAA9B3B|        |3333B3AB|FFFFFFF3|FE9EEEFF|
; |        |        |        | F2CABA3|        |  3BB3BA|FFFF3   |99EFFFEE|
; |        |        |        |  3B33B2|        | 33BBBAB|EEFF33  |9FFEEEFF|
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:F480             db CA,FE,17,FE,2D,FC,CB,F9,87,E3,BD,BF,3A,FF,C6,FF,01,DF,00,2D,02,D3,04,9F,18,1F,40,6B,00,EB,00,E6,
                        C8,78,C0,F8,80,F8,80,F8,88,F8,00,F0,10,F0,A0,E0,00,E8,00,E8,00,48,00,D8,00,D8,00,B0,00,30,00,E0,
                        07,04,08,0F,02,0F,1D,1F,16,1E,16,1E,2D,35,29,35,00,03,07,07,0F,0F,07,07,0F,0E,1F,1E,17,1D,17,1D,
                        8C,FF,7A,D0,D9,87,48,37,6F,DF,BD,7D,39,F0,7C,EC,FF,FF,D5,FA,A6,DE,B7,7F,DF,FF,7D,FE,F9,F6,FB,E7,
                        00,00,80,80,C0,C0,E0,60,F0,70,10,30,00,30,88,78,00,00,00,00,00,00,00,00,00,40,C0,F0,C0,D0,00,E8,
                        9A,80,67,F8,31,FC,3A,FE,21,FF,69,FF,AB,FF,6B,FF,66,E5,01,7D,82,72,01,7B,00,FB,00,BF,00,AF,00,6F,
                        FE,FE,31,71,FE,FE,FF,FF,FE,FE,D9,D1,F8,48,EC,00,D0,D0,F0,70,F8,F8,FC,FC,44,44,D8,20,B8,44,1C,12,
                        00,00,00,00,00,00,00,00,00,00,01,01,02,03,05,06,00,00,00,00,00,00,00,00,00,00,01,01,03,03,06,07,
                        19,FF,E6,FF,B9,FF,F6,FE,F8,F8,00,00,00,00,00,00,00,F9,00,F7,00,FF,00,FE,00,F8,00,00,00,00,00,00,
                        60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,E0,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        39,31,34,38,1C,1A,0C,0E,07,07,00,00,00,00,00,00,17,19,0B,0C,1B,1E,0F,0E,04,04,00,00,00,00,00,00,
                        E3,E1,F4,C3,F0,D7,E8,C7,F0,E7,CF,F7,45,6F,3E,3F,6C,7D,F8,CD,E9,D8,F1,D4,C8,CE,40,7D,50,5E,00,12,
                        0F,0F,FF,FF,0F,0F,3F,3F,07,07,00,00,00,00,00,00,00,0B,00,01,00,0F,00,1F,00,07,00,00,00,00,00,00,
                        7B,7F,05,3F,0C,1F,6F,6F,1C,1F,FD,FF,3E,3F,7D,7F,00,3F,00,0F,00,1B,00,09,00,06,00,0B,00,1B,00,1F,
                        00,00,00,00,00,00,E0,E0,5C,FC,FF,FF,F8,F8,3C,FC,00,00,00,00,00,00,C0,C0,F8,F8,FE,FE,F0,F0,F0,F0,
                        00,00,00,00,00,00,0F,0F,61,7F,A3,DF,DC,3F,E3,7F,00,00,00,00,00,00,0F,0F,7F,7F,DF,FF,3F,FF,7F,FF,
}


;;; $F680: Samus bottom tiles - set 9 - entry 6 ;;;
{
; 1Bh: Facing right - space jump - frame 7
; 1Ch: Facing left  - space jump - frame 7
; 81h: Facing right - screw attack - frame 7
; 81h: Facing right - screw attack - frame Fh
; 81h: Facing right - screw attack - frame 17h
; 82h: Facing left  - screw attack - frame 7
; 82h: Facing left  - screw attack - frame Fh
; 82h: Facing left  - screw attack - frame 17h
; 83h: Facing right - wall jump - frame 13h
; 83h: Facing right - wall jump - frame 1Dh
; 83h: Facing right - wall jump - frame 25h
; 83h: Facing right - wall jump - frame 2Dh
; 84h: Facing left  - wall jump - frame 13h
; 84h: Facing left  - wall jump - frame 1Dh
; 84h: Facing left  - wall jump - frame 25h
; 84h: Facing left  - wall jump - frame 2Dh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |2ABB2ABA|BCBBABAB|        |  FFF 33| F9EFEFE|4BEF8335|88CCCBB3|3B      |
; |2ABB2BBA|B1B3AB2B|        |FFFFF3  | E9FEEF9|3EFF3878|11111CBB|AABB    |
; |ABBA2BAA|B13AABAB|      FF|FFF 33  | 9EFE949|EEF37711|ABBBA11C|B22AB   |
; |BB22BABB|1B32AB2B|     FFF|FF333 33|F9FEE99E|EFF771CB|BBBBBB11|CAA2AA  |
; |3AAAABB2|B3B2BA2B|    FFFF|FF33 3  |39EE9499|FF87B1BA|AB2BBBB1|CBBA2BA |
; |B3BBB3BC|BBABB2AB|   FFFFF|F3  33F3|39FE94EF|FF88CBAA|AAB2ABBB|1BBA2AB |
; |BABBB2AB|ABABB2BB|  FEFFEF|F FFFFF |39E9499E|F57BBA22|2BAB2ABB|CC3BA2AA|
; |2ABBAABA|BABBAAB |  EEFEEF|EE3FF33 |3EF94EFF|F57CB262|22BA2ABA|B1BBABAB|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |    3BBA|ABBBABA | F9EFEFE|4BEF8335|3EFEF49E|F58CB266|2ABB2ABA|BCBBABAB|
; |   33BAB|BBBAAB  | E9FEEF9|3EFF3878|3EFFE4EE|FF8BBA22|2ABB2BBA|B1B3AB2B|
; |3 333BBB|3BBBBA  | 9EFE949|EEF37711| 3EFF44F|FF5BCBAA|ABBA2BAA|B13AABAB|
; |   3BB33|3BABA   |F9FEE99E|EFF771CB| 39EFF4F|FFF5E1BB|BB22BABB|1B32AB2B|
; |  33  33|BBBA    |39EE9499|FF87B1BA|  F99E44|4FFFFECC|3AAAABB2|B3B2BA2B|
; | 3  33BB|BB      |39FE94EF|FF88CBAA|  3FE999|E44FF9EF|B3BBB3BC|BBABB2AB|
; |  3BBBBB|        |39E9499E|F57BBA22|   3FFF9|9F4FFFFF|BABBB2AB|ABABB2BB|
; |33 BB   |        |3EF94EFF|F57CB262|    33FF|F33   FF|2ABBAABA|BABBAAB |
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:F680             db 32,FF,36,FF,64,FF,CB,FF,86,FF,FE,FE,B9,FF,32,FF,00,77,00,77,00,F7,00,CF,00,7E,01,BB,00,FB,00,7F,
                        B5,BF,F5,BF,E5,BF,E5,7F,E9,FF,D9,FF,5B,FF,B2,FE,40,FF,00,AD,00,9F,00,4D,00,AD,00,FB,00,FB,00,FE,
                        00,00,00,00,03,03,07,07,0F,0F,1F,1F,2D,3F,09,3F,00,00,00,00,03,03,07,07,0F,0F,1F,1F,3F,3F,3F,3F,
                        3B,3B,FC,FC,EC,EC,FB,FB,F4,F4,CF,CF,BE,BE,3E,FE,38,38,F8,F8,E0,E0,C0,C0,C0,C0,82,82,BE,BE,D8,D8,
                        6A,5F,33,5E,55,38,E6,B9,CB,B0,E9,B3,D6,A1,B3,E7,5F,7F,5E,7F,3A,7D,B9,FF,34,7B,37,7B,29,77,6F,77,
                        57,76,BA,FA,3F,FC,7D,F9,DE,DB,C4,C7,F8,BF,E8,AF,B1,78,72,75,EC,E0,FA,E3,D0,EB,C8,FF,E0,9C,F2,98,
                        07,07,FB,03,76,F8,FF,FC,5F,FE,27,FF,53,FF,22,FF,38,FE,04,07,01,F9,00,FC,00,DE,00,EF,00,77,00,37,
                        C0,C0,30,F0,88,F8,00,7C,64,7E,E2,7E,30,3F,F5,BF,00,40,00,F0,00,98,80,EC,80,F6,00,76,C0,DB,00,BF,
                        0E,0F,1D,1F,BF,BF,1F,1F,33,33,4F,4F,3F,3F,D8,D8,00,07,00,07,00,07,00,0C,00,00,00,03,00,1F,00,18,
                        74,FE,E4,FC,F8,FC,D0,F8,E0,F0,C0,C0,00,00,00,00,00,FE,00,FC,00,7C,00,78,00,F0,00,C0,00,00,00,00,
                        6A,5F,33,5E,55,38,E6,B9,CB,B0,E9,B3,D6,A1,B3,E7,5F,7F,5E,7F,3A,7D,B9,FF,34,7B,37,7B,29,77,6F,77,
                        57,76,BA,FA,3F,FC,7D,F9,DE,DB,C4,C7,F8,BF,E8,AF,B1,78,72,75,EC,E0,FA,E3,D0,EB,C8,FF,E0,9C,F2,98,
                        AA,F9,B0,FB,59,79,6D,5D,38,24,37,38,1F,1E,0F,0F,7D,7B,7F,7B,3F,39,1F,3D,27,3C,18,1F,0E,0F,03,03,
                        C8,8F,D8,DF,F4,D7,F7,EB,78,7C,1D,9B,DF,5F,E3,E3,D3,B8,C0,FC,E8,DF,F8,EB,FF,7F,FB,9F,7F,DF,83,83,
                        32,FF,36,FF,64,FF,CB,FF,86,FF,FE,FE,B9,FF,32,FF,00,77,00,77,00,F7,00,CF,00,7E,01,BB,00,FB,00,7F,
                        B5,BF,F5,BF,E5,BF,E5,7F,E9,FF,D9,FF,5B,FF,B2,FE,40,FF,00,AD,00,9F,00,4D,00,AD,00,FB,00,FB,00,FE,
}


;;; $F880: Samus bottom tiles - set 9 - entry 7 ;;;
{
; 1Bh: Facing right - space jump - frame 8
; 1Ch: Facing left  - space jump - frame 8
; 81h: Facing right - screw attack - frame 8
; 81h: Facing right - screw attack - frame 10h
; 81h: Facing right - screw attack - frame 18h
; 82h: Facing left  - screw attack - frame 8
; 82h: Facing left  - screw attack - frame 10h
; 82h: Facing left  - screw attack - frame 18h
; 83h: Facing right - wall jump - frame 14h
; 83h: Facing right - wall jump - frame 1Eh
; 83h: Facing right - wall jump - frame 26h
; 83h: Facing right - wall jump - frame 2Eh
; 84h: Facing left  - wall jump - frame 14h
; 84h: Facing left  - wall jump - frame 1Eh
; 84h: Facing left  - wall jump - frame 26h
; 84h: Facing left  - wall jump - frame 2Eh
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |   BBBBB|BA33B2BB|23AA22A9|C911933 |1B75FF4E| 3      |
; |        |        |   BABBA|BAC2332B|2ABAAABC|BBBB333 |BB75FEEF|3  3   3|
; |      33|33      |   BBBBB|BBB22323|BA3BBBB9|ABBBB3  |C585FEFF|3 3   2B|
; |     F3F|F9F33   |   BABAB|A339AA32|33AABB2C|2ABB    |9583FFFF|B33  A2B|
; |    FFF9|99EE3E3 |   BABAB|ABBCC33A|233332C9|BBB     |5753FFFF|BBB3BBAB|
; |   FF994|EFFFFEE3|    BABA|B2339CBB|BAA22B91|        |383333 3|B33A33BB|
; |   39E44|444FEFE9|    BAB2|AABB39CB|BBBBBC13|        |85 33 3 |BBAABA62|
; |   F444F|EE44EEE9|     BAB|2AAB33C9|CBBC91C5|        |5 33    |AAB2BAB2|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |  FFFFFF|FEEE49EF|     BBA|B2ABB3BB|      3 |FFFEF   |99F     |        |
; | FFFFFFF|FEFF99EE|      BB|A22AAABB|     3  |FEFF3   |F99     |        |
; |32A35F5F|FFFEE4FE|       B|BA2222AA|    33B |FFFF3   |EEEF    |        |
; |BCA1CFF8|5FFFE99F|        | BBAA222|    333B|3FE33   |EF9F    |        |
; |3C911CCC|75FFEE9F|        |  BBBAAB|    B33B|3F33F   |EFEE    |        |
; |2ABA229C|B8FFEE4F|        |        |   3BB33| 333    |EFFEF   |        |
; |AB326621|B88FEE9E|        |        |   BBB3B|  3     |FEFEF   |3       |
; |ABA226A9|CB7FEF4E|        |        |   BABBB| 3      |FEFEF   |93      |
; |--------|--------|--------|--------|--------|--------|--------|--------|
$9C:F880             db 00,00,00,00,03,03,07,07,0F,0E,1E,18,18,14,11,11,00,00,00,00,00,00,05,05,0E,0F,19,1E,07,0C,1F,11,
                        00,00,00,00,C0,C0,F8,B8,CA,3E,79,FF,15,1E,01,CE,00,00,00,00,00,00,A0,E0,34,F4,FE,FE,FE,1F,FE,CF,
                        1F,1F,16,1F,1F,1F,15,1F,15,1F,0A,0F,0A,0F,05,07,00,1F,00,1F,00,1F,00,1F,00,1F,00,0F,00,0E,00,07,
                        BB,FF,8D,DF,E5,FF,72,EF,66,E7,BB,F3,3D,F9,1D,FC,00,CB,20,E1,00,E0,00,9C,18,F9,04,8F,02,F7,02,73,
                        41,FE,22,FE,BF,FE,CC,FE,79,FC,87,FC,FB,F9,6D,60,00,33,01,7F,00,DF,01,3D,02,03,00,E6,04,FC,93,FA,
                        7E,06,FE,FE,7C,FC,30,F0,E0,E0,00,00,00,00,00,00,80,C8,00,F0,00,F8,00,70,00,E0,00,00,00,00,00,00,
                        FC,6D,F9,EF,5B,0F,DF,1F,FF,5F,BD,BD,5A,1A,B0,30,3F,4D,3F,CF,DF,AF,4F,AF,EF,0F,00,40,40,80,80,00,
                        40,40,91,91,A1,A3,E1,E7,FD,FF,EF,FF,C8,FF,2A,FF,00,00,00,00,00,01,00,85,00,EF,00,93,02,FC,00,EE,
                        3F,3F,7F,7F,9F,F5,96,A6,B8,80,22,FC,61,FE,41,FE,3F,3F,7F,7F,0F,25,4E,EF,47,67,01,73,0C,C0,04,E3,
                        85,F3,BC,F3,E2,FB,F7,79,F3,BD,B1,BD,92,9D,74,7D,FB,F7,F3,FF,FF,FB,F9,7F,FD,3F,3F,FD,1D,FF,BF,DD,
                        06,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,07,00,03,00,01,00,00,00,00,00,00,00,00,00,00,
                        9F,FF,03,FF,80,FF,60,7F,39,3F,00,00,00,00,00,00,00,BB,00,9F,00,C3,00,78,00,3F,00,00,00,00,00,00,
                        02,02,04,04,0E,0E,0F,0F,0F,0F,1F,1F,1F,1F,17,1F,00,00,00,00,00,02,00,01,00,09,00,0C,00,1D,00,1F,
                        E8,F8,B8,F8,F8,F8,D8,F8,F8,F8,70,70,20,20,40,40,F8,F8,F0,F0,F0,F0,60,60,48,48,00,00,00,00,00,00,
                        E0,20,E0,80,10,F0,70,D0,40,F0,68,F8,A8,F8,A8,F8,20,E0,80,E0,F0,F0,D0,F0,F0,F0,F8,F8,F8,F8,F8,F8,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,C0,40,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,
}
}


;;; $FA80: Free space ;;;
{
$9C:FA80             fillto $9D8000, $FF
}
