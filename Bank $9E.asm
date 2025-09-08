;;; $8000..A65F: Samus top tiles - set 0 (general) ;;;
{
;;; $8000: Samus top tiles - set 0 - entry 0 ;;;
{
; 9: Moving right - not aiming - frames 0 / 5
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 3
; C7h: Facing right - vertical shinespark windup - frame 3
; F0h: Facing right - grabbed by Draygon - moving - frames 2 / 5
; |--------|--------|--------|--------|
; |3BBABABA|B33F    |        |        |
; |F3333BBB|B3E3    |     FFF|EE      |
; |FD58785D|3FEE    |   FFEF6|9EE     |
; |33333333|3FFE    |  FFEEFE|EFFE    |
; |5BBBBBB3|33FF    |  F3333F|EF4F    |
; |8BA62AB3|1333    | 3A2A2AB|F344    |
; |3BA22AB3|C13     |3BA6A2AA|3834    |
; |33AA2AB3|33      |3BB2B2BA|B353    |
; |--------|--------|--------|--------|
; | 3BAAB3D|DDD3D   |3BBABABA|B33F    |
; | 3BBB335|5553535 |F3333BBB|B3E3    |
; |  3333D8|8883738 |FD58785D|3FEE    |
; |  BA33D5|55D3D35 |33333333|3FFE    |
; |  3BB3DD|DDD3D3D |5BBBBBB3|33FF    |
; |   33333|3333333 |8BA62AB3|1333    |
; |        |        |3BA22AB3|C13     |
; |        |        |33AA2AB3|33      |
; |--------|--------|--------|--------|
$9E:8000             db EA,FF,FF,FF,EB,88,FF,FF,FF,7F,43,7F,C3,FF,C3,FF,00,7F,80,87,EB,D5,00,00,80,7E,10,E6,00,66,00,36,
                        F0,F0,D0,F0,C0,F0,E0,F0,F0,F0,F0,70,60,20,C0,C0,10,90,20,A0,70,70,70,70,30,30,00,00,80,80,00,00,
                        00,00,07,07,1A,1F,32,3F,3F,3F,41,7F,C0,FF,EA,FF,00,00,07,07,1F,1E,3F,3F,21,21,00,2B,10,6B,00,6B,
                        00,00,00,C0,80,60,60,F0,50,D0,C0,C0,A0,A0,F0,D0,00,00,C0,C0,60,E0,F0,F0,F0,D0,B0,80,10,40,20,80,
                        67,7E,7F,7E,3E,3C,2F,3C,3F,3C,1F,1F,00,00,00,00,01,3D,01,38,02,03,03,32,03,1B,00,00,00,00,00,00,
                        F8,10,FE,14,1C,1C,FE,14,FE,14,FE,FE,00,00,00,00,E8,E8,EA,00,08,E2,EA,28,EA,EA,00,00,00,00,00,00,
                        EA,FF,FF,FF,EB,88,FF,FF,FF,7F,43,7F,C3,FF,C3,FF,00,7F,80,87,EB,D5,00,00,80,7E,10,E6,00,66,00,36,
                        F0,F0,D0,F0,C0,F0,E0,F0,F0,F0,F0,70,60,20,C0,C0,10,90,20,A0,70,70,70,70,30,30,00,00,80,80,00,00,
}


;;; $8100: Samus top tiles - set 0 - entry 1 ;;;
{
; 9: Moving right - not aiming - frame 4
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 4
; C7h: Facing right - vertical shinespark windup - frame 4
; F0h: Facing right - grabbed by Draygon - moving - frame 0
; |--------|--------|--------|--------|
; |F3BBAABA|BA3F    |        |        |
; |F33333BB|BBF3    |     FFF|EE      |
; |F3DD5878|5DFE33  |   FFEF6|9EE     |
; |F3D33333|33F33D3 |  FFEEFE|EFFE    |
; |53333BBB|3F33D583| 3FF3333|FE4F    |
; |8F3BBAAB|33D5375D| FF3A2AA|BF44    |
; |333BA62A|B3D583D3|3F3A62A2|2334    |
; | 33BA222|B33D5D33|F3BAA2B2|BA53    |
; |--------|--------|--------|--------|
; |   3BA2A|BB3DD33 |F3BBAABA|BA3F    |
; |    3BAB|B33333  |F33333BB|BBF3    |
; |     3BB|3AB3    |F3DD5878|5DFE33  |
; |      33|BBB     |F3D33333|33F33D3 |
; |        |        |53333BBB|3F33D583|
; |        |        |8F3BBAAB|33D5375D|
; |        |        |333BA62A|B3D583D3|
; |        |        | 33BA222|B33D5D33|
; |--------|--------|--------|--------|
$9E:8100             db F2,FF,FF,FF,FA,C2,FF,DF,FF,7F,79,7F,F0,FF,70,7F,80,BF,80,83,BA,B5,A0,A0,80,07,40,DF,04,19,00,18,
                        B0,F0,F0,F0,EC,3C,FE,FA,FD,F1,FF,CC,F7,C5,FF,E3,10,D0,20,E0,F0,70,24,24,4C,4A,37,21,32,AA,1C,94,
                        00,00,07,07,1A,1F,32,3F,7F,7F,70,7F,E0,FF,E2,FF,00,00,07,07,1F,1E,3F,3F,30,30,60,6B,48,52,80,BA,
                        00,00,00,C0,80,60,60,F0,90,D0,C0,C0,60,E0,B0,D0,00,00,C0,C0,60,E0,F0,F0,F0,D0,70,C0,10,00,20,C0,
                        18,1F,0D,0F,07,07,03,03,00,00,00,00,00,00,00,00,00,0D,00,07,00,03,00,00,00,00,00,00,00,00,00,00,
                        FE,E6,FC,FC,B0,F0,E0,E0,00,00,00,00,00,00,00,00,18,D8,00,80,00,60,00,E0,00,00,00,00,00,00,00,00,
                        F2,FF,FF,FF,FA,C2,FF,DF,FF,7F,79,7F,F0,FF,70,7F,80,BF,80,83,BA,B5,A0,A0,80,07,40,DF,04,19,00,18,
                        B0,F0,F0,F0,EC,3C,FE,FA,FD,F1,FF,CC,F7,C5,FF,E3,10,D0,20,E0,F0,70,24,24,4C,4A,37,21,32,AA,1C,94,
}


;;; $8200: Samus top tiles - set 0 - entry 2 ;;;
{
; 9: Moving right - not aiming - frame 2
; F0h: Facing right - grabbed by Draygon - moving - frame 1
; |--------|--------|--------|--------|--------|
; |AABABB85|   3D   |        | FFFEE  |        |
; |BABB3853| 3DD53  |       F|FEEF69E |        |
; |BB337533|3D55373 |     AFF|EEBBBEFE|        |
; |3335D3BB|3DD8D3D |    B3FF|3BAABB4F|        |
; |33DD3BAB|B3DD5D3 |   B3FF3|BB622AB4|        |
; |F333BA62|B33DD3  |   3BF3B|A2BA22A4|        |
; |113BA222|AB3D3   |   BAF3B|BA2BA2A3|        |
; |1C33BA2A|BB33    |   ABE3B|AB22BABB|        |
; |--------|--------|--------|--------|--------|
; |   33BB3|333     |  3ABE3B|AABABB85|
; |     333|AB      | B333E3B|BABB3853|
; |      3B|B       | B3B3EF3|BB337533|
; |        |        | B3B3FF3|3335D3BB|
; |        |        |  3BB55F|33DD3BAB|
; |        |        |   BBD8F|F333BA62|
; |        |        |    B333|113BA222|
; |        |        |     331|1C33BA2A|
; |--------|--------|--------|--------|
$9E:8200             db 2D,FC,BB,F9,FF,FB,FF,E7,FD,CF,F8,FF,F0,3F,B8,3F,01,FE,02,F4,0C,C0,18,0B,30,37,82,8C,00,18,40,4D,
                        18,10,7C,44,FE,8E,EE,84,FE,C2,FC,E4,78,E8,F0,F0,08,08,38,30,74,40,6A,7A,3C,B4,18,98,10,D0,00,C0,
                        00,00,01,01,03,07,0F,0F,1F,1F,1F,1F,17,1F,0B,1F,00,00,01,01,03,07,03,0B,06,16,04,0D,04,1D,04,1D,
                        70,7C,94,FA,3A,FF,CD,FD,C2,FE,20,FE,91,FF,4B,FF,7C,7C,FA,F6,C7,FF,03,7D,21,C6,01,B2,00,DA,00,CF,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1F,1F,07,07,03,03,00,00,00,00,00,00,00,00,00,00,00,06,00,00,00,01,00,00,00,00,00,00,00,00,00,00,
                        E0,E0,40,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        2B,3F,7B,7F,7B,7F,7F,7F,3F,39,1D,19,0F,0F,07,06,04,1D,04,45,06,56,06,56,07,19,05,1F,00,08,00,00,
                        2D,FC,BB,F9,FF,FB,FF,E7,FD,CF,F8,FF,F0,3F,B8,3F,01,FE,02,F4,0C,C0,18,0B,30,37,82,8C,00,18,40,4D,
}


;;; $8320: Samus top tiles - set 0 - entry 3 ;;;
{
; 9: Moving right - not aiming - frame 3
; |--------|--------|--------|--------|--------|
; |ABABB83 |  DD5373|        |FFFEE   |        |
; |BAB385A |3DD58D3D|      FF|EEF69E  |        |
; |BB375333|DD5855D3|    AFFE|EFFFEFE |        |
; |B35D33BB|35855D3 |   B3FF3|3AAFF4F |        |
; |3DD33BAB|B3D5D3  |  B33F3B|A622AF4 |        |
; |3333BA6A|BB3D3   | B33F3BA|6BA22A4 |        |
; |133BA222|AB33    |BBB3F3BB|A2BA2A3 |     D  |
; |CC33BA2A|B33     |BBA3E3BA|B22BABB |   D353 |
; |--------|--------|--------|--------|--------|
; |   33BBB|3A      |B3A3E3BB|ABABB83 |
; |     333|B3      |B333E3BB|BAB385A |
; |        |        |33B3EF3B|BB375333|
; |        |        |3BB33333|B35D33BB|
; |        |        | 3B355F3|3DD33BAB|
; |        |        |  B3D833|3333BA6A|
; |        |        |   33111|133BA222|
; |        |        |    331C|CC33BA2A|
; |--------|--------|--------|--------|
$9E:8320             db 5A,FA,B4,F2,FF,F7,FF,CF,FD,9F,F8,FF,F0,7F,38,3F,00,FC,04,EA,18,C0,30,93,60,67,02,0D,00,18,C0,CD,
                        3F,07,F7,82,EF,01,DE,82,FC,C4,F8,E8,70,F0,E0,E0,3A,30,75,6D,EE,D2,5C,24,38,A8,10,D0,00,C0,00,80,
                        00,00,03,03,06,0F,1F,1F,3F,3F,7E,7F,FF,FF,D6,FF,00,00,03,03,07,0F,06,16,04,25,08,4B,08,EB,08,EB,
                        E0,F8,28,F4,74,FE,9A,FA,04,FC,40,FC,22,FE,96,FE,F8,F8,F4,EC,FE,FE,1E,7A,46,8C,82,64,00,B4,00,9E,
                        00,00,00,00,00,00,00,00,00,00,00,00,04,00,1E,0A,00,00,00,00,00,00,00,00,00,00,00,00,04,04,14,10,
                        1F,1F,07,07,00,00,00,00,00,00,00,00,00,00,00,00,00,07,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        80,C0,C0,C0,00,00,00,00,00,00,00,00,00,00,00,00,00,40,00,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        D7,FF,F7,FF,F7,FF,FF,FF,7F,73,3B,33,1F,18,0E,0C,08,AB,08,8B,0C,2D,00,60,0E,22,08,2C,00,00,01,01,
                        5A,FA,B4,F2,FF,F7,FF,CF,FD,9F,F8,FF,F0,7F,38,3F,00,FC,04,EA,18,C0,30,93,60,67,02,0D,00,18,C0,CD,
}


;;; $8440: Samus top tiles - set 0 - entry 4 ;;;
{
; 9: Moving right - not aiming - frame 9
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frames 0 / 2
; C7h: Facing right - vertical shinespark windup - frames 0 / 2
; F0h: Facing right - grabbed by Draygon - moving - frame 3
; |--------|--------|--------|--------|
; |333BBBBA|AB3F3F  |        |        |
; |3DD5785B|BB3FE3  |       F|FFEE    |
; |33333D55|B33FEE  |     FFE|F69EE   |
; |3BBBB333|333FFE  |   33333|FEEFFE  |
; |BBAAABB3|3333F3  |  3BBBBB|3FEF4F  |
; |BA622B33|311333B3| 3B2A2AA|B3F344  |
; |BA22AB33|11C133AB| BAB6AB2|AB3834  |
; |BA22A333|31C13B2A| BABAB22|AB3353B |
; |--------|--------|--------|--------|
; |3BAAB333|31113BB3|333BBBBA|AB3F3F  |
; |333333D3|3333333 |3DD5785B|BB3FE3  |
; |BAB33D5D|D33     |33333D55|B33FEE  |
; | BB3D585|5D33    |3BBBB333|333FFE  |
; |  33DD58|83DD3   |BBAAABB3|3333F3  |
; |    3DD5|3853D3  |BA622B33|311333B3|
; |     33D|D538D3  |BA22AB33|11C133AB|
; |       3|3DD53   |BA22A333|31C13B2A|
; |--------|--------|--------|--------|
$9E:8440             db FE,FF,FB,89,FF,F8,FF,FF,C7,FF,87,FF,87,FF,87,FF,00,1F,7A,65,07,04,00,78,00,FE,20,C4,00,CC,00,C8,
                        7C,FC,F4,FC,F0,FC,F8,FC,FC,FC,FF,9F,DD,0F,DC,8F,14,D4,18,D8,1C,9C,1C,1C,08,08,00,02,20,23,20,25,
                        00,00,01,01,06,07,1F,1F,3F,3F,60,7F,52,7F,54,7F,00,00,01,01,07,07,00,00,00,1F,00,2B,08,76,00,7C,
                        00,00,C0,F0,A0,D8,98,FC,D4,F4,F0,F0,68,E8,7E,F6,00,00,F0,F0,D8,B8,FC,FC,7C,74,2C,A0,04,D0,08,C2,
                        CF,FF,FF,FD,BF,F8,7D,70,3E,30,0F,08,07,06,01,01,00,78,02,02,07,E5,0D,6A,0E,0D,07,06,01,01,00,00,
                        FF,8F,FE,FE,E0,60,F0,30,78,48,BC,94,EC,24,F8,88,00,06,00,00,80,80,C0,40,30,B0,28,48,C8,98,70,60,
                        FE,FF,FB,89,FF,F8,FF,FF,C7,FF,87,FF,87,FF,87,FF,00,1F,7A,65,07,04,00,78,00,FE,20,C4,00,CC,00,C8,
                        7C,FC,F4,FC,F0,FC,F8,FC,FC,FC,FF,9F,DD,0F,DC,8F,14,D4,18,D8,1C,9C,1C,1C,08,08,00,02,20,23,20,25,
}


;;; $8540: Samus top tiles - set 0 - entry 5 ;;;
{
; 9: Moving right - not aiming - frame 7
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 1
; C7h: Facing right - vertical shinespark windup - frame 1
; F0h: Facing right - grabbed by Draygon - moving - frame 4
; |--------|--------|--------|--------|--------|--------|
; | 3FFFEE |        |  BA262A|355BB33F|        | 3FFFEE |
; |BB33699E|        |  3BA2AB|B3DD3FF9|       3|BB33699E|
; |ABAB3FFF|E       | 3A3BBB3|3333FFEE|      3B|ABAB3FFF|
; |B62AB344|F       | 3BA3B3D|33FFFFEF|     3BA|B62AB344|
; |A2BAAB34|4       | 3BB338D|D333FFFF|     B3B|A2BAAB34|
; |AB22AB83|4B      |  333D58|DD3133F3|    3D53|AB22AB83|
; |3BA2AB35|3B      |   33DD5|8D33C133|   3B3D8|3BA2AB35|
; |8BBABB33|FB      |    33DD|53D3C33B|   BA2B3|8BBABB33|
; |--------|--------|--------|--------|--------|--------|
; |355BB33F|3   BB2B|     33D|3583    |  BA262A|355BB33F|
; |B3DD3FF9|E  3AB2B|      33|DDD3    |  3BA2AB|B3DD3FF9|
; |3333FFEE|E3 3AB2B|       3|3D3     | 3A3BBB3|3333FFEE|
; |33FFFFEF|3BA33BBB|        |33      | 3BA3B3D|33FFFFEF|
; |D333FFFF|3A2B333 |        |        | 3BB338D|D333FFFF|
; |DD3133F3|BAAB3   |        |        |  333D58|DD3133F3|
; |8D33C133|AAB3    |        |        |   33DD5|8D33C133|
; |53D3C33B|BB3     |        |        |    33DD|53D3C33B|
; |--------|--------|--------|--------|--------|--------|
$9E:8540             db 78,7E,F6,F9,5F,FF,8C,FC,26,FE,45,FD,C7,FE,6F,7F,3E,3E,09,C7,07,F7,43,98,01,BC,00,CE,01,6C,00,FC,
                        00,00,00,00,00,80,80,80,00,00,40,40,C0,C0,C0,C0,00,00,00,00,80,80,80,80,80,00,80,40,00,40,80,C0,
                        20,3F,31,3F,5F,7F,6F,7E,7D,7C,3E,38,1F,18,0F,0C,04,31,00,1B,00,2E,01,35,01,33,06,05,07,06,03,03,
                        FF,9F,FF,CE,FC,FF,FD,FF,FF,7F,FF,2F,77,33,F7,57,61,19,36,B7,0F,0F,3F,3F,8F,8F,C2,C2,48,C8,A8,29,
                        00,00,01,01,03,03,06,07,07,07,0F,09,1E,1C,13,1F,00,00,00,00,00,01,00,03,00,05,06,04,02,0B,00,1A,
                        78,7E,F6,F9,5F,FF,8C,FC,26,FE,45,FD,C7,FE,6F,7F,3E,3E,09,C7,07,F7,43,98,01,BC,00,CE,01,6C,00,FC,
                        FF,9F,FF,CE,FC,FF,FD,FF,FF,7F,FF,2F,77,33,F7,57,61,19,36,B7,0F,0F,3F,3F,8F,8F,C2,C2,48,C8,A8,29,
                        8D,8F,15,9F,55,DF,DF,FF,9E,FE,98,F8,30,F0,E0,E0,00,0D,80,8D,80,8D,00,67,00,50,00,F0,00,E0,00,C0,
                        07,06,03,03,01,01,00,00,00,00,00,00,00,00,00,00,01,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        D0,90,F0,10,E0,A0,C0,C0,00,00,00,00,00,00,00,00,40,20,E0,E0,40,40,00,00,00,00,00,00,00,00,00,00,
                        20,3F,31,3F,5F,7F,6F,7E,7D,7C,3E,38,1F,18,0F,0C,04,31,00,1B,00,2E,01,35,01,33,06,05,07,06,03,03,
                        FF,9F,FF,CE,FC,FF,FD,FF,FF,7F,FF,2F,77,33,F7,57,61,19,36,B7,0F,0F,3F,3F,8F,8F,C2,C2,48,C8,A8,29,
}


;;; $86C0: Samus top tiles - set 0 - entry 6 ;;;
{
; Ah: Moving left  - not aiming - frames 0 / 5
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 3
; BEh: Facing left  - grabbed by Draygon - moving - frames 2 / 5
; C8h: Facing left  - vertical shinespark windup - frame 3
; |--------|--------|--------|--------|
; |    F33B|ABABABB3|        |        |
; |    3E3B|BBB33333|      EE|FFF     |
; |    EEF3|D58785D3|     EE9|6FEFF   |
; |    EFF3|33333333|    EFFE|F333FF  |
; |    EFF3|3BA2ABB3|    F4FF|3BBBB33 |
; |    3F31|33226AB5|    443F|BA6A2B3 |
; |    3311|33A22AB3|    4383|AA2A2AB3|
; |  BB3333|B3BAAAB |    353B|AB2B2AB3|
; |--------|--------|--------|--------|
; | B2A3ABB|B3BBBB3 |    F33B|ABABABB3|
; | BAA3226|AB3B333 |    3E3B|BBB33333|
; |  BB3BAA|AA33BA3 |    EEF3|D58785D3|
; |   333BB|BBB3BB  |    EFF3|33333333|
; |      33|3333    |    EFF3|3BA2ABB3|
; |        |        |    3F31|33226AB5|
; |        |        |    3311|33A22AB3|
; |        |        |  BB3333|B3BAAAB |
; |--------|--------|--------|--------|
$9E:86C0             db 0F,0F,0B,0F,03,0F,07,0F,07,0F,0F,0E,0F,0C,3F,3F,08,09,04,05,0E,0E,0E,0E,0E,0E,04,04,00,00,00,30,
                        57,FF,FF,FF,D7,11,FF,FF,C7,FF,C3,FE,C3,FF,E2,FE,00,FE,00,E0,D6,AA,00,00,00,6E,09,06,00,26,00,BE,
                        00,00,00,03,01,06,06,0F,0B,0B,03,03,05,05,0F,0B,00,00,03,03,06,07,0F,0F,0F,0B,0D,01,08,02,04,01,
                        00,00,E0,E0,58,F8,FC,FC,FE,FE,86,FE,03,FF,53,FF,00,00,E0,E0,F8,78,8C,8C,00,78,20,D4,00,D6,00,D6,
                        4B,7F,48,7F,3C,3F,1F,1F,03,03,00,00,00,00,00,00,00,57,01,70,00,37,00,03,00,00,00,00,00,00,00,00,
                        FE,FE,7E,FE,3A,FE,FC,FC,F0,F0,00,00,00,00,00,00,00,BC,00,D0,00,CC,00,EC,00,00,00,00,00,00,00,00,
                        0F,0F,0B,0F,03,0F,07,0F,07,0F,0F,0E,0F,0C,3F,3F,08,09,04,05,0E,0E,0E,0E,0E,0E,04,04,00,00,00,30,
                        57,FF,FF,FF,D7,11,FF,FF,C7,FF,C3,FE,C3,FF,E2,FE,00,FE,00,E0,D6,AA,00,00,00,6E,09,06,00,26,00,BE,
}


;;; $87C0: Samus top tiles - set 0 - entry 7 ;;;
{
; Ah: Moving left  - not aiming - frame 4
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 4
; BEh: Facing left  - grabbed by Draygon - moving - frame 0
; C8h: Facing left  - vertical shinespark windup - frame 4
; |--------|--------|--------|--------|
; |    F3AA|BABABB3F|        |        |
; |    3EBB|BB333B3F|      EE|FFF     |
; |    EF3D|5785D33F|     EE9|6FEFF   |
; |    FF33|3333DD3F|    EFFE|FFFFFF  |
; |B2B33FF3|BBB333FF|    F4EF|BBB33FB |
; |A2A33333|BA2B33F5|    44FA|A6AA33FB|
; |BA3BB33B|A262B333|    43B2|A2A2A3FB|
; |33B2AB3A|A22AB3  |    35A2|B2B2AB3F|
; |--------|--------|--------|--------|
; | 3B26A3B|A2AB3   |    F3AA|BABABB3F|
; |  BAAA33|BAB3    |    3EBB|BB333B3F|
; |   BAB3A|3B3     |    EF3D|5785D33F|
; |    B3BB|3       |    FF33|3333DD3F|
; |        |        |B2B33FF3|BBB333FF|
; |        |        |A2A33333|BA2B33F5|
; |        |        |BA3BB33B|A262B333|
; |        |        |33B2AB3A|A22AB3  |
; |--------|--------|--------|--------|
$9E:87C0             db 0C,0F,0B,0F,07,0E,0F,0F,BF,FF,1F,FF,BF,FF,E6,FF,08,0B,04,07,0D,0D,0C,0C,06,A6,00,A0,00,D9,00,2D,
                        AF,FF,FF,FF,DF,47,FF,F3,FF,FF,9F,FE,0F,FF,0C,FC,01,FD,01,C5,D9,29,0D,0D,03,E3,03,D2,20,88,00,98,
                        00,00,00,03,01,06,06,0F,09,0B,02,03,06,07,0C,0B,00,00,03,03,06,07,0F,0F,0F,0B,0E,03,08,02,04,02,
                        00,00,E0,E0,58,F8,FC,FC,FE,FE,0F,FF,07,FF,A7,FF,00,00,E0,E0,F8,78,FC,FC,04,E6,42,B3,02,AB,01,AD,
                        63,7F,23,3F,16,1F,0F,0F,00,00,00,00,00,00,00,00,08,25,00,3C,00,1D,00,0B,00,00,00,00,00,00,00,00,
                        18,F8,B0,F0,E0,E0,80,80,00,00,00,00,00,00,00,00,00,B0,00,E0,00,40,00,00,00,00,00,00,00,00,00,00,
                        0C,0F,0B,0F,07,0E,0F,0F,BF,FF,1F,FF,BF,FF,E6,FF,08,0B,04,07,0D,0D,0C,0C,06,A6,00,A0,00,D9,00,2D,
                        AF,FF,FF,FF,DF,47,FF,F3,FF,FF,9F,FE,0F,FF,0C,FC,01,FD,01,C5,D9,29,0D,0D,03,E3,03,D2,20,88,00,98,
}


;;; $88C0: Samus top tiles - set 0 - entry 8 ;;;
{
; Ah: Moving left  - not aiming - frame 2
; BEh: Facing left  - grabbed by Draygon - moving - frame 1
; |--------|--------|--------|--------|--------|--------|
; |        |35BBABAB|  EEFFF |        |        |  EEFFF |
; |  2AB   |ED83BABB| E969FEF|F       |        | E969FEF|
; | AB3B3  |33D733BB|EFEFFFFE|3FA     |        |EFEFFFFE|
; | A3BA2B3|333D8333|F4BBAAB3|3F3B    |        |F4BBAAB3|
; | B3A26A3|BAB33DD3|4FA226AB|3FF3B   |        |4FA226AB|
; |  BBAABB|A26AB333|4A22AA2A|B3FB3   |        |4A22AA2A|
; |   3BB3B|A222AB11|3B2AB2AA|B3FAB   |        |3B2AB2AA|
; |    3333|AAAAB3C1|FBBB2ABA|B3EBAB  |        |FBBB2ABA|
; |--------|--------|--------|--------|--------|--------|
; |     BA3|BABB3   |35BBABAB|B3EBA3  |        |35BBABAB|
; |      B3|BB33    |ED83BABB|B3E333B |  2AB   |ED83BABB|
; |        |        |33D733BB|3FE3D3B | AB3B3  |33D733BB|
; |        |        |333D8333|3333D3B | A3BA2B3|333D8333|
; |        |        |BAB33DD3|3553D3  | B3A26A3|BAB33DD3|
; |        |        |A26AB333|1D833   |  BBAABB|A26AB333|
; |        |        |A222AB11|3D33    |   3BB3B|A222AB11|
; |        |        |AAAAB3C1|333     |    3333|AAAAB3C1|
; |--------|--------|--------|--------|--------|--------|
$9E:88C0             db 00,00,08,38,3C,7C,33,7F,61,7F,33,3F,1F,1F,0F,0F,00,00,00,18,00,68,00,5A,04,52,00,3F,00,0D,00,00,
                        F5,BF,5B,9F,FF,DF,F7,E7,BF,F9,0F,FF,07,FC,0D,FC,40,3F,C0,EF,30,23,10,18,06,E6,20,98,00,8C,02,FA,
                        0E,3E,2D,57,5E,FF,B3,BF,41,7F,00,7F,C8,FF,F2,FF,3E,3E,57,6F,FF,FF,C0,BE,C4,63,80,4D,00,5B,80,F7,
                        00,00,80,80,C0,E0,F0,F0,F8,F8,F8,F8,E8,F8,D4,FC,00,00,80,80,40,60,40,50,60,68,20,B0,20,B8,20,BC,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        0E,3E,2D,57,5E,FF,B3,BF,41,7F,00,7F,C8,FF,F2,FF,3E,3E,57,6F,FF,FF,C0,BE,C4,63,80,4D,00,5B,80,F7,
                        05,07,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,06,00,02,00,00,00,00,00,00,00,00,00,00,00,00,
                        B8,F8,F0,F0,00,00,00,00,00,00,00,00,00,00,00,00,00,F0,00,C0,00,00,00,00,00,00,00,00,00,00,00,00,
                        F5,BF,5B,9F,FF,DF,F7,E7,BF,F9,0F,FF,07,FC,0D,FC,40,3F,C0,EF,30,23,10,18,06,E6,20,98,00,8C,02,FA,
                        D4,FC,DE,FE,DE,F6,FE,F6,FC,94,D8,18,F0,B0,E0,E0,20,B8,20,A2,68,6A,08,0A,68,08,40,60,40,40,00,00,
                        00,00,08,38,3C,7C,33,7F,61,7F,33,3F,1F,1F,0F,0F,00,00,00,18,00,68,00,5A,04,52,00,3F,00,0D,00,00,
                        F5,BF,5B,9F,FF,DF,F7,E7,BF,F9,0F,FF,07,FC,0D,FC,40,3F,C0,EF,30,23,10,18,06,E6,20,98,00,8C,02,FA,
}


;;; $8A40: Samus top tiles - set 0 - entry 9 ;;;
{
; Ah: Moving left  - not aiming - frame 3
; |--------|--------|--------|--------|--------|--------|
; |AA333   | 35BBABA|        |   EEFFF|   EEFFF|        |
; |A3BAB3  | FD83BAB|        |  E969FE|  E969FE|FF      |
; |B3A2AB3 | 33D73BB|        | EFEFFFE| EFEFFFE|E3FA    |
; | BBA2AB3|3B33D833|        | F4FFAA3| F4FFAA3|33F3B   |
; |  3BAB33|ABB33355|        | 4FA226A| 4FA226A|B3F33B  |
; |   BBB3B|26AB3333|        | 4F22AA6| 4F22AA6|AB3F33B |
; |   3B3BA|222AB311|        | 3A2AB26| 3A2AB26|AB3F3B3B|
; |    33BA|AAAB31CC| 2AB    | FBAB22B| FBAB22B|AB3E3B3A|
; |--------|--------|--------|--------|--------|--------|
; |     B33|3BB3    |AA333   | 35BBABA| 35BBABA|BB3E3B3A|
; |     3BB|333     |A3BAB3  | FD83BAB| FD83BAB|BB3E3333|
; |        |        |B3A2AB3 | 33D73BB| 33D73BB|B3FF33D3|
; |        |        | BBA2AB3|3B33D833|3B33D833|33333DD3|
; |        |        |  3BAB33|ABB33355|ABB33355|335D3D3 |
; |        |        |   BBB3B|26AB3333|26AB3333|3133D3  |
; |        |        |   3B3BA|222AB311|222AB311|C13D3   |
; |        |        |    33BA|AAAB31CC|AAAB31CC|1333    |
; |--------|--------|--------|--------|--------|--------|
$9E:8A40             db 38,F8,6C,FC,C6,FE,63,7F,37,3F,1F,1F,1E,1F,0E,0F,00,C0,00,B8,00,AC,00,76,00,1C,00,1D,00,0B,00,03,
                        7A,5F,6D,4F,7F,6F,FB,F3,7F,FC,1F,FF,0F,FC,1C,F8,20,1F,60,77,18,13,08,4C,03,E0,40,30,00,18,03,F3,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,70,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,30,
                        07,1F,16,2B,2E,7F,59,5F,20,3F,20,3F,44,7F,69,7F,1F,1F,2B,37,7F,7F,78,5E,62,31,61,26,01,2C,40,79,
                        07,1F,16,2B,2E,7F,59,5F,20,3F,20,3F,44,7F,69,7F,1F,1F,2B,37,7F,7F,78,5E,62,31,61,26,01,2C,40,79,
                        00,00,C0,C0,60,F0,F8,F8,FC,FC,7E,FE,7F,FF,6E,FF,00,00,C0,C0,A0,B0,20,28,20,A4,10,D2,10,D5,10,D5,
                        07,07,07,07,00,00,00,00,00,00,00,00,00,00,00,00,00,04,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        F0,F0,E0,E0,00,00,00,00,00,00,00,00,00,00,00,00,00,60,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        38,F8,6C,FC,C6,FE,63,7F,37,3F,1F,1F,1E,1F,0E,0F,00,C0,00,B8,00,AC,00,76,00,1C,00,1D,00,0B,00,03,
                        7A,5F,6D,4F,7F,6F,FB,F3,7F,FC,1F,FF,0F,FC,1C,F8,20,1F,60,77,18,13,08,4C,03,E0,40,30,00,18,03,F3,
                        7A,5F,6D,4F,7F,6F,FB,F3,7F,FC,1F,FF,0F,FC,1C,F8,20,1F,60,77,18,13,08,4C,03,E0,40,30,00,18,03,F3,
                        EE,FF,EF,FF,FF,FD,FF,F9,FE,CA,FC,B4,78,28,F0,70,10,D5,10,D0,32,B2,06,06,34,14,08,08,90,90,00,00,
}


;;; $8BC0: Samus top tiles - set 0 - entry Ah ;;;
{
; Ah: Moving left  - not aiming - frame 9
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frames 0 / 2
; BEh: Facing left  - grabbed by Draygon - moving - frame 3
; C8h: Facing left  - vertical shinespark windup - frames 0 / 2
; |--------|--------|--------|--------|
; | BF3F3BA|ABBB55DF|        |        |
; |  3EF3BB|AB87333F|    EEFF|F       |
; |  EEF3BB|B7D33B3F|   EE96F|EFF     |
; |  EFE33B|D333BAB3|  EFFEEF|F333    |
; |  3EFF33|3BBA2AAB|  F4FFEF|3BBBB   |
; | 33FF311|33BAA26A|  443FFB|BABAAB  |
; |838F31CC|133BA22A|  438FBA|2B2B2AB |
; |535333C3|333BBAAB|  353FBA|22BABBB |
; |--------|--------|--------|--------|
; |535D3333|33B3BAB3| BF3F3BA|ABBB55DF|
; |D3DDD333|BBAB333B|  3EF3BB|AB87333F|
; |3333333B|A22A3B2A|  EEF3BB|B7D33B3F|
; |   3B23A|262A3BAB|  EFE33B|D333BAB3|
; |   3AAA3|AAB33   |  3EFF33|3BBA2AAB|
; |   3BAB3|333     | 33FF311|33BAA26A|
; |    333 |        |838F31CC|133BA22A|
; |        |        |535333C3|333BBAAB|
; |--------|--------|--------|--------|
$9E:8BC0             db 7E,7F,2F,3F,0F,3F,17,3F,2F,3F,7F,7C,5C,58,FD,5D,28,6B,18,1B,38,3B,38,39,1C,1C,18,18,13,B3,A2,02,
                        7F,F1,5F,DF,FF,DF,FB,7F,E1,FF,E0,FF,F0,7F,F9,FF,0F,F3,11,E1,61,A5,80,8E,00,77,02,39,00,19,00,1F,
                        00,00,03,0F,05,1B,19,3F,2D,2F,0F,0F,16,17,3E,2F,00,00,0F,0F,1B,1D,3F,3F,3F,2F,36,07,24,0F,14,07,
                        00,00,80,80,60,E0,F0,F0,F8,F8,A4,FC,52,FE,2E,FE,00,00,80,80,E0,E0,80,80,00,78,00,FC,00,56,00,3E,
                        FF,4F,FF,47,FF,FF,1A,1F,11,1F,1B,1F,0E,0E,00,00,B0,10,B8,B8,00,01,00,09,00,0E,00,0E,00,00,00,00,
                        FB,FF,DF,FF,0C,FF,0D,FF,38,F8,E0,E0,00,00,00,00,00,2E,00,F1,00,95,40,17,00,E0,00,00,00,00,00,00,
                        7E,7F,2F,3F,0F,3F,17,3F,2F,3F,7F,7C,5C,58,FD,5D,28,6B,18,1B,38,3B,38,39,1C,1C,18,18,13,B3,A2,02,
                        7F,F1,5F,DF,FF,DF,FB,7F,E1,FF,E0,FF,F0,7F,F9,FF,0F,F3,11,E1,61,A5,80,8E,00,77,02,39,00,19,00,1F,
}


;;; $8CC0: Samus top tiles - set 0 - entry Bh ;;;
{
; Ah: Moving left  - not aiming - frame 7
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 1
; BEh: Facing left  - grabbed by Draygon - moving - frame 4
; C8h: Facing left  - vertical shinespark windup - frame 1
; |--------|--------|--------|--------|--------|
; |F33BB38D|3A26AB  |        | EEFFF3 |        |
; |9F3B3DD3|BA222B  |        |E9963BB3|3       |
; |EE333333|BBA2A3A |       E|FFF3BBAB|B3      |
; |FFEFF333|333B3AB |       F|443BA26A|BB3     |
; |FFF33333|BBB33B  |       4|43BBAB2B|A33     |
; |3F331133|A6AB33  |       4|38BA22BA|35D3    |
; |3331C33B|A22AB   |      B3|53BA2ABB|8D3B    |
; |333CC33A|22AB3   |      BF|33BBABB7|33AAB   |
; |--------|--------|--------|--------|--------|
; |     333|BAB3    | 383D B3|F33BB38D|
; |    32AB|3B3     |3D535D E|9F3B3DD3|
; |    BAAB|33      |D53D73DF|EE333333|
; |    3BBB|3       |33D5385F|FFEFF333|
; |     333|        | 3D355D3|FFF33333|
; |        |        |  3DDDDD|3F331133|
; |        |        |   3DDD3|3331C33B|
; |        |        |    3333|333CC33A|
; |--------|--------|--------|--------|
$9E:8CC0             db FD,FC,FF,79,3F,FF,DF,FF,FF,FF,FF,F3,F7,E7,E6,E7,81,9B,46,D6,C0,C0,F8,F8,E0,E0,40,40,08,09,18,19,
                        84,FC,84,FC,C4,FE,FA,FE,FC,FC,1C,FC,08,F8,18,F8,10,4C,00,C4,00,EA,00,16,00,E4,40,B0,00,98,00,30,
                        00,00,00,00,00,01,01,01,00,00,00,00,03,03,03,03,00,00,00,00,01,01,01,01,01,00,01,00,00,02,01,03,
                        1E,7E,6F,9F,FD,FF,30,3F,75,7F,A2,BF,E3,7F,F7,FF,7C,7C,90,E6,E0,EF,C2,19,80,3D,00,73,80,37,01,3E,
                        00,00,80,80,C0,C0,E0,E0,60,E0,F0,90,70,30,C8,F8,00,00,00,00,00,80,00,C0,00,80,60,20,40,D0,00,38,
                        07,07,09,0F,09,0F,0F,0F,07,07,00,00,00,00,00,00,00,00,00,03,00,0F,00,07,00,00,00,00,00,00,00,00,
                        B0,F0,E0,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,E0,00,40,00,00,00,00,00,00,00,00,00,00,00,00,
                        5B,53,FC,91,FF,2D,FB,C9,7F,51,3F,20,1F,11,0F,0F,08,2A,6D,45,DB,93,33,25,2E,22,1F,1F,0E,0E,00,00,
                        FD,FC,FF,79,3F,FF,DF,FF,FF,FF,FF,F3,F7,E7,E6,E7,81,9B,46,D6,C0,C0,F8,F8,E0,E0,40,40,08,09,18,19,
}


;;; $8DE0: Samus top tiles - set 0 - entry Ch ;;;
{
; 11h: Moving right - aiming down-right - frames 0..1 / 5..6
; 17h: Facing right - normal jump - aiming down - frame 0
; 2Dh: Facing right - falling - aiming down - frame 0
; 6Bh: Facing right - normal jump - aiming down-right - frames 0..1
; 6Fh: Facing right - falling - aiming down-right - frames 0 / 2
; 78h: Facing right - moonwalk - aiming down-right - frames 0 / 3
; AEh: Unused. Facing right - grappling - in air - aiming down - frame 0
; B0h: Unused. Facing right - grappling - in air - aiming down-right - frames 0..1
; EFh: Facing right - grabbed by Draygon - not moving - aiming down-right - frame 0
; |--------|--------|--------|--------|--------|--------|--------|
; |      FF|FEE     | 3B3DD3 |        |  BBBBB |    3   |   33   |
; |    FFFE|F69E    |  3DD3  |        | BA622AB|    3D  |  3DD3  |
; |   FFEEE|FEFEE   |   33   |        |BAAA2B2A|    53  | 3D75D3 |
; |   FEFFF|FFFF9   |        |B       |BA6B22BA|    3D3 |3D5875D3|
; |  FEFF33|3FF4F   |        |B3      |BA22B2AB|33D3853 |33D5875D|
; | FFFF333|33F44   |        |53      |BAB2ABB8|  3D53  | 33D5873|
; | FFF3333|333F4   |        |3       |3BABB378|   33   |  33D533|
; | F3F3333|3333D   |        |        |3BAB3583|        |   33338|
; |--------|--------|--------|--------|--------|--------|--------|
; |FE3F3333|33333   |
; |FE333333|333BAB2 |
; |EF333333|33BA2AAA|
; |553F3333|3BA26ABA|
; |833FF333|BBA222AB|
; |333F3FF3|3BBA222A|
; |  3F3111|133BAAAB|
; |   33311|C133BBB3|
; |--------|--------|
$9E:8DE0             db 03,03,0E,0F,18,1F,17,1F,2F,3F,7F,7F,7F,7F,7F,7F,03,03,0F,0F,1F,1F,1F,1F,3C,3C,78,78,70,70,50,50,
                        80,E0,A0,D0,A0,F8,F8,F0,E8,E8,E0,E0,F0,F0,F8,F0,E0,E0,D0,B0,F8,F8,F0,F8,78,68,38,20,18,10,08,08,
                        7E,72,3C,24,18,18,00,00,00,00,00,00,00,00,00,00,0C,2C,18,18,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,80,80,C0,C0,C0,40,80,80,00,00,00,00,00,00,00,00,00,80,00,80,80,00,00,00,00,00,
                        3E,3E,41,7F,84,FF,92,FF,89,FF,A6,FE,DE,FE,DD,F9,00,3E,10,63,00,F5,20,D3,00,CB,00,EF,02,79,04,72,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        BF,FF,BF,FF,7F,FF,FF,3F,7F,7F,FF,FF,3F,38,1F,1C,D0,D0,C0,C0,C0,C0,D0,10,18,98,16,16,10,10,00,00,
                        F8,F8,F4,FE,E0,FF,C2,FF,C1,FF,E0,FF,F1,7F,7F,3F,00,00,00,1C,00,37,08,67,00,E3,00,71,00,1F,80,8E,
}


;;; $8F00: Samus top tiles - set 0 - entry Dh ;;;
{
; 12h: Moving left  - aiming down-left - frames 0..1 / 5..6
; 18h: Facing left  - normal jump - aiming down - frame 0
; 2Eh: Facing left  - falling - aiming down - frame 0
; 6Ch: Facing left  - normal jump - aiming down-left - frames 0..1
; 70h: Facing left  - falling - aiming down-left - frames 0 / 2
; 77h: Facing left  - moonwalk - aiming down-left - frames 0 / 3
; AFh: Unused. Facing left  - grappling - in air - aiming down - frame 0
; B1h: Unused. Facing left  - grappling - in air - aiming down-left - frames 0..1
; BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left - frame 0
; |--------|--------|--------|--------|--------|--------|--------|
; |     EEF|FF      |    3   |   33   | 3DD3B3 |        | BBBBB  |
; |    E96F|EFFF    |    3D  |  3DD3  |  3333  |        |BA2A6AB |
; |   EEFEF|EEEFF   |    53  | 3D75D3 |        |       B|A2B22BAB|
; |   9FFFF|FFFEF   |    3D3 |3D5875D3|        |      BB|AB22B6AB|
; |   F4FF3|333FEF  |33D3853 |33D5875D|        |      DB|BAAB22BB|
; |   44F33|333EFFF |  3D53  | 33D5873|        |      35|8BBA2BAB|
; |   4F333|3333FFF |   33   |  33D533|        |       3|873BBAB3|
; |   D3333|3333F3F |        |   33338|        |        |3853BBB3|
; |--------|--------|--------|--------|--------|--------|--------|
; |   3B333|3333F3EF|
; | 2BBAB33|333333EF|
; |AABA2AB3|333333FE|
; |ABA22AAB|B333F355|
; |BBA622AB|333FF338|
; |BBA22ABB|3FF3F333|
; |A3BAABB3|1113F3  |
; |2A3BBB3C|11133   |
; |--------|--------|
$9E:8F00             db 01,07,05,0B,05,1F,1F,0F,17,17,07,07,0F,0F,1F,0F,07,07,0B,0D,1F,1F,0F,1F,1E,16,1C,04,18,08,10,10,
                        C0,C0,70,F0,18,F8,E8,F8,F4,FC,EE,FE,FE,FE,FE,FE,C0,C0,F0,F0,F8,F8,F8,F8,1C,1C,1E,1E,0E,0E,0A,0A,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        7E,4E,3C,3C,00,00,00,00,00,00,00,00,00,00,00,00,30,34,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,03,03,03,01,03,02,01,01,00,00,00,00,00,00,00,01,00,03,02,03,01,00,00,00,00,00,
                        7C,7C,82,FE,25,FF,49,FF,93,FF,65,7F,7B,7F,BF,9F,00,7C,08,D6,00,A7,04,CB,00,F3,00,F7,40,9E,20,4E,
                        1F,1F,37,7F,23,FF,41,FF,C1,FF,C3,FF,67,FF,3E,FE,00,08,00,3C,00,F6,00,E7,10,E3,00,E7,00,BE,01,5D,
                        FD,FF,FD,FF,FE,FF,FF,FC,FE,FE,FF,FF,FC,1C,F8,18,0B,0B,03,03,03,03,0B,88,18,19,68,68,08,08,00,00,
}


;;; $9020: Samus top tiles - set 0 - entry Eh ;;;
{
; 7: Facing right - aiming down-right - frame 0
; 59h: Facing right - normal jump transition - aiming down-right - frame 0
; 73h: Facing right - crouching - aiming down-right - frame 0
; AAh: Facing right - grappling - aiming down-right - frame 0
; B6h: Facing right - grappling - crouching - aiming down-right - frame 0
; D1h: Facing right - ran into a wall - aiming down-right - frame 0
; E4h: Facing right - landing from normal jump - aiming down-right - frames 0..1
; F5h: Facing right - crouching transition - aiming down-right - frame 0
; FBh: Facing right - standing transition - aiming down-right - frame 0
; |--------|--------|--------|--------|--------|--------|--------|
; |BB333FF |        |        |BB333FF |33B33   |    3   |   33   |
; |B3FFEEEF|F       |      BA|B3FFEEEF|  33    |    3D  |  3DD3  |
; |FEEFE699|FF      |      AB|FEEFE699|        |    53  | 3D75D3 |
; |EFF3333E|9F      |     BB3|EFF3333E|        |    3D3 |3D5875D3|
; |FF3BBBB3|4E      |     B3F|FF3BBBB3|        |33D3853 |33D5875D|
; |F3BBBAAB|34      |     B3F|F3BBBAAB|        |  3D53  | 33D5873|
; |33BA2B6A|B3      |     333|33BA2B6A|        |   33   |  33D533|
; |3BABA2B2|B3      |     333|3BABA2B2|        |        |   33338|
; |--------|--------|--------|--------|--------|--------|--------|
; |3BA2BA2B|5B3     |     3FF|3BA2BA2B|
; |3BBA2BB8|8D3B3   |     F3E|3BBA2BB8|
; |33BAB387|33BAB3  |     FFE|33BAB387|
; |E3BB3773|3B3A23  |     F3F|E3BB3773|
; |F3335533|BAB333  |     D3F|F3335533|
; |5333333B|A26AB33 |     537|5333333B|
; |111333BB|AA22AB3 |       3|111333BB|
; |1CC11333|BAAA33  |       3|1CC11333|
; |--------|--------|--------|--------|
$9E:9020             db FE,FE,F1,FF,93,FC,7E,FF,FF,FF,F9,FF,E4,FF,D2,FF,06,C6,3F,BF,FC,FB,E1,E1,C0,DE,80,BF,02,35,00,7A,
                        00,00,80,80,C0,C0,C0,40,00,40,80,80,C0,C0,C0,C0,00,00,80,80,C0,C0,40,C0,C0,40,40,00,00,80,00,80,
                        00,00,02,03,01,03,07,07,07,07,07,07,07,07,07,07,00,00,00,03,00,03,00,06,01,05,01,05,00,00,00,00,
                        FE,FE,F1,FF,93,FC,7E,FF,FF,FF,F9,FF,E4,FF,D2,FF,06,C6,3F,BF,FC,FB,E1,E1,C0,DE,80,BF,02,35,00,7A,
                        F8,F8,30,30,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        C9,FF,E6,FE,ED,FD,7F,FF,FF,F3,FF,7F,FF,1F,9F,07,00,6D,00,77,01,3A,86,B0,8C,80,80,01,00,03,60,60,
                        E0,60,78,38,EC,FC,E4,FC,BC,FC,0E,FE,06,FE,8C,FC,80,40,40,D0,00,38,00,50,00,E0,20,98,00,CC,00,F0,
                        07,07,06,07,06,07,07,07,07,03,07,03,01,01,01,01,03,03,05,05,07,07,05,05,05,05,05,00,00,00,00,00,
                        C9,FF,E6,FE,ED,FD,7F,FF,FF,F3,FF,7F,FF,1F,9F,07,00,6D,00,77,01,3A,86,B0,8C,80,80,01,00,03,60,60,
}


;;; $9180: Samus top tiles - set 0 - entry Fh ;;;
{
; 8: Facing left  - aiming down-left - frame 0
; 5Ah: Facing left  - normal jump transition - aiming down-left - frame 0
; 74h: Facing left  - crouching - aiming down-left - frame 0
; ABh: Facing left  - grappling - aiming down-left - frame 0
; B7h: Facing left  - grappling - crouching - aiming down-left - frame 0
; D2h: Facing left  - ran into a wall - aiming down-left - frame 0
; E5h: Facing left  - landing from normal jump - aiming down-left - frames 0..1
; F6h: Facing left  - crouching transition - aiming down-left - frame 0
; FCh: Facing left  - standing transition - aiming down-left - frame 0
; |--------|--------|--------|--------|--------|--------|--------|
; |        | FFFFFF3| FFFFFF3|3       |   33   |  3BBBB3|    3   |
; |        |FE96FE3A|FE96FE3A|BBAB    |  3DD3  |   3BB3 |    3D  |
; |       F|E9EEF33B|E9EEF33B|AABAB   | 3D75D3 |    33  |    53  |
; |      3F|9EFEF3BB|9EFEF3BB|22B6BB  |3D5875D3|        |    3D3 |
; |     B3F|EF4E3BAA|EF4E3BAA|B2BABB  |33D5875D|        |33D3853 |
; |     B3F|F4FF3BA2|F4FF3BA2|BABABB  | 33D5873|        |  3D53  |
; |     BB3|44383BAA|44383BAA|BBB33B  |  33D533|        |   33   |
; |     BA3|437F3BB5|437F3BB5|8785D3  |   33338|        |        |
; |--------|--------|--------|--------|--------|--------|--------|
; |     853|FF333D83|FF333D83|33B3D3  |
; |     533|33EEF3B2|33EEF3B2|6AB33F  |
; |     33B|3FF33BA2|3FF33BA2|22AB3F  |
; |    B3A3|3F3BB3A2|3F3BB3A2|2AB3F8  |
; |   B3A42|32A2B3BA|32A2B3BA|AB33FD  |
; |   B3323|BA26A333|BA26A333|3333    |
; |  BAA3B3|BBAAB3B2|BBAAB3B2|A313    |
; | 3BBAB33|33333333|33333333|3113    |
; |--------|--------|--------|--------|
$9E:9180             db 00,00,00,00,01,01,03,03,07,07,07,07,07,07,05,07,00,00,00,00,01,01,01,01,01,05,01,05,00,06,00,06,
                        7F,7F,AA,DF,4F,BF,AF,7F,4C,DF,BC,BF,2C,2F,7F,7E,7E,7E,DC,ED,B8,F9,78,FB,F0,D7,F0,B6,C0,17,B1,16,
                        7F,7F,AA,DF,4F,BF,AF,7F,4C,DF,BC,BF,2C,2F,7F,7E,7E,7E,DC,ED,B8,F9,78,FB,F0,D7,F0,B6,C0,17,B1,16,
                        80,80,D0,F0,28,F8,2C,FC,AC,FC,AC,FC,FC,FC,5C,44,00,00,00,F0,00,F8,10,2C,00,BC,00,FC,00,E4,58,A8,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        3F,3F,1E,1E,0C,0C,00,00,00,00,00,00,00,00,00,00,00,1E,00,0C,00,00,00,00,00,00,00,00,00,00,00,00,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        03,01,07,03,07,07,0D,0F,18,1D,1D,1F,27,3F,77,7F,02,04,04,00,00,01,00,0A,02,14,00,10,00,3A,00,3C,
                        FD,F9,CE,FF,FC,FF,FC,FF,8E,FF,87,FF,CE,FF,FF,FF,C4,C6,38,3A,60,66,40,5A,00,2B,10,C8,00,FA,00,00,
                        FD,F9,CE,FF,FC,FF,FC,FF,8E,FF,87,FF,CE,FF,FF,FF,C4,C6,38,3A,60,66,40,5A,00,2B,10,C8,00,FA,00,00,
                        FC,F4,3C,FC,1C,FC,38,F8,7C,F8,F0,F0,70,D0,F0,90,08,28,84,64,04,34,08,6C,0C,CC,00,00,00,80,00,00,
}


;;; $92E0: Samus top tiles - set 0 - entry 10h ;;;
{
; 13h: Facing right - normal jump - not aiming - not moving - gun extended - frames 0..1
; 35h: Facing right - crouching transition - frame 0
; 3Bh: Facing right - standing transition - frame 0
; 4Ah: Facing right - moonwalk - frames 0 / 3
; 51h: Facing right - normal jump - not aiming - moving forward - frames 0..1
; 67h: Facing right - falling - gun extended - frames 0..2 / 5..6
; ACh: Unused. Facing right - grappling - in air - frames 0..1
; D3h: Facing right - crystal flash - frame Eh
; D5h: Facing right - x-ray - standing - frame 2
; D7h: Facing right - crystal flash ending - frame 3
; D9h: Facing right - x-ray - crouching - frame 2
; DBh: Unused - frame 0
; DDh: Unused - frame 2
; E6h: Facing right - landing from normal jump - firing - frames 0..1
; E8h: Facing right - Samus drained - crouching/falling - frame Eh
; EAh: Facing right - Samus drained - standing - frame 5
; EEh: Facing right - grabbed by Draygon - firing - frame 0
; |--------|--------|--------|--------|--------|--------|
; |     FFF|FF      |AB3 3BAA|   3BBAA|        |        |
; |   3EF69|9EF     |BB   3BB|     B33|D33     |3DDDDDD3|
; |  3FFFFF|FFFF    |33    33|     3AA|53D3    |35555553|
; | 3FF3333|334F    |33      |      BB|7383    |38888873|
; | F33ABAB|3344    |        |        |5353    |35555553|
; | 33B2A2A|B734    |        |        |D3D3    |3DDDDDD3|
; |F3BA2A22|AB53    |        |        |333     |33333333|
; |33B22B6A|AB3F    |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|
; |F3BA2B2B|ABF3    |
; |F3BBABAB|B3FF    |
; |F3333BBD|5DFE    |
; |FF358785|33FFB   |
; |5F3DD333|B3F33   |
; |8D133BAA|BB33BBB |
; |  13BA62|AB333BAB|
; |  33BA22|AB3 3A26|
; |--------|--------|
$9E:92E0             db 07,07,15,1E,3F,3F,7F,7F,75,7F,70,7F,E0,FF,E4,FF,07,07,0E,0D,1F,1F,30,30,40,4F,00,15,80,B4,02,25,
                        C0,C0,A0,60,F0,F0,D0,D0,C0,C0,E0,E0,70,D0,70,F0,C0,C0,60,E0,F0,F0,30,10,30,00,50,80,20,C0,10,D0,
                        6C,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,C7,00,C3,00,00,00,00,00,00,00,00,00,00,00,00,
                        1C,1F,07,07,04,07,03,03,00,00,00,00,00,00,00,00,00,0F,00,04,00,03,00,03,00,00,00,00,00,00,00,00,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        E5,FF,F5,FF,FF,FE,F5,E4,FF,67,7C,1F,38,1F,38,3F,80,B5,80,BF,81,87,D5,CA,D8,58,40,C7,02,0C,00,0C,
                        70,F0,F0,F0,E0,30,F8,F8,F8,F8,FE,FE,7D,FF,68,EF,20,E0,30,B0,F0,70,30,38,20,A0,00,CE,00,C7,01,C4,
}


;;; $93E0: Samus top tiles - set 0 - entry 11h ;;;
{
; 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frames 0..1
; 36h: Facing left  - crouching transition - frame 0
; 3Ch: Facing left  - standing transition - frame 0
; 49h: Facing left  - moonwalk - frames 0 / 3
; 52h: Facing left  - normal jump - not aiming - moving forward - frames 0..1
; 68h: Facing left  - falling - gun extended - frames 0..2 / 5..6
; ADh: Unused. Facing left  - grappling - in air - frames 0..1
; BCh: Facing left  - grabbed by Draygon - firing - frame 0
; D4h: Facing left  - crystal flash - frame Eh
; D6h: Facing left  - x-ray - standing - frame 2
; D8h: Facing left  - crystal flash ending - frame 3
; DAh: Facing left  - x-ray - crouching - frame 2
; DCh: Unused - frame 0
; DEh: Unused - frame 2
; E7h: Facing left  - landing from normal jump - firing - frames 0..1
; EBh: Facing left  - Samus drained - standing - frame 5
; |--------|--------|--------|--------|--------|--------|
; |      FE|FFF     |2AB31   |B326AB3A|        |        |
; |     FE9|96FE3   |AB3     |3BA2A33B|D33     |3DDDDDD3|
; |    FFFF|FFFFF3  |B3      |33BAA3B3|53D3    |35555553|
; |    F433|3333FF3 |3       | 33BB3AB|7383    |38888873|
; |    443B|BABA33F |        |    33BB|5353    |35555553|
; |    43BB|A2A2B333|        |        |D3D3    |3DDDDDD3|
; |    35BA|22A2AB3F|        |        |333     |33333333|
; |    F3BA|A6B2AB33|        |        |        |        |
; |--------|--------|--------|--------|--------|--------|
; |    33BA|B2B2BB3F|
; |    FF3B|BABABB3F|
; |    EF35|DBBB333F|
; |    EF33|58785D3F|
; |    3F3B|333333DD|
; | BB333BA|AAAB3138|
; |B2A333A2|26AB31  |
; |AA3AB3A2|22A333  |
; |--------|--------|
$9E:93E0             db 02,03,05,06,0F,0F,0B,0B,03,03,07,07,0E,0B,0E,0F,03,03,06,07,0F,0F,0C,08,0C,01,08,03,04,03,08,0B,
                        E0,E0,A8,78,FC,FC,FE,FE,AE,FE,0F,FF,07,FF,27,FF,E0,E0,70,B0,F8,F8,0C,0C,02,F2,00,A8,01,2D,40,AC,
                        38,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        C6,FF,C7,FF,E7,FF,7D,7F,0F,0F,00,00,00,00,00,00,10,8D,00,69,00,3A,00,1B,00,03,00,00,00,00,00,00,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        0E,0F,0F,0F,07,0E,07,0F,0F,0F,7E,7F,9C,FF,2C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A2,00,DA,
                        AF,FF,AF,FF,FF,7F,AF,23,FF,FC,1E,FA,1C,F8,1C,FC,01,AD,01,FD,81,F1,AD,55,03,03,00,F1,40,30,00,20,
}


;;; $94E0: Samus top tiles - set 0 - entry 12h ;;;
{
; 3: Facing right - aiming up - frame 0
; 5: Facing right - aiming up-right - frame 0
; 15h: Facing right - normal jump - aiming up - frame 0
; 2Bh: Facing right - falling - aiming up - frame 0
; 57h: Facing right - normal jump transition - aiming up-right - frame 0
; 71h: Facing right - crouching - aiming up-right - frame 0
; 85h: Facing right - crouching - aiming up - frame 0
; CFh: Facing right - ran into a wall - aiming up-right - frame 0
; E2h: Facing right - landing from normal jump - aiming up-right - frames 0..1
; F3h: Facing right - crouching transition - aiming up-right - frame 0
; F9h: Facing right - standing transition - aiming up-right - frame 0
; |--------|--------|--------|--------|--------|--------|
; |FFFEFF  |AB333   |       F|FFFEFF  |833D3   |        |
; |E69E4433|BA3B33  |      FF|E69E4433|3375D3  |   33   |
; |9EF3FF3B|B3BAB33 |     FFE|9EF3FF3B|35875D3 |  35D3D |
; |F3BA2AB3|3BA2AB33|     FEE|F3BA2AB3|3D5875D3| 3583533|
; |3BA262B5|3A62AB3 |    FFFF|3BA262B5|33D587D3| 3D3    |
; |3BBBBBB5|3A2AB3  |   3FEEF|3BBBBBB5| 33D5D3 |  3D    |
; |BAA2AB8D|3BABB3  |   3FEF3|BAA2AB8D|  33D3  |   3    |
; |BBBBBB7D|3BBB3   |   3FFF3|BBBBBB7D|   33   |   3    |
; |--------|--------|--------|--------|--------|--------|
; |BBAAAB83|3B33    |   3FF33|BBAAAB83|
; |3BBBB5D3|33      |   333FE|3BBBB5D3|
; |F3BBBD33|3       |   3EFE9|F3BBBD33|
; |EF3333F3|        |   3EFEE|EF3333F3|
; |FF3FFFF |        |   3F3FF|FF3FFFF |
; |D3133F  |        |   D8378|D3133F  |
; |11C13   |        |    33DD|11C13   |
; |CCC3    |        |    3111|CCC3    |
; |--------|--------|--------|--------|
$9E:94E0             db EC,FC,23,D3,BF,7F,E3,FF,C3,FE,FF,FE,85,FC,FF,FE,FC,FC,DC,B0,6C,ED,80,B6,09,62,01,7E,01,EF,03,FD,
                        78,F8,BC,FC,EE,FE,C7,FF,86,FE,8C,FC,DC,FC,F8,F8,00,C0,00,D0,00,B8,00,6C,20,4C,00,58,00,78,00,70,
                        01,01,03,03,06,07,04,07,0F,0F,19,1F,1B,1F,1F,1F,01,01,03,03,07,07,07,07,0F,0F,0F,0F,0E,0E,0E,0E,
                        EC,FC,23,D3,BF,7F,E3,FF,C3,FE,FF,FE,85,FC,FF,FE,FC,FC,DC,B0,6C,ED,80,B6,09,62,01,7E,01,EF,03,FD,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        C5,FD,FF,F9,FF,FB,7F,FF,FE,FE,FC,5C,D8,08,10,10,00,FE,06,7A,84,BC,C2,C2,DE,DE,84,84,20,20,E0,E0,
                        F0,F0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,40,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1F,1F,1E,1F,15,1E,14,1F,1F,1F,16,06,0F,0C,0F,08,0C,0C,03,03,0E,0F,0F,0F,0B,0B,12,19,03,03,00,00,
                        C5,FD,FF,F9,FF,FB,7F,FF,FE,FE,FC,5C,D8,08,10,10,00,FE,06,7A,84,BC,C2,C2,DE,DE,84,84,20,20,E0,E0,
}


;;; $9620: Samus top tiles - set 0 - entry 13h ;;;
{
; 4: Facing left  - aiming up - frame 0
; 6: Facing left  - aiming up-left - frame 0
; 16h: Facing left  - normal jump - aiming up - frame 0
; 2Ch: Facing left  - falling - aiming up - frame 0
; 58h: Facing left  - normal jump transition - aiming up-left - frame 0
; 72h: Facing left  - crouching - aiming up-left - frame 0
; 86h: Facing left  - crouching - aiming up - frame 0
; D0h: Facing left  - ran into a wall - aiming up-left - frame 0
; E3h: Facing left  - landing from normal jump - aiming up-left - frames 0..1
; F4h: Facing left  - crouching transition - aiming up-left - frame 0
; FAh: Facing left  - standing transition - aiming up-left - frame 0
; |--------|--------|--------|--------|--------|--------|
; |   33B33|  FFEFFF|  FFEFFF|F       |        |833D3   |
; |  33A33A|B344E96E|B344E96E|FF      |   33   |3375D3  |
; | 33AB322|B443FFF3|B443FFF3|3FF     |  35D3D |35875D3 |
; | 3BBB3AA|B438333B|B438333B|B33F    | 3583533|3D5875D3|
; |  3BB333|33833BBA|33833BBA|2AB3F   | 3D3    |33D587D3|
; |   3B3AB|3FF3BBA2|3FF3BBA2|6BAB3   |  3D    | 33D5D3 |
; |    3ABB|3F3DBA2A|3F3DBA2A|B2AB3   |   3    |  33D3  |
; |    3B33|333DDBAB|333DDBAB|22BAF   |   3    |   33   |
; |--------|--------|--------|--------|--------|--------|
; |    3B3B|BAB35DBB|BAB35DBB|ABAB3   |
; |    333B|AA2B3883|AA2B3883|BABB3   |
; |     333|A26AB378|A26AB378|33B33   |
; |     A23|A22AAB35|A22AAB35|D333F   |
; |     BA3|BAAB3333|BAAB3333|333F3   |
; |      33|33333313|33333313|3D57D   |
; |        |   31111|   31111|113D    |
; |        |    31CC|    31CC|CC3     |
; |--------|--------|--------|--------|
$9E:9620             db 1F,1F,36,3F,6C,7F,7C,7F,3F,3F,1D,1F,0B,0F,0F,0F,00,04,00,09,00,18,00,3B,00,18,00,0B,00,07,00,04,
                        37,3F,C4,CB,9F,9F,AF,AF,DE,DF,FC,FF,F8,EF,FD,E7,3F,3F,3B,8D,6E,8E,40,91,00,27,60,6E,50,5D,18,1F,
                        37,3F,C4,CB,9F,9F,AF,AF,DE,DF,FC,FF,F8,EF,FD,E7,3F,3F,3B,8D,6E,8E,40,91,00,27,60,6E,50,5D,18,1F,
                        80,80,C0,C0,E0,E0,F0,F0,38,F8,58,F8,98,F8,28,F8,80,80,C0,C0,60,60,10,90,08,68,80,70,00,B0,08,38,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        0F,0F,0F,0F,07,07,01,07,05,07,03,03,00,00,00,00,00,05,00,01,00,00,00,04,00,06,00,00,00,00,00,00,
                        BF,F3,19,F9,0E,FE,07,FE,9F,FF,FF,FD,1F,10,0C,08,0C,E7,00,D6,22,99,01,9C,00,F0,00,00,00,00,03,03,
                        BF,F3,19,F9,0E,FE,07,FE,9F,FF,FF,FD,1F,10,0C,08,0C,E7,00,D6,22,99,01,9C,00,F0,00,00,00,00,03,03,
                        58,F8,B8,F8,F8,F8,F8,78,F8,F8,F8,90,F0,20,20,20,00,F0,00,F0,00,20,88,88,10,10,78,48,10,10,C0,C0,
}


;;; $9760: Samus top tiles - set 0 - entry 14h ;;;
{
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 5
; C7h: Facing right - vertical shinespark windup - frame 5
; |--------|--------|--------|--------|--------|
; |AABABB85|   3D   |        | FFFEE  |        |
; |BABB3853| 3DD53  |       F|FEEF69E |        |
; |BB337533|3D55373 |     AFF|EEBBBEFE|        |
; |3335D3BB|3DD8D3D |    B3FF|3BAABB4F|        |
; |33DD3BAB|B3DD5D3 |   B3FF3|BB622AB4|        |
; |F333BA62|B33DD3  |   3BF3B|A2BA22A4|        |
; |113BA222|AB3D3   |   BAF3B|BA2BA2A3|        |
; |1C33BA2A|BB33    |   ABE3B|AB22BABB|        |
; |--------|--------|--------|--------|--------|
; |   33BB3|333     |  3ABE3B|AABABB85|
; |     333|AB      | B333E3B|BABB3853|
; |      3B|B       | B3B3EF3|BB337533|
; |        |        | B3B3FF3|3335D3BB|
; |        |        |  3BB55F|33DD3BAB|
; |        |        |   BBD8F|F333BA62|
; |        |        |    B333|113BA222|
; |        |        |     331|1C33BA2A|
; |--------|--------|--------|--------|
$9E:9760             db 2D,FC,BB,F9,FF,FB,FF,E7,FD,CF,F8,FF,F0,3F,B8,3F,01,FE,02,F4,0C,C0,18,0B,30,37,82,8C,00,18,40,4D,
                        18,10,7C,44,FE,8E,EE,84,FE,C2,FC,E4,78,E8,F0,F0,08,08,38,30,74,40,6A,7A,3C,B4,18,98,10,D0,00,C0,
                        00,00,01,01,03,07,0F,0F,1F,1F,1F,1F,17,1F,0B,1F,00,00,01,01,03,07,03,0B,06,16,04,0D,04,1D,04,1D,
                        70,7C,94,FA,3A,FF,CD,FD,C2,FE,20,FE,91,FF,4B,FF,7C,7C,FA,F6,C7,FF,03,7D,21,C6,01,B2,00,DA,00,CF,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1F,1F,07,07,03,03,00,00,00,00,00,00,00,00,00,00,00,06,00,00,00,01,00,00,00,00,00,00,00,00,00,00,
                        E0,E0,40,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        2B,3F,7B,7F,7B,7F,7F,7F,3F,39,1D,19,0F,0F,07,06,04,1D,04,45,06,56,06,56,07,19,05,1F,00,08,00,00,
                        2D,FC,BB,F9,FF,FB,FF,E7,FD,CF,F8,FF,F0,3F,B8,3F,01,FE,02,F4,0C,C0,18,0B,30,37,82,8C,00,18,40,4D,
}


;;; $9880: Samus top tiles - set 0 - entry 15h ;;;
{
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 5
; C8h: Facing left  - vertical shinespark windup - frame 5
; |--------|--------|--------|--------|--------|--------|
; |        |35BBABAB|  EEFFF |        |        |  EEFFF |
; |  2AB   |ED83BABB| E969FEF|F       |        | E969FEF|
; | AB3B3  |33D733BB|EFEFFFFE|3FA     |        |EFEFFFFE|
; | A3BA2B3|333D8333|F4BBAAB3|3F3B    |        |F4BBAAB3|
; | B3A26A3|BAB33DD3|4FA226AB|3FF3B   |        |4FA226AB|
; |  BBAABB|A26AB333|4A22AA2A|B3FB3   |        |4A22AA2A|
; |   3BB3B|A222AB11|3B2AB2AA|B3FAB   |        |3B2AB2AA|
; |    3333|AAAAB3C1|FBBB2ABA|B3EBAB  |        |FBBB2ABA|
; |--------|--------|--------|--------|--------|--------|
; |     BA3|BABB3   |35BBABAB|B3EBA3  |        |35BBABAB|
; |      B3|BB33    |ED83BABB|B3E333B |  2AB   |ED83BABB|
; |        |        |33D733BB|3FE3D3B | AB3B3  |33D733BB|
; |        |        |333D8333|3333D3B | A3BA2B3|333D8333|
; |        |        |BAB33DD3|3553D3  | B3A26A3|BAB33DD3|
; |        |        |A26AB333|1D833   |  BBAABB|A26AB333|
; |        |        |A222AB11|3D33    |   3BB3B|A222AB11|
; |        |        |AAAAB3C1|333     |    3333|AAAAB3C1|
; |--------|--------|--------|--------|--------|--------|
$9E:9880             db 00,00,08,38,3C,7C,33,7F,61,7F,33,3F,1F,1F,0F,0F,00,00,00,18,00,68,00,5A,04,52,00,3F,00,0D,00,00,
                        F5,BF,5B,9F,FF,DF,F7,E7,BF,F9,0F,FF,07,FC,0D,FC,40,3F,C0,EF,30,23,10,18,06,E6,20,98,00,8C,02,FA,
                        0E,3E,2D,57,5E,FF,B3,BF,41,7F,00,7F,C8,FF,F2,FF,3E,3E,57,6F,FF,FF,C0,BE,C4,63,80,4D,00,5B,80,F7,
                        00,00,80,80,C0,E0,F0,F0,F8,F8,F8,F8,E8,F8,D4,FC,00,00,80,80,40,60,40,50,60,68,20,B0,20,B8,20,BC,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        0E,3E,2D,57,5E,FF,B3,BF,41,7F,00,7F,C8,FF,F2,FF,3E,3E,57,6F,FF,FF,C0,BE,C4,63,80,4D,00,5B,80,F7,
                        05,07,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,06,00,02,00,00,00,00,00,00,00,00,00,00,00,00,
                        B8,F8,F0,F0,00,00,00,00,00,00,00,00,00,00,00,00,00,F0,00,C0,00,00,00,00,00,00,00,00,00,00,00,00,
                        F5,BF,5B,9F,FF,DF,F7,E7,BF,F9,0F,FF,07,FC,0D,FC,40,3F,C0,EF,30,23,10,18,06,E6,20,98,00,8C,02,FA,
                        D4,FC,DE,FE,DE,F6,FE,F6,FC,94,D8,18,F0,B0,E0,E0,20,B8,20,A2,68,6A,08,0A,68,08,40,60,40,40,00,00,
                        00,00,08,38,3C,7C,33,7F,61,7F,33,3F,1F,1F,0F,0F,00,00,00,18,00,68,00,5A,04,52,00,3F,00,0D,00,00,
                        F5,BF,5B,9F,FF,DF,F7,E7,BF,F9,0F,FF,07,FC,0D,FC,40,3F,C0,EF,30,23,10,18,06,E6,20,98,00,8C,02,FA,
}


;;; $9A00: Samus top tiles - set 0 - entry 16h ;;;
{
; 3: Facing right - aiming up - frame 1
; Dh: Unused. Moving right - aiming up - frames 0..1 / 5..6
; 15h: Facing right - normal jump - aiming up - frame 1
; 2Bh: Facing right - falling - aiming up - frames 1..2
; 55h: Facing right - normal jump transition - aiming up - frame 0
; 85h: Facing right - crouching - aiming up - frame 1
; E0h: Facing right - landing from normal jump - aiming up - frames 0..1
; F1h: Facing right - crouching transition - aiming up - frame 0
; F7h: Facing right - standing transition - aiming up - frame 0
; |--------|--------|--------|--------|--------|--------|
; |     FBB|32B33   |BB22BB83|        |        | 333333 |
; |   FFF3B|3AB3B3  |BABB2B5D|        |        | D575D3 |
; |  F3FE3B|A33BAB3 |BBAAABBD|   33   |        | D585D3 |
; |  333F3B|22AB3AB |33BBBB33| 33BD3  |        | D585D3 |
; | 333333B|22AB3333| 3333333| BBB553 |  3333  | D585D3 |
; | F33333B|A2AB3BBB|        |3BA6B83 | 3D85D3 | D585D3 |
; |F3333333|AAAB3BAB|        |BA22B733| 333333 | D585D3 |
; |F3333333|BABB3333|        |BABBB773| D575D3 | 333333 |
; |--------|--------|--------|--------|--------|--------|
; |F3333333|BBB33BB3|
; |FE333333|BB33333 |
; |3F333333|33F33   |
; | FF33333|FFEF3   |
; | 3333331|3FF33   |
; | 8D3311C|1333    |
; |    31CC|C13     |
; |    11CC|C13     |
; |--------|--------|
$9E:9A00             db 07,07,1F,1F,3B,3F,3F,3F,7F,7F,7F,7F,FF,FF,FF,FF,04,07,1C,1D,2C,2D,04,05,00,01,40,41,80,80,80,80,
                        B8,F8,BC,FC,76,FE,1A,FE,1F,FF,1F,FF,1D,FF,BF,FF,00,20,00,68,00,9C,00,36,00,30,00,B7,00,F7,00,F0,
                        CD,FD,B7,FC,C7,FE,FF,FF,7F,7F,00,00,00,00,00,00,00,CE,03,F5,01,FF,00,3C,00,00,00,00,00,00,00,00,
                        00,00,00,00,18,18,7C,74,7E,72,CA,FA,8F,FF,BF,FF,00,00,00,00,00,00,08,18,0C,70,10,6C,04,C8,06,F8,
                        00,00,00,00,00,00,00,00,3C,3C,6E,42,7E,7E,7E,12,00,00,00,00,00,00,00,00,00,00,2C,34,00,00,7C,44,
                        7E,7E,7E,12,6E,02,6E,02,6E,02,6E,02,6E,02,7E,7E,00,00,7C,44,6C,54,6C,54,6C,54,6C,54,6C,54,00,00,
                        FF,FF,BF,FF,FF,FF,7F,7F,7F,7E,3E,18,0C,08,0C,00,80,80,C0,C0,40,40,60,60,00,00,21,61,03,03,03,03,
                        FF,FF,FE,FE,F8,F8,D8,F8,F8,F8,F0,70,60,20,60,20,00,E6,00,C0,20,20,F0,F0,60,60,00,00,80,80,80,80,
}


;;; $9B00: Samus top tiles - set 0 - entry 17h ;;;
{
; 4: Facing left  - aiming up - frame 1
; Eh: Unused. Moving left  - aiming up - frames 0..1 / 5..6
; 16h: Facing left  - normal jump - aiming up - frame 1
; 2Ch: Facing left  - falling - aiming up - frames 1..2
; 56h: Facing left  - normal jump transition - aiming up - frame 0
; 86h: Facing left  - crouching - aiming up - frame 1
; E1h: Facing left  - landing from normal jump - aiming up - frames 0..1
; F2h: Facing left  - crouching transition - aiming up - frame 0
; F8h: Facing left  - standing transition - aiming up - frame 0
; |--------|--------|--------|--------|--------|--------|
; |   3B344|FFFF    | 38BAAB3|        |        | 333333 |
; |   33433|EF6FFF  | 35BABB3|        |        | D575D3 |
; |  B3F333|33333FF | 3DBBB3 |        |        | D585D3 |
; | 3333333|33333FF | 333333 |DBBBBBB |        | D585D3 |
; |3BB33BBB|B33333F3|        |8BAAAAB3|  3333  | D585D3 |
; |BAB3BAAA|B333333F|        |57BA62AB| 3D85D3 | D585D3 |
; |B333A262|B333333E|        |387B2B2A| 333333 | D585D3 |
; |3B2BBA22|AB33333E|        | 37B2B2A| D575D3 | 333333 |
; |--------|--------|--------|--------|--------|--------|
; |3BAB3BAA|AB33333F|
; | 3333BBB|B33333F3|
; |   33333|33333FF |
; |    FFFF|3FFFFF3 |
; |    3F33|113FFD8 |
; |     331|1113D5  |
; |     31C|CC13    |
; |     31C|CC11    |
; |--------|--------|
$9E:9B00             db 1C,1C,1B,1B,3F,3F,7F,7F,FF,FF,B8,FF,F0,FF,D8,FF,03,08,04,00,08,28,00,00,00,67,00,EF,02,88,00,5C,
                        F0,F0,5C,FC,FE,FE,FE,FE,FF,FF,FF,FF,FE,FF,7E,FF,F0,F0,FC,DC,06,06,06,06,02,82,01,81,01,81,01,C1,
                        53,5F,77,5F,7E,5E,7E,7E,00,00,00,00,00,00,00,00,00,3E,20,1E,20,3C,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,FE,7E,43,7F,E1,7F,B4,BF,74,7F,00,00,00,00,00,00,80,FE,00,FE,C8,33,20,55,20,15,
                        00,00,00,00,00,00,00,00,3C,3C,6E,42,7E,7E,7E,12,00,00,00,00,00,00,00,00,00,00,2C,34,00,00,7C,44,
                        7E,7E,7E,12,6E,02,6E,02,6E,02,6E,02,6E,02,7E,7E,00,00,7C,44,6C,54,6C,54,6C,54,6C,54,6C,54,00,00,
                        DC,FF,7F,7F,1F,1F,0F,0F,0F,0F,07,06,06,04,06,04,00,77,00,07,00,00,0F,0F,04,04,00,00,01,01,01,01,
                        7F,FF,FF,FF,FE,FE,FE,FE,FC,38,FC,10,30,10,30,00,01,C1,02,82,06,06,7C,7C,1C,1E,0C,08,C0,C0,C0,C0,
}


;;; $9C00: Samus top tiles - set 0 - entry 18h ;;;
{
; 9: Moving right - not aiming - frame 8
; |--------|--------|--------|--------|--------|
; |3FFFEE  |        |        |3FFFEE  |  33DDD3|
; |B33699E |        |      3B|B33699E |   33D33|
; |BAB3FFFE|        |     BBA|BAB3FFFE|    33  |
; |62AB344F|        |    BBAB|62AB344F|        |
; |2BAAB344|        |   35BBA|2BAAB344|        |
; |B22AB834|B       |  33D8BA|B22AB834|        |
; |BA2AB353|B   BBAB| 3BB3D7B|BA2AB353|        |
; |BBAB333B|B  3AB2B|3BA6AB38|BBAB333B|        |
; |--------|--------|--------|--------|--------|
; |5DB333F3|3  3ABAB|BAA22A33|5DB333F3|
; |3333FF9E|3 3B3BBB|3B2AABBB|3333FF9E|
; |333FFEEE|33BAB33 |A3BB33B3|333FFEEE|
; |3FFFFEFF|BBA2B3  |B338D333|3FFFFEFF|
; |333FFFF3|BA2B3   |3D58DD33|333FFFF3|
; |11133F33|BAAB3   |3DD58D33|11133F33|
; |3111133B|ABB3    |33DD53DD|3111133B|
; |31CC333B|B33     | 33D3583|31CC333B|
; |--------|--------|--------|--------|
$9E:9C00             db F0,FC,EC,F2,BE,FF,19,F9,4C,FC,8A,FA,8F,FD,DF,FF,7C,7C,12,8E,0F,EF,87,31,03,78,01,9C,02,D8,00,F1,
                        00,00,00,00,00,00,00,00,00,00,80,80,8D,8F,95,9F,00,00,00,00,00,00,00,00,00,00,00,80,00,8F,00,8D,
                        00,00,03,03,06,07,0D,0F,1E,17,3A,33,7F,7B,C6,FE,00,00,00,01,00,07,00,0F,08,07,08,0F,06,35,10,6D,
                        F0,FC,EC,F2,BE,FF,19,F9,4C,FC,8A,FA,8F,FD,DF,FF,7C,7C,12,8E,0F,EF,87,31,03,78,01,9C,02,D8,00,F1,
                        3F,31,1F,1B,0C,0C,00,00,00,00,00,00,00,00,00,00,0E,0E,04,04,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,3F,FE,FD,F8,FF,FB,FF,FF,FF,FF,1F,FF,87,CF,8F,C2,62,0D,0F,1F,1F,7F,7F,1E,1E,04,04,00,01,30,31,
                        95,9F,BF,BF,EE,FE,CC,FC,98,F8,98,F8,70,F0,E0,E0,00,0F,00,17,00,38,00,E8,00,D0,00,F0,00,E0,00,80,
                        83,FF,C7,FF,7F,FF,EF,E7,EF,83,F7,83,FF,C4,7D,69,00,E4,00,5F,00,B2,08,98,6C,5C,74,6C,3B,33,14,12,
                        FF,3F,FE,FD,F8,FF,FB,FF,FF,FF,FF,1F,FF,87,CF,8F,C2,62,0D,0F,1F,1F,7F,7F,1E,1E,04,04,00,01,30,31,
}


;;; $9D20: Samus top tiles - set 0 - entry 19h ;;;
{
; Ah: Moving left  - not aiming - frame 8
; |--------|--------|--------|--------|--------|
; |        |  EEFFF3|  EEFFF3|        |B3AB3B3 |
; |        | E996F3B| E996F3B|B3      |AB2AB3  |
; |        |EFFF3ABA|EFFF3ABA|BA3     | 3BAB   |
; |        |F443BB26|F443BB26|ABB3    |  33    |
; |        |443BAAB2|443BAAB2|BA33    |        |
; | 3D     |438BA22B|438BA22B|A3533   |        |
; |373D3  B|353BA2AB|353BA2AB|38D3B3  |        |
; |D585D3 B|F33BBAB3|F33BBAB3|7D3AAB3 |        |
; |--------|--------|--------|--------|--------|
; |53D83D3B|3F33BB58|3F33BB58|D3A26AB |
; |3D538DD3|E9F333D3|E9F333D3|BA2222A3|
; |3D3D55D3|EEE33333|EEE33333|3BA2AB3A|
; | 3D5D55D|FFFEFF33|FFFEFF33|F3BB333B|
; |  3DDDD3|3FFF3333|3FFF3333|F333BAB3|
; |   33D3B|D3F31111|D3F31111|333BA62A|
; |    333B|B3311CC1|B3311CC1|3 BA22AB|
; |     333|3331CCC1|3331CCC1|3333B2B3|
; |--------|--------|--------|--------|
$9E:9D20             db 00,00,00,00,00,00,00,00,00,00,60,40,F9,E9,DD,05,00,00,00,00,00,00,00,00,00,00,20,20,50,11,D8,A9,
                        0F,3F,37,4F,7A,FF,9C,9F,32,3F,51,5F,F1,BF,FB,FF,3E,3E,4C,75,F0,F7,E1,8C,C0,1E,80,39,40,1B,80,9E,
                        0F,3F,37,4F,7A,FF,9C,9F,32,3F,51,5F,F1,BF,FB,FF,3E,3E,4C,75,F0,F7,E1,8C,C0,1E,80,39,40,1B,80,9E,
                        00,00,C0,C0,A0,E0,70,F0,B0,F0,78,D8,BC,9C,E6,BE,00,00,00,80,00,C0,00,E0,00,C0,20,80,20,68,C0,5C,
                        DE,FE,4C,FC,68,78,30,30,00,00,00,00,00,00,00,00,00,B4,00,D8,00,38,00,00,00,00,00,00,00,00,00,00,
                        EF,4B,F7,91,FF,A1,7F,40,3F,21,1F,1B,0F,0F,07,07,A4,35,66,4E,5E,52,3F,29,1E,1E,04,05,00,01,00,00,
                        FE,FC,7F,BD,1F,FF,EF,FF,FF,FF,FF,70,F9,E0,F1,E0,42,4D,A2,E2,E0,E0,FC,FC,70,70,A0,A0,06,86,0E,0E,
                        FE,FC,7F,BD,1F,FF,EF,FF,FF,FF,FF,70,F9,E0,F1,E0,42,4D,A2,E2,E0,E0,FC,FC,70,70,A0,A0,06,86,0E,0E,
                        C2,7E,81,FF,C6,FF,FF,FF,FB,FF,F0,FF,A1,BF,FB,FF,88,A6,00,C2,00,6D,80,B1,80,8E,04,19,00,33,00,0A,
}


;;; $9E40: Samus top tiles - set 0 - entry 1Ah ;;;
{
; Fh: Moving right - aiming up-right - frames 0..1 / 5..6
; 69h: Facing right - normal jump - aiming up-right - frames 0..1
; 6Dh: Facing right - falling - aiming up-right - frames 0 / 2
; 76h: Facing right - moonwalk - aiming up-right - frames 0 / 3
; EDh: Facing right - grabbed by Draygon - not moving - aiming up-right - frame 0
; |--------|--------|--------|--------|--------|--------|
; |     FFE|EE      |        |BABBBB83|        |833D3   |
; |   FFF6E|9EE     |   33   |3BAAAB53|        |3375D3  |
; |  FFEEFE|EFF333  |  35D3D | BBBB3D3|        |35875D3 |
; |  FEFFFF|FF3BAA3 | 3583533| 3BBB333|  BBBBB |3D5875D3|
; | FEF3333|F3BAA2B3| 3D3    |  33333 | BA6AB53|33D587D3|
; | FF33333|3BA22B33|  3D    |        |BA62AB83| 33D5D3 |
; | FF33333|3B2623AA|   3    |        |BA6ABB83|  33D3  |
; |F3F33333|3B22A3A3|   3    |        |BB22AB73|   33   |
; |--------|--------|--------|--------|--------|--------|
; |E3F33333|33AAB33 |
; |E3333333|33BB3   |
; |E3333333|33B3    |
; |55333333|333     |
; |733F3333|33      |
; |33F31133|33      |
; | 3F31111|13      |
; |  33311C|C3      |
; |--------|--------|
$9E:9E40             db 06,07,1C,1F,32,3F,2F,3F,5F,7F,7F,7F,7F,7F,FF,FF,07,07,1F,1D,3F,3F,3F,3F,70,70,60,60,60,60,A0,A0,
                        00,C0,80,60,7C,FC,F2,FE,E3,FF,C7,FF,C4,FF,C5,FF,C0,C0,60,E0,E0,E0,C0,DC,80,BA,00,64,10,43,00,4A,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        BD,FD,C7,FD,7F,7D,7F,7F,3E,3E,00,00,00,00,00,00,00,FE,02,7C,02,7A,00,38,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,3E,3E,47,7D,85,FD,8D,FD,C7,FF,00,00,00,00,00,00,00,3E,12,6C,20,CE,20,DE,02,CC,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        7F,FF,7F,FF,7F,FF,FF,3F,FF,FF,FF,F3,7F,70,3E,38,A0,A0,80,80,80,80,C0,00,90,10,20,20,20,20,01,01,
                        CE,FE,F8,F8,F0,F0,E0,E0,C0,C0,C0,C0,C0,40,40,40,00,38,00,30,00,20,00,00,00,00,00,00,00,00,80,80,
}


;;; $9F40: Samus top tiles - set 0 - entry 1Bh ;;;
{
; 10h: Moving left  - aiming up-left - frames 0..1 / 5..6
; 6Ah: Facing left  - normal jump - aiming up-left - frames 0..1
; 6Eh: Facing left  - falling - aiming up-left - frames 0 / 2
; 75h: Facing left  - moonwalk - aiming up-left - frames 0 / 3
; BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left - frame 0
; |--------|--------|--------|--------|--------|--------|--------|
; |      EE|EFF     |  3DD33 |BBBBBB  |        |        |833D3   |
; |     EE9|E6FFF   |   333  |BA226BB |       3|   33   |3375D3  |
; |  3BE4FE|EFEEFF  |        |BA2BA6BB|      33|  35D3D |35875D3 |
; | 3BB44FF|FFFFEF  |        |7BBA26BB|      3D| 3583533|3D5875D3|
; | 3AB43F3|333FFEF |        |57BA2BAB|       3| 3D3    |33D587D3|
; |3BAB3333|3333FFF |        |358BBAAB|       3|  3D    | 33D5D3 |
; |BB3BF333|33333FF |        |3D53BAB3|        |   3    |  33D3  |
; |AB3AB333|33333F3F|        | 3DD3BB |        |   3    |   33   |
; |--------|--------|--------|--------|--------|--------|--------|
; |3BBBAB33|33333F3E|
; |3BA26A33|3333333E|
; |BA2222B3|3333333E|
; |BBA2AAB3|33333355|
; |B3BABBB3|3333B337|
; | B3BBB33|13113B33|
; |     33C|11113B3 |
; |      3C|C11333  |
; |--------|--------|
$9E:9F40             db 00,03,01,06,32,3B,73,73,57,77,DF,FF,FF,FF,6F,FF,03,03,06,07,0F,1B,0F,33,0A,32,00,70,08,D8,00,D8,
                        60,E0,38,F8,4C,FC,F4,FC,FA,FE,FE,FE,FE,FE,FF,FF,E0,E0,F8,B8,FC,FC,FC,FC,1E,1E,0E,0E,06,06,05,05,
                        3E,26,1C,1C,00,00,00,00,00,00,00,00,00,00,00,00,18,18,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FC,FC,86,FE,93,FF,E3,FF,E5,7F,D9,9F,FB,9F,7E,4E,00,FC,08,C6,04,DB,84,73,C0,37,40,3F,60,4E,30,36,
                        00,00,01,01,03,03,03,02,01,01,01,01,00,00,00,00,00,00,00,00,00,00,01,01,00,00,00,00,00,00,00,00,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        F7,FF,C3,FF,83,FF,C3,FF,EF,FF,7F,7F,06,06,02,02,00,7C,08,64,00,C2,00,EE,00,BE,00,5C,01,01,01,01,
                        FE,FF,FE,FF,FE,FF,FF,FC,FF,FF,FF,4F,FE,0E,7C,1C,05,05,01,01,01,01,03,00,01,08,00,04,00,04,80,80,
}


;;; $A060: Samus top tiles - set 0 - entry 1Ch ;;;
{
; 54h: Facing left  - knockback - frames 0..1
; D8h: Facing left  - crystal flash ending - frames 4..5
; E9h: Facing left  - Samus drained - crouching/falling - frames 2 / 4
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |3F9FEF3B|        |        |3F9FEF3B|AABAAB  |        |833D3   |
; |       3|F969F3BA|        |        |F969F3BA|62AB2B3 |   33   |3375D3  |
; |      33|3F9EF3BA|        |        |3F9EF3BA|22AB2B3 |  35D3D |35875D3 |
; |     3A2|33F4FFBA|        |        |33F4FFBA|AABBAB3 | 3583533|3D5875D3|
; |     326|A344E3BB|        |        |A344E3BB|B3BBBB3 | 3D3    |33D587D3|
; |    3BA2|A34F7357|        |        |A34F7357|7833BB3 |  3D    | 33D5D3 |
; |   B33B3|3F3F3333|   FFF33|33B     |3F3F3333|338553  |   3    |  33D3  |
; |  AAB333|F3E3F3BA| FFEEE3B|BBAAB   |F3E3F3BA|B333D3  |   3    |   33   |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | A2A3B2B|3F3F3BA6|3F9FEF3B|AABAAB  |3F3F3BA6|AB333   |
; |B6A3B62A|B3F3BA22|F969F3BA|62AB2B3 |B3F3BA22|2AB33   |
; |BAB3BAAB|B3333BA2|3F9EF3BA|22AB2B3 |B3333BA2|AB3D    |
; |3BB33BB3|3A22B3BA|33F4FFBA|AABBAB3 |3A22B3BA|B338    |
; | 333333B|BA62A33B|A344E3BB|B3BBBB3 |BA62A33B|33DD    |
; |      33|BBAAB333|A34F7357|7833BB3 |BBAAB333|33F5    |
; |        |33BB3B11|3F3F3333|338553  |33BB3B11|13      |
; |        | 333111C|F3E3F3BA|B333D3  | 333111C|13      |
; |--------|--------|--------|--------|--------|--------|
$9E:A060             db 00,00,01,01,03,03,04,07,04,07,0C,0F,1F,1F,0F,3F,00,00,00,00,00,00,00,02,01,00,00,06,00,12,00,38,
                        F7,DF,DE,AF,EE,DF,EE,EF,47,CF,5F,DD,FF,FF,DE,FF,5C,7D,A8,DB,58,7B,3C,2F,38,8B,3B,90,50,50,A8,AB,
                        00,00,00,00,00,00,00,00,00,00,00,00,1F,1F,63,7F,00,00,00,00,00,00,00,00,00,00,00,00,1C,1C,7C,7D,
                        00,00,00,00,00,00,00,00,00,00,00,00,E0,E0,C8,F8,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,F8,
                        F7,DF,DE,AF,EE,DF,EE,EF,47,CF,5F,DD,FF,FF,DE,FF,5C,7D,A8,DB,58,7B,3C,2F,38,8B,3B,90,50,50,A8,AB,
                        24,FC,16,FE,16,FE,36,FE,FE,FE,BE,BE,DC,C4,FC,F4,00,FC,80,34,00,34,00,FC,00,BC,80,4C,18,20,08,88,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        0D,7F,98,FF,B9,FF,FF,FF,7F,7F,03,03,00,00,00,00,00,55,44,A9,00,EF,00,66,00,01,00,00,00,00,00,00,
                        FC,FF,F8,FF,FC,FF,8E,FF,87,FF,CF,FF,FF,FC,7E,70,51,56,20,AC,00,86,00,4B,20,C9,00,F8,00,34,01,01,
                        F7,DF,DE,AF,EE,DF,EE,EF,47,CF,5F,DD,FF,FF,DE,FF,5C,7D,A8,DB,58,7B,3C,2F,38,8B,3B,90,50,50,A8,AB,
                        24,FC,16,FE,16,FE,36,FE,FE,FE,BE,BE,DC,C4,FC,F4,00,FC,80,34,00,34,00,FC,00,BC,80,4C,18,20,08,88,
                        FC,FF,F8,FF,FC,FF,8E,FF,87,FF,CF,FF,FF,FC,7E,70,51,56,20,AC,00,86,00,4B,20,C9,00,F8,00,34,01,01,
                        78,F8,38,F8,70,E0,E0,E0,F0,C0,F0,E0,C0,40,C0,40,00,C0,00,60,10,D0,00,90,30,30,30,20,00,00,00,00,
}


;;; $A220: Samus top tiles - set 0 - entry 1Dh ;;;
{
; 53h: Facing right - knockback - frames 0..1
; D7h: Facing right - crystal flash ending - frames 4..5
; E8h: Facing right - Samus drained - crouching/falling - frames 3 / 5
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |3F9FEF3B|3F9FEF3B|AABAAB  |        |833D3   |
; |        |        |       3|F969F3BA|F969F3BA|62AB2B3 |   33   |3375D3  |
; |        |        |      33|3F9EF3BA|3F9EF3BA|22AB2B3 |  35D3D |35875D3 |
; |        |        |     3A2|33F4FFBA|33F4FFBA|AABBAB3 | 3583533|3D5875D3|
; |        |        |     326|A344E3BB|A344E3BB|B3BBBB3 | 3D3    |33D587D3|
; |        |        |    3BA2|A34F7357|A34F7357|7833BB3 |  3D    | 33D5D3 |
; |   FFF33|33B     |   B33B3|3F3F3333|3F3F3333|338553  |   3    |  33D3  |
; | FFEEE3B|BBAAB   |  AAB333|F3E3F3BA|F3E3F3BA|B333D3  |   3    |   33   |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3F9FEF3B|AABAAB  | A2A3B2B|3F3F3BA6|3F3F3BA6|AB333   |
; |F969F3BA|62AB2B3 |B6A3B62A|B3F3BA22|B3F3BA22|2AB33   |
; |3F9EF3BA|22AB2B3 |BAB3BAAB|B3333BA2|B3333BA2|AB3D    |
; |33F4FFBA|AABBAB3 |3BB33BB3|3A22B3BA|3A22B3BA|B338    |
; |A344E3BB|B3BBBB3 | 333333B|BA62A33B|BA62A33B|33DD    |
; |A34F7357|7833BB3 |      33|BBAAB333|BBAAB333|33F5    |
; |3F3F3333|338553  |        |33BB3B11|33BB3B11|13      |
; |F3E3F3BA|B333D3  |        | 333111C| 333111C|13      |
; |--------|--------|--------|--------|--------|--------|
$9E:A220             db 00,00,00,00,00,00,00,00,00,00,00,00,1F,1F,63,7F,00,00,00,00,00,00,00,00,00,00,00,00,1C,1C,7C,7D,
                        00,00,00,00,00,00,00,00,00,00,00,00,E0,E0,C8,F8,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,F8,
                        00,00,01,01,03,03,04,07,04,07,0C,0F,1F,1F,0F,3F,00,00,00,00,00,00,00,02,01,00,00,06,00,12,00,38,
                        F7,DF,DE,AF,EE,DF,EE,EF,47,CF,5F,DD,FF,FF,DE,FF,5C,7D,A8,DB,58,7B,3C,2F,38,8B,3B,90,50,50,A8,AB,
                        F7,DF,DE,AF,EE,DF,EE,EF,47,CF,5F,DD,FF,FF,DE,FF,5C,7D,A8,DB,58,7B,3C,2F,38,8B,3B,90,50,50,A8,AB,
                        24,FC,16,FE,16,FE,36,FE,FE,FE,BE,BE,DC,C4,FC,F4,00,FC,80,34,00,34,00,FC,00,BC,80,4C,18,20,08,88,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        F7,DF,DE,AF,EE,DF,EE,EF,47,CF,5F,DD,FF,FF,DE,FF,5C,7D,A8,DB,58,7B,3C,2F,38,8B,3B,90,50,50,A8,AB,
                        24,FC,16,FE,16,FE,36,FE,FE,FE,BE,BE,DC,C4,FC,F4,00,FC,80,34,00,34,00,FC,00,BC,80,4C,18,20,08,88,
                        0D,7F,98,FF,B9,FF,FF,FF,7F,7F,03,03,00,00,00,00,00,55,44,A9,00,EF,00,66,00,01,00,00,00,00,00,00,
                        FC,FF,F8,FF,FC,FF,8E,FF,87,FF,CF,FF,FF,FC,7E,70,51,56,20,AC,00,86,00,4B,20,C9,00,F8,00,34,01,01,
                        FC,FF,F8,FF,FC,FF,8E,FF,87,FF,CF,FF,FF,FC,7E,70,51,56,20,AC,00,86,00,4B,20,C9,00,F8,00,34,01,01,
                        78,F8,38,F8,70,E0,E0,E0,F0,C0,F0,E0,C0,40,C0,40,00,C0,00,60,10,D0,00,90,30,30,30,20,00,00,00,00,
}


;;; $A3E0: Samus top tiles - set 0 - entry 1Eh ;;;
{
; Unused
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |      EE|FFF     |        |BBBBB   |        |        |AB3     |BA262BAA|
; |     E96|FEFFF   |       3|BAB6BB  |D33     |3DDDDDD3|B3      |3BA2A3BA|
; |    FEFE|FFEEFF  |      3B|A2A26AB |53D3    |35555553|3       |33BAB333|
; |    F43F|FFFFEF  |      BA|B2A2AAB |7383    |38888873|        |   B32A3|
; |    4433|333FFEF |      BA|B2B2BAB3|5353    |35555553|        |        |
; |    4353|3333FFF |      BA|BA3ABAB3|D3D3    |3DDDDDD3|        |        |
; |    3833|33333FF |      BB|3B3B3333|333     |33333333|        |        |
; |    3F33|33333F3F|      3D|57855D33|        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |    EF33|33333F3E|
; |    FF33|33333F3E|
; |33 3FF33|3333333E|
; |B333F333|33333FF5|
; |B33333BA|AABB3F38|
; |3B333BA2|62AB3333|
; |AABB3BA2|2AB311  |
; |A22AAB22|AAB313  |
; |--------|--------|
$9E:A3E0             db 00,03,02,05,0A,0F,0B,0B,03,03,07,05,0B,0B,0F,0F,03,03,05,06,0F,0F,0D,09,0C,00,0A,00,00,04,04,04,
                        E0,E0,B8,F8,CC,FC,F4,FC,FA,FE,FE,FE,FE,FE,FF,FF,E0,E0,F8,F8,FC,FC,FC,FC,1E,1E,0E,0E,06,06,05,05,
                        00,00,01,01,03,03,02,03,02,03,02,03,03,03,03,02,00,00,00,00,00,01,00,03,00,03,00,03,00,03,01,01,
                        F8,F8,AC,FC,02,FE,82,FE,AB,FF,AB,FF,FF,FF,DF,43,00,F8,10,EC,08,A6,00,AE,00,AE,00,DE,00,50,DC,24,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        84,FF,C6,FF,EF,FF,19,1F,00,00,00,00,00,00,00,00,10,C7,00,6B,00,38,00,12,00,00,00,00,00,00,00,00,
                        07,0F,0F,0F,DF,DF,FF,FF,FE,FF,FC,FF,3C,FF,04,FF,0C,0C,0C,0C,0C,0C,08,88,00,83,00,46,00,F6,00,9C,
                        FE,FF,FE,FF,FE,FF,FF,FE,3E,FE,1F,FF,3C,F0,3C,F4,05,05,05,05,01,01,07,06,04,F5,80,30,00,60,00,E0,
}


;;; $A520: Samus top tiles - set 0 - entry 1Fh ;;;
{
; Unused
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |     FFF|EE      | 3B3553 |        |  BBBBB |        |   33A23|        |
; |   FFFEF|69E     |  3DD3  |        | BA6A2A3|D33     |        |3DDDDDD3|
; |  FFEEFF|EFEF    |   33   |3       |BAA22B2A|53D3    |        |35555553|
; |  FEFFFF|F34F    |        |B       |BA6B22BA|7383    |        |38888873|
; | FEFF333|3344    |        |D3      |BA22B2AB|5353    |        |35555553|
; | FFF3333|3534    |        |53      |BAB2ABB8|D3D3    |        |3DDDDDD3|
; | FFF3333|3383    |        |3       |3BABB378|333     |        |33333333|
; |F3FF3333|33F3    |        |        |3BBB3883|        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |E3F33333|33FF    |
; |E3333333|33BBB   |
; |E3333333|3BAABB  |
; |5333F333|BA22AB3 |
; |83FFF33B|AA262AB3|
; |333F3133|BAA22AB3|
; | 3331113|3BAAAB33|
; |  331C11|33BBB3AB|
; |--------|--------|
$9E:A520             db 07,07,1D,1F,33,3F,2F,3F,5F,7F,7F,7F,7F,7F,FF,FF,07,07,1F,1F,3F,3F,3F,3F,78,78,70,70,70,70,B0,B0,
                        00,C0,40,A0,50,F0,D0,D0,C0,C0,E0,A0,D0,D0,F0,F0,C0,C0,A0,60,F0,F0,B0,90,30,00,50,00,00,20,20,20,
                        7E,72,3C,24,18,18,00,00,00,00,00,00,00,00,00,00,0C,20,18,18,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,80,80,80,80,C0,40,C0,40,80,80,00,00,00,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,
                        3E,3E,41,7F,84,FF,92,FF,89,FF,A6,FE,DE,FE,F9,F9,00,3E,10,6A,00,E5,20,D3,00,CB,00,EF,02,79,00,76,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        19,1F,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,04,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        7F,FF,7F,FF,7F,FF,FF,7F,7F,7F,FF,FB,7F,71,3B,30,A0,A0,80,80,80,80,88,08,38,B9,10,10,00,00,04,04,
                        F0,F0,F8,F8,CC,FC,86,FE,03,FF,83,FF,C7,FF,FD,FF,30,30,00,38,00,7C,00,CC,10,C6,00,E6,00,7C,00,3B,
}
}


;;; $A660..C81F: Samus top tiles - set 1 (general) ;;;
{
;;; $A660: Samus top tiles - set 1 - entry 0 ;;;
{
; Unused
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
$9E:A660             db E5,FF,F5,FF,FF,FE,F5,E4,FF,67,7C,1F,38,1F,38,3F,80,B5,80,BF,81,87,D5,CA,D8,58,40,C7,02,0C,00,0C,
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


;;; $A7A0: Samus top tiles - set 1 - entry 1 ;;;
{
; Unused
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
$9E:A7A0             db 0E,0F,0F,0F,07,0E,07,0F,0F,0F,7E,7F,9C,FF,2C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A2,00,DA,
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


;;; $A8E0: Samus top tiles - set 1 - entry 2 ;;;
{
; 8Bh: Facing right - turning - standing - aiming up - frame 1
; 8Ch: Facing left  - turning - standing - aiming up - frame 1
; 8Fh: Facing right - turning - in air - aiming up - frame 1
; 90h: Facing left  - turning - in air - aiming up - frame 1
; 93h: Facing right - turning - falling - aiming up - frame 1
; 94h: Facing left  - turning - falling - aiming up - frame 1
; 97h: Facing right - turning - crouching - aiming up - frame 1
; 98h: Facing left  - turning - crouching - aiming up - frame 1
; 9Ch: Facing right - turning - standing - aiming up-right - frame 1
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 1
; 9Eh: Facing right - turning - in air - aiming up-right - frame 1
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 1
; A0h: Facing right - turning - falling - aiming up-right - frame 1
; A1h: Facing left  - turning - falling - aiming up-left - frame 1
; A2h: Facing right - turning - crouching - aiming up-right - frame 1
; A3h: Facing left  - turning - crouching - aiming up-left - frame 1
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 1
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 1
; |--------|--------|--------|--------|--------|--------|--------|
; |        |        |FF4EEE4F|EBABBBB | B233333|FF4EEE4F|        |
; |        |        |FF44E44F|E3BA2AAB|BAAD575D|FF44E44F|        |
; |        |        |F8F444F8|F3A262AA|BABD585D|F8F444F8|        |
; |        |        |3F7F4F7F|3B5878DB|BBAD585D|3F7F4F7F|        |
; |        |        |3F33533F|35DDDD53|B3BD585D|3F33533F|        |
; | FFEEEFF|        |33BB3BB3|33333335|358D585D|33BB3BB3|    D75D|
; |FFE999EF|F       |3BBBAAB3|BBAA2AB3|D33DD5DD|3BBBAAB3|    3333|
; |FEFE6EFE|F  BBB  |3BA226A3|22326AB3|33B33333|3BA226A3|  BD575D|
; |--------|--------|--------|--------|--------|--------|--------|
; |FF4EEE4F|EBABBBB |3BA222A3|AA3AAB3 | BB3BBBB|3BA222A3|
; |FF44E44F|E3BA2AAB|3BBBAABB|BB3BBB3 | 3A3B22B|3BBBAABB|
; |F8F444F8|F3A262AA|33333B33|33333   |  A3BAAB|33333B33|
; |3F7F4F7F|3B5878DB|3FFF3333|F3      |  3B3333|3FFF3333|
; |3F33533F|35DDDD53|3111FFFF|33      |   33BB3|3111FFFF|
; |33BB3BB3|33333335|311C1C11|3       |    3333|311C1C11|
; |3BBBAAB3|BBAA2AB3|31CCCCC1|3       |        |31CCCCC1|
; |3BA226A3|22326AB3|331C1C13|3       |        |331C1C13|
; |--------|--------|--------|--------|--------|--------|
$9E:A8E0             db 00,00,00,00,00,00,00,00,00,00,63,7F,DD,E3,A2,FF,00,00,00,00,00,00,00,00,00,00,7F,7F,E3,FF,FF,F7,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,9C,9C,00,00,00,00,00,00,00,00,00,00,00,00,80,80,80,9C,
                        C1,DD,C1,C9,A2,A2,F7,F7,FF,F7,FF,FF,F3,FF,C1,FF,FF,DD,FF,C9,BE,E3,7F,55,49,41,00,36,00,7E,04,62,
                        5E,FE,61,FF,C0,FF,EB,C9,FF,81,FF,FE,C3,FF,23,FF,80,FE,80,B7,88,A3,2A,57,7E,3C,01,00,00,F6,08,06,
                        5F,7F,9F,E4,BB,E0,DB,E0,FB,E0,DB,80,FF,60,FF,FF,00,40,1F,F1,1B,F5,1B,F5,1B,B5,5B,35,9F,9B,00,20,
                        C1,DD,C1,C9,A2,A2,F7,F7,FF,F7,FF,FF,F3,FF,C1,FF,FF,DD,FF,C9,BE,E3,7F,55,49,41,00,36,00,7E,04,62,
                        00,00,00,00,00,00,00,00,00,00,0F,04,0F,0F,3F,24,00,00,00,00,00,00,00,00,00,00,0F,09,00,00,1F,31,
                        C1,DD,C1,C9,A2,A2,F7,F7,FF,F7,FF,FF,F3,FF,C1,FF,FF,DD,FF,C9,BE,E3,7F,55,49,41,00,36,00,7E,04,62,
                        5E,FE,61,FF,C0,FF,EB,C9,FF,81,FF,FE,C3,FF,23,FF,80,FE,80,B7,88,A3,2A,57,7E,3C,01,00,00,F6,08,06,
                        C1,FF,F3,FF,FF,FF,FF,FF,FF,8F,EB,80,C1,80,EB,C1,00,62,00,7F,00,04,70,70,0F,0F,14,14,3E,3E,14,14,
                        26,FE,FE,FE,F8,F8,C0,C0,C0,C0,80,80,80,80,80,80,00,DC,00,DC,00,00,80,80,00,00,00,00,00,00,00,00,
                        7F,7F,59,7F,19,3F,3F,3F,1F,1F,0F,0F,00,00,00,00,00,6F,00,29,00,2F,00,10,00,06,00,00,00,00,00,00,
                        C1,FF,F3,FF,FF,FF,FF,FF,FF,8F,EB,80,C1,80,EB,C1,00,62,00,7F,00,04,70,70,0F,0F,14,14,3E,3E,14,14,
}


;;; $AA80: Samus top tiles - set 1 - entry 3 ;;;
{
; 8Dh: Facing right - turning - standing - aiming down-right - frame 1
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 1
; 91h: Facing right - turning - in air - aiming down/down-right - frame 1
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 1
; 95h: Facing right - turning - falling - aiming down/down-right - frame 1
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 1
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 1
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 1
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 1
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 1
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |BABBBBB3|EF4EEE4F|  D585D3|F3BBBBB |
; |        |        |        |        |BBA262B3|EF44E44F|  D575D3|3BAAAB  |
; |        |        |        |        |BAA222AB|F8F444F8|  D575D3|3BA6AB  |
; |        |        |        |        |BBBA2AAB|3F7F4F7F|  D333D3|B3A2AB  |
; |        |        |        |        |B33BBBB3|3F33533F|  357533|A3BABB  |
; | FFEEEFF|        |        | FFEEEFF|358785D3|FFFF3FFF|  D333D3|A33BB   |
; |FFE999EF|F       |  BBBB  |FFE999EF|DD33335D|EF9E3E9F|   D8533|B3AA    |
; |F9FE6EFE|F  BBB  | BAAAAB |F9FE6EFE|3BBBBB33|E9F939F9|   333D |33A2    |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |EF4EEE4F|EFA22AB |BABBBBB3|EF4EEE4F| BA2ABB3|FE9FFF9E|
; |EF44E44F|E3ABBBBB|BBA262B3|EF44E44F| B26A333|3FEE3EEF|
; |F8F444F8|F3BA62BB|BAA222AB|F8F444F8| BAABAAA|33333333|
; |3F7F4F7F|3BAA22AB|BBBA2AAB|3F7F4F7F| BA3BA24|ABBA2AAB|
; |3F33533F|3BAAAAAB|B33BBBB3|3F33533F| BB3BBA2|BBBAA262|
; |FFFF3FFF|F3B8775B|358785D3|FFFF3FFF| 3B33333|333BAA22|
; |EF9E3E9F|F353333D|DD33335D|EF9E3E9F|  3D5D33|33333BAA|
; |E9F939F9|F3BBBB33|3BBBBB33|E9F939F9|  D585D3|33C1C133|
; |--------|--------|--------|--------|--------|--------|
$9E:AA80             db 00,00,00,00,00,00,00,00,00,00,63,7F,DD,E3,E2,BF,00,00,00,00,00,00,00,00,00,00,7F,7F,E3,FF,BF,F7,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,9C,9C,00,00,00,00,00,00,00,00,00,00,00,00,80,80,80,9C,
                        00,00,00,00,00,00,00,00,00,00,00,00,3C,3C,42,7E,00,00,00,00,00,00,00,00,00,00,00,00,00,3C,00,7E,
                        00,00,00,00,00,00,00,00,00,00,63,7F,DD,E3,E2,BF,00,00,00,00,00,00,00,00,00,00,7F,7F,E3,FF,BF,F7,
                        BF,FF,C3,FF,81,FF,E1,FF,FF,FF,D7,91,FF,3C,FF,FF,00,FE,08,E2,00,E3,00,F7,00,9E,56,2A,C3,C1,00,7C,
                        41,DD,41,C9,A2,A2,F7,F7,FF,F7,FF,FF,6B,DD,7F,AA,FF,DD,FF,C9,BE,E3,7F,55,49,41,F7,F7,D5,F7,A2,F7,
                        37,01,3F,09,3F,09,3F,1D,3F,2B,3F,1D,17,03,1E,1C,36,2A,3E,22,3E,22,22,22,1C,00,22,22,14,18,02,02,
                        FE,FE,C4,FC,C4,FC,C4,FC,6C,FC,78,F8,C0,F0,C0,F0,80,BE,00,7C,10,6C,00,AC,00,BC,00,98,00,B0,00,20,
                        41,DD,41,C9,A2,A2,F7,F7,FF,F7,FF,FF,6B,DD,7F,AA,FF,DD,FF,C9,BE,E3,7F,55,49,41,F7,F7,D5,F7,A2,F7,
                        42,FE,5F,FF,E3,FF,C1,FF,C1,FF,EF,ED,FF,DE,FF,FF,C0,E6,80,BF,88,B3,00,73,00,7F,8E,B1,A1,81,80,BC,
                        BF,FF,C3,FF,81,FF,E1,FF,FF,FF,D7,91,FF,3C,FF,FF,00,FE,08,E2,00,E3,00,F7,00,9E,56,2A,C3,C1,00,7C,
                        41,DD,41,C9,A2,A2,F7,F7,FF,F7,FF,FF,6B,DD,7F,AA,FF,DD,FF,C9,BE,E3,7F,55,49,41,F7,F7,D5,F7,A2,F7,
                        47,7F,47,7F,48,7F,58,7E,7C,7F,7F,7F,3F,23,37,01,00,6E,10,48,00,7F,01,6C,00,6E,00,20,1C,14,36,2A,
                        BE,DD,C9,FF,FF,FF,61,FF,E0,FF,F0,FF,FC,FF,D7,C3,DD,FF,77,77,00,00,00,F7,02,F8,00,1C,00,07,28,28,
}


;;; $AC40: Samus top tiles - set 1 - entry 4 ;;;
{
; Unused
; |--------|
; |111     |
; |1       |
; |111     |
; |1   111 |
; |111 1  1|
; |    111 |
; |    1   |
; |    1   |
; |--------|
$9E:AC40             db E0,00,80,00,E0,00,8E,00,E9,00,0E,00,08,00,08,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $AC60: Samus top tiles - set 1 - entry 5 ;;;
{
; 9Bh: Facing forward - varia/gravity suit - frame 0
; |--------|--------|
; |        |     FEE|
; |    B   |B   FE9E|
; |    2BBB|2B 3FFE6|
; |    BBA2|AB39F4E9|
; |   BB262|2A3EF44E|
; |   BA2BB|BA3F8F44|
; |   BBBA2|AB3337F4|
; |   BAB22|2BB3F3F5|
; |--------|--------|
; |   3333A|AB3EFFF3|
; |   D5833|333E6FEF|
; |   33D78|5D3FE9FF|
; |    3333|333FF99F|
; |    262A|B333FFEF|
; |    A22A|B 3133FF|
; |    B22A|B 33C333|
; |    B22A|B  33111|
; |--------|--------|
$9E:AC60             db 00,00,08,08,07,0F,0C,0F,18,1F,13,1F,1C,1F,14,1F,00,00,00,08,00,07,00,0E,02,18,00,1B,00,1E,00,1C,
                        04,07,8A,8D,5C,DF,79,EA,28,F9,B4,F4,7E,FE,7F,FE,07,07,0D,8F,0F,4E,0E,DB,1F,59,17,DC,07,C2,0B,6A,
                        1E,1F,1B,03,1E,1A,0F,0F,00,0F,00,0F,08,0F,08,0F,00,01,18,14,06,05,00,00,04,01,00,09,00,09,00,09,
                        6F,FF,E5,FF,F7,3B,FF,F9,FD,FF,BF,AF,B7,B7,9F,98,1E,DE,1F,17,DB,5F,19,1F,0F,8F,03,83,08,88,00,80,
}


;;; $ACE0: Samus top tiles - set 1 - entry 6 ;;;
{
; 25h: Facing right - turning - standing - frame 2
; 26h: Facing left  - turning - standing - frame 0
; 2Fh: Facing right - turning - jumping - frame 2
; 30h: Facing left  - turning - jumping - frame 0
; 43h: Facing right - turning - crouching - frame 2
; 44h: Facing left  - turning - crouching - frame 0
; 87h: Facing right - turning - falling - frame 2
; 88h: Facing left  - turning - falling - frame 0
; BFh: Facing right - moonwalking - turn/jump left - frame 2
; C0h: Facing left  - moonwalking - turn/jump right - frame 0
; C6h: Unused - frame 2
; |--------|--------|--------|--------|--------|--------|
; |3F49E44E|3BAA2B  |       B|3F49E44E|        |        |
; |3E4E443E|BBBAA2B |      BA|3E4E443E|        |        |
; |3E3443FF|BAA62A2B|     B2A|3E3443FF|        |        |
; |38F43F83|B2BAAB2B|     B2A|38F43F83|        |        |
; |338E3833|A22BAB2B|     BA3|338E3833|        |        |
; |FF333FFF|A2ABBBBB|     BB3|FF333FFF|        |   FFFFF|
; |EFEEF993|BBBBD75D|      53|EFEEF993|F       |  FEF9EF|
; |E9FF99E3|3333333 |      33|E9FF99E3|F3BBB   | FE96FEF|
; |--------|--------|--------|--------|--------|--------|
; |3EF99E33|33BBBB3 |      AB|3EF99E33|
; |33FE333F|3BA62A3 |      33|33FE333F|
; |BA33CCC3|3A222B3 |  D3D3DB|BA33CCC3|
; |BA2BBBBB|3BA2AB  | D838355|BA2BBBBB|
; |5B33A22A|B3BAB3  | 8383738|5B33A22A|
; |5D3A222A|AB333   | 8373535|5D3A222A|
; |D333BAAB|3BAB3   | D83D3DD|D333BAAB|
; |33333333|33B3    |  333333|33333333|
; |--------|--------|--------|--------|
$9E:ACE0             db D0,C9,82,D3,A7,E7,AD,AD,CB,DB,FF,FF,4F,F9,7D,B3,6F,59,7D,51,5B,43,34,66,10,34,C7,C7,F8,FE,B2,FE,
                        C4,FC,E2,FE,81,FF,A5,FF,15,FF,1F,FF,FF,F4,FE,FE,00,74,00,FA,10,E5,00,BD,00,9D,00,BF,0F,F9,00,00,
                        01,01,02,03,04,07,04,07,05,07,07,07,03,01,03,03,00,01,00,03,00,05,00,05,00,06,00,06,02,00,00,00,
                        D0,C9,82,D3,A7,E7,AD,AD,CB,DB,FF,FF,4F,F9,7D,B3,6F,59,7D,51,5B,43,34,66,10,34,C7,C7,F8,FE,B2,FE,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,F8,F8,00,00,00,00,00,00,00,00,00,00,00,00,80,80,80,B8,
                        00,00,00,00,00,00,00,00,00,00,1F,1F,2D,3B,55,6F,00,00,00,00,00,00,00,00,00,00,1F,1F,3B,3F,6F,77,
                        BB,E7,EF,FF,B1,F1,9F,FF,F0,7F,E0,3F,F9,7F,FF,FF,64,7C,31,31,0E,CE,00,DF,80,49,C0,51,80,8F,00,00,
                        FE,FE,C2,FE,86,FE,C4,FC,EC,FC,78,F8,D8,F8,F0,F0,00,3C,10,64,00,44,00,6C,00,B8,00,C0,00,70,00,20,
                        01,03,03,03,3F,15,57,14,2E,2E,3F,3A,5F,14,3F,3F,00,03,00,00,2A,2B,43,68,04,51,15,40,4B,6B,00,00,
                        BB,E7,EF,FF,B1,F1,9F,FF,F0,7F,E0,3F,F9,7F,FF,FF,64,7C,31,31,0E,CE,00,DF,80,49,C0,51,80,8F,00,00,
}


;;; $AE20: Samus top tiles - set 1 - entry 7 ;;;
{
; 25h: Facing right - turning - standing - frame 0
; 26h: Facing left  - turning - standing - frame 2
; 2Fh: Facing right - turning - jumping - frame 0
; 30h: Facing left  - turning - jumping - frame 2
; 43h: Facing right - turning - crouching - frame 0
; 44h: Facing left  - turning - crouching - frame 2
; 87h: Facing right - turning - falling - frame 0
; 88h: Facing left  - turning - falling - frame 2
; BFh: Facing right - moonwalking - turn/jump left - frame 0
; C0h: Facing left  - moonwalking - turn/jump right - frame 2
; C6h: Unused - frame 0
; |--------|--------|--------|--------|--------|--------|
; |    BBA2|23FE44E9|23FE44E9|4F3AB   |        |        |
; |    BAAA|BB3E344E|BB3E344E|4E32AB  |        |        |
; |   BAAB2|2ADFF344|2ADFF344|DE326B  |        |        |
; |   BABAA|B2A38F34|B2A38F34|F83A2B  |        |        |
; |   BABAB|22A3383E|22A3383E|8333AB  |        |        |
; |   BBBBB|AADDFF33|AADDFF33|3FF3BB  |        |   FFFFF|
; |   D5785|5BB3EEFE|5BB3EEFE|EFE378  |F       |  FEF9EF|
; |    3333|3333E9EF|3333E9EF|F9933   |F3BBB   | FE96FEF|
; |--------|--------|--------|--------|--------|--------|
; |    3BBB|B3333EEE|B3333EEE|F933B   |
; |    3A22|AB3B333E|AB3B333E|F33AB   |
; |    3BA2|2A3DDDD3|2A3DDDD3|DDAA2B  |
; |     BAA|ABD55853|ABD55853|838D2A  |
; |     3BA|B3888837|B3888837|3838AB  |
; |      33|33555535|33555535|3738B   |
; |      3B|A33DDDD3|A33DDDD3|D38     |
; |       3|B3333333|B3333333|333     |
; |--------|--------|--------|--------|
$9E:AE20             db 0C,0F,08,0F,12,1F,14,1F,15,1F,1F,1F,1D,04,0F,0F,00,0E,00,0F,00,1E,00,1F,00,1F,00,1F,1D,12,00,00,
                        61,F2,E8,F9,3C,DC,96,F6,1A,FB,3F,CF,F2,7F,F5,FB,3E,33,17,D1,3B,78,05,AC,01,25,3C,FC,8F,6F,0B,0F,
                        61,F2,E8,F9,3C,DC,96,F6,1A,FB,3F,CF,F2,7F,F5,FB,3E,33,17,D1,3B,78,05,AC,01,25,3C,FC,8F,6F,0B,0F,
                        68,78,24,7C,A4,7C,A4,BC,74,7C,FC,FC,58,F8,F8,98,C0,58,C0,4C,C8,C4,80,D4,00,8C,60,6C,E8,E4,80,E0,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,F8,F8,00,00,00,00,00,00,00,00,00,00,00,00,80,80,80,B8,
                        00,00,00,00,00,00,00,00,00,00,1F,1F,2D,3B,55,6F,00,00,00,00,00,00,00,00,00,00,1F,1F,3B,3F,6F,77,
                        0F,0F,08,0F,0C,0F,04,07,06,07,03,03,03,03,01,01,00,07,00,04,00,06,00,07,00,03,00,00,00,01,00,00,
                        F8,FF,7E,FF,3F,E1,7B,C1,C3,C3,FF,C2,7F,E1,FF,FF,07,87,01,D1,1E,5E,3A,E4,01,BC,3D,00,1E,9E,00,80,
                        F8,FF,7E,FF,3F,E1,7B,C1,C3,C3,FF,C2,7F,E1,FF,FF,07,87,01,D1,1E,5E,3A,E4,01,BC,3D,00,1E,9E,00,80,
                        F8,B8,E8,F8,C4,3C,50,4C,A4,AC,E8,E8,C0,40,E0,E0,80,C8,80,98,C0,F4,10,B4,00,5C,40,18,80,A0,00,00,
}


;;; $AF60: Samus top tiles - set 1 - entry 8 ;;;
{
; 8Bh: Facing right - turning - standing - aiming up - frame 2
; 8Ch: Facing left  - turning - standing - aiming up - frame 0
; 8Fh: Facing right - turning - in air - aiming up - frame 2
; 90h: Facing left  - turning - in air - aiming up - frame 0
; 93h: Facing right - turning - falling - aiming up - frame 2
; 94h: Facing left  - turning - falling - aiming up - frame 0
; 97h: Facing right - turning - crouching - aiming up - frame 2
; 98h: Facing left  - turning - crouching - aiming up - frame 0
; 9Ch: Facing right - turning - standing - aiming up-right - frame 2
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 0
; 9Eh: Facing right - turning - in air - aiming up-right - frame 2
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 0
; A0h: Facing right - turning - falling - aiming up-right - frame 2
; A1h: Facing left  - turning - falling - aiming up-left - frame 0
; A2h: Facing right - turning - crouching - aiming up-right - frame 2
; A3h: Facing left  - turning - crouching - aiming up-left - frame 0
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 2
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 0
; |--------|--------|--------|--------|--------|--------|--------|
; |    3333|3F49E44E|        |        |        |3BAAAB3 |3BAA2B  |
; |    D575|DE4E443E|        |        |        |3A262A3 |BBBAA2B |
; |    D585|DE3443FF|        |        |        |ABAAAB3 |BAA62A2B|
; |    D585|D8F43F83|        |        |        |2ABBBB  |B2BAAB2B|
; |    D585|D38E3833|        |        |        |B33333  |A22BAB2B|
; |    D585|DF333FFF|     D75|        |D  FFFFF|AB333   |A2ABBBBB|
; |    DD5D|D3FEF993|     333|F       |3 FEF9EF|3BAB3   |BBBBD75D|
; |    3333|33FFFFF3|    D575|F3FFF   |3FE96FEF|33B3    |3333333 |
; |--------|--------|--------|--------|--------|--------|--------|
; |    B22B|33A222AF|
; |    3AA3|33FAA2AF|
; |    B333|BF33BAFB|
; |    BBBA|B3FF333A|
; |     BBB|33111133|
; |        | 31CC113|
; |        |  1C1C11|
; |        |  11C1C1|
; |--------|--------|
$9E:AF60             db 0F,0F,0F,02,0D,00,0D,00,0D,00,0D,00,0F,00,0F,0F,00,00,0F,08,0D,0A,0D,0A,0D,0A,0D,0A,0F,0D,00,00,
                        D0,C9,82,53,A7,67,AD,2D,CB,5B,FF,7F,EF,79,FF,FF,6F,59,FD,D1,DB,C3,B4,E6,90,B4,C7,C7,B8,BE,3E,3E,
                        00,00,00,00,00,00,00,00,00,00,07,02,07,07,0F,02,00,00,00,00,00,00,00,00,00,00,07,04,00,00,0F,08,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,F8,F8,00,00,00,00,00,00,00,00,00,00,00,00,80,80,B8,B8,
                        00,00,00,00,00,00,00,00,00,00,9F,1F,AD,BB,D5,EF,00,00,00,00,00,00,00,00,00,00,9F,9F,3B,3F,6F,77,
                        C6,FE,82,FE,46,FE,3C,FC,FC,FC,78,F8,D8,F8,F0,F0,00,7C,10,44,00,FC,00,7C,00,80,00,C0,00,70,00,20,
                        C4,FC,E2,FE,81,FF,A5,FF,15,FF,1F,FF,FF,F4,FE,FE,00,74,00,FA,10,E5,00,BD,00,9D,00,BF,0F,F9,00,00,
                        09,0F,09,0F,0F,0F,0E,0F,07,07,00,00,00,00,00,00,00,09,00,06,00,08,00,0F,00,07,00,00,00,00,00,00,
                        C1,FF,E1,FF,FB,FF,FE,FF,FF,C3,67,41,2B,00,35,00,01,23,21,3B,42,CF,30,B1,00,00,18,18,14,14,0A,0A,
}


;;; $B080: Samus top tiles - set 1 - entry 9 ;;;
{
; 8Bh: Facing right - turning - standing - aiming up - frame 0
; 8Ch: Facing left  - turning - standing - aiming up - frame 2
; 8Fh: Facing right - turning - in air - aiming up - frame 0
; 90h: Facing left  - turning - in air - aiming up - frame 2
; 93h: Facing right - turning - falling - aiming up - frame 0
; 94h: Facing left  - turning - falling - aiming up - frame 2
; 97h: Facing right - turning - crouching - aiming up - frame 0
; 98h: Facing left  - turning - crouching - aiming up - frame 2
; 9Ch: Facing right - turning - standing - aiming up-right - frame 0
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 2
; 9Eh: Facing right - turning - in air - aiming up-right - frame 0
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 2
; A0h: Facing right - turning - falling - aiming up-right - frame 0
; A1h: Facing left  - turning - falling - aiming up-left - frame 2
; A2h: Facing right - turning - crouching - aiming up-right - frame 0
; A3h: Facing left  - turning - crouching - aiming up-left - frame 2
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 0
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 2
; |--------|--------|--------|--------|--------|--------|
; |233333E9|4F3AB   |        |        |    3BA2|    BBA2|
; |BD575D4E|4E32AB  |        |        |    3BA2|    BAAA|
; |2D585D44|DE326B  |        |        |    3BA2|   BAAB2|
; |BD585D34|F83A2B  |        |        |     BBA|   BABAA|
; |BD585D3E|8333AB  |        |        |     3BB|   BABBB|
; |DD585D33|3FF3BB  |        |  D75DFF|      33|   BBB77|
; |3DD5DDFE|EFF378  |F       |  3333FE|        |   D5733|
; |B33333FF|FBBBB3  |EF B    |BD575D69|        |    333B|
; |--------|--------|--------|--------|--------|--------|
; |2A3AA3BB|AA22A3  |
; |ABBA2A3B|BBAAAB  |
; |AB3AA333|BBBBB   |
; |AABBB333|3333    |
; |BBB33311|333     |
; |3333313C|11      |
; |33111CC1|1       |
; |3331C1C1|        |
; |--------|--------|
$9E:B080             db 7D,FE,FC,91,6C,80,EE,82,EE,83,EF,03,FE,83,FF,FF,02,03,7F,C5,6F,54,6D,D4,6D,D5,EC,D4,7F,6F,03,83,
                        68,78,24,7C,A4,7C,A4,BC,74,7C,FC,FC,78,F8,FC,FC,C0,58,C0,4C,C8,C4,80,D4,00,8C,60,6C,E8,E4,80,F8,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,50,D0,00,00,00,00,00,00,00,00,00,00,00,00,80,80,C0,D0,
                        00,00,00,00,00,00,00,00,00,00,3F,13,3E,3F,FD,92,00,00,00,00,00,00,00,00,00,00,3F,27,03,03,7E,C5,
                        0C,0F,0C,0F,0C,0F,06,07,07,07,03,03,00,00,00,00,00,06,00,06,00,06,00,07,00,03,00,00,00,00,00,00,
                        0C,0F,08,0F,12,1F,14,1F,17,1F,1F,1F,1F,07,0F,0F,00,0E,00,0F,00,1E,00,1F,00,1F,03,1C,1C,10,00,01,
                        27,FF,63,FF,67,FF,3F,FF,FF,FC,FE,FA,F9,C0,F5,E0,00,5B,00,F5,00,D8,00,F8,00,E0,01,01,06,06,0A,0A,
                        04,FC,C4,FC,F8,F8,F0,F0,E0,E0,C0,00,80,00,00,00,00,C8,00,FC,00,F8,00,00,00,00,00,00,00,00,00,00,
}


;;; $B180: Samus top tiles - set 1 - entry Ah ;;;
{
; 25h: Facing right - turning - standing - frame 1
; 26h: Facing left  - turning - standing - frame 1
; 2Fh: Facing right - turning - jumping - frame 1
; 30h: Facing left  - turning - jumping - frame 1
; 43h: Facing right - turning - crouching - frame 1
; 44h: Facing left  - turning - crouching - frame 1
; 87h: Facing right - turning - falling - frame 1
; 88h: Facing left  - turning - falling - frame 1
; BFh: Facing right - moonwalking - turn/jump left - frame 1
; C0h: Facing left  - moonwalking - turn/jump right - frame 1
; C6h: Unused - frame 1
; |--------|--------|--------|--------|--------|--------|--------|
; |        |        |BAABBBB3|EF4EEE4F|EF4EEE4F|EBA22AB |        |
; |        |        |BAB262B3|EF44E44F|EF44E44F|E3ABBBBB|        |
; |        |        |BBA222AB|F8F444F8|F8F444F8|F3BA62BB|        |
; |        |        |BBBA2AAB|3F7F4F7F|3F7F4F7F|3BAA22AA|        |
; |        |        |333BBAB3|3F33533F|3F33533F|3BAAA2AB|        |
; |        | FFEEEFF|D5878533|FFFF3FFF|FFFF3FFF|F3BABB33|        |
; |  BBBB  |FFE999EF|33333333|EF9E3E9F|EF9E3E9F|F358775D|F       |
; | B222AB |F9FE6EFE| BBBBB33|E9F939F9|E9F939F9|F3B33333|F  BBB  |
; |--------|--------|--------|--------|--------|--------|--------|
; |BAABBBB3|EF4EEE4F| BAAAB33|FE9F3F9E|FE9F3F9E|F3BBBBB |
; |BAB262B3|EF44E44F| B26AB35|5FEE3EEF|5FEE3EEF|33B22AB |
; |BBA222AB|F8F444F8| BA2B5DD|38333333|38333333|33A26AB |
; |BBBA2AAB|3F7F4F7F| BAB8583|33BAAAAB|33BAAAAB|B3A22B  |
; |333BBAB3|3F33533F|  B37D5D|3DBAA262|3DBAA262|A3BABB  |
; |D5878533|FFFF3FFF|  B38D35|833BAA22|833BAA22|A33BB   |
; |33333333|EF9E3E9F|   355D3|3D333BAA|3D333BAA|A3AA    |
; | BBBBB33|E9F939F9|    35D3|331111B3|331111B3|B3A2    |
; |--------|--------|--------|--------|--------|--------|
$9E:B180             db 00,00,00,00,00,00,00,00,00,00,00,00,3C,3C,42,7E,00,00,00,00,00,00,00,00,00,00,00,00,00,3C,00,46,
                        00,00,00,00,00,00,00,00,00,00,63,7F,DD,E3,E2,BF,00,00,00,00,00,00,00,00,00,00,7F,7F,E3,FF,BF,F7,
                        9F,FF,A3,FF,C1,FF,E1,FF,FB,FF,D7,13,FF,FF,7F,7F,00,FE,08,E2,00,E3,00,F7,00,1E,D4,A8,00,00,00,7C,
                        41,DD,41,C9,A2,A2,F7,F7,FF,F7,FF,FF,6B,DD,7F,AA,FF,DD,FF,C9,BE,E3,7F,55,49,41,F7,F7,D5,F7,A2,F7,
                        41,DD,41,C9,A2,A2,F7,F7,FF,F7,FF,FF,6B,DD,7F,AA,FF,DD,FF,C9,BE,E3,7F,55,49,41,F7,F7,D5,F7,A2,F7,
                        42,FE,5F,FF,E3,FF,C0,FF,C1,FF,EF,FF,EF,CC,FF,FF,80,E6,80,BF,88,B3,00,73,00,7B,80,BC,AF,91,80,A0,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,9C,9C,00,00,00,00,00,00,00,00,00,00,00,00,80,80,80,9C,
                        9F,FF,A3,FF,C1,FF,E1,FF,FB,FF,D7,13,FF,FF,7F,7F,00,FE,08,E2,00,E3,00,F7,00,1E,D4,A8,00,00,00,7C,
                        41,DD,41,C9,A2,A2,F7,F7,FF,F7,FF,FF,6B,DD,7F,AA,FF,DD,FF,C9,BE,E3,7F,55,49,41,F7,F7,D5,F7,A2,F7,
                        47,7F,47,7E,4F,78,55,71,3F,38,37,32,1F,11,0F,09,00,7C,11,4C,07,6B,04,7A,0F,25,05,2C,0E,02,06,02,
                        BE,DD,C9,7F,BF,BF,E1,FF,E0,BF,70,7F,FC,BF,FF,C3,D5,F7,F7,77,00,40,00,3F,42,78,00,9C,40,47,00,02,
                        BE,DD,C9,7F,BF,BF,E1,FF,E0,BF,70,7F,FC,BF,FF,C3,D5,F7,F7,77,00,40,00,3F,42,78,00,9C,40,47,00,02,
                        FE,FE,E2,FE,C2,FE,C4,FC,6C,FC,78,F8,40,F0,C0,F0,80,BE,00,26,08,26,00,A4,00,BC,00,98,00,B0,00,A0,
}


;;; $B320: Samus top tiles - set 1 - entry Bh ;;;
{
; 64h: Unused - frame 1
; B9h: Facing right - grapple wall jump pose - frame 0
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |    33BB|33      |        | 88     |        | B3AAA  |3BA2A3  |
; |        |   3BBAA|BB3333  |        |D33     |3DDDDDD3| 3B22B  |3B223   |
; |        |  3DBABB|BAB3FFFF|3       |53D     |35555553|  3AB3  |33BB3   |
; |      33|BB3DBB22|ABA3EEEF|F3      |877     |38888873|        |3B33    |
; |     33B|AB35BABB|BAB3F9EE|FF3     |588     |35555553|        |BAAB    |
; |     3BA|6B37BB26|2BA3F969|E9F33   |D35     |3DDDDDD3|        |B22A    |
; |    33B2|2B385B22|2AB3FE9E|FEF3B3  |333     |33333333|        |3A2A    |
; |    3BA2|2A338BBA|AB33F4F9|9FF3BB3 | 88     |        |        | 3A33   |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |    3BAA|AAB358BB|B333344F|F43BABB |
; |     3BB|BBB3335D|33F37344|443A2BB |
; |   B3AA2|33   333|3FEF8334|433262B |
; |   A3BBA|2A33 33F|FE6F3834|38BA2AB3|
; |   B3CBB|A62A33C3|FEFEF33F|33AAB333|
; |   333CC|BA222BCC|3EF9E3F3|F3333853|
; |   3B33C|CBBA2B3C|3FEF9EFE|F358733 |
; |    AB3C|1CBBAA33|13FEFFFF|333333  |
; |--------|--------|--------|--------|
$9E:B320             db 00,00,00,00,00,00,03,03,07,07,06,07,0E,0F,0C,0F,00,00,00,00,00,00,00,00,00,01,00,03,00,02,00,06,
                        0F,0F,1C,1F,3B,2F,FC,EF,7B,EF,7C,FF,6C,E7,36,F7,00,03,00,0F,10,1F,10,DC,10,CF,91,4C,08,54,00,4F,
                        C0,C0,FC,FC,BF,FF,51,FF,BC,FB,5D,FA,3A,FD,7B,FA,00,00,00,C0,0F,EF,0F,EF,0B,EF,0A,6D,0D,6F,0E,CB,
                        00,00,00,00,80,80,C0,C0,E0,E0,78,B8,BC,FC,FE,7E,00,00,00,00,00,00,80,80,C0,C0,A0,E0,E0,E8,60,EC,
                        00,00,E0,60,E0,40,60,60,80,00,E0,40,E0,E0,00,00,00,60,80,80,A0,20,60,80,80,60,A0,80,00,00,00,60,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        60,7C,64,7C,2C,3C,00,00,00,00,00,00,00,00,00,00,00,5C,00,24,00,18,00,00,00,00,00,00,00,00,00,00,
                        C4,FC,C8,F8,F8,F8,F0,F0,90,F0,80,F0,80,F0,58,78,00,68,00,40,00,30,00,40,00,F0,00,90,00,50,00,20,
                        0C,0F,07,07,18,1F,0E,1F,1B,1B,1C,1C,1E,1E,06,0E,00,07,00,03,00,16,00,17,04,17,03,03,01,09,01,0D,
                        3B,F3,FF,FC,C7,C7,37,F7,0D,FD,84,FC,66,7E,B3,3F,08,E7,03,E1,00,00,01,41,42,92,03,C7,81,F5,40,7C,
                        F9,F9,FC,FC,D6,F6,9A,FA,AF,FF,B7,EF,DA,F7,EF,7F,07,81,2B,20,71,78,F1,D4,F9,F9,6A,7A,77,7F,3F,3F,
                        B6,BE,26,3E,62,7E,A3,BF,CF,FF,FB,F9,EE,CE,FC,FC,C0,9E,C0,16,88,02,00,76,00,38,82,84,A8,90,00,00,
}


;;; $B4A0: Samus top tiles - set 1 - entry Ch ;;;
{
; 63h: Unused - frame 1
; B8h: Facing left  - grapple wall jump pose - frame 0
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        | 88     |        |  3A3BB3|   BAA62|
; |BB3     |        |       3|FEEEF333|D33     |3DDDDDD3|  3BB33 |   BBA2A|
; |ABBBB   |        |      3F|FEFF9E3A|53D     |35555553|   333  |   3B3B3|
; |BAAB53  |        |     3FE|E999FFE3|877     |38888873|        |    B32A|
; |3BABD33 |        |     3FE|96999EFF|588     |35555553|        |    33BB|
; |3BB38BA3|        |  33333F|F9EEEFFF|D35     |3DDDDDD3|        |    B333|
; |3B383B2B|3       | 3BBBBB3|FEFFE9EF|333     |33333333|        |    BBBB|
; |33553AA2|B3      |3BAA2AB3|3FFFEE9F| 88     |        |        |   33BBB|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3333BBAA|B3      |BA22BBBB|33FFFFFF|
; |FF33BBBB|33      |BA2BAABB|33333333|
; |EEF33333|3333B   |BA2B2AAB|B3F3F333|
; |3E53   3|3BBB33B |BAAB3333|33F39FFF|
; |F383  3B|BA2B33A |3333855D|D3FE99EF|
; |F333 3BB|262A3B  |35875333|33FFFFEF|
; |33333BAA|B2A3BA  | 333BB3B|33FF3853|
; |3113BA22|ABB3B   |  3BA22A|B3333533|
; |--------|--------|--------|--------|
$9E:B4A0             db 00,00,E0,E0,78,F8,9C,F4,DE,F6,F5,F7,ED,EF,F8,CF,00,00,00,C0,00,F8,08,F0,08,78,00,6E,00,55,30,06,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,C0,C0,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,
                        00,00,01,01,03,03,06,07,06,07,3F,3F,7F,7F,C3,FF,00,00,00,00,01,01,03,03,03,03,01,01,00,3E,00,76,
                        00,00,8F,FF,BA,F7,7D,8F,BB,47,C7,BF,B5,FB,F3,FD,00,00,F8,F8,F4,FD,8E,FE,47,BF,BF,FF,FB,FF,7D,7F,
                        00,00,E0,60,E0,40,60,60,80,00,E0,40,E0,E0,00,00,00,60,80,80,A0,20,60,80,80,60,A0,80,00,00,00,60,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        2F,3F,3E,3E,1C,1C,00,00,00,00,00,00,00,00,00,00,00,16,00,18,00,00,00,00,00,00,00,00,00,00,00,00,
                        10,1F,18,1F,1F,1F,0C,0F,0F,0F,0F,0F,0F,0F,1F,1F,02,1C,00,1D,00,0A,00,09,00,03,00,08,00,0F,00,07,
                        FC,FF,FF,FF,3F,FF,B1,D1,D3,D3,F7,F7,FC,FF,F8,9F,00,0F,C0,CF,E0,E0,60,40,80,A1,80,83,00,07,00,0C,
                        C0,C0,C0,C0,F8,F8,FE,FE,9C,FE,0C,FC,98,FC,78,F8,00,80,00,00,00,08,00,72,00,D2,40,14,00,AC,00,E8,
                        8F,FF,93,FF,91,FF,9F,FF,F7,F0,DF,97,7F,7F,30,3F,00,CF,00,DF,00,D7,00,F0,07,09,58,20,00,0D,00,19,
                        FF,FF,FF,FF,FF,FF,FF,F7,ED,73,FD,FF,FB,F9,FF,FB,3F,3F,00,00,28,A8,27,2F,B3,BF,3F,3F,32,34,04,80,
}


;;; $B620: Samus top tiles - set 1 - entry Dh ;;;
{
; 9: Moving right - not aiming - frame 1
; |--------|--------|--------|--------|
; |F3BBAABA|BA3F    |        |        |
; |F33333BB|BBF3    |     FFF|EE      |
; |F3DD5878|5DFE33  |   FFEF6|9EE     |
; |F3D33333|33F33D3 |  FFEEFE|EFFE    |
; |53333BBB|3F33D583| 3FF3333|FE4F    |
; |8F3BBAAB|33D5375D| FF3A2AA|BF44    |
; |333BA62A|B3D583D3|3F3A62A2|2334    |
; | 33BA222|B33D5D33|F3BAA2B2|BA53    |
; |--------|--------|--------|--------|
; |   3BA2A|BB3DD33 |F3BBAABA|BA3F    |
; |    3BAB|B33333  |F33333BB|BBF3    |
; |     3BB|3AB3    |F3DD5878|5DFE33  |
; |      33|BBB     |F3D33333|33F33D3 |
; |        |        |53333BBB|3F33D583|
; |        |        |8F3BBAAB|33D5375D|
; |        |        |333BA62A|B3D583D3|
; |        |        | 33BA222|B33D5D33|
; |--------|--------|--------|--------|
$9E:B620             db F2,FF,FF,FF,FA,C2,FF,DF,FF,7F,79,7F,F0,FF,70,7F,80,BF,80,83,BA,B5,A0,A0,80,07,40,DF,04,19,00,18,
                        B0,F0,F0,F0,EC,3C,FE,FA,FD,F1,FF,CC,F7,C5,FF,E3,10,D0,20,E0,F0,70,24,24,4C,4A,37,21,32,AA,1C,94,
                        00,00,07,07,1A,1F,32,3F,7F,7F,70,7F,E0,FF,E2,FF,00,00,07,07,1F,1E,3F,3F,30,30,60,6B,48,52,80,BA,
                        00,00,00,C0,80,60,60,F0,90,D0,C0,C0,60,E0,B0,D0,00,00,C0,C0,60,E0,F0,F0,F0,D0,70,C0,10,00,20,C0,
                        18,1F,0D,0F,07,07,03,03,00,00,00,00,00,00,00,00,00,0D,00,07,00,03,00,00,00,00,00,00,00,00,00,00,
                        FE,E6,FC,FC,B0,F0,E0,E0,00,00,00,00,00,00,00,00,18,D8,00,80,00,60,00,E0,00,00,00,00,00,00,00,00,
                        F2,FF,FF,FF,FA,C2,FF,DF,FF,7F,79,7F,F0,FF,70,7F,80,BF,80,83,BA,B5,A0,A0,80,07,40,DF,04,19,00,18,
                        B0,F0,F0,F0,EC,3C,FE,FA,FD,F1,FF,CC,F7,C5,FF,E3,10,D0,20,E0,F0,70,24,24,4C,4A,37,21,32,AA,1C,94,
}


;;; $B720: Samus top tiles - set 1 - entry Eh ;;;
{
; 9: Moving right - not aiming - frame 6
; |--------|--------|--------|--------|
; |333BBBBA|AB3F3F  |        |        |
; |3DD5785B|BB3FE3  |       F|FFEE    |
; |33333D55|B33FEE  |     FFE|F69EE   |
; |3BBBB333|333FFE  |   33333|FEEFFE  |
; |BBAAABB3|3333F3  |  3BBBBB|3FEF4F  |
; |BA622B33|311333B3| 3B2A2AA|B3F344  |
; |BA22AB33|11C133AB| BAB6AB2|AB3834  |
; |BA22A333|31C13B2A| BABAB22|AB3353B |
; |--------|--------|--------|--------|
; |3BAAB333|31113BB3|333BBBBA|AB3F3F  |
; |333333D3|3333333 |3DD5785B|BB3FE3  |
; |BAB33D5D|D33     |33333D55|B33FEE  |
; | BB3D585|5D33    |3BBBB333|333FFE  |
; |  33DD58|83DD3   |BBAAABB3|3333F3  |
; |    3DD5|3853D3  |BA622B33|311333B3|
; |     33D|D538D3  |BA22AB33|11C133AB|
; |       3|3DD53   |BA22A333|31C13B2A|
; |--------|--------|--------|--------|
$9E:B720             db FE,FF,FB,89,FF,F8,FF,FF,C7,FF,87,FF,87,FF,87,FF,00,1F,7A,65,07,04,00,78,00,FE,20,C4,00,CC,00,C8,
                        7C,FC,F4,FC,F0,FC,F8,FC,FC,FC,FF,9F,DD,0F,DC,8F,14,D4,18,D8,1C,9C,1C,1C,08,08,00,02,20,23,20,25,
                        00,00,01,01,06,07,1F,1F,3F,3F,60,7F,52,7F,54,7F,00,00,01,01,07,07,00,00,00,1F,00,2B,08,76,00,7C,
                        00,00,C0,F0,A0,D8,98,FC,D4,F4,F0,F0,68,E8,7E,F6,00,00,F0,F0,D8,B8,FC,FC,7C,74,2C,A0,04,D0,08,C2,
                        CF,FF,FF,FD,BF,F8,7D,70,3E,30,0F,08,07,06,01,01,00,78,02,02,07,E5,0D,6A,0E,0D,07,06,01,01,00,00,
                        FF,8F,FE,FE,E0,60,F0,30,78,48,BC,94,EC,24,F8,88,00,06,00,00,80,80,C0,40,30,B0,28,48,C8,98,70,60,
                        FE,FF,FB,89,FF,F8,FF,FF,C7,FF,87,FF,87,FF,87,FF,00,1F,7A,65,07,04,00,78,00,FE,20,C4,00,CC,00,C8,
                        7C,FC,F4,FC,F0,FC,F8,FC,FC,FC,FF,9F,DD,0F,DC,8F,14,D4,18,D8,1C,9C,1C,1C,08,08,00,02,20,23,20,25,
}


;;; $B820: Samus top tiles - set 1 - entry Fh ;;;
{
; Ah: Moving left  - not aiming - frame 1
; |--------|--------|--------|--------|
; |    F3AA|BABABB3F|        |        |
; |    3EBB|BB333B3F|      EE|FFF     |
; |    EF3D|5785D33F|     EE9|6FEFF   |
; |    FF33|3333DD3F|    EFFE|FFFFFF  |
; |B2B33FF3|BBB333FF|    F4EF|BBB33FB |
; |A2A33333|BA2B33F5|    44FA|A6AA33FB|
; |BA3BB33B|A262B333|    43B2|A2A2A3FB|
; |33B2AB3A|A22AB3  |    35A2|B2B2AB3F|
; |--------|--------|--------|--------|
; | 3B26A3B|A2AB3   |    F3AA|BABABB3F|
; |  BAAA33|BAB3    |    3EBB|BB333B3F|
; |   BAB3A|3B3     |    EF3D|5785D33F|
; |    B3BB|3       |    FF33|3333DD3F|
; |        |        |B2B33FF3|BBB333FF|
; |        |        |A2A33333|BA2B33F5|
; |        |        |BA3BB33B|A262B333|
; |        |        |33B2AB3A|A22AB3  |
; |--------|--------|--------|--------|
$9E:B820             db 0C,0F,0B,0F,07,0E,0F,0F,BF,FF,1F,FF,BF,FF,E6,FF,08,0B,04,07,0D,0D,0C,0C,06,A6,00,A0,00,D9,00,2D,
                        AF,FF,FF,FF,DF,47,FF,F3,FF,FF,9F,FE,0F,FF,0C,FC,01,FD,01,C5,D9,29,0D,0D,03,E3,03,D2,20,88,00,98,
                        00,00,00,03,01,06,06,0F,09,0B,02,03,06,07,0C,0B,00,00,03,03,06,07,0F,0F,0F,0B,0E,03,08,02,04,02,
                        00,00,E0,E0,58,F8,FC,FC,FE,FE,0F,FF,07,FF,A7,FF,00,00,E0,E0,F8,78,FC,FC,04,E6,42,B3,02,AB,01,AD,
                        63,7F,23,3F,16,1F,0F,0F,00,00,00,00,00,00,00,00,08,25,00,3C,00,1D,00,0B,00,00,00,00,00,00,00,00,
                        18,F8,B0,F0,E0,E0,80,80,00,00,00,00,00,00,00,00,00,B0,00,E0,00,40,00,00,00,00,00,00,00,00,00,00,
                        0C,0F,0B,0F,07,0E,0F,0F,BF,FF,1F,FF,BF,FF,E6,FF,08,0B,04,07,0D,0D,0C,0C,06,A6,00,A0,00,D9,00,2D,
                        AF,FF,FF,FF,DF,47,FF,F3,FF,FF,9F,FE,0F,FF,0C,FC,01,FD,01,C5,D9,29,0D,0D,03,E3,03,D2,20,88,00,98,
}


;;; $B920: Samus top tiles - set 1 - entry 10h ;;;
{
; Ah: Moving left  - not aiming - frame 6
; |--------|--------|--------|--------|
; | BF3F3BA|ABBB55DF|        |        |
; |  3EF3BB|AB87333F|    EEFF|F       |
; |  EEF3BB|B7D33B3F|   EE96F|EFF     |
; |  EFE33B|D333BAB3|  EFFEEF|F333    |
; |  3EFF33|3BBA2AAB|  F4FFEF|3BBBB   |
; | 33FF311|33BAA26A|  443FFB|BABAAB  |
; |838F31CC|133BA22A|  438FBA|2B2B2AB |
; |535333C3|333BBAAB|  353FBA|22BABBB |
; |--------|--------|--------|--------|
; |535D3333|33B3BAB3| BF3F3BA|ABBB55DF|
; |D3DDD333|BBAB333B|  3EF3BB|AB87333F|
; |3333333B|A22A3B2A|  EEF3BB|B7D33B3F|
; |   3B23A|262A3BAB|  EFE33B|D333BAB3|
; |   3AAA3|AAB33   |  3EFF33|3BBA2AAB|
; |   3BAB3|333     | 33FF311|33BAA26A|
; |    333 |        |838F31CC|133BA22A|
; |        |        |535333C3|333BBAAB|
; |--------|--------|--------|--------|
$9E:B920             db 7E,7F,2F,3F,0F,3F,17,3F,2F,3F,7F,7C,5C,58,FD,5D,28,6B,18,1B,38,3B,38,39,1C,1C,18,18,13,B3,A2,02,
                        7F,F1,5F,DF,FF,DF,FB,7F,E1,FF,E0,FF,F0,7F,F9,FF,0F,F3,11,E1,61,A5,80,8E,00,77,02,39,00,19,00,1F,
                        00,00,03,0F,05,1B,19,3F,2D,2F,0F,0F,16,17,3E,2F,00,00,0F,0F,1B,1D,3F,3F,3F,2F,36,07,24,0F,14,07,
                        00,00,80,80,60,E0,F0,F0,F8,F8,A4,FC,52,FE,2E,FE,00,00,80,80,E0,E0,80,80,00,78,00,FC,00,56,00,3E,
                        FF,4F,FF,47,FF,FF,1A,1F,11,1F,1B,1F,0E,0E,00,00,B0,10,B8,B8,00,01,00,09,00,0E,00,0E,00,00,00,00,
                        FB,FF,DF,FF,0C,FF,0D,FF,38,F8,E0,E0,00,00,00,00,00,2E,00,F1,00,95,40,17,00,E0,00,00,00,00,00,00,
                        7E,7F,2F,3F,0F,3F,17,3F,2F,3F,7F,7C,5C,58,FD,5D,28,6B,18,1B,38,3B,38,39,1C,1C,18,18,13,B3,A2,02,
                        7F,F1,5F,DF,FF,DF,FB,7F,E1,FF,E0,FF,F0,7F,F9,FF,0F,F3,11,E1,61,A5,80,8E,00,77,02,39,00,19,00,1F,
}


;;; $BA20: Samus top tiles - set 1 - entry 11h ;;;
{
; 0: Facing forward - power suit - frame 0
; |--------|--------|--------|--------|
; | FEEEF  |        |        | FEEEF  |
; |FE9E9EF |        |        |FE9E9EF |
; |FFE6EFF3| 3333   |  3333 3|FFE6EFF3|
; |F4E9E4F9|3BBBB3  | 3BBBB39|F4E9E4F9|
; |F44E44FE|BA2B2AB |BA2B2ABE|F44E44FE|
; |8F444F8F|BBBBBAB |BABBBBBF|8F444F8F|
; |37F4F733|BA2ABB3 |3BBA2AB3|37F4F733|
; |F3F5F3F3|BAAAB33 |33BAAAB3|F3F5F3F3|
; |--------|--------|--------|--------|
; |EF333FEF|BABB353 |353BBABF|EF333FEF|
; |EF9E9FFE|3B3D58D |D85D3B3F|EF9E9FFE|
; |99FEFF4F|F333333 |333333FF|99FEFF4F|
; |E99FF44F|33BBBB  | BBBB33F|E99FF44F|
; |FEEFE4F3|33BABA  | ABAB333|FEEFE4F3|
; |33FFF331|33BABA  | ABAB331|33FFF331|
; |C33333C3|33A2BB  | BB2A333|C33333C3|
; |31C2C133|  BAB3  | 3BAB3 3|31C2C133|
; |--------|--------|--------|--------|
$9E:BA20             db 44,7C,AA,D6,C7,FF,93,AA,82,93,45,45,EF,EF,FF,EF,7C,7C,D6,FE,FE,EE,EE,BB,FF,93,7D,C7,7C,28,BA,AA,
                        00,00,00,00,78,78,FC,FC,92,FE,FA,FE,8E,FE,8E,FE,00,00,00,00,00,00,00,78,00,D6,00,FE,00,DC,00,F8,
                        00,00,00,00,3D,3D,7F,7E,92,FF,BF,FF,E3,FF,E3,FF,00,00,00,00,00,00,00,3D,01,D7,01,FF,00,76,00,3E,
                        44,7C,AA,D6,C7,FF,93,AA,82,93,45,45,EF,EF,FF,EF,7C,7C,D6,FE,FE,EE,EE,BB,FF,93,7D,C7,7C,28,BA,AA,
                        7D,FF,6E,D7,ED,3D,79,99,93,FB,FF,FE,7D,7D,C7,93,C7,C7,D7,FF,3F,FD,9F,F9,FE,FA,38,38,82,82,28,28,
                        BE,FA,FA,E0,FE,FE,FC,FC,E8,FC,E8,FC,CC,FC,2C,3C,04,F0,1A,56,80,80,00,3C,00,3C,00,3C,00,2C,00,38,
                        FB,BF,BF,0F,FF,FF,7F,7F,2F,7F,2F,7E,67,7F,6D,7D,41,1F,B1,D5,03,03,01,79,00,78,00,78,00,68,00,38,
                        7D,FF,6E,D7,ED,3D,79,99,93,FB,FF,FE,7D,7D,C7,93,C7,C7,D7,FF,3F,FD,9F,F9,FE,FA,38,38,82,82,28,28,
}


;;; $BB20: Samus top tiles - set 1 - entry 12h ;;;
{
; 65h: Unused - frame 0
; 83h: Facing right - wall jump - frame 0
; |--------|--------|--------|--------|
; |        |        |        |        |
; |        |        |        |        |
; |        |        |        |        |
; |        |        |        |        |
; |        |        |        |        |
; |        |  F333FF|  F333FF|F       |
; |        |F33BABB3|F33BABB3|FEF     |
; |      3F|3BAA2BAB|3BAA2BAB|3EFF    |
; |--------|--------|--------|--------|
; |    B33F|3AB2BA2A|3AB2BA2A|3E9E    |
; |   B3353|DBA2B62A|DBA2B62A|3F99    |
; |  333573|DDBBA2AB|DDBBA2AB|34A6    |
; |  BB3333|358BBABA|358BBABA|34AE    |
; |  3B3333|33575BAB|33575BAB|344B    |
; |  33C3BB|B33575B3|B33575B3|734     |
; |  3133A2|AB333333|AB333333|3EB     |
; | 3333BA6|2AB33FFE|2AB33FFE|33      |
; |--------|--------|--------|--------|
$9E:BB20             db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,01,
                        00,00,00,00,00,00,00,00,00,00,3F,3F,F7,FF,C5,FF,00,00,00,00,00,00,00,00,00,00,23,23,80,9E,00,77,
                        00,00,00,00,00,00,00,00,00,00,3F,3F,F7,FF,C5,FF,00,00,00,00,00,00,00,00,00,00,23,23,80,9E,00,77,
                        00,00,00,00,00,00,00,00,00,00,80,80,A0,E0,B0,F0,00,00,00,00,00,00,00,00,00,00,80,80,E0,E0,70,70,
                        0F,0F,1F,1D,3F,3B,3F,3F,3F,3F,37,37,3C,2F,7C,7F,01,09,02,10,06,00,00,30,00,10,08,0B,00,02,01,06,
                        A8,FF,C8,7F,F1,3F,DA,9F,FD,D7,FF,EB,7F,FF,3E,FF,00,6D,84,E9,C0,FB,40,3F,38,07,1C,82,00,C0,07,67,
                        A8,FF,C8,7F,F1,3F,DA,9F,FD,D7,FF,EB,7F,FF,3E,FF,00,6D,84,E9,C0,FB,40,3F,38,07,1C,82,00,C0,07,67,
                        A0,D0,F0,C0,80,B0,80,B0,90,90,C0,C0,A0,E0,C0,C0,50,70,40,70,50,20,50,30,60,10,A0,00,40,60,00,00,
}


;;; $BC20: Samus top tiles - set 1 - entry 13h ;;;
{
; 66h: Unused - frame 0
; 84h: Facing left  - wall jump - frame 0
; |--------|--------|--------|--------|
; |        |        |        |        |
; |        |        |        |        |
; |        |        |        |        |
; |        |        |        |        |
; |        |        |        |        |
; |        |  F333FF|  F333FF|F       |
; |        |F33BABB3|F33BABB3|FEF     |
; |      3F|3BAA2BAB|3BAA2BAB|3EFF    |
; |--------|--------|--------|--------|
; |    B33F|3AB2BA2A|3AB2BA2A|3E9E    |
; |   B3353|DBA2B62A|DBA2B62A|3F99    |
; |  333573|DDBBA2AB|DDBBA2AB|34A6    |
; |  BB3333|358BBABA|358BBABA|34AE    |
; |  3B3333|33575BAB|33575BAB|344B    |
; |  33C3BB|B33575B3|B33575B3|734     |
; |  3133A2|AB333333|AB333333|3EB     |
; | 3333BA6|2AB33FFE|2AB33FFE|33      |
; |--------|--------|--------|--------|
$9E:BC20             db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,01,
                        00,00,00,00,00,00,00,00,00,00,3F,3F,F7,FF,C5,FF,00,00,00,00,00,00,00,00,00,00,23,23,80,9E,00,77,
                        00,00,00,00,00,00,00,00,00,00,3F,3F,F7,FF,C5,FF,00,00,00,00,00,00,00,00,00,00,23,23,80,9E,00,77,
                        00,00,00,00,00,00,00,00,00,00,80,80,A0,E0,B0,F0,00,00,00,00,00,00,00,00,00,00,80,80,E0,E0,70,70,
                        0F,0F,1F,1D,3F,3B,3F,3F,3F,3F,37,37,3C,2F,7C,7F,01,09,02,10,06,00,00,30,00,10,08,0B,00,02,01,06,
                        A8,FF,C8,7F,F1,3F,DA,9F,FD,D7,FF,EB,7F,FF,3E,FF,00,6D,84,E9,C0,FB,40,3F,38,07,1C,82,00,C0,07,67,
                        A8,FF,C8,7F,F1,3F,DA,9F,FD,D7,FF,EB,7F,FF,3E,FF,00,6D,84,E9,C0,FB,40,3F,38,07,1C,82,00,C0,07,67,
                        A0,D0,F0,C0,80,B0,80,B0,90,90,C0,C0,A0,E0,C0,C0,50,70,40,70,50,20,50,30,60,10,A0,00,40,60,00,00,
}


;;; $BD20: Samus top tiles - set 1 - entry 14h ;;;
{
; 63h: Unused - frame 0
; C9h: Facing right - shinespark - horizontal - frame 0
; CDh: Facing right - shinespark - diagonal - frame 0
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | BBA3899|43FFF33B|BB333   |        |        |      33|    3   |   33   |
; |3A2AB844|3F333333|AAB33333|3       |        |    33BB|    3D  |  3DD3  |
; |3A22B343|F733FF33|BBA35BBB|33      |        | 3333BBB|    53  | 3D75D3 |
; |BAAAB383|7333EF33|22B383BA|BB3     |      3F|33FF3BBA|    3D3 |3D5875D3|
; |3BB33333|33FF9EF3|BBA373B2|2A33    |     3F3|FFEF3BAB|33D3853 |33D5875D|
; |8778533F|3FFEEF33|6AB373BA|AB3B3   |    3F3F|E9F33BB2|  3D53  | 33D5873|
; |5333333F|333FE331|2B378333|333BB   |  3333FF|39393BAA|   33   |  33D533|
; |3BBBB333|3BA33311|B33833  |33AAB3  | 3BB3FE9|F33EF3BB|        |   33338|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 3AABB33|BA2A3111|B3533   | 3B2AB  | BBA3899|43FFF33B|
; | 3A2AB3B|3BA33333|333     |  3BAB3 |3A2AB844|3F333333|
; | 3BAB3BA|B33B3311|3       |   3333 |3A22B343|F733FF33|
; |  B3BAAB|B33AB331|        |   3B2AB|BAAAB383|7333EF33|
; |  3BA2AB|3BA2AB33|3       |   3BAA3|3BB33333|33FF9EF3|
; |  B3BAB3|3B2AB313|33333   |    3B3 |8778533F|3FFEEF33|
; |  3A3B33|BBAB3113|33BBB3  |        |5333333F|333FE331|
; |   3333B|2BB31133|3BAAAB3 |        |3BBBB333|3BA33311|
; |--------|--------|--------|--------|--------|--------|
$9E:BD20             db 6B,78,88,F8,8D,FD,8D,FD,FF,FF,6F,67,FF,7F,FF,FF,00,77,03,5C,02,48,00,FA,00,60,69,91,81,01,00,78,
                        7F,7F,FF,FF,FF,FF,F7,FF,FB,F7,E7,FF,F7,FE,DF,FC,B8,39,40,40,CC,8C,8C,0C,36,3E,7C,7C,18,18,00,60,
                        F8,F8,3F,FF,DF,F7,36,F7,DE,FF,3E,FF,77,F7,EC,EC,00,C0,00,E0,08,E7,00,2B,08,E2,88,63,10,48,00,90,
                        00,00,80,80,C0,C0,E0,E0,30,F0,78,F8,F8,F8,CC,FC,00,00,00,00,00,00,00,C0,00,40,00,D0,00,18,00,38,
                        00,00,00,00,00,00,03,03,07,07,0F,0F,3F,3F,7D,7E,00,00,00,00,00,00,01,01,02,02,05,05,03,03,06,37,
                        03,03,0F,0F,7F,7F,FE,FF,DD,FF,7E,BF,FC,AF,EF,FF,00,00,00,03,00,07,30,37,F0,F7,A0,E6,00,57,98,9B,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        4F,7F,47,7F,6E,7F,39,3F,31,3F,3B,3F,2F,3F,1F,1F,00,3C,00,2D,00,3B,00,2F,00,1B,00,2E,00,14,00,01,
                        8F,F8,DF,FF,FF,FC,EF,FE,C7,FF,CF,FD,DF,F9,7F,F3,00,D0,00,60,00,90,00,98,00,6C,00,58,00,F0,00,60,
                        F8,D8,E0,E0,80,80,00,00,80,80,F8,F8,FC,FC,C6,FE,20,80,00,00,00,00,00,00,00,00,00,00,00,38,00,7C,
                        64,7C,36,3E,1E,1E,19,1F,19,1F,0E,0E,00,00,00,00,00,2C,00,1C,00,00,00,0B,00,0E,00,04,00,00,00,00,
                        6B,78,88,F8,8D,FD,8D,FD,FF,FF,6F,67,FF,7F,FF,FF,00,77,03,5C,02,48,00,FA,00,60,69,91,81,01,00,78,
                        7F,7F,FF,FF,FF,FF,F7,FF,FB,F7,E7,FF,F7,FE,DF,FC,B8,39,40,40,CC,8C,8C,0C,36,3E,7C,7C,18,18,00,60,
}


;;; $BEE0: Samus top tiles - set 1 - entry 15h ;;;
{
; 64h: Unused - frame 0
; CAh: Facing left  - shinespark - horizontal - frame 0
; CEh: Facing left  - shinespark - diagonal - frame 0
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | BBA3899|43FFF33B|BB333   |        |        |      33|        |833D3   |
; |3A2AB844|3F333333|AAB33333|3       |        |    33BB|   33   |3375D3  |
; |3A22B343|F733FF33|BBA35BBB|33      |        | 3333BBB|  35D3D |35875D3 |
; |BAAAB383|7333EF33|22B383BA|BB3     |      3F|33FF3BBA| 3583533|3D5875D3|
; |3BB33333|33FF9EF3|BBA373B2|2A33    |     3F3|FFEF3BAB| 3D3    |33D587D3|
; |8778533F|3FFEEF33|6AB373BA|AB3B3   |    3F3F|E9F33BB2|  3D    | 33D5D3 |
; |5333333F|333FE331|2B378333|333BB   |  3333FF|39393BAA|   3    |  33D3  |
; |3BBBB333|3BA33311|B33833  |33AAB3  | 3BB3FE9|F33EF3BB|   3    |   33   |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 3AABB33|BA2A3111|B3533   | 3B2AB  | BBA3899|43FFF33B|
; | 3A2AB3B|3BA33333|333     |  3BAB3 |3A2AB844|3F333333|
; | 3BAB3BA|B33B3311|3       |   3333 |3A22B343|F733FF33|
; |  B3BAAB|B33AB331|        |   3B2AB|BAAAB383|7333EF33|
; |  3BA2AB|3BA2AB33|3       |   3BAA3|3BB33333|33FF9EF3|
; |  B3BAB3|3B2AB313|33333   |    3B3 |8778533F|3FFEEF33|
; |  3A3B33|BBAB3113|33BBB3  |        |5333333F|333FE331|
; |   3333B|2BB31133|3BAAAB3 |        |3BBBB333|3BA33311|
; |--------|--------|--------|--------|--------|--------|
$9E:BEE0             db 6B,78,88,F8,8D,FD,8D,FD,FF,FF,6F,67,FF,7F,FF,FF,00,77,03,5C,02,48,00,FA,00,60,69,91,81,01,00,78,
                        7F,7F,FF,FF,FF,FF,F7,FF,FB,F7,E7,FF,F7,FE,DF,FC,B8,39,40,40,CC,8C,8C,0C,36,3E,7C,7C,18,18,00,60,
                        F8,F8,3F,FF,DF,F7,36,F7,DE,FF,3E,FF,77,F7,EC,EC,00,C0,00,E0,08,E7,00,2B,08,E2,88,63,10,48,00,90,
                        00,00,80,80,C0,C0,E0,E0,30,F0,78,F8,F8,F8,CC,FC,00,00,00,00,00,00,00,C0,00,40,00,D0,00,18,00,38,
                        00,00,00,00,00,00,03,03,07,07,0F,0F,3F,3F,7D,7E,00,00,00,00,00,00,01,01,02,02,05,05,03,03,06,37,
                        03,03,0F,0F,7F,7F,FE,FF,DD,FF,7E,BF,FC,AF,EF,FF,00,00,00,03,00,07,30,37,F0,F7,A0,E6,00,57,98,9B,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        4F,7F,47,7F,6E,7F,39,3F,31,3F,3B,3F,2F,3F,1F,1F,00,3C,00,2D,00,3B,00,2F,00,1B,00,2E,00,14,00,01,
                        8F,F8,DF,FF,FF,FC,EF,FE,C7,FF,CF,FD,DF,F9,7F,F3,00,D0,00,60,00,90,00,98,00,6C,00,58,00,F0,00,60,
                        F8,D8,E0,E0,80,80,00,00,80,80,F8,F8,FC,FC,C6,FE,20,80,00,00,00,00,00,00,00,00,00,00,00,38,00,7C,
                        64,7C,36,3E,1E,1E,19,1F,19,1F,0E,0E,00,00,00,00,00,2C,00,1C,00,00,00,0B,00,0E,00,04,00,00,00,00,
                        6B,78,88,F8,8D,FD,8D,FD,FF,FF,6F,67,FF,7F,FF,FF,00,77,03,5C,02,48,00,FA,00,60,69,91,81,01,00,78,
                        7F,7F,FF,FF,FF,FF,F7,FF,FB,F7,E7,FF,F7,FE,DF,FC,B8,39,40,40,CC,8C,8C,0C,36,3E,7C,7C,18,18,00,60,
}


;;; $C0A0: Samus top tiles - set 1 - entry 16h ;;;
{
; Unused
; |--------|
; |111     |
; |1       |
; |111     |
; |1   111 |
; |111 1  1|
; |    111 |
; |    1   |
; |    1   |
; |--------|
$9E:C0A0             db E0,00,80,00,E0,00,8E,00,E9,00,0E,00,08,00,08,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $C0C0: Samus top tiles - set 1 - entry 17h ;;;
{
; Unused
; |--------|
; |111     |
; |1       |
; |111     |
; |1   111 |
; |111 1  1|
; |    111 |
; |    1   |
; |    1   |
; |--------|
$9E:C0C0             db E0,00,80,00,E0,00,8E,00,E9,00,0E,00,08,00,08,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $C0E0: Samus top tiles - set 1 - entry 18h ;;;
{
; 8Dh: Facing right - turning - standing - aiming down-right - frame 2
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 0
; 91h: Facing right - turning - in air - aiming down/down-right - frame 2
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 0
; 95h: Facing right - turning - falling - aiming down/down-right - frame 2
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 0
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 2
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 0
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 2
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 0
; |--------|--------|--------|--------|--------|--------|--------|
; |       B|3F49E44E|  D585D3|        |        |33BBBB3 |3BAA2B  |
; |      BA|3E4E443E|  D575D3|        |        |3BA62A3 |BBBAA2B |
; |     B2A|3E3443FF|  D575D3|        |        |3A222B3 |BAA62A2B|
; |     B2A|38F43F83|  D333D3|        |        |3BA2AB  |B2BAAB2B|
; |     BA3|338E3833|  357533|        |        |B3BAB3  |A22BAB2B|
; |     BB3|FF333FFF|  D333D3|        |   FFFFF|AB333   |A2ABBBBB|
; |      53|EFEEF993|   D8533|F       |  FEF9EF|3BAB3   |BBBBD75D|
; |      33|E9FF99E3|   333D |F3BBB   | FE96FEF|33B3    |3333333 |
; |--------|--------|--------|--------|--------|--------|--------|
; |      33|3EF99E33|
; |      AA|33FE333F|
; |      2B|BA333333|
; |      2B|A22BBBBB|
; |      2B|A2B3A22A|
; |      AA|BA3BAA22|
; |      3D|5D33BAAB|
; |      D5|85D33333|
; |--------|--------|
$9E:C0E0             db 01,01,02,03,04,07,04,07,05,07,07,07,03,01,03,03,00,01,00,03,00,05,00,05,00,06,00,06,02,00,00,00,
                        D0,C9,82,D3,A7,E7,AD,AD,CB,DB,FF,FF,4F,F9,7D,B3,6F,59,7D,51,5B,43,34,66,10,34,C7,C7,F8,FE,B2,FE,
                        37,01,3F,09,3F,09,3F,1D,3F,2B,3F,1D,17,03,1E,1C,36,2A,3E,22,3E,22,22,22,1C,00,22,22,14,18,02,02,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,F8,F8,00,00,00,00,00,00,00,00,00,00,00,00,80,80,80,B8,
                        00,00,00,00,00,00,00,00,00,00,1F,1F,2D,3B,55,6F,00,00,00,00,00,00,00,00,00,00,1F,1F,3B,3F,6F,77,
                        FE,FE,C2,FE,86,FE,C4,FC,EC,FC,78,F8,D8,F8,F0,F0,00,3C,10,64,00,44,00,6C,00,B8,00,C0,00,70,00,20,
                        C4,FC,E2,FE,81,FF,A5,FF,15,FF,1F,FF,FF,F4,FE,FE,00,74,00,FA,10,E5,00,BD,00,9D,00,BF,0F,F9,00,00,
                        03,03,00,03,01,03,01,03,01,03,00,03,03,02,03,00,00,00,00,03,00,01,00,01,00,01,00,03,01,01,03,02,
                        BB,E7,EF,FF,BF,FF,1F,FF,30,FF,B0,FF,F9,3F,7F,1F,64,7C,31,31,00,C0,00,9F,00,A9,00,DC,C0,4F,60,A0,
}


;;; $C200: Samus top tiles - set 1 - entry 19h ;;;
{
; 8Dh: Facing right - turning - standing - aiming down-right - frame 0
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 2
; 91h: Facing right - turning - in air - aiming down/down-right - frame 0
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 2
; 95h: Facing right - turning - falling - aiming down/down-right - frame 0
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 2
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 0
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 2
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 0
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 2
; |--------|--------|--------|--------|--------|--------|--------|
; |23FE44E9|4F3AB   |  D585D3|        |        |    3BBB|    BBA2|
; |BB3E344E|4E32AB  |  D575D3|        |        |    3A22|    BAAA|
; |2ADFF344|DE326B  |  D575D3|        |        |    3BA6|   BAAB2|
; |B2A38F34|F83A2B  |  D333D3|        |        |     BA2|   BABAA|
; |2223383E|8333AB  |  357533|        |        |     3AA|   BABAB|
; |A2DDFF33|3FF3BB  |  D333D3|        |   FFFFF|     3BA|   BBBBB|
; |BBB3EEFE|EFE378  |   D8533|F       |  FEF9EF|     33D|   D57DB|
; |3333E9EF|F9F33B  |   333D |F3BBB   | FE96FEF|     3D5|    3333|
; |--------|--------|--------|--------|--------|--------|--------|
; |B3333EEE|FF33BB  |
; |AB3B3333|FBB33B  |
; |2333333B|AAABAB  |
; |3AAA3BAA|222BA2  |
; |3A2A3A2A|AAABB3  |
; |3BAB3B13|3333B   |
; |5D331111|13      |
; |85D3CCC1|1       |
; |--------|--------|
$9E:C200             db 61,F2,E8,F9,3C,DC,96,F6,1A,FB,3F,CF,F2,FF,F5,FB,3E,33,17,D1,3B,78,05,AC,01,05,3C,BC,0F,EF,0B,0F,
                        68,78,24,7C,A4,7C,A4,BC,74,7C,FC,FC,58,F8,FC,BC,C0,58,C0,4C,C8,C4,80,D4,00,8C,60,6C,E8,E4,A0,E4,
                        37,01,3F,09,3F,09,3F,1D,3F,2B,3F,1D,17,03,1E,1C,36,2A,3E,22,3E,22,22,22,1C,00,22,22,14,18,02,02,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,F8,F8,00,00,00,00,00,00,00,00,00,00,00,00,80,80,80,B8,
                        00,00,00,00,00,00,00,00,00,00,1F,1F,2D,3B,55,6F,00,00,00,00,00,00,00,00,00,00,1F,1F,3B,3F,6F,77,
                        0F,0F,08,0F,0C,0F,04,07,04,07,06,07,07,06,07,04,00,07,00,04,01,06,00,06,00,03,00,03,01,01,03,02,
                        0C,0F,08,0F,12,1F,14,1F,15,1F,1F,1F,1F,05,0F,0F,00,0E,00,0F,00,1E,00,1F,00,1F,00,1F,1E,13,00,00,
                        F8,FF,7F,FF,7F,FF,8C,FF,88,FF,DF,FD,FF,30,71,10,07,87,00,D0,00,01,00,77,00,55,00,74,C0,40,6E,AE,
                        FC,FC,FC,FC,14,FC,10,FC,1C,FC,F8,F8,C0,40,80,00,C0,CC,80,E4,00,FC,00,18,00,F8,00,08,00,00,00,00,
}


;;; $C320: Samus top tiles - set 1 - entry 1Ah ;;;
{
; 17h: Facing right - normal jump - aiming down - frame 1
; 2Dh: Facing right - falling - aiming down - frame 1
; AEh: Unused. Facing right - grappling - in air - aiming down - frame 1
; |--------|--------|--------|--------|--------|--------|
; |        |        |FF33333B|AAB33FFF| 333333 |        |
; |        |        |33EF33B2|6ABAB39F| D575D3 |        |
; |        |        |8DFF3BA2|BA2AB3FF| D585D3 |        |
; |        |        |D3FF33A2|BABAAB43| D585D3 |        |
; |   3F333|333     |313F333A|BABAAB4 | D585D3 |  3333  |
; |  3FFFFE|FEEFF   |1C113DD3|3BBBBB3 | D585D3 | 3D85D3 |
; | F3EE3FF|FFF9EF  |1CC133DD|58785DF | D585D3 | 333333 |
; |FEF33F33|3333E6F |33313333|33333B3B| 333333 | D575D3 |
; |--------|--------|--------|--------|--------|--------|
; |FF33333B|AAB33FFF|     33B|BA2A333A|
; |33EF33B2|6ABAB39F|      3B|BAA3AB32|
; |8DFF3BA2|BA2AB3FF|      3B|BA32AB3A|
; |D3FF33A2|BABAAB43|      3B|BA3AAB33|
; |313F333A|BABAAB4 |       3|BA333333|
; |1C113DD3|3BBBBB3 |       3|BBAAB3  |
; |1CC133DD|58785DF |       3|BBAAB3  |
; |33313333|33333B3B|       3|BBBBB3  |
; |--------|--------|--------|--------|
$9E:C320             db 00,00,00,00,00,00,00,00,1F,1F,3E,3F,67,7F,BF,FF,00,00,00,00,00,00,00,00,08,08,1F,1F,5B,5B,E4,E4,
                        00,00,00,00,00,00,00,00,E0,E0,98,F8,F4,EC,F2,FE,00,00,00,00,00,00,00,00,00,00,F8,F8,EC,FC,0E,0A,
                        FF,FF,DE,FF,7C,3F,FC,7F,FE,BF,BF,09,9F,0C,FF,EF,C0,C1,30,32,70,F6,B0,B2,10,11,46,46,63,63,00,00,
                        3F,FF,2F,FD,8F,FF,A5,FD,A4,FC,FE,FE,AE,22,FF,FF,07,E7,81,7B,03,DB,02,FC,02,FC,00,7C,AE,56,00,05,
                        7E,7E,7E,12,6E,02,6E,02,6E,02,6E,02,6E,02,7E,7E,00,00,7C,44,6C,54,6C,54,6C,54,6C,54,6C,54,00,00,
                        00,00,00,00,00,00,00,00,3C,3C,6E,42,7E,7E,7E,12,00,00,00,00,00,00,00,00,00,00,2C,34,00,00,7C,44,
                        FF,FF,DE,FF,7C,3F,FC,7F,FE,BF,BF,09,9F,0C,FF,EF,C0,C1,30,32,70,F6,B0,B2,10,11,46,46,63,63,00,00,
                        3F,FF,2F,FD,8F,FF,A5,FD,A4,FC,FE,FE,AE,22,FF,FF,07,E7,81,7B,03,DB,02,FC,02,FC,00,7C,AE,56,00,05,
                        07,07,03,03,03,03,03,03,01,01,01,01,01,01,01,01,00,01,00,01,00,01,00,01,00,00,00,00,00,00,00,00,
                        8E,FF,96,FF,A6,FF,A7,FF,BF,FF,CC,FC,CC,FC,FC,FC,00,D1,00,EC,00,CD,00,DC,00,C0,00,F8,00,F8,00,F8,
}


;;; $C460: Samus top tiles - set 1 - entry 1Bh ;;;
{
; 18h: Facing left  - normal jump - aiming down - frame 1
; 2Eh: Facing left  - falling - aiming down - frame 1
; AFh: Unused. Facing left  - grappling - in air - aiming down - frame 1
; |--------|--------|--------|--------|--------|--------|
; |        |        |F9EF3AA2|B2BAB3FF| 333333 |        |
; |        |        |FFFF3AAA|BABAB3FF| D575D3 |        |
; |        |        |FF4F3BBB|B33333F8| D585D3 |        |
; |        |        |344FFD55|8785D3FD| D585D3 |        |
; |     333|333     | 4383333|33333333| D585D3 |  3333  |
; |   FFE3B|BAB3F   | 37333BB|A26AB313| D585D3 | 3D85D3 |
; |  FE93BA|B2AA3FF | F3AB3BB|A222ABC1| D585D3 | 333333 |
; | F6E33A2|A6BABEF | 3BAB33B|BA22AB33| 333333 | D575D3 |
; |--------|--------|--------|--------|--------|--------|
; |F9EF3AA2|B2BAB3FF|3B2B33B3|BA22A3  |
; |FFFF3AAA|BABAB3FF|B22ABABB|3BBAB3  |
; |FF4F3BBB|B33333F8|3A6AB222|B33B3   |
; |344FFD55|8785D3FD| BAB3A2A|3B233   |
; | 4383333|33333333| 33333AB|3AB3    |
; | 37333BB|A26AB313| 3BBBB33|333     |
; | F3AB3BB|A222ABC1| 3BBBB3 |        |
; | 3BAB33B|BA22AB33| 3BBBB3 |        |
; |--------|--------|--------|--------|
$9E:C460             db 00,00,00,00,00,00,00,00,07,07,1B,1F,2E,37,4C,7F,00,00,00,00,00,00,00,00,00,00,1C,1D,30,3B,70,52,
                        00,00,00,00,00,00,00,00,E0,E0,B8,F8,8E,FE,2A,FE,00,00,00,00,00,00,00,00,00,00,08,E8,06,B6,46,BE,
                        D8,BF,F8,FF,DF,DF,9F,98,2F,2F,7F,7F,6F,7F,6F,7F,B0,F6,F0,F7,F0,D7,7F,1C,40,10,20,03,40,5B,00,39,
                        AF,FF,AF,FF,FE,FE,5F,46,FF,FF,0F,FD,05,FC,87,FF,03,BB,03,FB,02,83,5B,AB,00,00,20,98,02,8E,00,CC,
                        7E,7E,7E,12,6E,02,6E,02,6E,02,6E,02,6E,02,7E,7E,00,00,7C,44,6C,54,6C,54,6C,54,6C,54,6C,54,00,00,
                        00,00,00,00,00,00,00,00,3C,3C,6E,42,7E,7E,7E,12,00,00,00,00,00,00,00,00,00,00,2C,34,00,00,7C,44,
                        D8,BF,F8,FF,DF,DF,9F,98,2F,2F,7F,7F,6F,7F,6F,7F,B0,F6,F0,F7,F0,D7,7F,1C,40,10,20,03,40,5B,00,39,
                        AF,FF,AF,FF,FE,FE,5F,46,FF,FF,0F,FD,05,FC,87,FF,03,BB,03,FB,02,83,5B,AB,00,00,20,98,02,8E,00,CC,
                        DF,FF,8B,FF,88,FF,58,7F,7D,7F,7F,7F,7E,7E,7E,7E,00,52,00,9F,20,58,00,75,00,03,00,3C,00,3C,00,3C,
                        84,FC,EC,FC,F8,F8,D8,F8,B0,F0,E0,E0,00,00,00,00,00,C8,00,78,00,90,00,40,00,60,00,00,00,00,00,00,
}


;;; $C5A0: Samus top tiles - set 1 - entry 1Ch ;;;
{
; 19h: Facing right - spin jump - frame Bh
; 1Bh: Facing right - space jump - frame Bh
; 81h: Facing right - screw attack - frame 1Bh
; |--------|--------|--------|--------|--------|--------|
; |        |     3BB|33      |        | B3AAA  |3BA2A3  |
; |        |    3BAA|BB3333  |        | 3B22B  |3B223   |
; |        |   33ABB|BAB3FFFF|3       |  3AB3  |33BB3   |
; |        | 33D3B22|ABA3EEEF|F3      |        |3B33    |
; |        |3B353ABB|BAB3F9EE|FF3     |        |BAAB    |
; |       B|BA373B26|2BA3F969|E9F33   |        |B22A    |
; |      BA|62385BA2|2AB3FE9E|FEF3B3  |        |3A2A    |
; |     B3B|AA3D8BBA|AB33F4F9|9FF3BB3 |        | 3A33   |
; |--------|--------|--------|--------|--------|--------|
; |    B333|33B3DDBB|B333344F|F43BABB |
; |    3558|35B333D3|33F37344|443A2BB |
; |   35873|8353 333|3FEF8334|433262B |
; |   35883|7353  33|FE6F3834|38BA2AB3|
; |   3D553|53D33 33|FEFEF33F|33AAB333|
; |   33DDD|3D33B333|3EF9E3F3|F3333853|
; |    3331|3BBBAB31|3FEF9EFE|F358733 |
; |    3B33|11BBAA33|13FEFFFF|333333  |
; |--------|--------|--------|--------|
$9E:C5A0             db 00,00,00,00,00,00,00,00,00,00,01,01,02,03,07,07,00,00,00,00,00,00,00,00,00,00,00,01,00,03,00,05,
                        07,07,0C,0F,1B,1F,7C,6F,FB,EF,BC,FF,2C,E7,36,E7,00,03,00,07,00,07,10,14,10,47,11,C4,88,16,10,DF,
                        C0,C0,FC,FC,BF,FF,51,FF,BC,FB,5D,FA,3A,FD,7B,FA,00,00,00,C0,0F,EF,0F,EF,0B,EF,0A,6D,0D,6F,0E,CB,
                        00,00,00,00,80,80,C0,C0,E0,E0,78,B8,BC,FC,FE,7E,00,00,00,00,00,00,80,80,C0,C0,A0,E0,E0,E8,60,EC,
                        60,7C,64,7C,2C,3C,00,00,00,00,00,00,00,00,00,00,00,5C,00,24,00,18,00,00,00,00,00,00,00,00,00,00,
                        C4,FC,C8,F8,F8,F8,F0,F0,90,F0,80,F0,80,F0,58,78,00,68,00,40,00,30,00,40,00,F0,00,90,00,50,00,20,
                        0F,0F,0E,08,1B,13,19,11,1F,11,1F,18,0F,0E,0F,0F,00,08,06,01,0A,04,08,06,0E,08,07,07,00,00,00,04,
                        FF,F3,FF,BD,77,57,F3,D3,FB,5B,FF,BF,F7,FE,F3,3F,0C,2F,42,22,20,80,A0,00,A0,20,40,48,00,7C,00,3C,
                        F9,F9,FC,FC,D6,F6,9A,FA,AF,FF,B7,EF,DA,F7,EF,7F,07,81,2B,20,71,78,F1,D4,F9,F9,6A,7A,77,7F,3F,3F,
                        B6,BE,26,3E,62,7E,A3,BF,CF,FF,FB,F9,EE,CE,FC,FC,C0,9E,C0,16,88,02,00,76,00,38,82,84,A8,90,00,00,
}


;;; $C6E0: Samus top tiles - set 1 - entry 1Dh ;;;
{
; 1Ah: Facing left  - spin jump - frame Bh
; 1Ch: Facing left  - space jump - frame Bh
; 82h: Facing left  - screw attack - frame 1Bh
; |--------|--------|--------|--------|--------|--------|
; |        |        |        |        |  3A3BB3|   BAA62|
; |BB3     |        |       3|FEEEF333|  3BB33 |   BBA2A|
; |ABBBB   |        |      3F|FEFF9E3A|   333  |   3B3B3|
; |BAAB53  |        |     3FE|E999FFE3|        |    B32A|
; |3BABD33 |        |     3FE|96999EFF|        |    33BB|
; |3BB38BA3|        |  33333F|F9EEEFFF|        |    B333|
; |3B383B2B|3       | 3BBBBB3|FEFFE9EF|        |    BBBB|
; |33553AA2|B3      |3BAA2AB3|3FFFEE9F|        |   33BBB|
; |--------|--------|--------|--------|--------|--------|
; |3333BBAA|B3      |BA22BBBB|33FFFFFF|
; |FF333BBB|33      |BA2BAABB|33333333|
; |EEF33 33|3333B   |BA2B2AAB|B3F3F333|
; |3E53   3|3BBB33B |BAAB3333|33F39FFF|
; |F383  3B|BA2B33A |3333855D|D3FE99EF|
; |F333 3BB|262A3B  |35875333|33FFFFEF|
; |33333BAA|B2A3BA  | 333BB3B|33FF3853|
; |3113BA22|ABB3B   |  3BA22A|B3333533|
; |--------|--------|--------|--------|
$9E:C6E0             db 00,00,E0,E0,78,F8,9C,F4,DE,F6,F5,F7,ED,EF,F8,CF,00,00,00,C0,00,F8,08,F0,08,78,00,6E,00,55,30,06,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,C0,C0,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,
                        00,00,01,01,03,03,06,07,06,07,3F,3F,7F,7F,C3,FF,00,00,00,00,01,01,03,03,03,03,01,01,00,3E,00,76,
                        00,00,8F,FF,BA,F7,7D,8F,BB,47,C7,BF,B5,FB,F3,FD,00,00,F8,F8,F4,FD,8E,FE,47,BF,BF,FF,FB,FF,7D,7F,
                        2F,3F,3E,3E,1C,1C,00,00,00,00,00,00,00,00,00,00,00,16,00,18,00,00,00,00,00,00,00,00,00,00,00,00,
                        10,1F,18,1F,1F,1F,0C,0F,0F,0F,0F,0F,0F,0F,1F,1F,02,1C,00,1D,00,0A,00,09,00,03,00,08,00,0F,00,07,
                        FC,FF,FF,FF,3B,FB,B1,D1,D3,D3,F7,F7,FC,FF,F8,9F,00,0F,C0,C7,E0,E0,60,40,80,A1,80,83,00,07,00,0C,
                        C0,C0,C0,C0,F8,F8,FE,FE,9C,FE,0C,FC,98,FC,78,F8,00,80,00,00,00,08,00,72,00,D2,40,14,00,AC,00,E8,
                        8F,FF,93,FF,91,FF,9F,FF,F7,F0,DF,97,7F,7F,30,3F,00,CF,00,DF,00,D7,00,F0,07,09,58,20,00,0D,00,19,
                        FF,FF,FF,FF,FF,FF,FF,F7,ED,73,FD,FF,FB,F9,FF,FB,3F,3F,00,00,28,A8,27,2F,B3,BF,3F,3F,32,34,04,80,
}
}


;;; $C820..E9BF: Samus top tiles - set 2 (general) ;;;
{
;;; $C820: Samus top tiles - set 2 - entry 0 ;;;
{
; 4Bh: Facing right - normal jump transition - frame 0
; A4h: Facing right - landing from normal jump - frame 0
; A6h: Facing right - landing from spin jump - frame 1
; |--------|--------|--------|--------|
; |       3|3FFFEE  |        |BB3DDDDD|
; |    33BB|33B699E |D3D3    |BA355555|
; |   33BAB|AB33FFFE|5353D3  |BA388888|
; |  3BBAB6|2AB33F4F|737383  |3B355555|
; |  3BBAB2|B2A33344|535353  | 33DDDDD|
; |  3BBABA|B2A33834|D3D3D3  |  333333|
; |  33333B|AAB33353|33333   |        |
; |  358785|33B3333F|        |        |
; |--------|--------|--------|--------|
; |   33335|5D333FF3|
; |  3BAAB3|333FFF9E|
; |  3BA2AB|333FFEEE|
; |  3A26AB|3333FFE3|
; | 3BA2AB3|33133F3 |
; | 333BAB3|331113  |
; | 3B33333|331C3   |
; | 3AB3D5D|31C13   |
; |--------|--------|
$9E:C820             db 01,01,0F,0F,1D,1F,3A,3F,3A,3F,3A,3F,3F,3F,35,24,00,00,00,03,00,07,01,1E,00,1E,00,1F,00,01,15,0A,
                        F0,FC,EC,F2,7E,FF,3D,FD,9C,FC,9A,FA,3F,FD,FF,FF,7C,7C,12,2E,0F,CF,07,65,03,A0,01,A4,02,E0,01,21,
                        00,00,F0,50,FC,54,F4,F4,FC,54,FC,54,F8,F8,00,00,00,00,A0,A0,A8,08,A0,08,A8,00,A8,A8,00,00,00,00,
                        FF,E0,BF,E0,A0,E0,FF,E0,7F,60,3F,3F,00,00,00,00,1F,DF,1F,C0,00,DF,1F,40,1F,1F,00,00,00,00,00,00,
                        1F,1E,33,3F,31,3F,21,3F,63,7F,7B,7F,7F,7F,5F,78,01,00,00,1E,00,1B,04,13,00,36,00,0E,00,20,07,35,
                        FF,3F,FE,FD,F8,FF,FD,FF,FE,DE,FC,C4,E8,C8,D8,88,C6,46,1D,1F,1F,1F,0E,0E,04,04,00,00,10,10,20,20,
}


;;; $C8E0: Samus top tiles - set 2 - entry 1 ;;;
{
; 4Ch: Facing left  - normal jump transition - frame 0
; A5h: Facing left  - landing from normal jump - frame 0
; A7h: Facing left  - landing from spin jump - frame 1
; |--------|--------|--------|--------|
; |3FF33D53|33333   |  EEFFF3|3       |
; |E9FF3333|BAAB3   | E96FF33|BB3     |
; |EEEFF33B|A22A3   |EFFFF3BB|ABB3    |
; |3EFF333B|B262B3  |F4FF3BAB|6BBB3   |
; | 3F33333|BA2A33  |4433BA2B|2BAB3   |
; |  331333|3BAB3B  |4373BA2B|ABAB3   |
; |   31133|3333BA  |3533BAB3|33333   |
; |   3333B|A2AB33  |F333B335|87853   |
; |--------|--------|--------|--------|
; |   3B33A|26AB3   |3FF33D53|33333   |
; |  3A2BA2|AAB3    |E9FF3333|BAAB3   |
; |  BAA3BA|BB3     |EEEFF33B|A22A3   |
; |  3BB43B|3       |3EFF333B|B262B3  |
; |   33B  |        | 3F33333|BA2A33  |
; |        |        |  331333|3BAB3B  |
; |        |        |   31133|3333BA  |
; |        |        |   3333B|A2AB33  |
; |--------|--------|--------|--------|
$9E:C8E0             db FF,F9,7F,BF,1F,FF,BF,FF,7F,7F,3F,37,1F,13,1F,1F,66,64,B0,F0,F8,F9,70,71,20,20,00,00,00,00,00,01,
                        F8,F8,98,F8,08,F8,8C,FC,8C,FC,DC,FC,F8,FC,1C,FC,00,00,00,F0,00,90,20,88,00,D0,00,74,00,0C,00,B0,
                        0F,3F,2F,5F,7F,FF,BD,BF,39,3F,79,7F,FB,BF,FF,FE,3E,3E,5C,6C,F8,FB,F0,B7,C0,0D,A0,0D,40,0E,81,88,
                        80,80,E0,E0,70,F0,78,F8,58,F8,58,F8,F8,F8,58,48,00,00,00,C0,00,E0,80,70,00,70,00,F0,00,00,50,A0,
                        1E,1F,24,3F,26,3F,3B,3B,1C,1C,00,00,00,00,00,00,00,09,00,16,00,3B,04,19,00,04,00,00,00,00,00,00,
                        18,F8,30,F0,E0,E0,80,80,00,00,00,00,00,00,00,00,40,30,00,E0,00,C0,00,00,00,00,00,00,00,00,00,00,
                        FF,F9,7F,BF,1F,FF,BF,FF,7F,7F,3F,37,1F,13,1F,1F,66,64,B0,F0,F8,F9,70,71,20,20,00,00,00,00,00,01,
                        F8,F8,98,F8,08,F8,8C,FC,8C,FC,DC,FC,F8,FC,1C,FC,00,00,00,F0,00,90,20,88,00,D0,00,74,00,0C,00,B0,
}


;;; $C9E0: Samus top tiles - set 2 - entry 2 ;;;
{
; Unused
; |--------|--------|--------|--------|--------|--------|
; | E33333B|BAB3E3  |        |FFFEE   |    3   |   33   |
; | E3D5878|DBB3EE  |      FF|EF69EE  |    3D  |  3DD3  |
; | F333333|5D33FE  |     FFE|EFEEFFE |    53  | 3D75D3 |
; | 83BAAAB|3313FF  |     F3B|3BFEF4F |    3D3 |3D5875D3|
; | 53A62AA|31C13   |   3B2B2|ABF3344 |33D3853 |33D5875D|
; | 3BA22AB|3111    |  3BA6A2|AA33834 |  3D53  | 33D5873|
; | 3BA2AAB|311     |  3BB2B2|B2B3353 |   33   |  33D533|
; | 33BAAB3|333BB3  | 33BBABA|B2B333F |        |   33338|
; |--------|--------|--------|--------|--------|--------|
; | B33BB33|333BA23 | E33333B|BAB3E3  |
; | BA33B  | 3BBBA3 | E3D5878|DBB3EE  |
; |  B33   |  3BB3  | F333333|5D33FE  |
; |        |        | 83BAAAB|3313FF  |
; |        |        | 53A62AA|31C13   |
; |        |        | 3BA22AB|3111    |
; |        |        | 3BA2AAB|311     |
; |        |        | 33BAAB3|333BB3  |
; |--------|--------|--------|--------|
$9E:C9E0             db 3F,7F,3A,62,7F,7F,31,3F,60,3F,61,7F,61,7F,73,7F,40,41,5A,55,40,40,00,5F,48,13,00,33,00,37,00,1E,
                        B4,FC,F0,7C,F8,3C,FC,DC,D8,88,F0,80,E0,80,FC,FC,08,E8,8C,EC,CC,4C,0C,0C,20,20,00,00,00,00,00,18,
                        00,00,03,03,06,07,07,07,1A,1F,30,3F,3A,3F,7A,7F,00,00,03,03,07,07,04,05,00,0A,04,1A,00,1A,00,1F,
                        E0,F8,50,EC,4C,FE,EA,FA,78,F8,34,F4,BE,FA,BE,FE,F8,F8,EC,DC,FE,FE,3E,7A,26,E0,02,C8,04,A0,02,A2,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        7F,7F,5C,7C,38,38,00,00,00,00,00,00,00,00,00,00,00,4C,00,64,00,20,00,00,00,00,00,00,00,00,00,00,
                        F2,FE,7A,7E,3C,3C,00,00,00,00,00,00,00,00,00,00,00,18,00,3C,00,18,00,00,00,00,00,00,00,00,00,00,
                        3F,7F,3A,62,7F,7F,31,3F,60,3F,61,7F,61,7F,73,7F,40,41,5A,55,40,40,00,5F,48,13,00,33,00,37,00,1E,
                        B4,FC,F0,7C,F8,3C,FC,DC,D8,88,F0,80,E0,80,FC,FC,08,E8,8C,EC,CC,4C,0C,0C,20,20,00,00,00,00,00,18,
}


;;; $CB20: Samus top tiles - set 2 - entry 3 ;;;
{
; E9h: Facing left  - Samus drained - crouching/falling - frames 10h / 15h
; |--------|--------|--------|--------|
; |  3E3BBB|B578D3E |   EEFFF|        |
; |  EE33BD|87D33FE |  EE96FE|FF      |
; |  EFF3D5|3BBB33F | EFFEEFE|EFF     |
; |  FF3133|BA2AB38 | F4FEF3B|B3F3    |
; |   31C1B|A262AB5 | 4433F3A|2B2B3   |
; |   31113|BA22AB3 | 43833AB|26A2B3  |
; |  333113|3BAB333 | 3533B22|B22AB33 |
; | 33DD333|33332B3 | F333BA2|AB3333F |
; |--------|--------|--------|--------|
; |3D3533BA|ABB3AB  |  3E3BBB|B578D3E |
; |3 333BA2|22B33   |  EE33BD|87D33FE |
; |32AB3A22|AAB3    |  EFF3D5|3BBB33F |
; |A24B3BAB|B       |  FF3133|BA2AB38 |
; |3ABBB3  |        |   31C1B|A262AB5 |
; | 3BB    |        |   31113|BA22AB3 |
; |        |        |  333113|3BAB333 |
; |        |        | 33DD333|33332B3 |
; |--------|--------|--------|--------|
$9E:CB20             db 2F,3F,0F,3E,1F,3C,3F,3B,1B,11,1F,11,3F,39,7F,67,10,17,31,33,3B,3A,30,30,04,05,00,00,00,00,18,18,
                        EC,A6,7C,5E,FE,FE,8C,FC,06,FC,86,FE,DE,FE,F6,FE,6A,9A,66,A6,02,72,00,DA,22,8C,00,CC,00,70,00,04,
                        07,1F,0A,37,32,7F,57,5F,1E,1F,2D,2F,7C,5F,7C,7F,1F,1F,37,3B,7F,7F,7C,5D,64,05,40,13,20,04,40,46,
                        00,00,C0,C0,60,E0,F0,F0,58,F8,0C,FC,8E,FE,7E,FE,00,00,C0,C0,E0,E0,20,A0,00,50,40,28,00,98,02,C2,
                        FE,AF,BC,BF,98,FF,1D,DF,BC,FC,70,70,00,00,00,00,50,43,00,06,00,34,20,97,00,78,00,30,00,00,00,00,
                        74,FC,38,F8,30,F0,80,80,00,00,00,00,00,00,00,00,00,EC,00,20,00,E0,00,80,00,00,00,00,00,00,00,00,
                        2F,3F,0F,3E,1F,3C,3F,3B,1B,11,1F,11,3F,39,7F,67,10,17,31,33,3B,3A,30,30,04,05,00,00,00,00,18,18,
                        EC,A6,7C,5E,FE,FE,8C,FC,06,FC,86,FE,DE,FE,F6,FE,6A,9A,66,A6,02,72,00,DA,22,8C,00,CC,00,70,00,04,
}


;;; $CC20: Samus top tiles - set 2 - entry 4 ;;;
{
; 19h: Facing right - spin jump - frame 0
; 1Bh: Facing right - space jump - frame 0
; 29h: Facing right - falling - frames 0 / 6
; 50h: Facing right - damage boost - frames 0..1
; 81h: Facing right - screw attack - frame 0
; 83h: Facing right - wall jump - frame 1
; A4h: Facing right - landing from normal jump - frame 1
; A6h: Facing right - landing from spin jump - frames 0 / 2
; ECh: Facing right - grabbed by Draygon - not moving - not aiming - frame 0
; |--------|--------|--------|--------|
; |       3|3FFFEE  |    3   |   33   |
; |    33BB|33B699E |    3D  |  3DD3  |
; |   33BAB|AB33FFFE|    53  | 3D75D3 |
; |  3BBAB6|2AB33F4F|    3D3 |3D5875D3|
; |  3BBAB2|B2A33344|33D3853 |33D5875D|
; |  3BBABA|B2A33834|  3D53  | 33D5873|
; |  33333B|AAB33353|   33   |  33D533|
; |  358785|33B3333F|        |   33338|
; |--------|--------|--------|--------|
; |   33335|5D333FF3|
; |  3BAAB3|333FFF9E|
; |  3BA2AB|333FFEEE|
; |  3A26AB|3333FFE3|
; | 3BA2AB3|33133F3 |
; | 333BAB3|331113  |
; | 3B33333|331C3   |
; | 3AB3D5D|31C13   |
; |--------|--------|
$9E:CC20             db 01,01,0F,0F,1D,1F,3A,3F,3A,3F,3A,3F,3F,3F,35,24,00,00,00,03,00,07,01,1E,00,1E,00,1F,00,01,15,0A,
                        F0,FC,EC,F2,7E,FF,3D,FD,9C,FC,9A,FA,3F,FD,FF,FF,7C,7C,12,2E,0F,CF,07,65,03,A0,01,A4,02,E0,01,21,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        1F,1E,33,3F,31,3F,21,3F,63,7F,7B,7F,7F,7F,5F,78,01,00,00,1E,00,1B,04,13,00,36,00,0E,00,20,07,35,
                        FF,3F,FE,FD,F8,FF,FD,FF,FE,DE,FC,C4,E8,C8,D8,88,C6,46,1D,1F,1F,1F,0E,0E,04,04,00,00,10,10,20,20,
}


;;; $CCE0: Samus top tiles - set 2 - entry 5 ;;;
{
; 1Ah: Facing left  - spin jump - frame 0
; 1Ch: Facing left  - space jump - frame 0
; 2Ah: Facing left  - falling - frames 0 / 6
; 4Fh: Facing left  - damage boost - frames 0..1
; 82h: Facing left  - screw attack - frame 0
; 84h: Facing left  - wall jump - frame 1
; A5h: Facing left  - landing from normal jump - frame 1
; A7h: Facing left  - landing from spin jump - frames 0 / 2
; BAh: Facing left  - grabbed by Draygon - not moving - not aiming - frame 0
; |--------|--------|--------|--------|
; |3FF33D53|33333   |  EEFFF3|3       |
; |E9FF3333|BAAB3   | E96FF33|BB3     |
; |EEEFF33B|A22A3   |EFFFF3BB|ABB3    |
; |3EFF333B|B262B3  |F4FF3BAB|6BBB3   |
; | 3F33333|BA2A33  |4433BA2B|2BAB3   |
; |  331333|3BAB3B  |4373BA2B|ABAB3   |
; |   31133|3333BA  |3533BAB3|33333   |
; |   3333B|A2AB33  |F333B335|87853   |
; |--------|--------|--------|--------|
; |   3B33A|26AB3   |3FF33D53|33333   |
; |  3A2BA2|AAB3    |E9FF3333|BAAB3   |
; |  BAA3BA|BB3     |EEEFF33B|A22A3   |
; |  3BB43B|3       |3EFF333B|B262B3  |
; |   33B  |        | 3F33333|BA2A33  |
; |        |        |  331333|3BAB3B  |
; |        |        |   31133|3333BA  |
; |        |        |   3333B|A2AB33  |
; |--------|--------|--------|--------|
$9E:CCE0             db FF,F9,7F,BF,1F,FF,BF,FF,7F,7F,3F,37,1F,13,1F,1F,66,64,B0,F0,F8,F9,70,71,20,20,00,00,00,00,00,01,
                        F8,F8,98,F8,08,F8,8C,FC,8C,FC,DC,FC,F8,FC,1C,FC,00,00,00,F0,00,90,20,88,00,D0,00,74,00,0C,00,B0,
                        0F,3F,2F,5F,7F,FF,BD,BF,39,3F,79,7F,FB,BF,FF,FE,3E,3E,5C,6C,F8,FB,F0,B7,C0,0D,A0,0D,40,0E,81,88,
                        80,80,E0,E0,70,F0,78,F8,58,F8,58,F8,F8,F8,58,48,00,00,00,C0,00,E0,80,70,00,70,00,F0,00,00,50,A0,
                        1E,1F,24,3F,26,3F,3B,3B,1C,1C,00,00,00,00,00,00,00,09,00,16,00,3B,04,19,00,04,00,00,00,00,00,00,
                        18,F8,30,F0,E0,E0,80,80,00,00,00,00,00,00,00,00,40,30,00,E0,00,C0,00,00,00,00,00,00,00,00,00,00,
                        FF,F9,7F,BF,1F,FF,BF,FF,7F,7F,3F,37,1F,13,1F,1F,66,64,B0,F0,F8,F9,70,71,20,20,00,00,00,00,00,01,
                        F8,F8,98,F8,08,F8,8C,FC,8C,FC,DC,FC,F8,FC,1C,FC,00,00,00,F0,00,90,20,88,00,D0,00,74,00,0C,00,B0,
}


;;; $CDE0: Samus top tiles - set 2 - entry 6 ;;;
{
; 11h: Moving right - aiming down-right - frames 2 / 4 / 7 / 9
; 78h: Facing right - moonwalk - aiming down-right - frames 1..2 / 4..5
; |--------|--------|--------|--------|--------|--------|--------|
; |      FF|FEE     | 3B3DD3 |        |  BBBBB |    3   |   33   |
; |    FFFE|F69E    |  3DD3  |        | BA622AB|    3D  |  3DD3  |
; |   FFEEE|FEFEE   |   33   |        |BAAA2B2A|    53  | 3D75D3 |
; |   FEFFF|FFFF9   |        |B       |BA6B22BA|    3D3 |3D5875D3|
; |  FEFF33|3FF4F   |        |B3      |BA22B2AB|33D3853 |33D5875D|
; | FFFF333|33F44   |        |53      |BAB2ABB8|  3D53  | 33D5873|
; | FFF3333|333F4   |        |3       |3BABB378|   33   |  33D533|
; | F3F3333|3333D   |        |        |3BAB3583|        |   33338|
; |--------|--------|--------|--------|--------|--------|--------|
; |FE3F3333|33333   |
; |FE333333|333BAB2 |
; |EF333333|33BA2AAA|
; |553F3333|3BA26ABA|
; |833FF333|BBA222AB|
; |333F3FF3|3BBA222A|
; |  3F3111|133BAAAB|
; |   33311|C133BBB3|
; |--------|--------|
$9E:CDE0             db 03,03,0E,0F,18,1F,17,1F,2F,3F,7F,7F,7F,7F,7F,7F,03,03,0F,0F,1F,1F,1F,1F,3C,3C,78,78,70,70,50,50,
                        80,E0,A0,D0,A0,F8,F8,F0,E8,E8,E0,E0,F0,F0,F8,F0,E0,E0,D0,B0,F8,F8,F0,F8,78,68,38,20,18,10,08,08,
                        7E,72,3C,24,18,18,00,00,00,00,00,00,00,00,00,00,0C,2C,18,18,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,80,80,C0,C0,C0,40,80,80,00,00,00,00,00,00,00,00,00,80,00,80,80,00,00,00,00,00,
                        3E,3E,41,7F,84,FF,92,FF,89,FF,A6,FE,DE,FE,DD,F9,00,3E,10,63,00,F5,20,D3,00,CB,00,EF,02,79,04,72,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        BF,FF,BF,FF,7F,FF,FF,3F,7F,7F,FF,FF,3F,38,1F,1C,D0,D0,C0,C0,C0,C0,D0,10,18,98,16,16,10,10,00,00,
                        F8,F8,F4,FE,E0,FF,C2,FF,C1,FF,E0,FF,F1,7F,7F,3F,00,00,00,1C,00,37,08,67,00,E3,00,71,00,1F,80,8E,
}


;;; $CF00: Samus top tiles - set 2 - entry 7 ;;;
{
; 12h: Moving left  - aiming down-left - frames 2 / 4 / 7 / 9
; 77h: Facing left  - moonwalk - aiming down-left - frames 1..2 / 4..5
; |--------|--------|--------|--------|--------|--------|--------|
; |     EEF|FF      |   33   |    3   | 3DD3B3 |        | BBBBB  |
; |    E96F|EFFF    |  3DD3  |    3D  |  3333  |        |BA2A6AB |
; |   EEFEF|EEEFF   | 3D75D3 |    53  |        |       B|A2B22BAB|
; |   9FFFF|FFFEF   |3D5875D3|    3D3 |        |      BB|AB22B6AB|
; |   F4FF3|333FEF  |33D5875D|33D3853 |        |      DB|BAAB22BB|
; |   44F33|333EFFF | 33D5873|  3D53  |        |      35|8BBA2BAB|
; |   4F333|3333FFF |  33D533|   33   |        |       3|873BBAB3|
; |   D3333|3333F3F |   33338|        |        |        |3853BBB3|
; |--------|--------|--------|--------|--------|--------|--------|
; |   3B333|3333F3EF|
; | 2BBAB33|333333EF|
; |AABA2AB3|333333FE|
; |ABA22AAB|B333F355|
; |BBA622AB|333FF338|
; |BBA22ABB|3FF3F333|
; |A3BAABB3|1113F3  |
; |2A3BBB3C|11133   |
; |--------|--------|
$9E:CF00             db 01,07,05,0B,05,1F,1F,0F,17,17,07,07,0F,0F,1F,0F,07,07,0B,0D,1F,1F,0F,1F,1E,16,1C,04,18,08,10,10,
                        C0,C0,70,F0,18,F8,E8,F8,F4,FC,EE,FE,FE,FE,FE,FE,C0,C0,F0,F0,F8,F8,F8,F8,1C,1C,1E,1E,0E,0E,0A,0A,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        7E,4E,3C,3C,00,00,00,00,00,00,00,00,00,00,00,00,30,34,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,03,03,03,01,03,02,01,01,00,00,00,00,00,00,00,01,00,03,02,03,01,00,00,00,00,00,
                        7C,7C,82,FE,25,FF,49,FF,93,FF,65,7F,7B,7F,BF,9F,00,7C,08,D6,00,A7,04,CB,00,F3,00,F7,40,9E,20,4E,
                        1F,1F,37,7F,23,FF,41,FF,C1,FF,C3,FF,67,FF,3E,FE,00,08,00,3C,00,F6,00,E7,10,E3,00,E7,00,BE,01,5D,
                        FD,FF,FD,FF,FE,FF,FF,FC,FE,FE,FF,FF,FC,1C,F8,18,0B,0B,03,03,03,03,0B,88,18,19,68,68,08,08,00,00,
}


;;; $D020: Samus top tiles - set 2 - entry 8 ;;;
{
; D5h: Facing right - x-ray - standing - frame 1
; D9h: Facing right - x-ray - crouching - frame 1
; |--------|--------|--------|--------|--------|--------|
; |F3BA2B2B|ABF3    |FFF     |       E|        |        |
; |F3BBABAB|B3FF    |996EF   |     FE9|D33     |3DDDDDD3|
; |F3333BBD|5DFE    |33333F  |    F4F3|53D3    |35555553|
; |FF358785|33FFB   |BBBB3FF |    4333|7383    |38888873|
; |5F3DD333|B3F33   |BBBBB3F |    433B|5353    |35555553|
; |8D133BAA|BB33BBB |A2AABB33|    38BB|D3D3    |3DDDDDD3|
; |  13BA62|AB333BAB|26A2AB3F|    F3BA|333     |33333333|
; |  33BA22|AB3 3A26|A2B2AB33|    33BA|        |        |
; |--------|--------|--------|--------|--------|--------|
; |   3BBAA|AB3 3BAA|
; |     B33|BB   3BB|
; |     3AA|33    33|
; |      BB|33      |
; |        |        |
; |        |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:D020             db E5,FF,F5,FF,FF,FE,F5,E4,FF,67,7C,1F,38,1F,38,3F,80,B5,80,BF,81,87,D5,CA,D8,58,40,C7,02,0C,00,0C,
                        70,F0,F0,F0,E0,30,F8,F8,F8,F8,FE,FE,7D,FF,68,EF,20,E0,30,B0,F0,70,30,38,20,A0,00,CE,00,C7,01,C4,
                        E0,E0,C8,38,FC,FC,FE,FE,FE,FE,0F,FF,07,FF,27,FF,E0,E0,38,D8,04,04,06,F6,02,FA,00,BC,41,2D,00,AC,
                        00,01,05,06,0B,0B,07,07,07,07,0B,0B,0E,0F,0E,0F,01,01,06,07,0E,0A,08,00,08,01,00,07,08,0B,00,03,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        1C,1F,07,07,04,07,03,03,00,00,00,00,00,00,00,00,00,0F,00,04,00,03,00,03,00,00,00,00,00,00,00,00,
                        6C,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,C7,00,C3,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D120: Samus top tiles - set 2 - entry 9 ;;;
{
; D5h: Facing right - x-ray - standing - frame 0
; D9h: Facing right - x-ray - crouching - frame 0
; |--------|--------|--------|--------|--------|--------|
; |F3BA2B2B|ABF3    |FFF     |       E|        |        |
; |F3BBABAB|B3FF    |9996F   |      49|D33     |3DDDDDD3|
; |F3333BBD|5DFE    |33333F  |     443|53D3    |35555553|
; |FF358785|33FFB   |BBBB3FF |    4333|7383    |38888873|
; |5F3DD333|B3F33   |BBBBB3F |    383B|5353    |35555553|
; |8D133BAA|BB33BBB |A2AABB33|    F3BB|D3D3    |3DDDDDD3|
; |  13BA62|AB333BAB|26A2AB3F|     3BA|333     |33333333|
; |  33BA22|AB3 3A26|A2B2AB33|    33BA|        |        |
; |--------|--------|--------|--------|--------|--------|
; |   3BBAA|AB3 3BAA|
; |     B33|BB   3BB|
; |     3AA|33    33|
; |      BB|33      |
; |        |        |
; |        |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:D120             db E5,FF,F5,FF,FF,FE,F5,E4,FF,67,7C,1F,38,1F,38,3F,80,B5,80,BF,81,87,D5,CA,D8,58,40,C7,02,0C,00,0C,
                        70,F0,F0,F0,E0,30,F8,F8,F8,F8,FE,FE,7D,FF,68,EF,20,E0,30,B0,F0,70,30,38,20,A0,00,CE,00,C7,01,C4,
                        E0,E0,E8,18,FC,FC,FE,FE,FE,FE,0F,FF,07,FF,27,FF,E0,E0,18,E8,04,04,06,F6,02,FA,00,BC,41,2D,00,AC,
                        00,01,01,00,01,01,07,07,0B,0B,0F,0F,06,07,0E,0F,01,01,02,01,06,00,08,00,00,05,08,0B,00,03,00,03,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        1C,1F,07,07,04,07,03,03,00,00,00,00,00,00,00,00,00,0F,00,04,00,03,00,03,00,00,00,00,00,00,00,00,
                        6C,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,C7,00,C3,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D220: Samus top tiles - set 2 - entry Ah ;;;
{
; D5h: Facing right - x-ray - standing - frame 3
; D9h: Facing right - x-ray - crouching - frame 3
; |--------|--------|--------|--------|--------|--------|
; |F3BA2B2B|ABF3    |FF      |       E|        |        |
; |F3BBABAB|B3FF    |6FEFF   |      99|D33     |3DDDDDD3|
; |F3333BBD|5DFE    |33333F  |     EE3|53D3    |35555553|
; |FF358785|33FFB   |BBBB3FF |    EE33|7383    |38888873|
; |5F3DD333|B3F33   |BBBBB3F |    E43B|5353    |35555553|
; |8D133BAA|BB33BBB |A2AABB33|    43BB|D3D3    |3DDDDDD3|
; |  13BA62|AB333BAB|26A2AB3F|    43BA|333     |33333333|
; |  33BA22|AB3 3A26|A2B2AB33|    F8BA|        |        |
; |--------|--------|--------|--------|--------|--------|
; |   3BBAA|AB3 3BAA|
; |     B33|BB   3BB|
; |     3AA|33    33|
; |      BB|33      |
; |        |        |
; |        |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:D220             db E5,FF,F5,FF,FF,FE,F5,E4,FF,67,7C,1F,38,1F,38,3F,80,B5,80,BF,81,87,D5,CA,D8,58,40,C7,02,0C,00,0C,
                        70,F0,F0,F0,E0,30,F8,F8,F8,F8,FE,FE,7D,FF,68,EF,20,E0,30,B0,F0,70,30,38,20,A0,00,CE,00,C7,01,C4,
                        C0,C0,58,F8,FC,FC,FE,FE,FE,FE,0F,FF,07,FF,27,FF,C0,C0,F8,78,04,04,06,F6,02,FA,00,BC,41,2D,00,AC,
                        00,01,03,00,01,07,03,0F,03,0B,07,07,06,07,0A,0B,01,01,00,03,06,06,0C,0C,0C,09,08,03,08,03,08,0F,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        1C,1F,07,07,04,07,03,03,00,00,00,00,00,00,00,00,00,0F,00,04,00,03,00,03,00,00,00,00,00,00,00,00,
                        6C,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,C7,00,C3,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D320: Samus top tiles - set 2 - entry Bh ;;;
{
; D5h: Facing right - x-ray - standing - frame 4
; D9h: Facing right - x-ray - crouching - frame 4
; |--------|--------|--------|--------|--------|--------|
; |F3BA2B2B|ABF3    |FFF     |       E|        |        |
; |F3BBABAB|B3FF    |FEFFF   |      E6|D33     |3DDDDDD3|
; |F3333BBD|5DFE    |33333F  |     EE3|53D3    |35555553|
; |FF358785|33FFB   |BBBB3FF |    FE33|7383    |38888873|
; |5F3DD333|B3F33   |BBBBB3F |    FF3B|5353    |35555553|
; |8D133BAA|BB33BBB |A2AABB33|    F4BB|D3D3    |3DDDDDD3|
; |  13BA62|AB333BAB|26A2AB3F|    43BA|333     |33333333|
; |  33BA22|AB3 3A26|A2B2AB33|    43BA|        |        |
; |--------|--------|--------|--------|--------|--------|
; |   3BBAA|AB3 3BAA|
; |     B33|BB   3BB|
; |     3AA|33    33|
; |      BB|33      |
; |        |        |
; |        |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:D320             db E5,FF,F5,FF,FF,FE,F5,E4,FF,67,7C,1F,38,1F,38,3F,80,B5,80,BF,81,87,D5,CA,D8,58,40,C7,02,0C,00,0C,
                        70,F0,F0,F0,E0,30,F8,F8,F8,F8,FE,FE,7D,FF,68,EF,20,E0,30,B0,F0,70,30,38,20,A0,00,CE,00,C7,01,C4,
                        E0,E0,B8,F8,FC,FC,FE,FE,FE,FE,0F,FF,07,FF,27,FF,E0,E0,F8,F8,04,04,06,F6,02,FA,00,BC,41,2D,00,AC,
                        00,01,00,03,01,07,0B,0F,0F,0F,0B,0B,06,07,06,07,01,01,03,02,06,06,0C,0C,0C,0D,0C,0B,08,03,08,03,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        1C,1F,07,07,04,07,03,03,00,00,00,00,00,00,00,00,00,0F,00,04,00,03,00,03,00,00,00,00,00,00,00,00,
                        6C,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,C7,00,C3,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $D420: Samus top tiles - set 2 - entry Ch ;;;
{
; D6h: Facing left  - x-ray - standing - frame 1
; DAh: Facing left  - x-ray - crouching - frame 1
; |--------|--------|--------|--------|--------|--------|
; |    33BA|B2B2BB3F|       E|FFF     |        |        |
; |    FF3B|BABABB3F|     FE9|996EF   |D33     |3DDDDDD3|
; |    EF35|DBBB333F|    F4F3|33333F  |53D3    |35555553|
; |    EF33|58785D3F|    4333|BBBB3FF |7383    |38888873|
; |    3F3B|333333DD|    433B|BBBBB3F |5353    |35555553|
; | BB333BA|AAAB3138|    38BB|A2AABB33|D3D3    |3DDDDDD3|
; |B2A333A2|26AB31  |    F3BA|26A2AB3F|333     |33333333|
; |AA3AB3A2|22A333  |    33BA|A2B2AB33|        |        |
; |--------|--------|--------|--------|--------|--------|
; |B326AB3A|2AB31   |
; |3BA2A33B|AB3     |
; |33BAA3B3|B3      |
; | 33BB3AB|3       |
; |    33BB|        |
; |        |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:D420             db 0E,0F,0F,0F,07,0E,07,0F,0F,0F,7E,7F,9C,FF,2C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A2,00,DA,
                        AF,FF,AF,FF,FF,7F,AF,23,FF,FC,1E,FA,1C,F8,1C,FC,01,AD,01,FD,81,F1,AD,55,03,03,00,F1,40,30,00,20,
                        00,01,05,06,0B,0B,07,07,07,07,0B,0B,0E,0F,0E,0F,01,01,06,07,0E,0A,08,00,08,01,00,07,08,0B,00,03,
                        E0,E0,C8,38,FC,FC,FE,FE,FE,FE,0F,FF,07,FF,27,FF,E0,E0,38,D8,04,04,06,F6,02,FA,00,BC,41,2D,00,AC,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        C6,FF,C7,FF,E7,FF,7D,7F,0F,0F,00,00,00,00,00,00,10,8D,00,69,00,3A,00,1B,00,03,00,00,00,00,00,00,
                        38,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
}


;;; $D520: Samus top tiles - set 2 - entry Dh ;;;
{
; D6h: Facing left  - x-ray - standing - frame 0
; DAh: Facing left  - x-ray - crouching - frame 0
; |--------|--------|--------|--------|--------|--------|
; |    33BA|B2B2BB3F|       E|FFF     |        |        |
; |    FF3B|BABABB3F|      49|9996F   |D33     |3DDDDDD3|
; |    EF35|DBBB333F|     443|33333F  |53D3    |35555553|
; |    EF33|58785D3F|    4333|BBBB3FF |7383    |38888873|
; |    3F3B|333333DD|    383B|BBBBB3F |5353    |35555553|
; | BB333BA|AAAB3138|    F3BB|A2AABB33|D3D3    |3DDDDDD3|
; |B2A333A2|26AB31  |     3BA|26A2AB3F|333     |33333333|
; |AA3AB3A2|22A333  |    33BA|A2B2AB33|        |        |
; |--------|--------|--------|--------|--------|--------|
; |B326AB3A|2AB31   |
; |3BA2A33B|AB3     |
; |33BAA3B3|B3      |
; | 33BB3AB|3       |
; |    33BB|        |
; |        |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:D520             db 0E,0F,0F,0F,07,0E,07,0F,0F,0F,7E,7F,9C,FF,2C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A2,00,DA,
                        AF,FF,AF,FF,FF,7F,AF,23,FF,FC,1E,FA,1C,F8,1C,FC,01,AD,01,FD,81,F1,AD,55,03,03,00,F1,40,30,00,20,
                        00,01,01,00,01,01,07,07,0B,0B,0F,0F,06,07,0E,0F,01,01,02,01,06,00,08,00,00,05,08,0B,00,03,00,03,
                        E0,E0,E8,18,FC,FC,FE,FE,FE,FE,0F,FF,07,FF,27,FF,E0,E0,18,E8,04,04,06,F6,02,FA,00,BC,41,2D,00,AC,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        C6,FF,C7,FF,E7,FF,7D,7F,0F,0F,00,00,00,00,00,00,10,8D,00,69,00,3A,00,1B,00,03,00,00,00,00,00,00,
                        38,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
}


;;; $D620: Samus top tiles - set 2 - entry Eh ;;;
{
; Dh: Unused. Moving right - aiming up - frames 2 / 4 / 7 / 9
; D6h: Facing left  - x-ray - standing - frame 3
; DAh: Facing left  - x-ray - crouching - frame 3
; |--------|--------|--------|--------|--------|--------|
; |    33BA|B2B2BB3F|FF      |       E|        |        |
; |    FF3B|BABABB3F|6FEFF   |      99|D33     |3DDDDDD3|
; |    EF35|DBBB333F|33333F  |     EE3|53D3    |35555553|
; |    EF33|58785D3F|BBBB3FF |    EE33|7383    |38888873|
; |    3F3B|333333DD|BBBBB3F |    E43B|5353    |35555553|
; | BB333BA|AAAB3138|A2AABB33|    43BB|D3D3    |3DDDDDD3|
; |B2A333A2|26AB31  |26A2AB3F|    43BA|333     |33333333|
; |AA3AB3A2|22A333  |A2B2AB33|    F8BA|        |        |
; |--------|--------|--------|--------|--------|--------|
; |B326AB3A|2AB31   |
; |3BA2A33B|AB3     |
; |33BAA3B3|B3      |
; | 33BB3AB|3       |
; |    33BB|        |
; |        |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:D620             db 0E,0F,0F,0F,07,0E,07,0F,0F,0F,7E,7F,9C,FF,2C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A2,00,DA,
                        AF,FF,AF,FF,FF,7F,AF,23,FF,FC,1E,FA,1C,F8,1C,FC,01,AD,01,FD,81,F1,AD,55,03,03,00,F1,40,30,00,20,
                        C0,C0,58,F8,FC,FC,FE,FE,FE,FE,0F,FF,07,FF,27,FF,C0,C0,F8,78,04,04,06,F6,02,FA,00,BC,41,2D,00,AC,
                        00,01,03,00,01,07,03,0F,03,0B,07,07,06,07,0A,0B,01,01,00,03,06,06,0C,0C,0C,09,08,03,08,03,08,0F,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        C6,FF,C7,FF,E7,FF,7D,7F,0F,0F,00,00,00,00,00,00,10,8D,00,69,00,3A,00,1B,00,03,00,00,00,00,00,00,
                        38,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
}


;;; $D720: Samus top tiles - set 2 - entry Fh ;;;
{
; Eh: Unused. Moving left  - aiming up - frames 2 / 4 / 7 / 9
; D6h: Facing left  - x-ray - standing - frame 4
; DAh: Facing left  - x-ray - crouching - frame 4
; |--------|--------|--------|--------|--------|--------|
; |    33BA|B2B2BB3F|FFF     |       E|        |        |
; |    FF3B|BABABB3F|FEFFF   |      E6|D33     |3DDDDDD3|
; |    EF35|DBBB333F|33333F  |     EE3|53D3    |35555553|
; |    EF33|58785D3F|BBBB3FF |    FE33|7383    |38888873|
; |    3F3B|333333DD|BBBBB3F |    FF3B|5353    |35555553|
; | BB333BA|AAAB3138|A2AABB33|    F4BB|D3D3    |3DDDDDD3|
; |B2A333A2|26AB31  |26A2AB3F|    43BA|333     |33333333|
; |AA3AB3A2|22A333  |A2B2AB33|    43BA|        |        |
; |--------|--------|--------|--------|--------|--------|
; |B326AB3A|2AB31   |
; |3BA2A33B|AB3     |
; |33BAA3B3|B3      |
; | 33BB3AB|3       |
; |    33BB|        |
; |        |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:D720             db 0E,0F,0F,0F,07,0E,07,0F,0F,0F,7E,7F,9C,FF,2C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A2,00,DA,
                        AF,FF,AF,FF,FF,7F,AF,23,FF,FC,1E,FA,1C,F8,1C,FC,01,AD,01,FD,81,F1,AD,55,03,03,00,F1,40,30,00,20,
                        E0,E0,B8,F8,FC,FC,FE,FE,FE,FE,0F,FF,07,FF,27,FF,E0,E0,F8,F8,04,04,06,F6,02,FA,00,BC,41,2D,00,AC,
                        00,01,00,03,01,07,0B,0F,0F,0F,0B,0B,06,07,06,07,01,01,03,02,06,06,0C,0C,0C,0D,0C,0B,08,03,08,03,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        C6,FF,C7,FF,E7,FF,7D,7F,0F,0F,00,00,00,00,00,00,10,8D,00,69,00,3A,00,1B,00,03,00,00,00,00,00,00,
                        38,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
}


;;; $D820: Samus top tiles - set 2 - entry 10h ;;;
{
; Fh: Moving right - aiming up-right - frames 2 / 4 / 7 / 9
; 76h: Facing right - moonwalk - aiming up-right - frames 1..2 / 4..5
; |--------|--------|--------|--------|--------|--------|
; |     FFE|EE      |        |BABBBB83|        |833D3   |
; |   FFF6E|9EE     |   33   |3BAAAB53|        |3375D3  |
; |  FFEEFE|EFF333  |  35D3D | BBBB3D3|        |35875D3 |
; |  FEFFFF|FF3BAA3 | 3583533| 3BBB333|  BBBBB |3D5875D3|
; | FEF3333|F3BAA2B3| 3D3    |  33333 | BA6AB53|33D587D3|
; | FF33333|3BA22B33|  3D    |        |BA62AB83| 33D5D3 |
; | FF33333|3B2623AA|   3    |        |BA6ABB83|  33D3  |
; |F3F33333|3B22A3A3|   3    |        |BB22AB73|   33   |
; |--------|--------|--------|--------|--------|--------|
; |E3F33333|33AAB33 |
; |E3333333|33BB3   |
; |E3333333|33B3    |
; |55333333|333     |
; |733F3333|33      |
; |33F31133|33      |
; | 3F31111|13      |
; |  33311C|C3      |
; |--------|--------|
$9E:D820             db 06,07,1C,1F,32,3F,2F,3F,5F,7F,7F,7F,7F,7F,FF,FF,07,07,1F,1D,3F,3F,3F,3F,70,70,60,60,60,60,A0,A0,
                        00,C0,80,60,7C,FC,F2,FE,E3,FF,C7,FF,C4,FF,C5,FF,C0,C0,60,E0,E0,E0,C0,DC,80,BA,00,64,10,43,00,4A,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        BD,FD,C7,FD,7F,7D,7F,7F,3E,3E,00,00,00,00,00,00,00,FE,02,7C,02,7A,00,38,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,3E,3E,47,7D,85,FD,8D,FD,C7,FF,00,00,00,00,00,00,00,3E,12,6C,20,CE,20,DE,02,CC,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        7F,FF,7F,FF,7F,FF,FF,3F,FF,FF,FF,F3,7F,70,3E,38,A0,A0,80,80,80,80,C0,00,90,10,20,20,20,20,01,01,
                        CE,FE,F8,F8,F0,F0,E0,E0,C0,C0,C0,C0,C0,40,40,40,00,38,00,30,00,20,00,00,00,00,00,00,00,00,80,80,
}


;;; $D920: Samus top tiles - set 2 - entry 11h ;;;
{
; 10h: Moving left  - aiming up-left - frames 2 / 4 / 7 / 9
; 75h: Facing left  - moonwalk - aiming up-left - frames 1..2 / 4..5
; |--------|--------|--------|--------|--------|--------|--------|
; |      EE|EFF     |  3DD33 |BBBBBB  |        |        |833D3   |
; |     EE9|E6FFF   |   333  |BA226BB |       3|   33   |3375D3  |
; |  3BE4FE|EFEEFF  |        |BA2BA6BB|      33|  35D3D |35875D3 |
; | 3BB44FF|FFFFEF  |        |7BBA26BB|      3D| 3583533|3D5875D3|
; | 3AB43F3|333FFEF |        |57BA2BAB|       3| 3D3    |33D587D3|
; |3BAB3333|3333FFF |        |358BBAAB|       3|  3D    | 33D5D3 |
; |BB3BF333|33333FF |        |3D53BAB3|        |   3    |  33D3  |
; |AB3AB333|33333F3F|        | 3DD3BB |        |   3    |   33   |
; |--------|--------|--------|--------|--------|--------|--------|
; |3BBBAB33|33333F3E|
; |3BA26A33|3333333E|
; |BA2222B3|3333333E|
; |BBA2AAB3|33333355|
; |B3BABBB3|3333B337|
; | B3BBB33|13113B33|
; |     33C|11113B3 |
; |      3C|C11333  |
; |--------|--------|
$9E:D920             db 00,03,01,06,32,3B,73,73,57,77,DF,FF,FF,FF,6F,FF,03,03,06,07,0F,1B,0F,33,0A,32,00,70,08,D8,00,D8,
                        60,E0,38,F8,4C,FC,F4,FC,FA,FE,FE,FE,FE,FE,FF,FF,E0,E0,F8,B8,FC,FC,FC,FC,1E,1E,0E,0E,06,06,05,05,
                        3E,26,1C,1C,00,00,00,00,00,00,00,00,00,00,00,00,18,18,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FC,FC,86,FE,93,FF,E3,FF,E5,7F,D9,9F,FB,9F,7E,4E,00,FC,08,C6,04,DB,84,73,C0,37,40,3F,60,4E,30,36,
                        00,00,01,01,03,03,03,02,01,01,01,01,00,00,00,00,00,00,00,00,00,00,01,01,00,00,00,00,00,00,00,00,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        F7,FF,C3,FF,83,FF,C3,FF,EF,FF,7F,7F,06,06,02,02,00,7C,08,64,00,C2,00,EE,00,BE,00,5C,01,01,01,01,
                        FE,FF,FE,FF,FE,FF,FF,FC,FF,FF,FF,4F,FE,0E,7C,1C,05,05,01,01,01,01,03,00,01,08,00,04,00,04,80,80,
}


;;; $DA40: Samus top tiles - set 2 - entry 12h ;;;
{
; Unused
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |      EE|FFF     |        |BBBBB   |        |        |AB3     |BA262BAA|
; |     E96|FEFFF   |       3|BAB6BB  |D33     |3DDDDDD3|B3      |3BA2A3BA|
; |    FEFE|FFEEFF  |      3B|A2A26AB |53D3    |35555553|3       |33BAB333|
; |    F43F|FFFFEF  |      BA|B2A2AAB |7383    |38888873|        |   B32A3|
; |    4433|333FFEF |      BA|B2B2BAB3|5353    |35555553|        |        |
; |    4353|3333FFF |      BA|BA3ABAB3|D3D3    |3DDDDDD3|        |        |
; |    3833|33333FF |      BB|3B3B3333|333     |33333333|        |        |
; |    3F33|33333F3F|      3D|57855D33|        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |    EF33|33333F3E|
; |    FF33|33333F3E|
; |33 3FF33|3333333E|
; |B333F333|33333FF5|
; |B33333BA|AABB3F38|
; |3B333BA2|62AB3333|
; |AABB3BA2|2AB311  |
; |A22AAB22|AAB313  |
; |--------|--------|
$9E:DA40             db 00,03,02,05,0A,0F,0B,0B,03,03,07,05,0B,0B,0F,0F,03,03,05,06,0F,0F,0D,09,0C,00,0A,00,00,04,04,04,
                        E0,E0,B8,F8,CC,FC,F4,FC,FA,FE,FE,FE,FE,FE,FF,FF,E0,E0,F8,F8,FC,FC,FC,FC,1E,1E,0E,0E,06,06,05,05,
                        00,00,01,01,03,03,02,03,02,03,02,03,03,03,03,02,00,00,00,00,00,01,00,03,00,03,00,03,00,03,01,01,
                        F8,F8,AC,FC,02,FE,82,FE,AB,FF,AB,FF,FF,FF,DF,43,00,F8,10,EC,08,A6,00,AE,00,AE,00,DE,00,50,DC,24,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        84,FF,C6,FF,EF,FF,19,1F,00,00,00,00,00,00,00,00,10,C7,00,6B,00,38,00,12,00,00,00,00,00,00,00,00,
                        07,0F,0F,0F,DF,DF,FF,FF,FE,FF,FC,FF,3C,FF,04,FF,0C,0C,0C,0C,0C,0C,08,88,00,83,00,46,00,F6,00,9C,
                        FE,FF,FE,FF,FE,FF,FF,FE,3E,FE,1F,FF,3C,F0,3C,F4,05,05,05,05,01,01,07,06,04,F5,80,30,00,60,00,E0,
}


;;; $DB80: Samus top tiles - set 2 - entry 13h ;;;
{
; Unused
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |     FFF|EE      | 3B3553 |        |  BBBBB |        |   33A23|        |
; |   FFFEF|69E     |  3DD3  |        | BA6A2A3|D33     |        |3DDDDDD3|
; |  FFEEFF|EFEF    |   33   |3       |BAA22B2A|53D3    |        |35555553|
; |  FEFFFF|F34F    |        |B       |BA6B22BA|7383    |        |38888873|
; | FEFF333|3344    |        |D3      |BA22B2AB|5353    |        |35555553|
; | FFF3333|3534    |        |53      |BAB2ABB8|D3D3    |        |3DDDDDD3|
; | FFF3333|3383    |        |3       |3BABB378|333     |        |33333333|
; |F3FF3333|33F3    |        |        |3BBB3883|        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |E3F33333|33FF    |
; |E3333333|33BBB   |
; |E3333333|3BAABB  |
; |5333F333|BA22AB3 |
; |83FFF33B|AA262AB3|
; |333F3133|BAA22AB3|
; | 3331113|3BAAAB33|
; |  331C11|33BBB3AB|
; |--------|--------|
$9E:DB80             db 07,07,1D,1F,33,3F,2F,3F,5F,7F,7F,7F,7F,7F,FF,FF,07,07,1F,1F,3F,3F,3F,3F,78,78,70,70,70,70,B0,B0,
                        00,C0,40,A0,50,F0,D0,D0,C0,C0,E0,A0,D0,D0,F0,F0,C0,C0,A0,60,F0,F0,B0,90,30,00,50,00,00,20,20,20,
                        7E,72,3C,24,18,18,00,00,00,00,00,00,00,00,00,00,0C,20,18,18,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,80,80,80,80,C0,40,C0,40,80,80,00,00,00,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,
                        3E,3E,41,7F,84,FF,92,FF,89,FF,A6,FE,DE,FE,F9,F9,00,3E,10,6A,00,E5,20,D3,00,CB,00,EF,02,79,00,76,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        19,1F,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,04,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        7F,FF,7F,FF,7F,FF,FF,7F,7F,7F,FF,FB,7F,71,3B,30,A0,A0,80,80,80,80,88,08,38,B9,10,10,00,00,04,04,
                        F0,F0,F8,F8,CC,FC,86,FE,03,FF,83,FF,C7,FF,FD,FF,30,30,00,38,00,7C,00,CC,10,C6,00,E6,00,7C,00,3B,
}


;;; $DCC0: Samus top tiles - set 2 - entry 14h ;;;
{
; Unused
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |      EE|FFF     |        |BBBBB   |        |        |AB3     |BA262BAA|
; |     E96|FEFFF   |       3|BAB6BB  |D33     |3DDDDDD3|B3      |3BA2A3BA|
; |    FEFE|FFEEFF  |      3B|A2A26AB |53D3    |35555553|3       |33BAB333|
; |    F43F|FFFFEF  |      BA|B2A2AAB |7383    |38888873|        |   B32A3|
; |    4433|333FFEF |      BA|B2B2BAB3|5353    |35555553|        |        |
; |    4353|3333FFF |      BA|BA3ABAB3|D3D3    |3DDDDDD3|        |        |
; |    3833|33333FF |      BB|3B3B3333|333     |33333333|        |        |
; |    3F33|33333F3F|      3D|57855D33|        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |    EF33|33333F3E|
; |    FF33|33333F3E|
; |33 3FF33|3333333E|
; |B333F333|33333FF5|
; |B33333BA|AABB3F38|
; |3B333BA2|62AB3333|
; |AABB3BA2|2AB311  |
; |A22AAB22|AAB313  |
; |--------|--------|
$9E:DCC0             db 00,03,02,05,0A,0F,0B,0B,03,03,07,05,0B,0B,0F,0F,03,03,05,06,0F,0F,0D,09,0C,00,0A,00,00,04,04,04,
                        E0,E0,B8,F8,CC,FC,F4,FC,FA,FE,FE,FE,FE,FE,FF,FF,E0,E0,F8,F8,FC,FC,FC,FC,1E,1E,0E,0E,06,06,05,05,
                        00,00,01,01,03,03,02,03,02,03,02,03,03,03,03,02,00,00,00,00,00,01,00,03,00,03,00,03,00,03,01,01,
                        F8,F8,AC,FC,02,FE,82,FE,AB,FF,AB,FF,FF,FF,DF,43,00,F8,10,EC,08,A6,00,AE,00,AE,00,DE,00,50,DC,24,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        84,FF,C6,FF,EF,FF,19,1F,00,00,00,00,00,00,00,00,10,C7,00,6B,00,38,00,12,00,00,00,00,00,00,00,00,
                        07,0F,0F,0F,DF,DF,FF,FF,FE,FF,FC,FF,3C,FF,04,FF,0C,0C,0C,0C,0C,0C,08,88,00,83,00,46,00,F6,00,9C,
                        FE,FF,FE,FF,FE,FF,FF,FE,3E,FE,1F,FF,3C,F0,3C,F4,05,05,05,05,01,01,07,06,04,F5,80,30,00,60,00,E0,
}


;;; $DE00: Samus top tiles - set 2 - entry 15h ;;;
{
; Unused
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |     FFF|EE      | 3B3553 |        |  BBBBB |        |   33A23|        |
; |   FFFEF|69E     |  3DD3  |        | BA6A2A3|D33     |        |3DDDDDD3|
; |  FFEEFF|EFEF    |   33   |3       |BAA22B2A|53D3    |        |35555553|
; |  FEFFFF|F34F    |        |B       |BA6B22BA|7383    |        |38888873|
; | FEFF333|3344    |        |D3      |BA22B2AB|5353    |        |35555553|
; | FFF3333|3534    |        |53      |BAB2ABB8|D3D3    |        |3DDDDDD3|
; | FFF3333|3383    |        |3       |3BABB378|333     |        |33333333|
; |F3FF3333|33F3    |        |        |3BBB3883|        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |E3F33333|33FF    |
; |E3333333|33BBB   |
; |E3333333|3BAABB  |
; |5333F333|BA22AB3 |
; |83FFF33B|AA262AB3|
; |333F3133|BAA22AB3|
; | 3331113|3BAAAB33|
; |  331C11|33BBB3AB|
; |--------|--------|
$9E:DE00             db 07,07,1D,1F,33,3F,2F,3F,5F,7F,7F,7F,7F,7F,FF,FF,07,07,1F,1F,3F,3F,3F,3F,78,78,70,70,70,70,B0,B0,
                        00,C0,40,A0,50,F0,D0,D0,C0,C0,E0,A0,D0,D0,F0,F0,C0,C0,A0,60,F0,F0,B0,90,30,00,50,00,00,20,20,20,
                        7E,72,3C,24,18,18,00,00,00,00,00,00,00,00,00,00,0C,20,18,18,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,80,80,80,80,C0,40,C0,40,80,80,00,00,00,00,00,00,00,00,00,80,80,80,80,00,00,00,00,00,
                        3E,3E,41,7F,84,FF,92,FF,89,FF,A6,FE,DE,FE,F9,F9,00,3E,10,6A,00,E5,20,D3,00,CB,00,EF,02,79,00,76,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        19,1F,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,04,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        7F,FF,7F,FF,7F,FF,FF,7F,7F,7F,FF,FB,7F,71,3B,30,A0,A0,80,80,80,80,88,08,38,B9,10,10,00,00,04,04,
                        F0,F0,F8,F8,CC,FC,86,FE,03,FF,83,FF,C7,FF,FD,FF,30,30,00,38,00,7C,00,CC,10,C6,00,E6,00,7C,00,3B,
}


;;; $DF40: Samus top tiles - set 2 - entry 16h ;;;
{
; Fh: Moving right - aiming up-right - frames 3 / 8
; |--------|--------|--------|--------|--------|--------|
; |     FFE|EE      |        |BABBBB83|        |833D3   |
; |   FFF6E|9EE     |   33   |3BAAAB53|        |3375D3  |
; |  FFEEFE|EFF333  |  35D3D | BBBB3D3|        |35875D3 |
; |  FEFFFF|FF3BAA3 | 3583533| 3BBB333|  BBBBB |3D5875D3|
; | FEF3333|F3BAA2B3| 3D3    |  33333 | BA6AB53|33D587D3|
; | FF33333|3BA22B33|  3D    |        |BA62AB83| 33D5D3 |
; | FF33333|3B2623AA|   3    |        |BA6ABB83|  33D3  |
; |F3F33333|3B22A3A3|   3    |        |BB22AB73|   33   |
; |--------|--------|--------|--------|--------|--------|
; |E3F33333|33AAB33 |
; |E3333333|33BB3   |
; |E3333333|33B3    |
; |55333333|333     |
; |733F3333|33      |
; |33F31133|33      |
; | 3F31111|13      |
; |  33311C|C3      |
; |--------|--------|
$9E:DF40             db 06,07,1C,1F,32,3F,2F,3F,5F,7F,7F,7F,7F,7F,FF,FF,07,07,1F,1D,3F,3F,3F,3F,70,70,60,60,60,60,A0,A0,
                        00,C0,80,60,7C,FC,F2,FE,E3,FF,C7,FF,C4,FF,C5,FF,C0,C0,60,E0,E0,E0,C0,DC,80,BA,00,64,10,43,00,4A,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        BD,FD,C7,FD,7F,7D,7F,7F,3E,3E,00,00,00,00,00,00,00,FE,02,7C,02,7A,00,38,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,3E,3E,47,7D,85,FD,8D,FD,C7,FF,00,00,00,00,00,00,00,3E,12,6C,20,CE,20,DE,02,CC,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        7F,FF,7F,FF,7F,FF,FF,3F,FF,FF,FF,F3,7F,70,3E,38,A0,A0,80,80,80,80,C0,00,90,10,20,20,20,20,01,01,
                        CE,FE,F8,F8,F0,F0,E0,E0,C0,C0,C0,C0,C0,40,40,40,00,38,00,30,00,20,00,00,00,00,00,00,00,00,80,80,
}


;;; $E040: Samus top tiles - set 2 - entry 17h ;;;
{
; 10h: Moving left  - aiming up-left - frames 3 / 8
; |--------|--------|--------|--------|--------|--------|--------|
; |      EE|EFF     |  3DD33 |BBBBBB  |        |        |833D3   |
; |     EE9|E6FFF   |   333  |BA226BB |       3|   33   |3375D3  |
; |  3BE4FE|EFEEFF  |        |BA2BA6BB|      33|  35D3D |35875D3 |
; | 3BB44FF|FFFFEF  |        |7BBA26BB|      3D| 3583533|3D5875D3|
; | 3AB43F3|333FFEF |        |57BA2BAB|       3| 3D3    |33D587D3|
; |3BAB3333|3333FFF |        |358BBAAB|       3|  3D    | 33D5D3 |
; |BB3BF333|33333FF |        |3D53BAB3|        |   3    |  33D3  |
; |AB3AB333|33333F3F|        | 3DD3BB |        |   3    |   33   |
; |--------|--------|--------|--------|--------|--------|--------|
; |3BBBAB33|33333F3E|
; |3BA26A33|3333333E|
; |BA2222B3|3333333E|
; |BBA2AAB3|33333355|
; |B3BABBB3|3333B337|
; | B3BBB33|13113B33|
; |     33C|11113B3 |
; |      3C|C11333  |
; |--------|--------|
$9E:E040             db 00,03,01,06,32,3B,73,73,57,77,DF,FF,FF,FF,6F,FF,03,03,06,07,0F,1B,0F,33,0A,32,00,70,08,D8,00,D8,
                        60,E0,38,F8,4C,FC,F4,FC,FA,FE,FE,FE,FE,FE,FF,FF,E0,E0,F8,B8,FC,FC,FC,FC,1E,1E,0E,0E,06,06,05,05,
                        3E,26,1C,1C,00,00,00,00,00,00,00,00,00,00,00,00,18,18,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FC,FC,86,FE,93,FF,E3,FF,E5,7F,D9,9F,FB,9F,7E,4E,00,FC,08,C6,04,DB,84,73,C0,37,40,3F,60,4E,30,36,
                        00,00,01,01,03,03,03,02,01,01,01,01,00,00,00,00,00,00,00,00,00,00,01,01,00,00,00,00,00,00,00,00,
                        00,00,18,18,3E,24,6F,4B,70,50,30,20,10,10,10,10,00,00,00,00,1A,0A,24,10,20,20,10,10,00,00,00,00,
                        78,68,FC,E4,DE,92,EF,89,F7,C5,7E,62,3C,34,18,18,10,90,38,08,5C,24,6E,52,36,2A,1C,14,08,08,00,00,
                        F7,FF,C3,FF,83,FF,C3,FF,EF,FF,7F,7F,06,06,02,02,00,7C,08,64,00,C2,00,EE,00,BE,00,5C,01,01,01,01,
                        FE,FF,FE,FF,FE,FF,FF,FC,FF,FF,FF,4F,FE,0E,7C,1C,05,05,01,01,01,01,03,00,01,08,00,04,00,04,80,80,
}


;;; $E160: Samus top tiles - set 2 - entry 18h ;;;
{
; 11h: Moving right - aiming down-right - frames 3 / 8
; |--------|--------|--------|--------|--------|--------|--------|
; |      FF|FEE     | 3B3DD3 |        |  BBBBB |    3   |   33   |
; |    FFFE|F69E    |  3DD3  |        | BA622AB|    3D  |  3DD3  |
; |   FFEEE|FEFEE   |   33   |        |BAAA2B2A|    53  | 3D75D3 |
; |   FEFFF|FFFF9   |        |B       |BA6B22BA|    3D3 |3D5875D3|
; |  FEFF33|3FF4F   |        |B3      |BA22B2AB|33D3853 |33D5875D|
; | FFFF333|33F44   |        |53      |BAB2ABB8|  3D53  | 33D5873|
; | FFF3333|333F4   |        |3       |3BABB378|   33   |  33D533|
; | F3F3333|3333D   |        |        |3BAB3583|        |   33338|
; |--------|--------|--------|--------|--------|--------|--------|
; |FE3F3333|33333   |
; |FE333333|333BAB2 |
; |EF333333|33BA2AAA|
; |553F3333|3BA26ABA|
; |833FF333|BBA222AB|
; |333F3FF3|3BBA222A|
; |  3F3111|133BAAAB|
; |   33311|C133BBB3|
; |--------|--------|
$9E:E160             db 03,03,0E,0F,18,1F,17,1F,2F,3F,7F,7F,7F,7F,7F,7F,03,03,0F,0F,1F,1F,1F,1F,3C,3C,78,78,70,70,50,50,
                        80,E0,A0,D0,A0,F8,F8,F0,E8,E8,E0,E0,F0,F0,F8,F0,E0,E0,D0,B0,F8,F8,F0,F8,78,68,38,20,18,10,08,08,
                        7E,72,3C,24,18,18,00,00,00,00,00,00,00,00,00,00,0C,2C,18,18,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,80,80,C0,C0,C0,40,80,80,00,00,00,00,00,00,00,00,00,80,00,80,80,00,00,00,00,00,
                        3E,3E,41,7F,84,FF,92,FF,89,FF,A6,FE,DE,FE,DD,F9,00,3E,10,63,00,F5,20,D3,00,CB,00,EF,02,79,04,72,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        BF,FF,BF,FF,7F,FF,FF,3F,7F,7F,FF,FF,3F,38,1F,1C,D0,D0,C0,C0,C0,C0,D0,10,18,98,16,16,10,10,00,00,
                        F8,F8,F4,FE,E0,FF,C2,FF,C1,FF,E0,FF,F1,7F,7F,3F,00,00,00,1C,00,37,08,67,00,E3,00,71,00,1F,80,8E,
}


;;; $E280: Samus top tiles - set 2 - entry 19h ;;;
{
; 12h: Moving left  - aiming down-left - frames 3 / 8
; |--------|--------|--------|--------|--------|--------|--------|
; |     EEF|FF      |   33   | 3DD3B3 |        | BBBBB  |    3   |
; |    E96F|EFFF    |  3DD3  |  3333  |        |BA2A6AB |    3D  |
; |   EEFEF|EEEFF   | 3D75D3 |        |       B|A2B22BAB|    53  |
; |   9FFFF|FFFEF   |3D5875D3|        |      BB|AB22B6AB|    3D3 |
; |   F4FF3|333FEF  |33D5875D|        |      DB|BAAB22BB|33D3853 |
; |   44F33|333EFFF | 33D5873|        |      35|8BBA2BAB|  3D53  |
; |   4F333|3333FFF |  33D533|        |       3|873BBAB3|   33   |
; |   D3333|3333F3F |   33338|        |        |3853BBB3|        |
; |--------|--------|--------|--------|--------|--------|--------|
; |   3B333|3333F3EF|
; | 2BBAB33|333333EF|
; |AABA2AB3|333333FE|
; |ABA22AAB|B333F355|
; |BBA622AB|333FF338|
; |BBA22ABB|3FF3F333|
; |A3BAABB3|1113F3  |
; |2A3BBB3C|11133   |
; |--------|--------|
$9E:E280             db 01,07,05,0B,05,1F,1F,0F,17,17,07,07,0F,0F,1F,0F,07,07,0B,0D,1F,1F,0F,1F,1E,16,1C,04,18,08,10,10,
                        C0,C0,70,F0,18,F8,E8,F8,F4,FC,EE,FE,FE,FE,FE,FE,C0,C0,F0,F0,F8,F8,F8,F8,1C,1C,1E,1E,0E,0E,0A,0A,
                        18,18,3C,24,7E,52,EF,89,F7,C4,7B,63,3F,33,1E,1E,00,00,18,18,3C,24,6E,52,37,29,1A,14,0C,08,00,01,
                        7E,4E,3C,3C,00,00,00,00,00,00,00,00,00,00,00,00,30,34,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,03,03,03,01,03,02,01,01,00,00,00,00,00,00,00,01,00,03,02,03,01,00,00,00,00,00,
                        7C,7C,82,FE,25,FF,49,FF,93,FF,65,7F,7B,7F,BF,9F,00,7C,08,D6,00,A7,04,CB,00,F3,00,F7,40,9E,20,4E,
                        08,08,0C,08,0C,04,0E,0A,F6,D2,3C,24,18,18,00,00,00,00,04,04,08,00,04,04,24,28,18,10,00,00,00,00,
                        1F,1F,37,7F,23,FF,41,FF,C1,FF,C3,FF,67,FF,3E,FE,00,08,00,3C,00,F6,00,E7,10,E3,00,E7,00,BE,01,5D,
                        FD,FF,FD,FF,FE,FF,FF,FC,FE,FE,FF,FF,FC,1C,F8,18,0B,0B,03,03,03,03,0B,88,18,19,68,68,08,08,00,00,
}


;;; $E3A0: Samus top tiles - set 2 - entry 1Ah ;;;
{
; 4Ah: Facing right - moonwalk - frames 1..2 / 4..5
; |--------|--------|--------|--------|--------|--------|
; |     FFF|FF      |AB3 3BAA|   3BBAA|        |        |
; |   3EF69|9EF     |BB   3BB|     B33|D33     |3DDDDDD3|
; |  3FFFFF|FFFF    |33    33|     3AA|53D3    |35555553|
; | 3FF3333|334F    |33      |      BB|7383    |38888873|
; | F33ABAB|3344    |        |        |5353    |35555553|
; | 33B2A2A|B734    |        |        |D3D3    |3DDDDDD3|
; |F3BA2A22|AB53    |        |        |333     |33333333|
; |33B22B6A|AB3F    |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|
; |F3BA2B2B|ABF3    |
; |F3BBABAB|B3FF    |
; |F3333BBD|5DFE    |
; |FF358785|33FFB   |
; |5F3DD333|B3F33   |
; |8D133BAA|BB33BBB |
; |  13BA62|AB333BAB|
; |  33BA22|AB3 3A26|
; |--------|--------|
$9E:E3A0             db 07,07,15,1E,3F,3F,7F,7F,75,7F,70,7F,E0,FF,E4,FF,07,07,0E,0D,1F,1F,30,30,40,4F,00,15,80,B4,02,25,
                        C0,C0,A0,60,F0,F0,D0,D0,C0,C0,E0,E0,70,D0,70,F0,C0,C0,60,E0,F0,F0,30,10,30,00,50,80,20,C0,10,D0,
                        6C,EF,C7,C7,C3,C3,C0,C0,00,00,00,00,00,00,00,00,00,C7,00,C3,00,00,00,00,00,00,00,00,00,00,00,00,
                        1C,1F,07,07,04,07,03,03,00,00,00,00,00,00,00,00,00,0F,00,04,00,03,00,03,00,00,00,00,00,00,00,00,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        E5,FF,F5,FF,FF,FE,F5,E4,FF,67,7C,1F,38,1F,38,3F,80,B5,80,BF,81,87,D5,CA,D8,58,40,C7,02,0C,00,0C,
                        70,F0,F0,F0,E0,30,F8,F8,F8,F8,FE,FE,7D,FF,68,EF,20,E0,30,B0,F0,70,30,38,20,A0,00,CE,00,C7,01,C4,
}


;;; $E4A0: Samus top tiles - set 2 - entry 1Bh ;;;
{
; 49h: Facing left  - moonwalk - frames 1..2 / 4..5
; |--------|--------|--------|--------|--------|--------|
; |      FE|FFF     |2AB31   |B326AB3A|        |        |
; |     FE9|96FE3   |AB3     |3BA2A33B|D33     |3DDDDDD3|
; |    FFFF|FFFFF3  |B3      |33BAA3B3|53D3    |35555553|
; |    F433|3333FF3 |3       | 33BB3AB|7383    |38888873|
; |    443B|BABA33F |        |    33BB|5353    |35555553|
; |    43BB|A2A2B333|        |        |D3D3    |3DDDDDD3|
; |    35BA|22A2AB3F|        |        |333     |33333333|
; |    F3BA|A6B2AB33|        |        |        |        |
; |--------|--------|--------|--------|--------|--------|
; |    33BA|B2B2BB3F|
; |    FF3B|BABABB3F|
; |    EF35|DBBB333F|
; |    EF33|58785D3F|
; |    3F3B|333333DD|
; | BB333BA|AAAB3138|
; |B2A333A2|26AB31  |
; |AA3AB3A2|22A333  |
; |--------|--------|
$9E:E4A0             db 02,03,05,06,0F,0F,0B,0B,03,03,07,07,0E,0B,0E,0F,03,03,06,07,0F,0F,0C,08,0C,01,08,03,04,03,08,0B,
                        E0,E0,A8,78,FC,FC,FE,FE,AE,FE,0F,FF,07,FF,27,FF,E0,E0,70,B0,F8,F8,0C,0C,02,F2,00,A8,01,2D,40,AC,
                        38,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        C6,FF,C7,FF,E7,FF,7D,7F,0F,0F,00,00,00,00,00,00,10,8D,00,69,00,3A,00,1B,00,03,00,00,00,00,00,00,
                        00,00,E0,60,F0,50,D0,D0,F0,50,F0,50,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        0E,0F,0F,0F,07,0E,07,0F,0F,0F,7E,7F,9C,FF,2C,FF,00,03,0C,0D,0D,0C,0C,0C,04,05,00,63,00,A2,00,DA,
                        AF,FF,AF,FF,FF,7F,AF,23,FF,FC,1E,FA,1C,F8,1C,FC,01,AD,01,FD,81,F1,AD,55,03,03,00,F1,40,30,00,20,
}


;;; $E5A0: Samus top tiles - set 2 - entry 1Ch ;;;
{
; 29h: Facing right - falling - frames 1 / 5
; |--------|--------|--------|--------|--------|--------|--------|
; |      FF|F       |        |BB3DDDDD|        |333373AA|        |
; |    FFEF|EEFF    |D3D3    |BA355555|        | 333732B|        |
; |   FE69F|EEEFF   |5353D3  |BA388888|        | 33383B3|        |
; |   E99FF|FFFEFF  |737383  |3B355555|        | 3353BB |  33333 |
; |  E4FEF3|33FFE3  |535353  | 33DDDDD|        |  3D333 |333BBA33|
; |  343F33|B33333F |D3D3D3  |  333333|        |        |3D583BAB|
; |  437F3B|BB33FFF |33333   |        |        |        |33385B2A|
; |  453F3B|ABB3FFFF|        |        |        |        |333573BB|
; |--------|--------|--------|--------|--------|--------|--------|
; |  3F3333|BB33FFEF|
; |  F33F33|3333FF35|
; |  3FEEF3|333FF357|
; |   3FFFF|F333F333|
; |    3FFF|3333333 |
; |      33|3113333 |
; |      31|CC1113  |
; |       3|1CC113  |
; |--------|--------|
$9E:E5A0             db 03,03,0D,0F,13,1D,0F,13,0B,2F,2F,2F,1F,1F,1F,0F,03,03,0F,0F,1D,1B,13,1F,3E,2E,14,04,2C,05,34,05,
                        80,80,30,F0,18,F8,EC,FC,F4,FC,FE,FE,FE,FE,7F,FF,80,80,F0,F0,F8,F8,FC,FC,38,38,02,82,0E,CE,0F,EF,
                        00,00,F0,50,FC,54,F4,F4,FC,54,FC,54,F8,F8,00,00,00,00,A0,A0,A8,08,A0,08,A8,00,A8,A8,00,00,00,00,
                        FF,E0,BF,E0,A0,E0,FF,E0,7F,60,3F,3F,00,00,00,00,1F,DF,1F,C0,00,DF,1F,40,1F,1F,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FC,FF,7D,7F,77,77,7E,6E,3E,2E,00,00,00,00,00,00,08,03,08,01,00,0A,10,06,10,10,00,00,00,00,00,00,
                        00,00,00,00,00,00,3E,3E,FB,FF,ED,8F,EC,E7,FF,EF,00,00,00,00,00,00,00,00,00,1C,60,57,08,15,18,03,
                        3F,3F,3F,3F,33,3F,1F,1F,0F,0F,03,03,03,02,01,01,10,10,24,24,1E,1E,0F,0F,07,07,00,00,00,00,00,00,
                        FD,FF,FF,FE,FF,FD,FF,FF,FE,FE,FE,9E,3C,04,9C,04,0F,CF,0D,0C,1B,18,88,88,00,00,00,00,C0,C0,60,60,
}


;;; $E6C0: Samus top tiles - set 2 - entry 1Dh ;;;
{
; 29h: Facing right - falling - frame 2
; 50h: Facing right - damage boost - frame 9
; |--------|--------|--------|--------|--------|--------|
; |      FF|F       |    33  |        |333373AA|        |
; |    FFEF|EEFF    |DD3D5D3 |        | 333732B|        |
; |   FE69F|EEEFF   |538373D |   333DD| 33383B3|        |
; |   E99FF|FFFEFF  |737353D |  3B3D58| 3353BB |  33333 |
; |  E4FEF3|33FFE3  |53533D3 | 3B23588|  3D333 |333BBA33|
; |  343F33|B33333F |DD3D33  | 3BA3D55|        |3D583BAB|
; |  437F3B|BB33FFF |3333    |  3B33DD|        |33385B2A|
; |  453F3B|ABB3FFFF|        |  333333|        |333573BB|
; |--------|--------|--------|--------|--------|--------|
; |  3F3333|BB33FFEF|
; |  F33F33|3333FF35|
; |  3FEEF3|333FF357|
; |   3FFFF|F333F333|
; |    3FFF|3333333 |
; |      33|3113333 |
; |      31|CC1113  |
; |       3|1CC113  |
; |--------|--------|
$9E:E6C0             db 03,03,0D,0F,13,1D,0F,13,0B,2F,2F,2F,1F,1F,1F,0F,03,03,0F,0F,1D,1B,13,1F,3E,2E,14,04,2C,05,34,05,
                        80,80,30,F0,18,F8,EC,FC,F4,FC,FE,FE,FE,FE,7F,FF,80,80,F0,F0,F8,F8,FC,FC,38,38,02,82,0E,CE,0F,EF,
                        0C,0C,FE,22,DE,5C,FE,F4,FE,5A,FC,2C,F0,F0,00,00,00,00,DC,D4,8A,22,AA,02,A4,04,D0,D0,00,00,00,00,
                        00,00,00,00,1F,1C,3E,38,6C,78,6F,78,3F,3C,3F,3F,00,00,00,00,03,03,06,15,04,23,07,34,03,13,00,00,
                        FC,FF,7D,7F,77,77,7E,6E,3E,2E,00,00,00,00,00,00,08,03,08,01,00,0A,10,06,10,10,00,00,00,00,00,00,
                        00,00,00,00,00,00,3E,3E,FB,FF,ED,8F,EC,E7,FF,EF,00,00,00,00,00,00,00,00,00,1C,60,57,08,15,18,03,
                        3F,3F,3F,3F,33,3F,1F,1F,0F,0F,03,03,03,02,01,01,10,10,24,24,1E,1E,0F,0F,07,07,00,00,00,00,00,00,
                        FD,FF,FF,FE,FF,FD,FF,FF,FE,FE,FE,9E,3C,04,9C,04,0F,CF,0D,0C,1B,18,88,88,00,00,00,00,C0,C0,60,60,
}


;;; $E7C0: Samus top tiles - set 2 - entry 1Eh ;;;
{
; Dh: Unused. Moving right - aiming up - frames 3 / 8
; 2Ah: Facing left  - falling - frames 1 / 5
; |--------|--------|--------|--------|--------|--------|
; |      FF|F       |        | 333    |333373AA|        |
; |    FFEF|EEFF    |333333  |32AB3333| 333732B|        |
; |   FE69F|EEEFF   |AAAAB33 |A24A3BBA| 33383B3|        |
; |   E99FF|FFFEFF  |222B3A23|3AAB3BA2| 3353BB |  33333 |
; |  E4FEF3|33FFE3  |BBAA3BA3| 333333B|  3D333 |333BBA33|
; |  343F33|B33333F |33BB333 |       3|        |3D583BAB|
; |  437F3B|BB33FFF |  333   |        |        |33385B2A|
; |  453F3B|ABB3FFFF|        |        |        |333573BB|
; |--------|--------|--------|--------|--------|--------|
; |  3F3333|BB33FFEF|
; |  F33F33|3333FF35|
; |  3FEEF3|333FF357|
; |   3FFFF|F333F333|
; |    3FFF|3333333 |
; |      33|3113333 |
; |      31|CC1113  |
; |       3|1CC113  |
; |--------|--------|
$9E:E7C0             db 03,03,0D,0F,13,1D,0F,13,0B,2F,2F,2F,1F,1F,1F,0F,03,03,0F,0F,1D,1B,13,1F,3E,2E,14,04,2C,05,34,05,
                        80,80,30,F0,18,F8,EC,FC,F4,FC,FE,FE,FE,FE,7F,FF,80,80,F0,F0,F8,F8,FC,FC,38,38,02,82,0E,CE,0F,EF,
                        00,00,FC,FC,0E,FE,19,FF,CD,FF,FE,FE,38,38,00,00,00,00,00,00,00,F8,00,14,00,F6,00,30,00,00,00,00,
                        70,70,9F,FF,0E,DF,9C,FF,7F,7F,01,01,00,00,00,00,00,00,00,30,20,97,00,76,00,01,00,00,00,00,00,00,
                        FC,FF,7D,7F,77,77,7E,6E,3E,2E,00,00,00,00,00,00,08,03,08,01,00,0A,10,06,10,10,00,00,00,00,00,00,
                        00,00,00,00,00,00,3E,3E,FB,FF,ED,8F,EC,E7,FF,EF,00,00,00,00,00,00,00,00,00,1C,60,57,08,15,18,03,
                        3F,3F,3F,3F,33,3F,1F,1F,0F,0F,03,03,03,02,01,01,10,10,24,24,1E,1E,0F,0F,07,07,00,00,00,00,00,00,
                        FD,FF,FF,FE,FF,FD,FF,FF,FE,FE,FE,9E,3C,04,9C,04,0F,CF,0D,0C,1B,18,88,88,00,00,00,00,C0,C0,60,60,
}


;;; $E8C0: Samus top tiles - set 2 - entry 1Fh ;;;
{
; Eh: Unused. Moving left  - aiming up - frames 3 / 8
; 2Ah: Facing left  - falling - frame 2
; 4Fh: Facing left  - damage boost - frame 9
; |--------|--------|--------|--------|--------|--------|
; |      FF|F       |        |   3AAB |333373AA|        |
; |    FFEF|EEFF    |333     |   A24A3| 333732B|        |
; |   FE69F|EEEFF   |ABB333  |   A22A3| 33383B3|        |
; |   E99FF|FFFEFF  |A22AB33 |   3BAB3| 3353BB |  33333 |
; |  E4FEF3|33FFE3  |BA22A323|    3B33|  3D333 |333BBA33|
; |  343F33|B33333F |3BAA23A3|        |        |3D583BAB|
; |  437F3B|BB33FFF | 3BBA333|        |        |33385B2A|
; |  453F3B|ABB3FFFF| 333BA3 |        |        |333573BB|
; |--------|--------|--------|--------|--------|--------|
; |  3F3333|BB33FFEF|
; |  F33F33|3333FF35|
; |  3FEEF3|333FF357|
; |   3FFFF|F333F333|
; |    3FFF|3333333 |
; |      33|3113333 |
; |      31|CC1113  |
; |       3|1CC113  |
; |--------|--------|
$9E:E8C0             db 03,03,0D,0F,13,1D,0F,13,0B,2F,2F,2F,1F,1F,1F,0F,03,03,0F,0F,1D,1B,13,1F,3E,2E,14,04,2C,05,34,05,
                        80,80,30,F0,18,F8,EC,FC,F4,FC,FE,FE,FE,FE,7F,FF,80,80,F0,F0,F8,F8,FC,FC,38,38,02,82,0E,CE,0F,EF,
                        00,00,E0,E0,7C,FC,0E,FE,85,FF,C5,FF,77,7F,7A,7E,00,00,00,00,00,E0,00,98,00,C8,00,72,00,38,00,0C,
                        12,1E,01,1B,01,1F,1B,1F,0F,0F,00,00,00,00,00,00,00,0E,04,12,00,12,00,0E,00,04,00,00,00,00,00,00,
                        FC,FF,7D,7F,77,77,7E,6E,3E,2E,00,00,00,00,00,00,08,03,08,01,00,0A,10,06,10,10,00,00,00,00,00,00,
                        00,00,00,00,00,00,3E,3E,FB,FF,ED,8F,EC,E7,FF,EF,00,00,00,00,00,00,00,00,00,1C,60,57,08,15,18,03,
                        3F,3F,3F,3F,33,3F,1F,1F,0F,0F,03,03,03,02,01,01,10,10,24,24,1E,1E,0F,0F,07,07,00,00,00,00,00,00,
                        FD,FF,FF,FE,FF,FD,FF,FF,FE,FE,FE,9E,3C,04,9C,04,0F,CF,0D,0C,1B,18,88,88,00,00,00,00,C0,C0,60,60,
}
}


;;; $E9C0..F6BF: Samus bottom tiles - set 3 (unused) ;;;
{
;;; $E9C0: Samus bottom tiles - set 3 - entry 0 ;;;
{
; Unused
; |--------|--------|
; |    BBCC|C99CCC  |
; |   BC911|11EEE9C |
; |  BCBCC9|1EEEEE1C|
; | BBBBC91|E199CCCC|
; |BB  CC11|9CCB    |
; |B   C919|C       |
; |   C99CC|        |
; |   99CB |        |
; |--------|--------|
; |  C9C   |        |
; |  9C    |        |
; |  CB    |        |
; | BB     |        |
; | BB     |        |
; | B      |        |
; | B      |        |
; | B      |        |
; |--------|--------|
$9E:E9C0             db 0C,0C,17,10,29,28,7B,78,C3,C0,87,80,0C,00,1A,02,03,0F,08,1C,16,3F,04,7E,0C,CC,08,8D,13,1F,04,1E,
                        60,00,C4,38,82,7C,70,80,90,10,00,00,00,00,00,00,9C,FC,3A,3E,7D,7D,8F,BF,60,F0,80,80,00,00,00,00,
                        10,00,20,00,10,10,60,60,60,60,40,40,40,40,40,40,28,38,10,30,20,30,00,60,00,60,00,40,00,40,00,40,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $EA40: Samus bottom tiles - set 3 - entry 1 ;;;
{
; Unused
; |--------|--------|--------|--------|
; |        |     BBB|       C|C   BBBB|
; |        |  BBBBBB|      CC|  CCCBB |
; |        |BBBBB   |     91C|CC9CC   |
; |      BB|BB      |    C19C|9CC     |
; |     BBB|        |    C1C1|C       |
; |    BBB |        |   C9E1C|        |
; |   BBB  |        |   C1E9C|        |
; |   BB   |        |   CE9C |        |
; |--------|--------|--------|--------|
; |  BB    |        |   9EC  |        |
; |  BB    |        |   19   |        |
; | BB     |        | B CC   |        |
; | BB     |        | B C    |        |
; | BB     |        | B      |        |
; |BB      |        |BB      |        |
; |BB      |        |BB      |        |
; |BB      |        |BB      |        |
; |--------|--------|--------|--------|
$9E:EA40             db 00,00,00,00,00,00,03,03,07,07,0E,0E,1C,1C,18,18,00,00,00,00,00,00,00,03,00,07,00,0E,00,1C,00,18,
                        07,07,3F,3F,F8,F8,C0,C0,00,00,00,00,00,00,00,00,00,07,00,3F,00,F8,00,C0,00,00,00,00,00,00,00,00,
                        00,00,00,00,06,00,06,00,05,00,0A,04,0A,04,04,08,01,01,03,03,01,05,09,0B,0A,0A,15,1D,15,17,1A,1E,
                        0F,0F,06,06,20,00,80,00,00,00,00,00,00,00,00,00,80,8F,38,3E,D8,F8,60,E0,80,80,00,00,00,00,00,00,
                        30,30,30,30,60,60,60,60,60,60,C0,C0,C0,C0,C0,C0,00,30,00,30,00,60,00,60,00,60,00,C0,00,C0,00,C0,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        10,08,18,00,40,40,40,40,40,40,C0,C0,C0,C0,C0,C0,0C,1C,00,08,18,58,10,50,00,40,00,C0,00,C0,00,C0,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $EB40: Samus bottom tiles - set 3 - entry 2 ;;;
{
; Unused
; |--------|--------|
; |        |   BB   |
; |BBBBC   |    BB  |
; |   BCCCC|     BB |
; |      CC|9C   BBB|
; |       C|99CC BCB|
; |        |C99CCC9B|
; |        | C119C9B|
; |        | C91199C|
; |--------|--------|
; |        |  C9111C|
; |        |   C1E11|
; |        |   C1EE9|
; |        |    9EE9|
; |        |    CE1C|
; |        |    CE9C|
; |        |    C1CB|
; |        |    C9B |
; |--------|--------|
$9E:EB40             db 00,00,F0,F0,10,10,00,00,00,00,00,00,00,00,00,00,00,00,08,F8,0F,1F,03,03,01,01,00,00,00,00,00,00,
                        18,18,0C,0C,06,06,87,07,C5,05,63,01,3B,01,3E,00,00,18,00,0C,00,06,40,C7,32,F7,9C,FF,44,4F,41,67,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1E,00,0B,04,09,06,09,06,02,04,02,04,05,01,06,02,21,31,14,14,16,17,06,0F,0D,0D,0D,0F,0A,0B,08,0E,
}


;;; $EBC0: Samus bottom tiles - set 3 - entry 3 ;;;
{
; Unused
; |--------|--------|--------|--------|
; |BB      |        |        |     BBB|
; |BB      |        |        |  BBBBBB|
; |CC      |        |        |BBBBB   |
; |CCC     |        |      BB|BB      |
; | CC     |        |     BBB|        |
; | CCC    |        |    BBB |        |
; |9 9C    |        |   BBB  |        |
; |C111C   |        |   BB   |        |
; |--------|--------|--------|--------|
; | C9119  |        |  BB    |        |
; | CC9EEEC|        |  BB    |        |
; |  CCC1EE|19C     | BB     |        |
; |    CCCC|CCCC    | BB     |        |
; |        |        | BB     |        |
; |        | BBBB   |BB      |        |
; |        |   BBBBB|BB      |        |
; |        |     BBB|BB      |        |
; |--------|--------|--------|--------|
$9E:EBC0             db C0,C0,C0,C0,00,00,00,00,00,00,00,00,A0,00,70,00,00,C0,00,C0,C0,C0,E0,E0,60,60,70,70,10,B0,88,88,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,03,03,07,07,0E,0E,1C,1C,18,18,00,00,00,00,00,00,00,03,00,07,00,0E,00,1C,00,18,
                        07,07,3F,3F,F8,F8,C0,C0,00,00,00,00,00,00,00,00,00,07,00,3F,00,F8,00,C0,00,00,00,00,00,00,00,00,
                        3C,00,10,0E,04,03,00,00,00,00,00,00,00,00,00,00,40,64,6F,7F,3B,3B,0F,0F,00,00,00,00,00,00,00,00,
                        00,00,00,00,C0,00,00,00,00,00,78,78,1F,1F,07,07,00,00,00,00,20,60,F0,F0,00,00,00,78,00,1F,00,07,
                        30,30,30,30,60,60,60,60,60,60,C0,C0,C0,C0,C0,C0,00,30,00,30,00,60,00,60,00,60,00,C0,00,C0,00,C0,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $ECC0: Samus bottom tiles - set 3 - entry 4 ;;;
{
; Unused
; |--------|--------|
; |    BBCC|C99CCC  |
; |   BC911|11EEE9C |
; |  BCBCC9|1EEEEE1C|
; | BBBBC91|E199CCCC|
; |BB  CC11|9CCB    |
; |B   C919|C       |
; |   C99CC|        |
; |   99CB |        |
; |--------|--------|
; |  C9C   |        |
; |  9C    |        |
; |  CB    |        |
; | BB     |        |
; | BB     |        |
; | B      |        |
; | B      |        |
; | B      |        |
; |--------|--------|
$9E:ECC0             db 0C,0C,17,10,29,28,7B,78,C3,C0,87,80,0C,00,1A,02,03,0F,08,1C,16,3F,04,7E,0C,CC,08,8D,13,1F,04,1E,
                        60,00,C4,38,82,7C,70,80,90,10,00,00,00,00,00,00,9C,FC,3A,3E,7D,7D,8F,BF,60,F0,80,80,00,00,00,00,
                        10,00,20,00,10,10,60,60,60,60,40,40,40,40,40,40,28,38,10,30,20,30,00,60,00,60,00,40,00,40,00,40,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $ED40: Samus bottom tiles - set 3 - entry 5 ;;;
{
; Unused
; |--------|--------|--------|--------|
; |       C|C   BBBB|        |     BBB|
; |      CC|  CCCBB |        |  BBBBBB|
; |     91C|CC9CC   |        |BBBBB   |
; |    C19C|9CC     |      BB|BB      |
; |    C1C1|C       |     BBB|        |
; |   C9E1C|        |    BBB |        |
; |   C1E9C|        |   BBB  |        |
; |   CE9C |        |   BB   |        |
; |--------|--------|--------|--------|
; |   9EC  |        |  BB    |        |
; |   19   |        |  BB    |        |
; | B CC   |        | BB     |        |
; | B C    |        | BB     |        |
; | B      |        | BB     |        |
; |BB      |        |BB      |        |
; |BB      |        |BB      |        |
; |BB      |        |BB      |        |
; |--------|--------|--------|--------|
$9E:ED40             db 00,00,00,00,06,00,06,00,05,00,0A,04,0A,04,04,08,01,01,03,03,01,05,09,0B,0A,0A,15,1D,15,17,1A,1E,
                        0F,0F,06,06,20,00,80,00,00,00,00,00,00,00,00,00,80,8F,38,3E,D8,F8,60,E0,80,80,00,00,00,00,00,00,
                        00,00,00,00,00,00,03,03,07,07,0E,0E,1C,1C,18,18,00,00,00,00,00,00,00,03,00,07,00,0E,00,1C,00,18,
                        07,07,3F,3F,F8,F8,C0,C0,00,00,00,00,00,00,00,00,00,07,00,3F,00,F8,00,C0,00,00,00,00,00,00,00,00,
                        10,08,18,00,40,40,40,40,40,40,C0,C0,C0,C0,C0,C0,0C,1C,00,08,18,58,10,50,00,40,00,C0,00,C0,00,C0,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        30,30,30,30,60,60,60,60,60,60,C0,C0,C0,C0,C0,C0,00,30,00,30,00,60,00,60,00,60,00,C0,00,C0,00,C0,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $EE40: Samus bottom tiles - set 3 - entry 6 ;;;
{
; Unused
; |--------|--------|
; |        |   BB   |
; |BBBBC   |    BB  |
; |   BCCCC|     BB |
; |      CC|9C   BBB|
; |       C|99CC BCB|
; |        |C99CCC9B|
; |        | C119C9B|
; |        | C91199C|
; |--------|--------|
; |        |  C9111C|
; |        |   C1E11|
; |        |   C1EE9|
; |        |    9EE9|
; |        |    CE1C|
; |        |    CE9C|
; |        |    C1CB|
; |        |    C9B |
; |--------|--------|
$9E:EE40             db 00,00,F0,F0,10,10,00,00,00,00,00,00,00,00,00,00,00,00,08,F8,0F,1F,03,03,01,01,00,00,00,00,00,00,
                        18,18,0C,0C,06,06,87,07,C5,05,63,01,3B,01,3E,00,00,18,00,0C,00,06,40,C7,32,F7,9C,FF,44,4F,41,67,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1E,00,0B,04,09,06,09,06,02,04,02,04,05,01,06,02,21,31,14,14,16,17,06,0F,0D,0D,0D,0F,0A,0B,08,0E,
}


;;; $EEC0: Samus bottom tiles - set 3 - entry 7 ;;;
{
; Unused
; |--------|--------|--------|--------|
; |        |     BBB|BB      |        |
; |        |  BBBBBB|BB      |        |
; |        |BBBBB   |CC      |        |
; |      BB|BB      |CCC     |        |
; |     BBB|        | CC     |        |
; |    BBB |        | CCC    |        |
; |   BBB  |        |9 9C    |        |
; |   BB   |        |C111C   |        |
; |--------|--------|--------|--------|
; |  BB    |        | C9119  |        |
; |  BB    |        | CC9EEEC|        |
; | BB     |        |  CCC1EE|19C     |
; | BB     |        |    CCCC|CCCC    |
; | BB     |        |        |        |
; |BB      |        |        | BBBB   |
; |BB      |        |        |   BBBBB|
; |BB      |        |        |     BBB|
; |--------|--------|--------|--------|
$9E:EEC0             db 00,00,00,00,00,00,03,03,07,07,0E,0E,1C,1C,18,18,00,00,00,00,00,00,00,03,00,07,00,0E,00,1C,00,18,
                        07,07,3F,3F,F8,F8,C0,C0,00,00,00,00,00,00,00,00,00,07,00,3F,00,F8,00,C0,00,00,00,00,00,00,00,00,
                        C0,C0,C0,C0,00,00,00,00,00,00,00,00,A0,00,70,00,00,C0,00,C0,C0,C0,E0,E0,60,60,70,70,10,B0,88,88,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        30,30,30,30,60,60,60,60,60,60,C0,C0,C0,C0,C0,C0,00,30,00,30,00,60,00,60,00,60,00,C0,00,C0,00,C0,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        3C,00,10,0E,04,03,00,00,00,00,00,00,00,00,00,00,40,64,6F,7F,3B,3B,0F,0F,00,00,00,00,00,00,00,00,
                        00,00,00,00,C0,00,00,00,00,00,78,78,1F,1F,07,07,00,00,00,00,20,60,F0,F0,00,00,00,78,00,1F,00,07,
}


;;; $EFC0: Samus bottom tiles - set 3 - entry 8 ;;;
{
; Unused
; |--------|--------|
; |        |     26E|
; |        |  BA2226|
; |        |BBAAABB2|
; |      BB|BB     B|
; |     BBB|        |
; |    BBB |        |
; |   BB   |        |
; |   B    |        |
; |--------|--------|
; |  B     |        |
; |        |        |
; | B      |        |
; |        |        |
; |        |        |
; |B       |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:EFC0             db 00,00,00,00,00,00,03,03,07,07,0E,0E,18,18,10,10,00,00,00,00,00,00,00,03,00,07,00,0E,00,18,00,10,
                        00,07,20,3F,C6,FF,C1,C1,00,00,00,00,00,00,00,00,03,01,01,30,00,FE,00,C1,00,00,00,00,00,00,00,00,
                        20,20,00,00,40,40,00,00,00,00,80,80,00,00,00,00,00,20,00,00,00,40,00,00,00,00,00,80,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $F040: Samus bottom tiles - set 3 - entry 9 ;;;
{
; Unused
; |--------|--------|--------|--------|
; |        |     BB |        |     BB |
; | B      |  BBB   |        |  BBB   |
; |  A     |AAB     |        |BBB     |
; |   2  22|AA      |   B  BB|BB      |
; |    2662|        |    BBBB|        |
; |    6E6B|        |    BBB |        |
; |   2662 |        |   BBBB |        |
; |   22B A|        |   BB  A|        |
; |--------|--------|--------|--------|
; |  AA    |        |  BB    |        |
; |  AA    |        |  BB    |        |
; | BB     |        | BB     |        |
; | B      |        | BB     |        |
; | B      |        | B      |        |
; |B       |        |BB      |        |
; |B       |        |B       |        |
; |        |        |        |        |
; |--------|--------|--------|--------|
$9E:F040             db 00,00,40,40,00,20,00,13,00,0F,01,0F,00,1E,04,1D,00,00,00,40,00,20,00,00,06,00,0E,05,0C,00,00,05,
                        06,06,38,38,20,E0,00,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,13,13,0F,0F,0E,0E,1E,1E,18,19,00,00,00,00,00,00,00,13,00,0F,00,0E,00,1E,00,19,
                        06,06,38,38,E0,E0,C0,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,30,00,30,60,60,40,40,40,40,80,80,80,80,00,00,00,30,00,30,00,60,00,40,00,40,00,80,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        30,30,30,30,60,60,60,60,40,40,C0,C0,80,80,00,00,00,30,00,30,00,60,00,60,00,40,00,C0,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $F140: Samus bottom tiles - set 3 - entry Ah ;;;
{
; Unused
; |--------|--------|
; |        |     B  |
; |        |  B     |
; |        |B       |
; |      BB|        |
; |     BB |        |
; |    BB  |        |
; |   BB   |        |
; |   BB   |        |
; |--------|--------|
; |  BB    |        |
; |  BB    |        |
; | BA     |        |
; | AA     |        |
; | 2A     |        |
; |22B     |        |
; |66B     |        |
; |E22B    |        |
; |--------|--------|
$9E:F140             db 00,00,00,00,00,00,03,03,06,06,0C,0C,18,18,18,18,00,00,00,00,00,00,00,03,00,06,00,0C,00,18,00,18,
                        04,04,20,20,80,80,00,00,00,00,00,00,00,00,00,00,00,04,00,20,00,80,00,00,00,00,00,00,00,00,00,00,
                        30,30,30,30,40,60,00,60,00,60,20,E0,20,E0,10,F0,00,30,00,30,00,60,00,60,00,20,00,20,C0,20,80,90,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $F1C0: Samus bottom tiles - set 3 - entry Bh ;;;
{
; Unused
; |--------|--------|--------|--------|
; |        |     BB |        |     BB |
; | B      |  BBB   |        |  BBB   |
; |  A     |AAB     |        |BBB     |
; |   2  22|AA      |   B  BB|BB      |
; |    2662|        |    BBBB|        |
; |    6E6B|        |    BBB |        |
; |   2662 |        |   BBBB |        |
; |   22B A|        |   BB  A|        |
; |--------|--------|--------|--------|
; |  AA    |        |  BB    |        |
; |  AA    |        |  BB    |        |
; | BB     |        | BB     |        |
; | B      |        | BB     |        |
; | B      |        | B      |        |
; |B       |        |BB      |        |
; |B       |        |B       |        |
; |        |        |        |        |
; |--------|--------|--------|--------|
$9E:F1C0             db 00,00,40,40,00,20,00,13,00,0F,01,0F,00,1E,04,1D,00,00,00,40,00,20,00,00,06,00,0E,05,0C,00,00,05,
                        06,06,38,38,20,E0,00,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,13,13,0F,0F,0E,0E,1E,1E,18,19,00,00,00,00,00,00,00,13,00,0F,00,0E,00,1E,00,19,
                        06,06,38,38,E0,E0,C0,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,30,00,30,60,60,40,40,40,40,80,80,80,80,00,00,00,30,00,30,00,60,00,40,00,40,00,80,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        30,30,30,30,60,60,60,60,40,40,C0,C0,80,80,00,00,00,30,00,30,00,60,00,60,00,40,00,C0,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $F2C0: Samus bottom tiles - set 3 - entry Ch ;;;
{
; Unused
; |--------|--------|
; |        |     26E|
; |        |  BA2226|
; |        |BBAAABB2|
; |      BB|BB     B|
; |     BBB|        |
; |    BBB |        |
; |   BB   |        |
; |   B    |        |
; |--------|--------|
; |  B     |        |
; |        |        |
; | B      |        |
; |        |        |
; |        |        |
; |B       |        |
; |        |        |
; |        |        |
; |--------|--------|
$9E:F2C0             db 00,00,00,00,00,00,03,03,07,07,0E,0E,18,18,10,10,00,00,00,00,00,00,00,03,00,07,00,0E,00,18,00,10,
                        00,07,20,3F,C6,FF,C1,C1,00,00,00,00,00,00,00,00,03,01,01,30,00,FE,00,C1,00,00,00,00,00,00,00,00,
                        20,20,00,00,40,40,00,00,00,00,80,80,00,00,00,00,00,20,00,00,00,40,00,00,00,00,00,80,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $F340: Samus bottom tiles - set 3 - entry Dh ;;;
{
; Unused
; |--------|--------|--------|--------|
; |        |     BB |        |     BB |
; | B      |  BBB   |        |  BBB   |
; |  A     |AAB     |        |BBB     |
; |   2  22|AA      |   B  BB|BB      |
; |    2662|        |    BBBB|        |
; |    6E6B|        |    BBB |        |
; |   2662 |        |   BBBB |        |
; |   22B A|        |   BB  A|        |
; |--------|--------|--------|--------|
; |  AA    |        |  BB    |        |
; |  AA    |        |  BB    |        |
; | BB     |        | BB     |        |
; | B      |        | BB     |        |
; | B      |        | B      |        |
; |B       |        |BB      |        |
; |B       |        |B       |        |
; |        |        |        |        |
; |--------|--------|--------|--------|
$9E:F340             db 00,00,40,40,00,20,00,13,00,0F,01,0F,00,1E,04,1D,00,00,00,40,00,20,00,00,06,00,0E,05,0C,00,00,05,
                        06,06,38,38,20,E0,00,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,13,13,0F,0F,0E,0E,1E,1E,18,19,00,00,00,00,00,00,00,13,00,0F,00,0E,00,1E,00,19,
                        06,06,38,38,E0,E0,C0,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,30,00,30,60,60,40,40,40,40,80,80,80,80,00,00,00,30,00,30,00,60,00,40,00,40,00,80,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        30,30,30,30,60,60,60,60,40,40,C0,C0,80,80,00,00,00,30,00,30,00,60,00,60,00,40,00,C0,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $F440: Samus bottom tiles - set 3 - entry Eh ;;;
{
; Unused
; |--------|--------|
; |        |     B  |
; |        |  B     |
; |        |B       |
; |      BB|        |
; |     BB |        |
; |    BB  |        |
; |   BB   |        |
; |   BB   |        |
; |--------|--------|
; |  BB    |        |
; |  BB    |        |
; | BA     |        |
; | AA     |        |
; | 2A     |        |
; |22B     |        |
; |66B     |        |
; |E22B    |        |
; |--------|--------|
$9E:F440             db 00,00,00,00,00,00,03,03,06,06,0C,0C,18,18,18,18,00,00,00,00,00,00,00,03,00,06,00,0C,00,18,00,18,
                        04,04,20,20,80,80,00,00,00,00,00,00,00,00,00,00,00,04,00,20,00,80,00,00,00,00,00,00,00,00,00,00,
                        30,30,30,30,40,60,00,60,00,60,20,E0,20,E0,10,F0,00,30,00,30,00,60,00,60,00,20,00,20,C0,20,80,90,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $F4C0: Samus bottom tiles - set 3 - entry Fh ;;;
{
; Unused
; |--------|--------|--------|--------|
; |        |     BB |        |     BB |
; | B      |  BBB   |        |  BBB   |
; |  A     |AAB     |        |BBB     |
; |   2  22|AA      |   B  BB|BB      |
; |    2662|        |    BBBB|        |
; |    6E6B|        |    BBB |        |
; |   2662 |        |   BBBB |        |
; |   22B A|        |   BB  A|        |
; |--------|--------|--------|--------|
; |  AA    |        |  BB    |        |
; |  AA    |        |  BB    |        |
; | BB     |        | BB     |        |
; | B      |        | BB     |        |
; | B      |        | B      |        |
; |B       |        |BB      |        |
; |B       |        |B       |        |
; |        |        |        |        |
; |--------|--------|--------|--------|
$9E:F4C0             db 00,00,40,40,00,20,00,13,00,0F,01,0F,00,1E,04,1D,00,00,00,40,00,20,00,00,06,00,0E,05,0C,00,00,05,
                        06,06,38,38,20,E0,00,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,13,13,0F,0F,0E,0E,1E,1E,18,19,00,00,00,00,00,00,00,13,00,0F,00,0E,00,1E,00,19,
                        06,06,38,38,E0,E0,C0,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,30,00,30,60,60,40,40,40,40,80,80,80,80,00,00,00,30,00,30,00,60,00,40,00,40,00,80,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        30,30,30,30,60,60,60,60,40,40,C0,C0,80,80,00,00,00,30,00,30,00,60,00,60,00,40,00,C0,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $F5C0: Samus bottom tiles - set 3 - entry 10h ;;;
{
; Unused
; |--------|--------|--------|--------|
; |        |     BB |        |     BB |
; | B      |  BBB   |        |  BBB   |
; |  A     |AAB     |        |BBB     |
; |   2  22|AA      |   B  BB|BB      |
; |    2662|        |    BBBB|        |
; |    6E6B|        |    BBB |        |
; |   2662 |        |   BBBB |        |
; |   22B A|        |   BB  A|        |
; |--------|--------|--------|--------|
; |  AA    |        |  BB    |        |
; |  AA    |        |  BB    |        |
; | BB     |        | BB     |        |
; | B      |        | BB     |        |
; | B      |        | B      |        |
; |B       |        |BB      |        |
; |B       |        |B       |        |
; |        |        |        |        |
; |--------|--------|--------|--------|
$9E:F5C0             db 00,00,40,40,00,20,00,13,00,0F,01,0F,00,1E,04,1D,00,00,00,40,00,20,00,00,06,00,0E,05,0C,00,00,05,
                        06,06,38,38,20,E0,00,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,13,13,0F,0F,0E,0E,1E,1E,18,19,00,00,00,00,00,00,00,13,00,0F,00,0E,00,1E,00,19,
                        06,06,38,38,E0,E0,C0,C0,00,00,00,00,00,00,00,00,00,06,00,38,00,E0,00,C0,00,00,00,00,00,00,00,00,
                        00,30,00,30,60,60,40,40,40,40,80,80,80,80,00,00,00,30,00,30,00,60,00,40,00,40,00,80,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        30,30,30,30,60,60,60,60,40,40,C0,C0,80,80,00,00,00,30,00,30,00,60,00,60,00,40,00,C0,00,80,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}
}


;;; $F6C0: Free space ;;;
{
$9E:F6C0             fillto $9F8000, $FF
}
