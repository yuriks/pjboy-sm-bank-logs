;;; $8000..A7DF: Samus bottom tiles - set 0 (general) ;;;
{
;;; $8000: Samus bottom tiles - set 0 - entry 0 ;;;
{
; 9: Moving right - not aiming - frame 0
; Ah: Moving left  - not aiming - frame 0
; Bh: Moving right - gun extended - frame 0
; Ch: Moving left  - gun extended - frame 0
; Dh: Unused. Moving right - aiming up - frame 0
; Eh: Unused. Moving left  - aiming up - frame 0
; Fh: Moving right - aiming up-right - frame 0
; 10h: Moving left  - aiming up-left - frame 0
; 11h: Moving right - aiming down-right - frame 0
; 12h: Moving left  - aiming down-left - frame 0
; C5h: Unused - frames 0..7 / 9
; DFh: Unused - frames 0..7 / 9
; |--------|--------|--------|--------|
; |3A    32|2AB     |     333|3313    |
; |33    BA|AB      |    3BBB|B33     |
; |     3BB|3       |   3BBAA|BB3     |
; |    33BB|3       |   3BA22|AB33    |
; |   3B333|33      |   3B226|2AB3    |
; |  3BAB33|A3      |    3A22|2AB3    |
; |  3BABB2|B       |    3BA2|AAAB3   |
; |   3BBBB|3       |     3BA|A2AB3   |
; |--------|--------|--------|--------|
; |    3BAA|B       | 3BB  3B|222AB   |
; |     3BA|2AB     | 3BB333B|A22AB   |
; |      33|333     | 3B3BBB3|BAABB33 |
; |        |        | 3B33BB3|3BBB33A |
; |        |        |3BBA333B|3B333BA |
; |        |        |3BABBA 3|BAABBBB |
; |        |        |3B33   B|22AAAB3 |
; |        |        |3BB    A|622AB   |
; |--------|--------|--------|--------|
$9D:8000             db 82,C3,C2,C3,07,07,0F,0F,1F,1F,37,3F,36,3F,1F,1F,00,40,00,03,00,03,00,03,00,08,00,1C,00,1E,00,0F,
                        20,E0,40,C0,80,80,80,80,C0,C0,40,C0,80,80,80,80,00,60,00,C0,00,00,00,00,00,00,00,80,00,80,00,00,
                        07,07,0F,0F,1C,1F,18,1F,18,1F,08,0F,0C,0F,06,07,00,00,00,07,00,0F,00,0C,01,08,00,04,00,06,00,03,
                        F0,D0,E0,E0,E0,E0,70,F0,30,F0,30,F0,18,F8,18,F8,00,00,00,80,00,C0,00,C0,00,60,00,60,00,F0,00,B0,
                        0C,0F,06,07,03,03,00,00,00,00,00,00,00,00,00,00,00,07,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        80,80,20,E0,E0,E0,00,00,00,00,00,00,00,00,00,00,00,80,00,60,00,00,00,00,00,00,00,00,00,00,00,00,
                        73,73,7F,7F,7F,7F,7F,7F,EF,FF,D9,FD,F1,F1,E0,E1,00,31,00,31,00,2E,00,26,00,71,00,7C,00,41,00,61,
                        08,F8,08,F8,9E,FE,FC,FE,FC,FE,9E,FE,06,FE,08,F8,00,18,00,98,00,F8,00,72,00,46,00,FE,00,3C,80,18,
}


;;; $8100: Samus bottom tiles - set 0 - entry 1 ;;;
{
; 9: Moving right - not aiming - frame 2
; Ah: Moving left  - not aiming - frame 2
; Bh: Moving right - gun extended - frame 2
; Ch: Moving left  - gun extended - frame 2
; Dh: Unused. Moving right - aiming up - frame 2
; Eh: Unused. Moving left  - aiming up - frame 2
; Fh: Moving right - aiming up-right - frame 2
; 10h: Moving left  - aiming up-left - frame 2
; 11h: Moving right - aiming down-right - frame 2
; 12h: Moving left  - aiming down-left - frame 2
; |--------|--------|--------|--------|--------|--------|--------|
; |       B|A22AB3  |  33331C|13      |        |3BA2    |BB33    |
; |       B|AAAB3   | 33BB331|133     |        | 3BAAB3 |BBBA3   |
; |      33|3AB3    | 3BAAB31|3BB3    |        | 333333 |3BBA3   |
; |     3BB|333     |3BA22AB1|3AAB3   |       B|        | 3BBB   |
; |    3BAA|B3BA    |3B2622B3|3BAAB3  |      3B|        |  3BBA3 |
; |    BA62|ABAB    |BBA22AB3|1BBBAB3 |      33|        |   3333 |
; |   3B22A|BB     3|BABAABB3|1CBBBBB3|       3|        |        |
; |   BAAAB|      3B|B2ABBB33|31C1BB3A|        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|
; |  3BAB3 |      3B|A22AB3  |331333BA|
; |  BBB3  |       3|AAAB3   | 3BBB3BB|
; | 33B3   |        |3AB3    | BBABB3 |
; |B333    |        |333     |3BABB3  |
; |BBBAA   |        |B3BA    |3BBB3   |
; |AAAA    |        |ABAB    |BB333   |
; |BA23    |        |BB     3|333BA   |
; |3BBB    |        |      3B|B3BA    |
; |--------|--------|--------|--------|
$9D:8100             db 01,01,01,01,03,03,07,07,0C,0F,08,0F,18,1F,11,1F,00,01,00,01,00,00,00,03,00,07,02,0C,00,09,00,1F,
                        0C,FC,18,F8,B0,F0,E0,E0,E0,F0,50,F0,C1,C1,03,03,00,98,00,F0,00,60,00,00,00,B0,00,F0,00,C0,00,01,
                        3E,3C,7F,7E,67,7E,C3,FE,C3,FF,C3,FF,A7,FF,9F,FF,01,01,00,18,00,3C,00,66,10,42,00,E6,00,FE,00,BC,
                        C0,40,E0,60,F0,F0,98,F8,CC,FC,F6,7E,BF,3F,DE,8F,00,00,00,00,00,60,00,70,00,78,00,7C,40,7E,20,2D,
                        00,00,00,00,00,00,01,01,03,03,03,03,01,01,00,00,00,00,00,00,00,00,00,01,00,01,00,00,00,00,00,00,
                        C0,F0,66,7E,7E,7E,00,00,00,00,00,00,00,00,00,00,00,60,00,3C,00,00,00,00,00,00,00,00,00,00,00,00,
                        F0,F0,E8,F8,E8,F8,78,78,3A,3E,1E,1E,00,00,00,00,00,C0,00,F0,00,70,00,38,00,1C,00,00,00,00,00,00,
                        36,3E,3C,3C,78,78,F0,F0,E0,F8,00,F0,90,F0,F0,F0,00,1C,00,38,00,10,00,80,00,F8,00,F0,00,C0,00,70,
                        03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        0C,FC,18,F8,B0,F0,E0,E0,E0,F0,50,F0,C1,C1,03,03,00,98,00,F0,00,60,00,00,00,B0,00,F0,00,C0,00,01,
                        FE,DF,7F,7F,6E,7E,DC,FC,F8,F8,F8,F8,F0,F8,E0,F0,00,03,00,3B,00,7C,00,78,00,70,00,C0,00,18,00,B0,
}


;;; $8260: Samus bottom tiles - set 0 - entry 2 ;;;
{
; 9: Moving right - not aiming - frame 4
; Ah: Moving left  - not aiming - frame 4
; Bh: Moving right - gun extended - frame 4
; Ch: Moving left  - gun extended - frame 4
; Dh: Unused. Moving right - aiming up - frame 4
; Eh: Unused. Moving left  - aiming up - frame 4
; Fh: Moving right - aiming up-right - frame 4
; 10h: Moving left  - aiming up-left - frame 4
; 11h: Moving right - aiming down-right - frame 4
; 12h: Moving left  - aiming down-left - frame 4
; |--------|--------|--------|--------|--------|--------|--------|
; |        |     33B|     BBA|B3      |     33B|B3C3    |        |
; |        |     3BA|     3BA|AB      |     3BA|AB13    |3       |
; |     3  |    3BA2|      3B|AB      |    3BA2|AA33B   |A3      |
; |    3B3 |    3B22|      3B|BB3     |    3B22|2AB3A   |A3      |
; |   3BAB3|    BA26|       3|BB3B    |    BA26|2AB3AA  |B       |
; |  3BBAA3|3  3BB22|       3|BB3A    |3  3BB22|2B33A2  |B3      |
; | 3BAB33B|33 3ABBA|       3|333AB3  |33 3ABBA|BB33BAB |B3      |
; |33B2A3BB|AB3BA2AB|       3|BBBBAAAB|AB3BA2AB|B331BAA |B3      |
; |--------|--------|--------|--------|--------|--------|--------|
; |3B23A33A|AA3A222A|       3|BABBB333|AA3A222A|3311CBA3|
; |3A  B33B|A23BA2AB|       3|BB3333  |A23BA2AB|3311CBAB|
; |3B  3  3|A6BBAAB3|       3|333     |A6BBAAB3|  311CB3|
; |33      |BA23BB3 |        |        |BA23BB3 |   3133B|
; |        |3BB333  |        |        |3BB333  |    33BB|
; |        | BBBA3  |        |        | BBBA3  |    3BAA|
; |        |  3BBA  |        |        |  3BBA  |    3AAA|
; |        |        |        |        |        |    3BAA|
; |--------|--------|--------|--------|--------|--------|
$9D:8260             db 00,00,00,00,04,04,0E,0E,1B,1F,39,3F,6F,7F,E7,FF,00,00,00,00,00,00,00,04,00,0E,00,1E,00,39,00,2B,
                        07,07,06,07,0C,0F,0C,0F,08,0F,9C,9F,D6,DF,71,FF,00,01,00,03,00,06,00,04,01,0C,00,0C,00,0F,00,DB,
                        06,07,06,07,03,03,03,03,01,01,01,01,01,01,01,01,00,07,00,03,00,01,00,01,00,00,00,00,00,00,00,00,
                        C0,C0,40,C0,40,C0,E0,E0,F0,F0,E0,F0,EC,FC,F1,FF,00,80,00,C0,00,C0,00,C0,00,D0,00,D0,00,18,00,FF,
                        07,07,06,07,0C,0F,0C,0F,08,0F,9C,9F,D6,DF,71,FF,00,01,00,03,00,06,00,04,01,0C,00,0C,00,0F,00,DB,
                        D0,D0,70,D0,38,F8,30,F8,30,FC,70,FC,FA,FE,F8,EE,20,A0,00,C0,00,C8,00,68,00,6C,00,48,00,CE,00,8E,
                        00,00,80,80,40,C0,40,C0,80,80,C0,C0,C0,C0,C0,C0,00,00,00,00,00,80,00,80,00,80,00,80,00,80,00,80,
                        D6,FF,8F,CF,C9,C9,C0,C0,00,00,00,00,00,00,00,00,00,49,00,49,00,40,00,00,00,00,00,00,00,00,00,00,
                        20,FF,31,FF,33,FF,9E,FE,FC,FC,74,7C,38,3C,00,00,00,D1,00,9B,40,BE,00,CC,00,60,00,78,00,1C,00,00,
                        01,01,01,01,01,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        BF,FF,FC,FC,E0,E0,00,00,00,00,00,00,00,00,00,00,00,F8,00,C0,00,00,00,00,00,00,00,00,00,00,00,00,
                        20,FF,31,FF,33,FF,9E,FE,FC,FC,74,7C,38,3C,00,00,00,D1,00,9B,40,BE,00,CC,00,60,00,78,00,1C,00,00,
                        F5,C7,F5,C7,3B,23,1F,17,0F,0F,0C,0F,08,0F,0C,0F,08,0E,08,0F,04,06,00,01,00,03,00,07,00,07,00,07,
}


;;; $8400: Samus bottom tiles - set 0 - entry 3 ;;;
{
; 9: Moving right - not aiming - frame 5
; Ah: Moving left  - not aiming - frame 5
; Bh: Moving right - gun extended - frame 5
; Ch: Moving left  - gun extended - frame 5
; Dh: Unused. Moving right - aiming up - frame 5
; Eh: Unused. Moving left  - aiming up - frame 5
; Fh: Moving right - aiming up-right - frame 5
; 10h: Moving left  - aiming up-left - frame 5
; 11h: Moving right - aiming down-right - frame 5
; 12h: Moving left  - aiming down-left - frame 5
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 0
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 0
; C7h: Facing right - vertical shinespark windup - frame 0
; C8h: Facing left  - vertical shinespark windup - frame 0
; |--------|--------|--------|--------|
; |3B    3B|B333    |     333|11C13   |
; |      3B|BB3     |     3BB|BB13    |
; |      BB|B3      |     3BA|ABB33   |
; |     3BB|B       |     BA2|2ABB33  |
; |     3BB|3       |     BA2|62AB33  |
; |    B333|3AB     |     BA2|22BAB3  |
; |   3BB3A|AB      |     3BA|2AA2BB3 |
; |   3BBBB|B       |      3B|BB222AB |
; |--------|--------|--------|--------|
; |    3BAA|B       | 3BB3 33|3BA222A3|
; |     3BB|AAB3    | 3AA3333|33BA2ABB|
; |      33|3333    | 3BA3BBB|B33BABB3|
; |        |        | 3A33BAA|AABBBB33|
; |        |        |3B2AB3BB|A262B333|
; |        |        |3A2B2B33|BA22A3BB|
; |        |        |3AB BA 3|3BBAABAA|
; |        |        |3B     3|333BB33 |
; |--------|--------|--------|--------|
$9D:8400             db C3,C3,03,03,03,03,07,07,07,07,0F,0F,1E,1F,1F,1F,00,41,00,01,00,03,00,03,00,03,00,08,00,0D,00,0F,
                        F0,F0,E0,E0,C0,C0,80,80,80,80,A0,E0,40,C0,80,80,00,80,00,C0,00,80,00,80,00,00,00,60,00,C0,00,80,
                        07,07,07,07,06,07,04,07,04,07,04,07,06,07,03,03,00,00,00,03,00,03,00,06,00,06,00,06,00,03,00,01,
                        D8,08,F0,D0,78,F8,3C,FC,1C,FC,2C,FC,0E,FE,C2,FE,20,20,00,C0,00,E0,00,70,80,30,00,38,00,6C,00,C6,
                        0C,0F,07,07,03,03,00,00,00,00,00,00,00,00,00,00,00,07,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        80,80,30,F0,F0,F0,00,00,00,00,00,00,00,00,00,00,00,80,00,E0,00,00,00,00,00,00,00,00,00,00,00,00,
                        7B,7B,4F,7F,6F,7F,5C,7F,CF,FF,97,FF,A9,ED,C1,C1,00,30,00,30,00,37,00,27,00,5B,00,54,00,6C,00,40,
                        C1,FF,E3,FF,F7,FF,3F,FF,0F,FF,87,FF,E4,FF,FE,FE,00,62,00,37,00,9E,00,FC,20,88,00,CB,00,7F,00,18,
}


;;; $8500: Samus bottom tiles - set 0 - entry 4 ;;;
{
; 9: Moving right - not aiming - frame 7
; Ah: Moving left  - not aiming - frame 7
; Bh: Moving right - gun extended - frame 7
; Ch: Moving left  - gun extended - frame 7
; Dh: Unused. Moving right - aiming up - frame 7
; Eh: Unused. Moving left  - aiming up - frame 7
; Fh: Moving right - aiming up-right - frame 7
; 10h: Moving left  - aiming up-left - frame 7
; 11h: Moving right - aiming down-right - frame 7
; 12h: Moving left  - aiming down-left - frame 7
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |      3B|1111333B|  33331C|3       |        |        | 3BAA   |AB3     |
; |      B1|11C13   | 33BBBB3|        |        |        | 3BBBAB |BBA     |
; |     333|1C1     |33BAAABB|B       |        |        |  33333 |BA23    |
; |    BBB3|333     |3BA222AB|AB      |        |       B|        |3BA2B   |
; |    BABB|3BB     |3BA2622B|AAAB    |        |      3B|        | 3BAAB  |
; |   BAABB|3B     3|3BAA222A|22AAB   |       3|      33|        |  3333  |
; |   BBBB3|       3|B3BBAABA|222ABB3 |       3|       3|        |        |
; |  3BBB3 |      3B|1133BBBB|AAABB33A|      3B|        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; | 3BBB3  |     3BA|1111333B|BBB333BA|
; |33B33   |      3A|11C13   |333AAAB3|
; |B3333   |       3|1C1     | B62AB3 |
; |A33AAA  |        |333     |3A2AB3  |
; |B3BBA   |        |3BB     |BAAB3   |
; |BAAB    |        |3B     3|BB33    |
; |3BAA    |        |       3|333B3   |
; |3BBB    |        |      3B|BA2A3   |
; |--------|--------|--------|--------|
$9D:8500             db 03,03,03,02,07,07,0F,0F,0B,0F,13,1F,1F,1F,3E,3E,00,01,00,02,00,00,00,0E,00,0F,00,1F,00,1E,00,1C,
                        FF,0F,D8,08,A0,00,E0,E0,E0,E0,C1,C1,01,01,03,03,00,01,20,20,40,40,00,00,00,60,00,40,00,00,00,01,
                        3E,3C,7F,7F,E3,FF,C1,FF,C1,FF,C0,FF,F2,FF,FF,3F,01,01,00,1E,00,3F,00,63,08,61,00,71,00,BF,00,0F,
                        80,80,00,00,80,80,40,C0,10,F0,08,F8,0E,FE,1E,FF,00,00,00,00,00,80,00,C0,00,F0,00,38,00,1C,00,F9,
                        00,00,00,00,00,00,00,00,00,00,01,01,01,01,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,
                        00,00,00,00,00,00,01,01,03,03,03,03,01,01,00,00,00,00,00,00,00,00,00,01,00,01,00,00,00,00,00,00,
                        60,78,7A,7E,3E,3E,00,00,00,00,00,00,00,00,00,00,00,38,00,3E,00,00,00,00,00,00,00,00,00,00,00,00,
                        60,E0,C0,E0,90,F0,C8,F8,64,7C,3C,3C,00,00,00,00,00,C0,00,E0,00,C0,00,68,00,3C,00,00,00,00,00,00,
                        7C,7C,F8,F8,F8,F8,60,FC,F0,F8,90,F0,C0,F0,F0,F0,00,38,00,20,00,80,00,9C,00,B8,00,F0,00,70,00,70,
                        06,07,02,03,01,01,00,00,00,00,00,00,00,00,00,00,00,03,00,01,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,0F,D8,08,A0,00,E0,E0,E0,E0,C1,C1,01,01,03,03,00,01,20,20,40,40,00,00,00,60,00,40,00,00,00,01,
                        FE,FF,E3,FF,46,7E,8C,FC,98,F8,F0,F0,F8,F8,88,F8,00,E3,00,1E,20,4C,00,58,00,F0,00,C0,00,10,00,D0,
}


;;; $8680: Samus bottom tiles - set 0 - entry 5 ;;;
{
; 9: Moving right - not aiming - frame 9
; Ah: Moving left  - not aiming - frame 9
; Bh: Moving right - gun extended - frame 9
; Ch: Moving left  - gun extended - frame 9
; Dh: Unused. Moving right - aiming up - frame 9
; Eh: Unused. Moving left  - aiming up - frame 9
; Fh: Moving right - aiming up-right - frame 9
; 10h: Moving left  - aiming up-left - frame 9
; 11h: Moving right - aiming down-right - frame 9
; 12h: Moving left  - aiming down-left - frame 9
; |--------|--------|--------|--------|--------|--------|--------|
; |        |      33|   3A22B|        |      33|11C13   |  3BB   |
; |        |     33B|    BA2A|        |     33B|3313    |        |
; |        |    3BAA|    3BAA|3       |    3BAA|AB33    |        |
; |     3  |    BA22|     BBA|3 3     |    BA22|2AB3    |        |
; |    3B3 |    BA26|     3BB|B3A     |    BA26|22BB    |        |
; |   3BAB |    3A22|      BB|B32     |    3A22|22AB    |        |
; |  33BB3 |   33BA2|      33|33AB    |   33BA2|2ABAB   |        |
; | 33BB33B|   333BA|      3A|BAA22AAB|   333BA|AB22AB  |        |
; |--------|--------|--------|--------|--------|--------|--------|
; |33BBA3BB|B 3B133B|      3A|ABBBB333|B 3B133B|BA222AB3|
; |3BABA3BB|BB311133|      3B|B3333   |BB311133|3BA2AABA|
; |3A  BB3B|BAB311C1|      33|33      |BAB311C1| 3BAAB3A|
; |3B   B3B|BBB31C1 |        |        |BBB31C1 |  33B33B|
; |33     3|BBA331  |        |        |BBA331  |   33BB3|
; |        |BBBB33  |        |        |BBBB33  |   3BAAB|
; |        | BBB3   |        |        | BBB3   |   BA2AB|
; |        | BB33   |        |        | BB33   |   BA62B|
; |--------|--------|--------|--------|--------|--------|
$9D:8680             db 00,00,00,00,00,00,04,04,0E,0E,1A,1E,3E,3E,7F,7F,00,00,00,00,00,00,00,00,00,04,00,0E,00,0C,00,19,
                        03,03,07,07,0C,0F,08,0F,08,0F,08,0F,1C,1F,1E,1F,00,00,00,01,00,07,00,0C,01,0C,00,04,00,06,00,03,
                        11,1F,08,0F,0C,0F,06,07,07,07,03,03,03,03,02,03,00,09,00,0D,00,07,00,07,00,03,00,03,00,00,00,01,
                        00,00,00,00,80,80,A0,A0,C0,E0,C0,E0,D0,F0,81,FF,00,00,00,00,00,00,00,00,00,A0,00,80,00,30,00,E7,
                        03,03,07,07,0C,0F,08,0F,08,0F,08,0F,1C,1F,1E,1F,00,00,00,01,00,07,00,0C,01,0C,00,04,00,06,00,03,
                        D8,08,F0,D0,70,F0,30,F0,30,F0,10,F0,28,F8,44,FC,20,20,00,00,00,C0,00,60,00,30,00,30,00,78,00,CC,
                        38,38,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,18,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        F7,FF,D7,FF,8F,CF,C7,C7,C1,C1,00,00,00,00,00,00,00,3B,00,7B,00,4D,00,45,00,00,00,00,00,00,00,00,
                        BF,B7,FF,E3,BD,F0,FA,F0,DC,F8,FC,FC,78,78,78,78,00,91,00,C0,02,E2,04,E4,00,E0,00,F0,00,70,00,60,
                        02,03,03,03,03,03,00,00,00,00,00,00,00,00,00,00,00,01,00,01,00,00,00,00,00,00,00,00,00,00,00,00,
                        7F,FF,F8,F8,C0,C0,00,00,00,00,00,00,00,00,00,00,00,F8,00,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        BF,B7,FF,E3,BD,F0,FA,F0,DC,F8,FC,FC,78,78,78,78,00,91,00,C0,02,E2,04,E4,00,E0,00,F0,00,70,00,60,
                        83,FF,C2,FF,66,7F,3F,3F,1F,1F,19,1F,11,1F,11,1F,00,C6,00,6F,00,3D,00,09,00,06,00,0F,00,1B,04,19,
}


;;; $8820: Samus bottom tiles - set 0 - entry 6 ;;;
{
; 1: Facing right - normal - frames 0 / 5
; 2: Facing left  - normal - frames 0 / 5
; 47h: Unused - frame 0
; 48h: Unused - frame 0
; 89h: Facing right - ran into a wall - frame 0
; 8Ah: Facing left  - ran into a wall - frame 0
; A4h: Facing right - landing from normal jump - frame 1
; A5h: Facing left  - landing from normal jump - frame 1
; A6h: Facing right - landing from spin jump - frame 2
; A7h: Facing left  - landing from spin jump - frame 2
; A8h: Facing right - grappling - frame 0
; A9h: Facing left  - grappling - frame 0
; D5h: Facing right - x-ray - standing - frames 0..4
; D6h: Facing left  - x-ray - standing - frames 0..4
; E0h: Facing right - landing from normal jump - aiming up - frame 1
; E1h: Facing left  - landing from normal jump - aiming up - frame 1
; E2h: Facing right - landing from normal jump - aiming up-right - frame 1
; E3h: Facing left  - landing from normal jump - aiming up-left - frame 1
; E4h: Facing right - landing from normal jump - aiming down-right - frame 1
; E5h: Facing left  - landing from normal jump - aiming down-left - frame 1
; E6h: Facing right - landing from normal jump - firing - frame 1
; E7h: Facing left  - landing from normal jump - firing - frame 1
; |--------|--------|--------|--------|--------|--------|
; |       3|BA2AAB33|BA2AAB33|BBABB   |    BBBB|311     |
; |       3|BAABB3 3|BAABB3 3|BBBB    |   3BAAB|313B    |
; |      3B|BBB3   B|BBB3   B|BB3     |   BA22A|B33A    |
; |     B33|B33   3B|B33   3B|BB3B    |   A2222|A33AB   |
; |    BAB3|33A   33|33A   33|B3BB    |   A2622|A33AA   |
; |   3B2AB|AAB  333|AAB  333|3BAB    |   B2222|A31BAB  |
; |   3BABA|2B   3A3|2B   3A3|BAA3    |   BBAAA|B31BAB  |
; |   3BBAB|B3   3BB|B3   3BB|BBBB    |   BA22A|B31BBA  |
; |--------|--------|--------|--------|--------|--------|
; |    33BA|2BB  333|2BB  333|BAAAB   |    B22A|B311BAB |
; |     3BB|AAAB   3|AAAB   3|3BBAAAB |    B22A|B331BBB |
; |      33|3333    |3333    |3333333 |    BAAB|B3311B3 |
; |        |        |        |        |    33B3|333333B3|
; |        |        |        |        |   3BBBB|A33B3BA3|
; |        |        |        |        | 3BBBAB2|A3BBA3B |
; |        |        |        |        |3BAABABA|3BBBBB3 |
; |        |        |        |        |BA62AAB3|3BAAB3  |
; |--------|--------|--------|--------|--------|--------|
$9D:8820             db 01,01,01,01,03,03,07,07,0B,0F,19,1F,1A,1F,1D,1F,00,00,00,00,00,01,00,04,00,0E,00,0B,00,0F,00,0F,
                        87,FF,9D,FD,F1,F1,E3,E3,C3,E3,27,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        87,FF,9D,FD,F1,F1,E3,E3,C3,E3,27,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        D8,F8,F0,F0,E0,E0,F0,F0,F0,F0,D0,F0,90,F0,F0,F0,00,F8,00,F0,00,C0,00,D0,00,B0,00,70,00,E0,00,F0,
                        0F,0F,19,1F,10,1F,00,1F,00,1F,10,1F,18,1F,10,1F,00,0F,00,0F,00,19,00,10,04,10,00,10,00,1F,00,19,
                        E0,80,F0,B0,E0,F0,68,F8,60,F8,74,DC,F4,DC,F8,DC,00,00,00,10,00,90,00,98,00,98,00,9C,00,9C,00,9C,
                        0E,0F,07,07,03,03,00,00,00,00,00,00,00,00,00,00,00,03,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        88,F8,E2,FE,FE,FE,00,00,00,00,00,00,00,00,00,00,00,F8,00,7E,00,00,00,00,00,00,00,00,00,00,00,00,
                        08,0F,08,0F,09,0F,0F,0F,1F,1F,7A,7F,CA,FF,83,FF,00,09,00,09,00,0F,00,02,00,0F,00,3E,00,7F,20,CE,
                        FA,CE,FE,EE,FE,E6,FF,FF,7D,FF,76,FE,FE,FE,CC,FC,00,8E,00,8E,00,84,00,02,00,96,00,BA,00,7C,00,78,
}


;;; $89A0: Samus bottom tiles - set 0 - entry 7 ;;;
{
; 27h: Facing right - crouching - frames 0..3 / 5..8
; 28h: Facing left  - crouching - frames 0..3 / 5..8
; 71h: Facing right - crouching - aiming up-right - frame 0
; 72h: Facing left  - crouching - aiming up-left - frame 0
; 73h: Facing right - crouching - aiming down-right - frame 0
; 74h: Facing left  - crouching - aiming down-left - frame 0
; 85h: Facing right - crouching - aiming up - frames 0..1
; 86h: Facing left  - crouching - aiming up - frames 0..1
; B4h: Facing right - grappling - crouching - frame 0
; B5h: Facing left  - grappling - crouching - frame 0
; B6h: Facing right - grappling - crouching - aiming down-right - frame 0
; B7h: Facing left  - grappling - crouching - aiming down-left - frame 0
; D9h: Facing right - x-ray - crouching - frames 0..4
; DAh: Facing left  - x-ray - crouching - frames 0..4
; |--------|--------|--------|--------|
; |      3B|3BAAAB3C|3BAAAB3C|11333   |
; |      3A|3BBBBB31|3BBBBB31|3BBB3   |
; |      3B|311BBB3B|311BBB3B|BAAAB3  |
; |       3|3311113B|3311113B|AA22AB  |
; |       3|B333113B|B333113B|A262AB  |
; |       3|BBB333BA|BBB333BA|B222A3  |
; |        |3BBB3BBA|3BBB3BBA|BA2AB3  |
; |        |3BB33BA2|3BB33BA2|2BAB333 |
; |--------|--------|--------|--------|
; |        | 3B3BBA2| 3B3BBA2|ABB33333|
; |        |B3333BBA|B3333BBA|B333B3B3|
; |        |AB33333B|AB33333B|33A3BAA3|
; |        | AB3BAB3| AB3BAB3|BA33BBA3|
; |        | 3B33BAB| 3B33BAB|B33B3333|
; |       B|BA3B3333|BA3B3333|33333AB3|
; |      BA|ABB3B333|ABB3B333|3BAABB3 |
; |      33|33333333|33333333|3333333 |
; |--------|--------|--------|--------|
$9D:89A0             db 03,03,02,03,03,03,01,01,01,01,01,01,00,00,00,00,00,01,00,01,00,01,00,00,00,00,00,00,00,00,00,00,
                        C6,FE,FF,FE,FF,9F,FF,C3,FF,F3,FE,FF,FE,FF,FC,FF,01,7D,00,7C,00,1D,00,01,00,81,00,E3,00,77,00,66,
                        C6,FE,FF,FE,FF,9F,FF,C3,FF,F3,FE,FF,FE,FF,FC,FF,01,7D,00,7C,00,1D,00,01,00,81,00,E3,00,77,00,66,
                        F8,38,F8,F8,8C,FC,04,FC,04,FC,84,FC,8C,FC,5E,FE,00,00,00,70,00,F8,00,CC,20,8C,00,88,00,D8,00,70,
                        00,00,00,00,00,00,00,00,00,00,01,01,02,03,03,03,00,00,00,00,00,00,00,00,00,00,00,01,00,03,00,00,
                        7C,7F,FE,FF,7F,FF,3B,7F,7D,7F,BF,FF,7F,FF,FF,FF,00,2E,00,87,00,C1,00,6E,00,27,00,D0,00,E8,00,00,
                        7C,7F,FE,FF,7F,FF,3B,7F,7D,7F,BF,FF,7F,FF,FF,FF,00,2E,00,87,00,C1,00,6E,00,27,00,D0,00,E8,00,00,
                        7F,FF,FF,FF,D9,FF,BD,FF,FF,FF,FB,FF,CE,FE,FE,FE,00,E0,00,8A,00,2E,00,CE,00,90,00,06,00,7C,00,00,
}


;;; $8AA0: Samus bottom tiles - set 0 - entry 8 ;;;
{
; 9: Moving right - not aiming - frame 1
; Ah: Moving left  - not aiming - frame 1
; Bh: Moving right - gun extended - frame 1
; Ch: Moving left  - gun extended - frame 1
; Dh: Unused. Moving right - aiming up - frame 1
; Eh: Unused. Moving left  - aiming up - frame 1
; Fh: Moving right - aiming up-right - frame 1
; 10h: Moving left  - aiming up-left - frame 1
; 11h: Moving right - aiming down-right - frame 1
; 12h: Moving left  - aiming down-left - frame 1
; |--------|--------|--------|--------|--------|--------|
; |  311CC1|3       |     3BA|AB  3BBB|        |        |
; | 33331C1|B3      |    33BB|B    3BB|        |A       |
; |3BAAB311|BB3     |    3BB3|      3B|        |B       |
; |3A22AB31|BABB    |  3B3333|       3|        |BB      |
; |3A262A31|BAAAB   | 3AA33BA|B       |       3|33      |
; |3A222A31|1BBAAB  | 3ABBA2B|        |      3B|        |
; |3B222B31|C1BBA33 | 3BBAAB |        |      3A|        |
; |3BBBBA33|1C11B3B3|  3BBBB |        |     3BA|        |
; |--------|--------|--------|--------|--------|--------|
; | BA22A33|33333BA3|   3BA2B|        |
; | 3A22A33|3BBBBBB |    3BAA|B3      |
; | 3BAAB33|BBAAB3  |     333|33      |
; |3333B33B|BAA3    |        |        |
; |BBB33A3B|B3      |        |        |
; |A22ABA33|3       |        |        |
; |62AAB333|33      |        |        |
; |2AB333BB|AB      |        |        |
; |--------|--------|--------|--------|
$9D:8AA0             db 39,20,7D,78,CF,FC,87,FE,83,FE,83,FE,C7,FE,FB,FF,06,06,02,02,00,78,00,4C,10,44,00,44,00,44,00,7C,
                        80,80,C0,C0,E0,E0,B0,F0,88,F8,E4,7C,76,3E,BF,0F,00,00,00,80,00,C0,00,F0,00,F8,00,7C,80,B8,40,4A,
                        06,07,0F,0F,0F,0F,3F,3F,4E,7F,59,7F,72,7E,3E,3E,00,03,00,03,00,06,00,10,00,33,00,3D,00,3E,00,1E,
                        4F,CF,87,87,03,03,01,01,80,80,00,00,00,00,00,00,00,C7,00,83,00,01,00,00,00,80,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,01,01,03,03,02,03,06,07,00,00,00,00,00,00,00,00,00,00,00,01,00,01,00,03,
                        00,00,00,80,80,80,C0,C0,C0,C0,00,00,00,00,00,00,00,00,00,80,00,80,00,C0,00,00,00,00,00,00,00,00,
                        43,7F,43,7F,67,7F,FF,FF,FB,FF,0B,FF,0F,FF,3F,FF,00,64,00,24,00,3C,00,09,00,E5,00,9C,80,38,00,63,
                        FD,FF,FE,FE,CC,FC,90,F0,C0,C0,80,80,C0,C0,40,C0,00,06,00,7E,00,F8,00,E0,00,80,00,00,00,00,00,C0,
                        19,1F,0C,0F,07,07,00,00,00,00,00,00,00,00,00,00,00,0D,00,07,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,C0,C0,C0,C0,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $8BE0: Samus bottom tiles - set 0 - entry 9 ;;;
{
; 9: Moving right - not aiming - frame 3
; Ah: Moving left  - not aiming - frame 3
; Bh: Moving right - gun extended - frame 3
; Ch: Moving left  - gun extended - frame 3
; Dh: Unused. Moving right - aiming up - frame 3
; Eh: Unused. Moving left  - aiming up - frame 3
; Fh: Moving right - aiming up-right - frame 3
; 10h: Moving left  - aiming up-left - frame 3
; 11h: Moving right - aiming down-right - frame 3
; 12h: Moving left  - aiming down-left - frame 3
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |B3311CBA|B       |      33|331C3   |        |3BAA22A |        | 3ABBBBB|
; |3  311BA|B3B     |      3B|BBB133  |        |3BABA   |        | 3BB3333|
; |    311B|33A     |     3BA|AAB13B3 |        |3B2     |        | 3333   |
; |    3313|3BA     |     BA2|22AB3AB |        |3AA     |      3B|        |
; |     33B|BBB     |    3B22|62AB3AA3|        |32      |33333BA2|        |
; |     3BB|AB3     |    BBA2|22B33AAB|        |3A      |3AA3BAAA|        |
; |      BA|AB3     |   3B2AB|2AB31BAA|AB3     |33      |3AA33BBB|        |
; |      BA|ABB     |   BA22A|BB31CBAA|333     |        |3BB33333|        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |      BB|AAB     |   BA22A|B3311CBA|
; |      3B|BAB3    |  33BAAB|3  311BA|
; |       3|BBB3    |33333BB3|    311B|
; |        |3BAB 3  |AABB333 |    3313|
; |        | BBB3A  |62AB3B  |     33B|
; |        | 3BB3A3 |AAABAB  |     3BB|
; |        | 3333AB |BBBBB   |      BA|
; |        | 3BB3BAA|33BB    |      BA|
; |--------|--------|--------|--------|
$9D:8BE0             db FA,E3,9E,93,0F,09,0F,0D,07,07,07,07,02,03,02,03,04,87,00,03,00,01,00,00,00,01,00,03,00,03,00,03,
                        80,80,E0,E0,C0,E0,C0,E0,E0,E0,60,E0,60,E0,60,E0,00,80,00,A0,00,20,00,60,00,E0,00,C0,00,C0,00,E0,
                        03,03,03,03,06,07,04,07,0C,0F,0C,0F,19,1F,10,1F,00,00,00,01,00,03,00,06,00,04,00,0E,00,0B,00,19,
                        E8,C8,FC,EC,3E,EE,1A,FE,19,FF,39,FF,3C,F7,F4,E7,10,10,00,E0,00,E4,00,36,80,36,00,27,00,67,08,CF,
                        00,00,00,00,00,00,00,00,00,00,00,00,60,E0,E0,E0,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,00,
                        C0,FE,D0,F8,C0,E0,80,E0,80,C0,80,C0,C0,C0,00,00,00,72,00,78,00,40,00,60,00,00,00,40,00,00,00,00,
                        00,00,00,00,00,00,03,03,FC,FF,98,FF,9F,FF,FF,FF,00,00,00,00,00,00,00,01,00,06,00,6F,00,67,00,60,
                        5F,7F,7F,7F,78,78,00,00,00,00,00,00,00,00,00,00,00,3F,00,30,00,00,00,00,00,00,00,00,00,00,00,00,
                        03,03,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,03,00,01,00,00,00,00,00,00,00,00,00,00,00,00,
                        20,E0,B0,F0,F0,F0,D4,F4,78,7C,7A,7E,7A,7E,7C,7F,00,E0,00,E0,00,E0,00,70,00,74,00,34,00,06,00,37,
                        10,1F,39,3F,FF,FF,3E,FE,1C,FC,14,FC,F8,F8,F0,F0,00,19,00,0F,00,06,00,F0,80,34,00,FC,00,F8,00,30,
                        FA,E3,9E,93,0F,09,0F,0D,07,07,07,07,02,03,02,03,04,87,00,03,00,01,00,00,00,01,00,03,00,03,00,03,
}


;;; $8D60: Samus bottom tiles - set 0 - entry Ah ;;;
{
; 9: Moving right - not aiming - frame 6
; Ah: Moving left  - not aiming - frame 6
; Bh: Moving right - gun extended - frame 6
; Ch: Moving left  - gun extended - frame 6
; Dh: Unused. Moving right - aiming up - frame 6
; Eh: Unused. Moving left  - aiming up - frame 6
; Fh: Moving right - aiming up-right - frame 6
; 10h: Moving left  - aiming up-left - frame 6
; 11h: Moving right - aiming down-right - frame 6
; 12h: Moving left  - aiming down-left - frame 6
; |--------|--------|--------|--------|--------|--------|
; |  31CCC1|3       |        |BB13333B|        |     3BA|
; | 333BBB3|        |       3|B11113 3|B3      |     3BB|
; | 3BAAABB|3       |      33|31113 3B|33      |      33|
; |3BA222AB|B3      |      3B|333333BA|        |        |
; |3BA2622B|ABB     |     3BA|B33B3BBB|        |        |
; |3BBA22AB|2AAB    |     3BA|B3AA33B3|        |        |
; |33BBAABA|22AAB   |     3AB|B3A33BA2|        |        |
; |3B33BBBB|AAAB33  |     3AB|B333BB3 |        |        |
; |--------|--------|--------|--------|--------|--------|
; |BB13333B|BBB33BA3|     3BB|3 3BBA  |
; |B11113 3|BBAABBA3|    3BBB|3  3BA  |
; |31113 3B|B262AB3 |    33B3|3  3BA  |
; |333333BA|AAAA33  |   3B333|3   3BA |
; |B33B3BBB|B333    |  3BAB3B|BA   33 |
; |B3AA33B3|3       |  3BBBBB|A       |
; |B3A33BA2|A3      |   3BBBB|        |
; |B333BB3 |        |    3BBA|        |
; |--------|--------|--------|--------|
$9D:8D60             db 31,20,7F,7F,63,7F,C1,FF,C1,FF,E1,FF,F2,FF,FF,FF,0E,0E,00,0E,00,3F,00,63,08,61,00,73,00,3F,00,4F,
                        80,80,00,00,80,80,C0,C0,60,E0,10,F0,08,F8,1C,FC,00,00,00,00,00,00,00,80,00,E0,00,70,00,38,00,F0,
                        00,00,01,01,03,03,03,03,06,07,06,07,05,07,05,07,00,00,00,00,00,00,00,01,00,03,00,03,00,03,00,03,
                        FF,DF,FD,85,FB,8B,FE,FF,FF,FF,CF,FF,DC,FF,FE,FE,00,C1,00,80,00,01,00,03,00,97,00,B2,00,A6,00,8C,
                        00,00,C0,C0,C0,C0,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        06,07,07,07,03,03,00,00,00,00,00,00,00,00,00,00,00,03,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,DF,FD,85,FB,8B,FE,FF,FF,FF,CF,FF,DC,FF,FE,FE,00,C1,00,80,00,01,00,03,00,97,00,B2,00,A6,00,8C,
                        FD,FF,CD,FF,86,FE,0C,FC,F0,F0,80,80,40,C0,00,00,00,E6,00,FE,20,8C,00,F0,00,80,00,00,00,80,00,00,
                        07,07,0F,0F,0F,0F,1F,1F,37,3F,3F,3F,1F,1F,0E,0F,00,03,00,07,00,02,00,08,00,1D,00,1F,00,0F,00,07,
                        B8,BC,98,9C,98,9C,8C,8E,86,C6,00,80,00,00,00,00,00,1C,00,0C,00,0C,00,06,00,C0,00,80,00,00,00,00,
}


;;; $8EA0: Samus bottom tiles - set 0 - entry Bh ;;;
{
; 9: Moving right - not aiming - frame 8
; Ah: Moving left  - not aiming - frame 8
; Bh: Moving right - gun extended - frame 8
; Ch: Moving left  - gun extended - frame 8
; Dh: Unused. Moving right - aiming up - frame 8
; Eh: Unused. Moving left  - aiming up - frame 8
; Fh: Moving right - aiming up-right - frame 8
; 10h: Moving left  - aiming up-left - frame 8
; 11h: Moving right - aiming down-right - frame 8
; 12h: Moving left  - aiming down-left - frame 8
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3BAA222B|3B      |       3|11CC13  |        | ABA2BBB|3BBAAAB |        |
; |333BA2AB|3BB     |      33|33313   |        | ABBB333|3BBBA   |        |
; |13 33BB3|3BA     |      3B|BB333   |        | 3333   |3BA     |        |
; |3    333|BBB     |     3BA|22AB3   |        |        |3AA     |      3B|
; |      3B|AB3     |     3A2|622AB3  |        |        |3A      |333333BB|
; |      BA|2AB     |     3A2|222ABB3 |        |        |3B      |3BB3BBAA|
; |      B2|62B     |    33BA|22AA2AB3|AA3     |        |33      |3BB3BBBB|
; |      B2|22B     |    3B3B|AAB222AB|333     |        |        |3B333333|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |      3A|22B     |   3BA13|3BAA222B|
; |       B|A2A3    |  3BB111|333BA2AB|
; |       3|AAAB    |3333111C|13 33BB3|
; |        |BAAB    |BBB331C1|3    333|
; |        |3BAB3A  |AABB3313|      3B|
; |        | BBB32  |BBBB333 |      BA|
; |        | 3B3AAB |BBBBB3  |      B2|
; |        | 333ABA2|333BAB3 |      B2|
; |--------|--------|--------|--------|
$9D:8EA0             db C1,FF,F1,FF,DF,5F,87,87,03,03,02,03,02,03,02,03,00,71,00,1B,00,06,00,00,00,01,00,03,00,02,00,02,
                        C0,C0,E0,E0,C0,E0,E0,E0,60,E0,20,E0,20,E0,20,E0,00,40,00,60,00,60,00,E0,00,C0,00,60,80,20,00,20,
                        01,01,03,03,03,03,06,07,04,07,04,07,0E,0F,0F,0F,00,00,00,00,00,01,00,03,00,02,00,02,00,03,00,05,
                        CC,04,F8,E8,F8,F8,18,F8,0C,FC,0E,FE,03,FF,21,FF,30,30,00,00,00,C0,00,30,80,18,00,1C,00,36,00,E3,
                        00,00,00,00,00,00,00,00,00,00,00,00,20,E0,E0,E0,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,00,
                        27,7F,3F,7F,78,78,00,00,00,00,00,00,00,00,00,00,00,77,00,78,00,00,00,00,00,00,00,00,00,00,00,00,
                        E2,FE,F0,F8,C0,E0,80,E0,80,C0,C0,C0,C0,C0,00,00,00,7E,00,78,00,60,00,60,00,40,00,40,00,00,00,00,
                        00,00,00,00,00,00,03,03,FF,FF,FC,FF,FF,FF,FF,FF,00,00,00,00,00,00,00,01,00,03,00,6F,00,6F,00,40,
                        02,03,01,01,01,01,00,00,00,00,00,00,00,00,00,00,00,01,00,01,00,00,00,00,00,00,00,00,00,00,00,00,
                        20,E0,10,F0,10,F0,90,F0,D8,FC,78,7C,72,7E,74,7F,00,20,00,A0,00,F0,00,F0,00,74,00,70,00,2E,00,0E,
                        1B,1D,3F,38,FE,F0,FD,F8,3F,FD,FE,FE,FC,FC,F6,FE,00,0C,00,18,01,01,02,E2,00,F0,00,F0,00,F8,00,1C,
                        C1,FF,F1,FF,DF,5F,87,87,03,03,02,03,02,03,02,03,00,71,00,1B,00,06,00,00,00,01,00,03,00,02,00,02,
}


;;; $9020: Samus bottom tiles - set 0 - entry Ch ;;;
{
; 0: Facing forward - power suit - frame 0
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |B3   3BB|AB      |1C111C13|  3333  |    3333|    3333|     BBB|     BAB|
; |B     BA|BAB     |C1CCC1C |  B2AB  |    5785|    D7D7|     BBB|    BABA|
; |B     BA|2AB     |1C111C13|  BAAB  |    3333|   388D5|    33B3|    BA2A|
; |B     BA|2A      |31CCC133|   BA3  |    D78D|   37855|    2B33|     A2A|
; |B     BA|2A      |331C133B|3  BB3  |     333|   38755|   33AB3|     A2A|
; |       B|2B      |B31C13BB|B  333  |        |   35755|  B2233B|     B2B|
; |       B|AB      |B33133BA|B 3BAAB |        |    3785|BAAAAB3A|     BAB|
; |       B|CB      |C13331C2|A 3A22B |        |    5785|33333333|     BCB|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |       B|BB      |C13 31C2|A 3A3AB |    3 A2|    B  3|
; |       B|BB      |C13 31CA|B  3AA  |    3 BA|    3   |
; |       3|B33     |B13 31BA|B       |    3 BA|    D3 3|
; |       3|3B2     |B3   3BC|B       |    3 BC|    D3 3|
; |B     B3|BA33    |B3   3BB|B       |    3 BB|    D33B|
; |B     BB|3322B   |B3   3B3|3       |      33|    D3BB|
; |3     3A|3AAAAAB |33   33B|AB      |     BAB|    3 BA|
; |3     33|3333333 |B3   3BA|2B      |     B2A|    3 A2|
; |--------|--------|--------|--------|--------|--------|
$9D:9020             db C7,C7,82,83,82,83,82,83,82,83,01,01,01,01,01,01,00,83,00,83,00,83,00,83,00,83,00,01,00,01,00,01,
                        40,C0,A0,E0,20,E0,00,C0,00,C0,40,C0,40,C0,40,40,00,C0,00,E0,00,60,00,40,00,40,00,40,00,C0,80,C0,
                        BB,01,44,00,BB,01,C7,83,EF,C7,EF,C7,FE,EF,7C,39,44,44,BA,BA,44,44,38,38,10,11,10,93,00,83,82,82,
                        3C,3C,24,3C,24,3C,14,1C,9C,9C,9C,9C,B2,BE,22,BE,00,00,00,2C,00,3C,00,18,00,18,00,80,00,9E,00,92,
                        0F,0F,0D,04,0F,0F,0D,04,07,07,00,00,00,00,00,00,00,00,0D,02,00,00,0D,0B,00,00,00,00,00,00,00,00,
                        0F,0F,0F,05,13,10,1B,18,17,14,1F,14,0D,0C,0D,04,00,00,0F,0A,03,0E,0B,04,07,08,0F,00,05,02,0D,02,
                        07,07,07,07,0F,0F,07,0F,1B,1F,27,3F,86,FF,FF,FF,00,07,00,07,00,02,00,04,00,06,00,21,00,FD,00,00,
                        05,07,0A,0F,08,0F,00,07,00,07,05,07,05,07,05,05,00,07,00,0F,00,0D,00,05,00,05,00,05,00,07,02,07,
                        01,01,01,01,01,01,01,01,83,83,83,83,82,83,83,83,00,01,00,01,00,00,00,00,00,82,00,83,00,01,00,00,
                        C0,C0,C0,C0,E0,E0,C0,E0,B0,F0,C8,F8,82,FE,FE,FE,00,C0,00,C0,00,80,00,40,00,C0,00,08,00,7E,00,00,
                        6C,29,6C,29,EE,AB,C6,C6,C7,C7,C7,C7,C7,C7,C6,C7,82,82,82,83,00,83,01,83,00,83,00,82,00,01,00,83,
                        2A,BE,90,9C,80,80,80,80,80,80,80,80,40,C0,40,C0,00,96,00,8C,00,80,00,80,00,80,00,00,00,C0,00,40,
                        08,0B,0A,0B,0A,0B,0A,0A,0B,0B,03,03,05,07,04,07,00,02,00,03,00,03,01,03,00,03,00,00,00,07,00,05,
                        09,09,08,08,0D,05,0D,05,0F,07,0F,07,0A,0B,08,0B,00,08,00,00,08,08,08,08,08,09,08,0B,00,03,00,02,
}


;;; $91E0: Samus bottom tiles - set 0 - entry Dh ;;;
{
; 9Bh: Facing forward - varia/gravity suit - frame 0
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |BB3 3BBA|BAB3    |1C111C13|333333A |    3333|    3333|     BAB|   3BABA|
; |AB3 3BA2|62A3    |C1CCC1C3|B3BB22A |    5785|    D7D7|   233BB|   3A262|
; |AB3 3BA2|22A3    |1C111C13|AB3B22A |    3333|   388D5|   A23BB|   3A222|
; |B3   3BA|2AB     |31CCC13B|2B3BA2  |    D78D|   37855|   BAA33|    BA2A|
; |B3   3BA|2A3     |B31C13BB|6A3BAA  |     333|   38755|   33AB3|    3A2A|
; |B     BA|2A      |B31C13BB|2A3333  |        |   35755|  B2A33A|     A2A|
; |B     BA|2A      |B13131BB|AA3B22A |        |    3785|BA222A3A|     A2A|
; |B     BB|AA      |BC333CB2|BA3A22A |        |    5785|33333333|     AAB|
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3     3B|AB      |BC3 3CB2|AB3232A |    3BA2|    3333|
; |3     3B|B332    |C13 31CB|2B 322B |    3B2B|    D3B3|
; |3     3B|B32A    |C3   3CB|AB  BB  |    3BAB|    3BA3|
; |3     33|3AAB    |13   313|3B      |    3B33|    3A2B|
; |2     23|BA33    |33   33B|A3      |     3AB|    3A6B|
; |A     AA|33A2B   |3     3A|6B      |     B6A|    3A2B|
; |3     3A|3A222AB |B     BA|2A3     |    3A2A|    3AAB|
; |3     33|3333333 |B3   3BB|AB3     |    3BAB|    3AB2|
; |--------|--------|--------|--------|--------|--------|
$9D:91E0             db EE,EF,6C,EF,6C,EF,C6,C7,C6,C7,82,83,82,83,83,83,00,C7,00,C6,00,C6,00,83,00,83,00,83,00,83,00,83,
                        B0,F0,10,F0,10,F0,20,E0,20,E0,00,C0,00,C0,00,C0,00,E0,80,20,00,20,00,60,00,40,00,40,00,40,00,C0,
                        BB,01,45,01,BB,01,C7,83,EF,C7,EF,C7,FF,AB,BA,BB,44,44,BA,BA,44,44,38,39,10,93,10,93,00,83,44,C6,
                        FC,FE,F0,FE,70,FE,70,FC,30,FC,3C,FC,30,FE,A0,FE,00,02,00,B2,00,D2,00,58,80,5C,00,40,00,D2,00,D2,
                        0F,0F,0D,04,0F,0F,0D,04,07,07,00,00,00,00,00,00,00,00,0D,02,00,00,0D,0B,00,00,00,00,00,00,00,00,
                        0F,0F,0F,05,13,10,1B,18,17,14,1F,14,0D,0C,0D,04,00,00,0F,0A,03,0E,0B,04,07,08,0F,00,05,02,0D,02,
                        05,07,0F,1F,07,1F,13,1F,1B,1F,26,3F,82,FF,FF,FF,00,07,00,03,00,13,00,1C,00,06,00,29,00,C5,00,00,
                        1A,1F,10,1F,10,1F,08,0F,08,0F,00,07,00,07,01,07,00,0F,02,08,00,08,00,0D,00,05,00,05,00,05,00,07,
                        83,83,83,83,83,83,83,83,01,83,00,83,82,83,83,83,00,01,00,01,00,01,00,00,00,00,00,83,00,01,00,00,
                        40,C0,E0,F0,C0,F0,90,F0,B0,F0,C8,F8,82,FE,FE,FE,00,C0,00,80,00,90,00,70,00,C0,00,28,00,46,00,00,
                        AA,AB,6D,29,45,45,C7,45,C7,C7,82,83,82,83,C7,C7,44,C6,82,83,82,83,00,00,00,01,00,01,00,83,00,83,
                        68,FE,52,DE,4C,CC,C0,C0,40,C0,40,C0,20,E0,60,E0,00,C2,00,42,00,CC,00,40,00,80,80,40,00,40,00,C0,
                        0C,0F,0D,0F,0D,0F,0F,0F,05,07,04,07,08,0F,0D,0F,00,06,00,05,00,07,00,04,00,03,02,05,00,05,00,07,
                        0F,0F,0F,07,0D,0F,09,0F,09,0F,09,0F,09,0F,0A,0F,00,00,08,0A,00,06,00,05,02,05,00,05,00,07,00,06,
}


;;; $93A0: Samus bottom tiles - set 0 - entry Eh ;;;
{
; 1: Facing right - normal - frames 1 / 3 / 6 / 8
; |--------|--------|--------|--------|--------|--------|
; |       3|BA2AAB33|BA2AAB33|BBABB   |    BBBB|311     |
; |       3|BAABB3 3|BAABB3 3|BBBB    |   3BAAB|313B    |
; |      3B|BBB3   B|BBB3   B|BB3     |   BA22A|B33A    |
; |     B33|B33   3B|B33   3B|BB3B    |   A2622|A33AB   |
; |    BAB3|33B   33|33B   33|B3BB    |   A2222|A33AA   |
; |   3B2AB|AAB  333|AAB  333|3BAB    |   B2222|A31BAB  |
; |   3BABA|2B   3A3|2B   3A3|BAB3    |   BBAAA|B31BAB  |
; |   3BBAB|B3   3BB|B3   3BB|BBBB    |   BA22A|B31BBA  |
; |--------|--------|--------|--------|--------|--------|
; |    33BA|2BB  333|2BB  333|BAAAB   |    B22A|B311BAB |
; |     3BB|AAAB   3|AAAB   3|3BBAAAB |    B22A|B331BBB |
; |      33|3333    |3333    |3333333 |    BAAB|B3311B3 |
; |        |        |        |        |    3BBB|333333A3|
; |        |        |        |        |   3BBBB|A33B3BA3|
; |        |        |        |        | 3BBBAB2|A3BBA3B |
; |        |        |        |        |3BAABABA|3BBABB3 |
; |        |        |        |        |BA22AAB3|3BAAB3  |
; |--------|--------|--------|--------|--------|--------|
$9D:93A0             db 01,01,01,01,03,03,07,07,0B,0F,19,1F,1A,1F,1D,1F,00,00,00,00,00,01,00,04,00,0E,00,0B,00,0F,00,0F,
                        87,FF,9D,FD,F1,F1,E3,E3,E3,E3,27,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        87,FF,9D,FD,F1,F1,E3,E3,E3,E3,27,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        D8,F8,F0,F0,E0,E0,F0,F0,F0,F0,D0,F0,B0,F0,F0,F0,00,F8,00,F0,00,C0,00,D0,00,B0,00,70,00,E0,00,F0,
                        0F,0F,19,1F,10,1F,00,1F,00,1F,10,1F,18,1F,10,1F,00,0F,00,0F,00,19,04,10,00,10,00,10,00,1F,00,19,
                        E0,80,F0,B0,E0,F0,68,F8,60,F8,74,DC,F4,DC,F8,DC,00,00,00,10,00,90,00,98,00,98,00,9C,00,9C,00,9C,
                        0E,0F,07,07,03,03,00,00,00,00,00,00,00,00,00,00,00,03,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        88,F8,E2,FE,FE,FE,00,00,00,00,00,00,00,00,00,00,00,F8,00,7E,00,00,00,00,00,00,00,00,00,00,00,00,
                        08,0F,08,0F,09,0F,0F,0F,1F,1F,7A,7F,CA,FF,83,FF,00,09,00,09,00,0F,00,07,00,0F,00,3E,00,7F,00,CE,
                        FA,CE,FE,EE,FE,E6,FD,FF,7D,FF,76,FE,EE,FE,CC,FC,00,8E,00,8E,00,84,00,02,00,96,00,BA,00,7C,00,78,
}


;;; $9520: Samus bottom tiles - set 0 - entry Fh ;;;
{
; 1: Facing right - normal - frames 2 / 7
; |--------|--------|--------|--------|--------|--------|
; |       3|BA2AAB33|BA2AAB33|BBABB   |    BBBB|311     |
; |       3|BAABB3 3|BAABB3 3|BBBB    |   3BAAB|313B    |
; |      3B|BBB3   B|BBB3   B|BB3     |   BA22A|B33A    |
; |     B33|B33   3B|B33   3B|BB3B    |   A2622|A33AB   |
; |    BAB3|33B   33|33B   33|B3BB    |   A2622|A33AA   |
; |   3B2AB|ABB  333|ABB  333|3BAB    |   B2222|A31BAB  |
; |   3BABA|2B   3A3|2B   3A3|BAB3    |   BBAAA|B31BAB  |
; |   3BBAB|B3   3BB|B3   3BB|BBBB    |   BA22A|B311BA  |
; |--------|--------|--------|--------|--------|--------|
; |    33BA|2BB  333|2BB  333|BAAAB   |    B22A|B311BAB |
; |     3BB|AAAB   3|AAAB   3|3BBAAAB |    B22A|B3311BB |
; |      33|3333    |3333    |3333333 |    BAAA|B3311B3 |
; |        |        |        |        |    333B|333333A3|
; |        |        |        |        |   3BBBB|B33B3BA3|
; |        |        |        |        | 3BBBAB2|A3BBA3B |
; |        |        |        |        |3BAABABA|3BAABB3 |
; |        |        |        |        |BAA2AAB3|3BAAB3  |
; |--------|--------|--------|--------|--------|--------|
$9D:9520             db 01,01,01,01,03,03,07,07,0B,0F,19,1F,1A,1F,1D,1F,00,00,00,00,00,01,00,04,00,0E,00,0B,00,0F,00,0F,
                        87,FF,9D,FD,F1,F1,E3,E3,E3,E3,67,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        87,FF,9D,FD,F1,F1,E3,E3,E3,E3,67,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        D8,F8,F0,F0,E0,E0,F0,F0,F0,F0,D0,F0,B0,F0,F0,F0,00,F8,00,F0,00,C0,00,D0,00,B0,00,70,00,E0,00,F0,
                        0F,0F,19,1F,10,1F,00,1F,00,1F,10,1F,18,1F,10,1F,00,0F,00,0F,00,19,04,10,04,10,00,10,00,1F,00,19,
                        E0,80,F0,B0,E0,F0,68,F8,60,F8,74,DC,F4,DC,F8,CC,00,00,00,10,00,90,00,98,00,98,00,9C,00,9C,00,8C,
                        0E,0F,07,07,03,03,00,00,00,00,00,00,00,00,00,00,00,03,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        88,F8,E2,FE,FE,FE,00,00,00,00,00,00,00,00,00,00,00,F8,00,7E,00,00,00,00,00,00,00,00,00,00,00,00,
                        08,0F,08,0F,08,0F,0F,0F,1F,1F,7A,7F,CA,FF,83,FF,00,09,00,09,00,0F,00,01,00,0F,00,3E,00,7F,00,EE,
                        FA,CE,FE,E6,FE,E6,FD,FF,FD,FF,76,FE,CE,FE,CC,FC,00,8E,00,86,00,84,00,02,00,96,00,BA,00,7C,00,78,
}


;;; $96A0: Samus bottom tiles - set 0 - entry 10h ;;;
{
; 2: Facing left  - normal - frames 1 / 3 / 6 / 8
; |--------|--------|--------|--------|--------|--------|
; |       3|BA2AAB33|BA2AAB33|BBABB   |    BBBB|311     |
; |       3|BAABB3 3|BAABB3 3|BBBB    |   3BAAB|313B    |
; |      3B|BBB3   B|BBB3   B|BB3     |   BA22A|B33A    |
; |     B33|B33   3B|B33   3B|BB3B    |   A2622|A33AB   |
; |    BAB3|33B   33|33B   33|B3BB    |   A2222|A33AA   |
; |   3B2AB|AAB  333|AAB  333|3BAB    |   B2222|A31BAB  |
; |   3BABA|2B   3A3|2B   3A3|BAB3    |   BBAAA|B31BAB  |
; |   3BBAB|B3   3BB|B3   3BB|BBBB    |   BA22A|B31BBA  |
; |--------|--------|--------|--------|--------|--------|
; |    33BA|2BB  333|2BB  333|BAAAB   |    B22A|B311BAB |
; |     3BB|AAAB   3|AAAB   3|3BBAAAB |    B22A|B331BBB |
; |      33|3333    |3333    |3333333 |    BAAB|B3311B3 |
; |        |        |        |        |    3BBB|333333A3|
; |        |        |        |        |   3BBBB|A33B3BA3|
; |        |        |        |        | 3BBBAB2|A3BBA3B |
; |        |        |        |        |3BAABABA|3BBABB3 |
; |        |        |        |        |BA22AAB3|3BAAB3  |
; |--------|--------|--------|--------|--------|--------|
$9D:96A0             db 01,01,01,01,03,03,07,07,0B,0F,19,1F,1A,1F,1D,1F,00,00,00,00,00,01,00,04,00,0E,00,0B,00,0F,00,0F,
                        87,FF,9D,FD,F1,F1,E3,E3,E3,E3,27,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        87,FF,9D,FD,F1,F1,E3,E3,E3,E3,27,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        D8,F8,F0,F0,E0,E0,F0,F0,F0,F0,D0,F0,B0,F0,F0,F0,00,F8,00,F0,00,C0,00,D0,00,B0,00,70,00,E0,00,F0,
                        0F,0F,19,1F,10,1F,00,1F,00,1F,10,1F,18,1F,10,1F,00,0F,00,0F,00,19,04,10,00,10,00,10,00,1F,00,19,
                        E0,80,F0,B0,E0,F0,68,F8,60,F8,74,DC,F4,DC,F8,DC,00,00,00,10,00,90,00,98,00,98,00,9C,00,9C,00,9C,
                        0E,0F,07,07,03,03,00,00,00,00,00,00,00,00,00,00,00,03,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        88,F8,E2,FE,FE,FE,00,00,00,00,00,00,00,00,00,00,00,F8,00,7E,00,00,00,00,00,00,00,00,00,00,00,00,
                        08,0F,08,0F,09,0F,0F,0F,1F,1F,7A,7F,CA,FF,83,FF,00,09,00,09,00,0F,00,07,00,0F,00,3E,00,7F,00,CE,
                        FA,CE,FE,EE,FE,E6,FD,FF,7D,FF,76,FE,EE,FE,CC,FC,00,8E,00,8E,00,84,00,02,00,96,00,BA,00,7C,00,78,
}


;;; $9820: Samus bottom tiles - set 0 - entry 11h ;;;
{
; 4Fh: Facing left  - damage boost - frame 0
; |--------|--------|--------|--------|--------|
; | 333BBBB|B331CC13|2A33    |BBBB3  B|      A3|
; |A33BBAAB|BBB33333|AB3     |3B33  3B|      23|
; |23BBA222|AABBBB33|B3      |333  BAA|     AAB|
; |B33BBAA2|2ABAAAB3|3       |33   333|    33BA|
; |33B3BBBA|ABA222AB|        |BB      |   A2A33|
; |3BBB3BBB|BA2262AB|        |BB      | BABAABB|
; | 3BAAB3B|BBA222AB|        |33      |BAABB333|
; | 3BA2AB3|3BBAAAB3|        |        |33333   |
; |--------|--------|--------|--------|--------|
; |  3BA2A3|333BBB3 |
; |   3BABB|333333  |
; |   333BB|B3B3    |
; |   3B33B|B3BB3   |
; |  3BB333|332A3   |
; |  3BBBA2|ABBA3   |
; | 3BBB333|33333   |
; |BABBB333|ABB3    |
; |--------|--------|
$9D:9820             db 7F,7F,79,FF,70,FF,F8,FF,FE,FF,FF,FF,67,7F,63,7F,00,0F,00,9F,00,38,00,9E,00,2F,00,77,00,3D,00,36,
                        F3,E1,FF,FF,3F,FF,23,FF,41,FF,81,FF,C1,FF,E3,FF,0C,8C,00,E0,00,FC,00,7E,00,E3,08,C3,00,E3,00,7E,
                        30,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,40,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        F9,F9,F3,F3,E4,E7,C7,C7,C0,C0,C0,C0,C0,C0,00,00,00,F1,00,41,00,07,00,00,00,C0,00,C0,00,00,00,00,
                        01,03,01,03,01,07,0E,0F,03,1F,53,7F,9F,FF,F8,F8,00,02,00,00,00,07,00,03,00,14,00,7F,00,F8,00,00,
                        31,3F,1B,1F,1F,1F,1F,1F,3F,3F,3C,3F,7F,7F,BF,FF,00,1A,00,0F,00,03,00,09,00,18,00,1E,00,38,00,F8,
                        FE,FE,FC,FC,F0,F0,F8,F8,C8,F8,68,F8,F8,F8,70,F0,00,1C,00,00,00,A0,00,B0,00,10,00,F0,00,00,00,E0,
}


;;; $9900: Samus bottom tiles - set 0 - entry 12h ;;;
{
; 50h: Facing right - damage boost - frame 0
; |--------|--------|--------|--------|--------|
; | 333BBBB|B331CC13|2A33    |BBBB3  B|      A3|
; |A33BBAAB|BBB33333|AB3     |3B33  3B|      23|
; |23BBA222|AABBBB33|B3      |333  BAA|     AAB|
; |B33BBAA2|2ABAAAB3|3       |33   333|    33BA|
; |33B3BBBA|ABA222AB|        |BB      |   A2A33|
; |3BBB3BBB|BA2262AB|        |BB      | BABAABB|
; | 3BAAB3B|BBA222AB|        |33      |BAABB333|
; | 3BA2AB3|3BBAAAB3|        |        |33333   |
; |--------|--------|--------|--------|--------|
; |  3BA2A3|333BBB3 |
; |   3BABB|333333  |
; |   333BB|B3B3    |
; |   3B33B|B3BB3   |
; |  3BB333|332A3   |
; |  3BBBA2|ABBA3   |
; | 3BBB333|33333   |
; |BABBB333|ABB3    |
; |--------|--------|
$9D:9900             db 7F,7F,79,FF,70,FF,F8,FF,FE,FF,FF,FF,67,7F,63,7F,00,0F,00,9F,00,38,00,9E,00,2F,00,77,00,3D,00,36,
                        F3,E1,FF,FF,3F,FF,23,FF,41,FF,81,FF,C1,FF,E3,FF,0C,8C,00,E0,00,FC,00,7E,00,E3,08,C3,00,E3,00,7E,
                        30,F0,60,E0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,40,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,
                        F9,F9,F3,F3,E4,E7,C7,C7,C0,C0,C0,C0,C0,C0,00,00,00,F1,00,41,00,07,00,00,00,C0,00,C0,00,00,00,00,
                        01,03,01,03,01,07,0E,0F,03,1F,53,7F,9F,FF,F8,F8,00,02,00,00,00,07,00,03,00,14,00,7F,00,F8,00,00,
                        31,3F,1B,1F,1F,1F,1F,1F,3F,3F,3C,3F,7F,7F,BF,FF,00,1A,00,0F,00,03,00,09,00,18,00,1E,00,38,00,F8,
                        FE,FE,FC,FC,F0,F0,F8,F8,C8,F8,68,F8,F8,F8,70,F0,00,1C,00,00,00,A0,00,B0,00,10,00,F0,00,00,00,E0,
}


;;; $99E0: Samus bottom tiles - set 0 - entry 13h ;;;
{
; 15h: Facing right - normal jump - aiming up - frame 1
; 69h: Facing right - normal jump - aiming up-right - frame 1
; |--------|--------|--------|--------|--------|
; |33BBAAAB|3BB3    |       3|BB3313BB|AAAB33  |
; |AB3BBAB3|3B3B    |      3B|AABB33BB|BBBB3AB |
; |BAB3BB33|333B    |      3A|22ABB333|33333AB |
; |3A263333|B3BB    |     3BA|262AB331|11133B3 |
; |3BA22B3B|A3333   |    33BA|222ABB31|133333  |
; | 3BBABB2|B3BBAAB3|    3B3B|A2AA2B33|33BB3   |
; |   3BBB3|33BBB33 |   3BA33|BAA22AB3|3BAB3   |
; |    3333|BB333   |   33BB3|3BAA22A3|3BB3    |
; |--------|--------|--------|--------|--------|
; |      33|333     |   3B3A3|33BBAAAB|
; |        |        |  33ABA3|AB3BBAB3|
; |        |        |  3B2B23|BAB3BB33|
; |        |        |  3ABB23|3A263333|
; |        |        |  32B A |3BA22B3B|
; |        |        |  3A  B | 3BBABB2|
; |        |        |  3B    |   3BBB3|
; |        |        |        |    3333|
; |--------|--------|--------|--------|
$9D:99E0             db F1,FF,7B,FF,BF,FF,8F,FF,C7,FF,76,7F,1F,1F,0F,0F,00,3F,00,DE,00,EC,10,40,00,65,00,3E,00,0E,00,00,
                        F0,F0,F0,F0,F0,F0,F0,F0,78,F8,F3,FF,FE,FE,F8,F8,00,60,00,50,00,10,00,B0,00,80,00,BE,00,38,00,C0,
                        01,01,03,03,02,03,06,07,0E,0F,0F,0F,1B,1F,1F,1F,00,00,00,01,00,01,00,03,00,03,00,05,00,0C,00,06,
                        FF,F7,3F,FF,1F,FF,0F,FE,0F,FE,07,FF,83,FF,C1,FF,00,C3,00,F3,00,38,40,18,00,1C,00,B4,00,E6,00,72,
                        1C,FC,FA,FE,FA,FE,FE,1E,FC,7C,F8,F8,D8,F8,F0,F0,00,F0,00,F6,00,06,00,04,00,00,00,30,00,70,00,60,
                        03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        E0,E0,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1D,1F,35,3F,35,3F,2D,3F,28,3A,22,32,30,30,00,00,00,0A,00,0E,00,14,00,1C,00,0A,00,12,00,10,00,00,
                        F1,FF,7B,FF,BF,FF,8F,FF,C7,FF,76,7F,1F,1F,0F,0F,00,3F,00,DE,00,EC,10,40,00,65,00,3E,00,0E,00,00,
}


;;; $9B00: Samus bottom tiles - set 0 - entry 14h ;;;
{
; 16h: Facing left  - normal jump - aiming up - frame 1
; 6Ah: Facing left  - normal jump - aiming up-left - frame 1
; |--------|--------|--------|--------|--------|
; |33BBAAAB|3BB3    |       3|BB3313BB|AAAB33  |
; |AB3BBAB3|3B3B    |      3B|AABB33BB|BBBB3AB |
; |BAB3BB33|333B    |      3A|22ABB333|33333AB |
; |3A263333|B3BB    |     3BA|262AB331|11133B3 |
; |3BA22B3B|A3333   |    33BA|222ABB31|133333  |
; | 3BBABB2|B3BBAAB3|    3B3B|A2AA2B33|33BB3   |
; |   3BBB3|33BBB33 |   3BA33|BAA22AB3|3BAB3   |
; |    3333|BB333   |   33BB3|3BAA22A3|3BB3    |
; |--------|--------|--------|--------|--------|
; |      33|333     |   3B3A3|33BBAAAB|
; |        |        |  33ABA3|AB3BBAB3|
; |        |        |  3B2B23|BAB3BB33|
; |        |        |  3ABB23|3A263333|
; |        |        |  32B A |3BA22B3B|
; |        |        |  3A  B | 3BBABB2|
; |        |        |  3B    |   3BBB3|
; |        |        |        |    3333|
; |--------|--------|--------|--------|
$9D:9B00             db F1,FF,7B,FF,BF,FF,8F,FF,C7,FF,76,7F,1F,1F,0F,0F,00,3F,00,DE,00,EC,10,40,00,65,00,3E,00,0E,00,00,
                        F0,F0,F0,F0,F0,F0,F0,F0,78,F8,F3,FF,FE,FE,F8,F8,00,60,00,50,00,10,00,B0,00,80,00,BE,00,38,00,C0,
                        01,01,03,03,02,03,06,07,0E,0F,0F,0F,1B,1F,1F,1F,00,00,00,01,00,01,00,03,00,03,00,05,00,0C,00,06,
                        FF,F7,3F,FF,1F,FF,0F,FE,0F,FE,07,FF,83,FF,C1,FF,00,C3,00,F3,00,38,40,18,00,1C,00,B4,00,E6,00,72,
                        1C,FC,FA,FE,FA,FE,FE,1E,FC,7C,F8,F8,D8,F8,F0,F0,00,F0,00,F6,00,06,00,04,00,00,00,30,00,70,00,60,
                        03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        E0,E0,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1D,1F,35,3F,35,3F,2D,3F,28,3A,22,32,30,30,00,00,00,0A,00,0E,00,14,00,1C,00,0A,00,12,00,10,00,00,
                        F1,FF,7B,FF,BF,FF,8F,FF,C7,FF,76,7F,1F,1F,0F,0F,00,3F,00,DE,00,EC,10,40,00,65,00,3E,00,0E,00,00,
}


;;; $9C20: Samus bottom tiles - set 0 - entry 15h ;;;
{
; 25h: Facing right - turning - standing - frame 2
; 26h: Facing left  - turning - standing - frame 0
; 8Bh: Facing right - turning - standing - aiming up - frame 2
; 8Ch: Facing left  - turning - standing - aiming up - frame 0
; 8Dh: Facing right - turning - standing - aiming down-right - frame 2
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 0
; 9Ch: Facing right - turning - standing - aiming up-right - frame 2
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 0
; BFh: Facing right - moonwalking - turn/jump left - frame 2
; C0h: Facing left  - moonwalking - turn/jump right - frame 0
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 2
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 0
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 2
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 0
; C6h: Unused - frame 2
; |--------|--------|--------|--------|--------|
; |       B|222AB3  |3BBB33CC|C13     |BABB3   |
; |       B|22AB3  3|3BAAB31C|1333    |BB33    |
; |      3B|ABB    3|BA22A311|13B3    |B33B    |
; |      BB|BB    3B|B262AB11|33AB3   |33BA    |
; |     333|B3    3A|B2222A31|3B2AB   |ABB2    |
; |     2A3|32A   3A|3A22AB33|33B2A3  |ABAAB   |
; |    3A3B|AA3   33|3BBBBAB3|113B2B3 |BBAAAAB |
; |    3B3A|B3      | BA22AB3|1113BAB | 333333 |
; |--------|--------|--------|--------|--------|
; |     3BB|A2B     | 3AA22A3|31113BB3|
; |      3B|BAAA3   |  BA22AB| 3111333|
; |       3|33333   |  3BAAAB|  31133B|
; |        |        |   BBBB3|   333BB|
; |        |        |  333333|  333BAB|
; |        |        | 3B332A | 33BBB3 |
; |        |        |BABBBAB |3BBBBB3 |
; |        |        |A6AABB3 |3BAAB3  |
; |--------|--------|--------|--------|
$9D:9C20             db 01,01,01,01,03,03,03,03,07,07,01,07,0B,0F,0E,0F,00,01,00,01,00,01,00,03,00,00,00,02,00,05,00,05,
                        0C,FC,19,F9,61,E1,C3,C3,C2,C3,82,E3,23,E3,C0,C0,00,18,00,30,00,E0,00,C1,00,81,00,21,00,C0,00,80,
                        FC,FC,CE,FC,87,FC,87,FC,83,FE,87,FF,FB,FF,43,7F,03,73,01,79,00,C8,20,8C,00,84,00,4C,00,7E,00,66,
                        60,20,F0,70,F0,70,D8,F8,C8,F8,E4,FC,F6,3E,FA,1E,80,80,00,00,00,20,00,30,00,58,00,28,00,14,00,0E,
                        B8,F8,F0,F0,F0,F0,E0,F0,60,F0,48,F8,C2,FE,7E,7E,00,F0,00,C0,00,90,00,30,00,E0,00,F8,00,FE,00,00,
                        07,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,03,00,01,00,00,00,00,00,00,00,00,00,00,00,00,
                        20,E0,88,F8,F8,F8,00,00,00,00,00,00,00,00,00,00,00,A0,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        41,7F,21,3F,31,3F,1F,1F,3F,3F,78,7E,BA,FE,0E,FE,00,32,00,33,00,1F,00,1E,00,00,00,22,00,FE,40,BC,
                        FF,8F,7F,47,3F,27,1F,1F,3D,3F,7E,7E,FE,FE,CC,FC,00,06,00,00,00,01,00,03,00,07,00,1C,00,7C,00,78,
}


;;; $9D40: Samus bottom tiles - set 0 - entry 16h ;;;
{
; 25h: Facing right - turning - standing - frame 0
; 26h: Facing left  - turning - standing - frame 2
; 8Bh: Facing right - turning - standing - aiming up - frame 0
; 8Ch: Facing left  - turning - standing - aiming up - frame 2
; 8Dh: Facing right - turning - standing - aiming down-right - frame 0
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 2
; 9Ch: Facing right - turning - standing - aiming up-right - frame 0
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 2
; BFh: Facing right - moonwalking - turn/jump left - frame 0
; C0h: Facing left  - moonwalking - turn/jump right - frame 2
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 0
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 2
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 0
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 2
; C6h: Unused - frame 0
; |--------|--------|--------|--------|--------|
; |       B|222AB3  |3BBB33CC|C13     |BABB3   |
; |       B|22AB3  3|3BAAB31C|1333    |BB33    |
; |      3B|ABB    3|BA22A311|13B3    |B33B    |
; |      BB|BB    3B|B262AB11|33AB3   |33BA    |
; |     333|B3    3A|B2222A31|3B2AB   |ABB2    |
; |     2A3|32A   3A|3A22AB33|33B2A3  |ABAAB   |
; |    3A3B|AA3   33|3BBBBAB3|113B2B3 |BBAAAAB |
; |    3B3A|B3      | BA22AB3|1113BAB | 333333 |
; |--------|--------|--------|--------|--------|
; |     3BB|A2B     | 3AA22A3|31113BB3|
; |      3B|BAAA3   |  BA22AB| 3111333|
; |       3|33333   |  3BAAAB|  31133B|
; |        |        |   BBBB3|   333BB|
; |        |        |  333333|  333BAB|
; |        |        | 3B332A | 33BBB3 |
; |        |        |BABBBAB |3BBBBB3 |
; |        |        |A6AABB3 |3BAAB3  |
; |--------|--------|--------|--------|
$9D:9D40             db 01,01,01,01,03,03,03,03,07,07,01,07,0B,0F,0E,0F,00,01,00,01,00,01,00,03,00,00,00,02,00,05,00,05,
                        0C,FC,19,F9,61,E1,C3,C3,C2,C3,82,E3,23,E3,C0,C0,00,18,00,30,00,E0,00,C1,00,81,00,21,00,C0,00,80,
                        FC,FC,CE,FC,87,FC,87,FC,83,FE,87,FF,FB,FF,43,7F,03,73,01,79,00,C8,20,8C,00,84,00,4C,00,7E,00,66,
                        60,20,F0,70,F0,70,D8,F8,C8,F8,E4,FC,F6,3E,FA,1E,80,80,00,00,00,20,00,30,00,58,00,28,00,14,00,0E,
                        B8,F8,F0,F0,F0,F0,E0,F0,60,F0,48,F8,C2,FE,7E,7E,00,F0,00,C0,00,90,00,30,00,E0,00,F8,00,FE,00,00,
                        07,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,03,00,01,00,00,00,00,00,00,00,00,00,00,00,00,
                        20,E0,88,F8,F8,F8,00,00,00,00,00,00,00,00,00,00,00,A0,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        41,7F,21,3F,31,3F,1F,1F,3F,3F,78,7E,BA,FE,0E,FE,00,32,00,33,00,1F,00,1E,00,00,00,22,00,FE,40,BC,
                        FF,8F,7F,47,3F,27,1F,1F,3D,3F,7E,7E,FE,FE,CC,FC,00,06,00,00,00,01,00,03,00,07,00,1C,00,7C,00,78,
}


;;; $9E60: Samus bottom tiles - set 0 - entry 17h ;;;
{
; 2Fh: Facing right - turning - jumping - frame 2
; 30h: Facing left  - turning - jumping - frame 0
; 43h: Facing right - turning - crouching - frame 2
; 44h: Facing left  - turning - crouching - frame 0
; 87h: Facing right - turning - falling - frame 2
; 88h: Facing left  - turning - falling - frame 0
; 8Fh: Facing right - turning - in air - aiming up - frame 2
; 90h: Facing left  - turning - in air - aiming up - frame 0
; 91h: Facing right - turning - in air - aiming down/down-right - frame 2
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 0
; 93h: Facing right - turning - falling - aiming up - frame 2
; 94h: Facing left  - turning - falling - aiming up - frame 0
; 95h: Facing right - turning - falling - aiming down/down-right - frame 2
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 0
; 97h: Facing right - turning - crouching - aiming up - frame 2
; 98h: Facing left  - turning - crouching - aiming up - frame 0
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 2
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 0
; 9Eh: Facing right - turning - in air - aiming up-right - frame 2
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 0
; A0h: Facing right - turning - falling - aiming up-right - frame 2
; A1h: Facing left  - turning - falling - aiming up-left - frame 0
; A2h: Facing right - turning - crouching - aiming up-right - frame 2
; A3h: Facing left  - turning - crouching - aiming up-left - frame 0
; |--------|--------|--------|--------|
; |3BA2A3CC|13BB33  |       3|       3|
; |B3BAB3C1|3BAAB3  |       3|      BA|
; |AB3BB313|BA22AB3 |       B|      2A|
; |3331C333|B2622AB |      32|      AB|
; |BB33133B|A2222AB |      3B|      33|
; |AAB3333B|BA22AB  |     BBA|      BB|
; |AABB333B|ABBAAB  |    BA22|      BA|
; |AABB33BA|22ABB   |    3333|       B|
; |--------|--------|--------|--------|
; |3BBB33BA|22AA3333|
; |B3BB3BA2|2AA3B3B3|
; |AB3B3BAA|AABBB3A3|
; |AA3333BB|ABBB3BA3|
; |3B3B3ABB|B3B3B333|
; |B3BA32A3|333BBBA3|
; |AB3A3BBB|33BBBA3 |
; |333333 3|3333333 |
; |--------|--------|
$9D:9E60             db C4,FC,ED,FC,7F,FD,F7,E7,FF,F7,3F,FF,3F,FF,3E,FF,03,6B,02,BA,00,D8,08,08,00,C1,00,E1,00,F1,00,F3,
                        FC,7C,CC,FC,86,FE,82,FE,02,FE,84,FC,64,FC,18,F8,00,30,00,78,00,CC,20,86,00,86,00,CC,00,FC,00,38,
                        01,01,01,01,01,01,02,03,03,03,06,07,08,0F,0F,0F,00,00,00,00,00,01,00,00,00,01,00,07,00,0C,00,00,
                        01,01,02,03,00,03,01,03,03,03,03,03,02,03,01,01,00,00,00,03,00,01,00,03,00,00,00,03,00,03,00,01,
                        FE,FF,FC,FF,7C,FF,3F,FF,FB,FF,E9,FF,6F,FF,FD,FD,00,73,00,B6,00,D7,00,C3,00,57,00,B2,00,D7,00,00,
                        0F,FF,1F,FF,3D,FF,7D,FF,FF,FF,FD,FF,FA,FE,FE,FE,00,30,00,6A,00,FA,00,F6,00,A8,00,1E,00,3C,00,00,
}


;;; $9F20: Samus bottom tiles - set 0 - entry 18h ;;;
{
; 2Fh: Facing right - turning - jumping - frame 0
; 30h: Facing left  - turning - jumping - frame 2
; 43h: Facing right - turning - crouching - frame 0
; 44h: Facing left  - turning - crouching - frame 2
; 87h: Facing right - turning - falling - frame 0
; 88h: Facing left  - turning - falling - frame 2
; 8Fh: Facing right - turning - in air - aiming up - frame 0
; 90h: Facing left  - turning - in air - aiming up - frame 2
; 91h: Facing right - turning - in air - aiming down/down-right - frame 0
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 2
; 93h: Facing right - turning - falling - aiming up - frame 0
; 94h: Facing left  - turning - falling - aiming up - frame 2
; 95h: Facing right - turning - falling - aiming down/down-right - frame 0
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 2
; 97h: Facing right - turning - crouching - aiming up - frame 0
; 98h: Facing left  - turning - crouching - aiming up - frame 2
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 0
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 2
; 9Eh: Facing right - turning - in air - aiming up-right - frame 0
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 2
; A0h: Facing right - turning - falling - aiming up-right - frame 0
; A1h: Facing left  - turning - falling - aiming up-left - frame 2
; A2h: Facing right - turning - crouching - aiming up-right - frame 0
; A3h: Facing left  - turning - crouching - aiming up-left - frame 2
; |--------|--------|--------|--------|
; |3BA2A3CC|13BB33  |       3|       3|
; |B3BAB3C1|3BAAB3  |       3|      BA|
; |AB3BB313|BA22AB3 |       B|      2A|
; |3331C333|B2622AB |      32|      AB|
; |BB33133B|A2222AB |      3B|      33|
; |AAB3333B|BA22AB  |     BBA|      BB|
; |AABB333B|ABBAAB  |    BA22|      BA|
; |AABB33BA|22ABB   |    3333|       B|
; |--------|--------|--------|--------|
; |3BBB33BA|22AA3333|
; |B3BB3BA2|2AA3B3B3|
; |AB3B3BAA|AABBB3A3|
; |AA3333BB|ABBB3BA3|
; |3B3B3ABB|B3B3B333|
; |B3BA32A3|333BBBA3|
; |AB3A3BBB|33BBBA3 |
; |333333 3|3333333 |
; |--------|--------|
$9D:9F20             db C4,FC,ED,FC,7F,FD,F7,E7,FF,F7,3F,FF,3F,FF,3E,FF,03,6B,02,BA,00,D8,08,08,00,C1,00,E1,00,F1,00,F3,
                        FC,7C,CC,FC,86,FE,82,FE,02,FE,84,FC,64,FC,18,F8,00,30,00,78,00,CC,20,86,00,86,00,CC,00,FC,00,38,
                        01,01,01,01,01,01,02,03,03,03,06,07,08,0F,0F,0F,00,00,00,00,00,01,00,00,00,01,00,07,00,0C,00,00,
                        01,01,02,03,00,03,01,03,03,03,03,03,02,03,01,01,00,00,00,03,00,01,00,03,00,00,00,03,00,03,00,01,
                        FE,FF,FC,FF,7C,FF,3F,FF,FB,FF,E9,FF,6F,FF,FD,FD,00,73,00,B6,00,D7,00,C3,00,57,00,B2,00,D7,00,00,
                        0F,FF,1F,FF,3D,FF,7D,FF,FF,FF,FD,FF,FA,FE,FE,FE,00,30,00,6A,00,FA,00,F6,00,A8,00,1E,00,3C,00,00,
}


;;; $9FE0: Samus bottom tiles - set 0 - entry 19h ;;;
{
; 64h: Unused - frame 1
; B9h: Facing right - grapple wall jump pose - frame 0
; |--------|--------|--------|--------|
; | 33 3AB3|311BBA31|311BBA31|113FF9EF|
; | 3A33BB3|3311B333|3311B333|11133F33|
; | 323323B|33111313|33111313|333333  |
; |  323ABA|B33133BB|B33133BB|3BB33   |
; |  3A2BBA|BB333B22|BB333B22|A3AB3   |
; |  3B2BBB|B333BA62|B333BA62|A32AB   |
; |   BAA33|333BABBA|333BABBA|3A6AB   |
; |   3BA3A|B333A2BB|B333A2BB|3222B   |
; |--------|--------|--------|--------|
; |    3333|3A23A2AB|3A23A2AB|3A2AB   |
; |    33BB|32A3A6A3|32A3A6A3|BAAB    |
; |     3AB|3A33AAB3|3A33AAB3|BBBB    |
; |     32A|3A3BBB33|3A3BBB33|333     |
; |     32A|3B3333  |3B3333  |        |
; |     32B|333     |333     |        |
; |     3A3|        |        |        |
; |     33 |        |        |        |
; |--------|--------|--------|--------|
$9D:9FE0             db 6B,6F,5F,7F,5B,7F,2A,3F,26,3F,37,3F,13,1F,1A,1F,00,06,00,26,00,01,00,07,00,17,00,17,00,1C,00,0D,
                        FB,9E,FF,CF,FF,C5,FF,EF,FC,FF,F8,FF,F6,FF,F3,FF,00,1C,00,08,00,00,00,83,00,C4,02,8C,00,1F,00,8B,
                        FB,9E,FF,CF,FF,C5,FF,EF,FC,FF,F8,FF,F6,FF,F3,FF,00,1C,00,08,00,00,00,83,00,C4,02,8C,00,1F,00,8B,
                        FD,3B,FF,1F,FC,FC,F8,F8,58,F8,48,F8,88,F8,88,F8,1B,1F,04,04,00,00,00,60,00,B0,00,98,20,58,00,08,
                        0F,0F,0F,0F,05,07,04,07,04,07,05,07,05,07,06,06,00,00,00,03,00,03,00,01,00,01,00,01,00,02,00,00,
                        91,FF,91,FF,B3,FF,BF,FF,FC,FC,E0,E0,00,00,00,00,00,4B,04,2A,00,4E,00,5C,00,40,00,00,00,00,00,00,
                        91,FF,91,FF,B3,FF,BF,FF,FC,FC,E0,E0,00,00,00,00,00,4B,04,2A,00,4E,00,5C,00,40,00,00,00,00,00,00,
                        88,F8,90,F0,F0,F0,E0,E0,00,00,00,00,00,00,00,00,00,58,00,F0,00,F0,00,00,00,00,00,00,00,00,00,00,
}


;;; $A0E0: Samus bottom tiles - set 0 - entry 1Ah ;;;
{
; 63h: Unused - frame 1
; B8h: Facing left  - grapple wall jump pose - frame 0
; |--------|--------|--------|--------|
; |113BA226|2A3BA   |   33333|113BA226|
; |CC3BA222|2B323 33|    3311|CC3BA222|
; |C133BA22|A3B233A3|   33311|C133BA22|
; |1313BBAA|B323A23 |   3B331|1313BBAA|
; |31133BBB|3AA33A3 |   BBB33|31133BBB|
; |3111333B|BB3AB3  |   BAAB3|3111333B|
; |33311333|BB3AB3  |   3A2AB|33311333|
; |B33333B3|B33B3   |   3BA2B|B33333B3|
; |--------|--------|--------|--------|
; |BB3333B3|3BB33   |    3BAA|BB3333B3|
; |333333B3|33B3    |3    333|333333B3|
; |     333|BB3     |A3      |     333|
; |       3|333     |B3      |       3|
; |       3|BB3     |3       |       3|
; |        |BB3     |        |        |
; |        | B3     |        |        |
; |        | 33     |        |        |
; |--------|--------|--------|--------|
$9D:A0E0             db F0,3F,30,3F,78,3F,FC,5F,FF,9F,FF,8F,FF,E7,FF,FF,01,18,C0,D8,80,8C,00,0F,00,07,00,01,00,00,00,82,
                        30,F8,6B,FB,6D,FF,D2,FE,9A,FE,EC,FC,EC,FC,F8,F8,00,58,00,40,00,A2,00,88,00,64,00,D8,00,D8,00,90,
                        1F,1F,0F,0C,1F,1C,1F,1E,1F,1F,13,1F,11,1F,19,1F,00,00,00,00,00,00,00,08,00,1C,00,1E,00,0B,00,0D,
                        F0,3F,30,3F,78,3F,FC,5F,FF,9F,FF,8F,FF,E7,FF,FF,01,18,C0,D8,80,8C,00,0F,00,07,00,01,00,00,00,82,
                        FF,FF,FF,FF,07,07,01,01,01,01,00,00,00,00,00,00,00,C2,00,02,00,00,00,00,00,00,00,00,00,00,00,00,
                        F8,F8,F0,F0,E0,E0,E0,E0,E0,E0,E0,E0,60,60,60,60,00,60,00,20,00,C0,00,00,00,C0,00,C0,00,40,00,00,
                        0C,0F,87,87,40,C0,C0,C0,80,80,00,00,00,00,00,00,00,07,00,00,00,80,00,80,00,00,00,00,00,00,00,00,
                        FF,FF,FF,FF,07,07,01,01,01,01,00,00,00,00,00,00,00,C2,00,02,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $A1E0: Samus bottom tiles - set 0 - entry 1Bh ;;;
{
; C9h: Facing right - shinespark - horizontal - frame 0
; CDh: Facing right - shinespark - diagonal - frame 0
; |--------|--------|--------|--------|--------|--------|
; |33B26A3 |        | 3AABB33|BA2A3111|      23|        |
; |33BA2AB3|        | 3A2AB3B|3BA33333|      A3|33  333 |
; |313BAAB3|        | 3AAB3BA|B33B3311|      33|B333BB33|
; |3313BBBB|        | 3B3BAAB|B33AB331|        |BB33A2B3|
; |33333BAA|3       | 33BA2AB|3BA2AB33|        |33BB3333|
; |333133BB|3       | 3B3BAB3|3B2AB313|        |3BAB3BB3|
; |333313B3|33      |  3A3B33|BBAB3113|        |BAB3AAB3|
; |BB333333|333333  |   3333B|2BB31133|        |     A23|
; |--------|--------|--------|--------|--------|--------|
; |3BB3333B|33BBBB33|      3B|AB311333|
; |333333BB|3BBAAAB3|      BA|B331333B|
; |3AB33BAA|3BA262AB|      33|331333BB|
; |A33B3 33|3BBAAA2A|      AB|3B3B3333|
; |3 BB3   |    3333|      3B|3BB3   B|
; |   B3   |        |        |        |
; |   B3   |        |        |        |
; |   33   |        |        |        |
; |--------|--------|--------|--------|
$9D:A1E0             db E2,FE,E3,FF,F3,BF,FF,DF,FC,FF,FF,EF,FF,F7,FF,FF,08,24,00,36,00,1E,00,0F,00,07,00,03,00,02,00,C0,
                        00,00,00,00,00,00,00,00,80,80,80,80,C0,C0,FC,FC,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        4F,7F,47,7F,4E,7F,79,7F,71,7F,7B,7F,2F,3F,1F,1F,00,3C,00,2D,00,3B,00,2F,00,1B,00,2E,00,14,00,01,
                        8F,F8,DF,FF,FF,FC,EF,FE,C7,FF,CF,FD,DF,F9,7F,F3,00,D0,00,60,00,90,00,98,00,6C,00,58,00,F0,00,60,
                        01,03,01,03,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,CE,CE,FF,FF,F3,FF,FF,FF,DF,FF,B3,FF,01,07,00,00,00,00,00,8C,00,CA,00,30,00,76,00,EE,00,04,
                        FF,FF,FF,FF,BC,FF,7B,FB,B8,B8,18,18,18,18,18,18,00,61,00,03,00,67,00,90,00,30,00,10,00,10,00,00,
                        FF,FF,E3,FF,C1,FF,E0,FF,0F,0F,00,00,00,00,00,00,00,3C,00,7E,08,63,00,7D,00,00,00,00,00,00,00,00,
                        03,03,02,03,03,03,01,03,03,03,00,00,00,00,00,00,00,01,00,03,00,00,00,03,00,01,00,00,00,00,00,00,
                        7F,E7,FF,EF,FF,DF,FF,FF,F1,F1,00,00,00,00,00,00,00,C0,00,81,00,03,00,50,00,61,00,00,00,00,00,00,
}


;;; $A320: Samus bottom tiles - set 0 - entry 1Ch ;;;
{
; CAh: Facing left  - shinespark - horizontal - frame 0
; CEh: Facing left  - shinespark - diagonal - frame 0
; |--------|--------|--------|--------|--------|--------|
; |33B26A3 |        | 3AABB33|BA2A3111|      23|        |
; |33BA2AB3|        | 3A2AB3B|3BA33333|      A3|33  333 |
; |313BAAB3|        | 3AAB3BA|B33B3311|      33|B333BB33|
; |3313BBBB|        | 3B3BAAB|B33AB331|        |BB33A2B3|
; |33333BAA|3       | 33BA2AB|3BA2AB33|        |33BB3333|
; |333133BB|3       | 3B3BAB3|3B2AB313|        |3BAB3BB3|
; |333313B3|33      |  3A3B33|BBAB3113|        |BAB3AAB3|
; |BB333333|333333  |   3333B|2BB31133|        |     A23|
; |--------|--------|--------|--------|--------|--------|
; |3BB3333B|33BBBB33|      3B|AB311333|
; |333333BB|3BBAAAB3|      BA|B331333B|
; |3AB33BAA|3BA262AB|      33|331333BB|
; |A33B3 33|3BBAAA2A|      AB|3B3B3333|
; |3 BB3   |    3333|      3B|3BB3   B|
; |   B3   |        |        |        |
; |   B3   |        |        |        |
; |   33   |        |        |        |
; |--------|--------|--------|--------|
$9D:A320             db E2,FE,E3,FF,F3,BF,FF,DF,FC,FF,FF,EF,FF,F7,FF,FF,08,24,00,36,00,1E,00,0F,00,07,00,03,00,02,00,C0,
                        00,00,00,00,00,00,00,00,80,80,80,80,C0,C0,FC,FC,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        4F,7F,47,7F,4E,7F,79,7F,71,7F,7B,7F,2F,3F,1F,1F,00,3C,00,2D,00,3B,00,2F,00,1B,00,2E,00,14,00,01,
                        8F,F8,DF,FF,FF,FC,EF,FE,C7,FF,CF,FD,DF,F9,7F,F3,00,D0,00,60,00,90,00,98,00,6C,00,58,00,F0,00,60,
                        01,03,01,03,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,CE,CE,FF,FF,F3,FF,FF,FF,DF,FF,B3,FF,01,07,00,00,00,00,00,8C,00,CA,00,30,00,76,00,EE,00,04,
                        FF,FF,FF,FF,BC,FF,7B,FB,B8,B8,18,18,18,18,18,18,00,61,00,03,00,67,00,90,00,30,00,10,00,10,00,00,
                        FF,FF,E3,FF,C1,FF,E0,FF,0F,0F,00,00,00,00,00,00,00,3C,00,7E,08,63,00,7D,00,00,00,00,00,00,00,00,
                        03,03,02,03,03,03,01,03,03,03,00,00,00,00,00,00,00,01,00,03,00,00,00,03,00,01,00,00,00,00,00,00,
                        7F,E7,FF,EF,FF,DF,FF,FF,F1,F1,00,00,00,00,00,00,00,C0,00,81,00,03,00,50,00,61,00,00,00,00,00,00,
}


;;; $A460: Samus bottom tiles - set 0 - entry 1Dh ;;;
{
; 2: Facing left  - normal - frames 2 / 7
; |--------|--------|--------|--------|--------|--------|
; |       3|BA2AAB33|BA2AAB33|BBABB   |    BBBB|311     |
; |       3|BAABB3 3|BAABB3 3|BBBB    |   3BAAB|313B    |
; |      3B|BBB3   B|BBB3   B|BB3     |   BA22A|B33A    |
; |     B33|B33   3B|B33   3B|BB3B    |   A2622|A33AB   |
; |    BAB3|33B   33|33B   33|B3BB    |   A2622|A33AA   |
; |   3B2AB|ABB  333|ABB  333|3BAB    |   B2222|A31BAB  |
; |   3BABA|2B   3A3|2B   3A3|BAB3    |   BBAAA|B31BAB  |
; |   3BBAB|B3   3BB|B3   3BB|BBBB    |   BA22A|B311BA  |
; |--------|--------|--------|--------|--------|--------|
; |    33BA|2BB  333|2BB  333|BAAAB   |    B22A|B311BAB |
; |     3BB|AAAB   3|AAAB   3|3BBAAAB |    B22A|B3311BB |
; |      33|3333    |3333    |3333333 |    BAAA|B3311B3 |
; |        |        |        |        |    333B|333333A3|
; |        |        |        |        |   3BBBB|B33B3BA3|
; |        |        |        |        | 3BBBAB2|A3BBA3B |
; |        |        |        |        |3BAABABA|3BAABB3 |
; |        |        |        |        |BAA2AAB3|3BAAB3  |
; |--------|--------|--------|--------|--------|--------|
$9D:A460             db 01,01,01,01,03,03,07,07,0B,0F,19,1F,1A,1F,1D,1F,00,00,00,00,00,01,00,04,00,0E,00,0B,00,0F,00,0F,
                        87,FF,9D,FD,F1,F1,E3,E3,E3,E3,67,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        87,FF,9D,FD,F1,F1,E3,E3,E3,E3,67,E7,45,C7,C7,C7,00,DC,00,F8,00,E1,00,81,00,20,00,E0,00,42,00,83,
                        D8,F8,F0,F0,E0,E0,F0,F0,F0,F0,D0,F0,B0,F0,F0,F0,00,F8,00,F0,00,C0,00,D0,00,B0,00,70,00,E0,00,F0,
                        0F,0F,19,1F,10,1F,00,1F,00,1F,10,1F,18,1F,10,1F,00,0F,00,0F,00,19,04,10,04,10,00,10,00,1F,00,19,
                        E0,80,F0,B0,E0,F0,68,F8,60,F8,74,DC,F4,DC,F8,CC,00,00,00,10,00,90,00,98,00,98,00,9C,00,9C,00,8C,
                        0E,0F,07,07,03,03,00,00,00,00,00,00,00,00,00,00,00,03,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        67,E7,11,F1,F0,F0,00,00,00,00,00,00,00,00,00,00,00,60,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        88,F8,E2,FE,FE,FE,00,00,00,00,00,00,00,00,00,00,00,F8,00,7E,00,00,00,00,00,00,00,00,00,00,00,00,
                        08,0F,08,0F,08,0F,0F,0F,1F,1F,7A,7F,CA,FF,83,FF,00,09,00,09,00,0F,00,01,00,0F,00,3E,00,7F,00,EE,
                        FA,CE,FE,E6,FE,E6,FD,FF,FD,FF,76,FE,CE,FE,CC,FC,00,8E,00,86,00,84,00,02,00,96,00,BA,00,7C,00,78,
}


;;; $A5E0: Samus bottom tiles - set 0 - entry 1Eh ;;;
{
; 19h: Facing right - spin jump - frame Bh
; 1Bh: Facing right - space jump - frame Bh
; 81h: Facing right - screw attack - frame 1Bh
; |--------|--------|--------|--------|
; | 33 3AB3|311BBA31|311BBA31|113FF9EF|
; | 3A33BB3|3311B333|3311B333|11133F33|
; | 323323B|33111313|33111313|333333  |
; |  323ABA|B33133BB|B33133BB|3BB33   |
; |  3A2BBA|BB333B22|BB333B22|A3AB3   |
; |  3B2BBB|B333BA62|B333BA62|A32AB   |
; |   BAA33|333BABBA|333BABBA|3A6AB   |
; |   3BA3A|B333A2BB|B333A2BB|3222B   |
; |--------|--------|--------|--------|
; |    3333|3A23A2AB|3A23A2AB|3A2AB   |
; |    33BB|32A3A6A3|32A3A6A3|BAAB    |
; |     3AB|3A33AAB3|3A33AAB3|BBBB    |
; |     32A|3A3BBB33|3A3BBB33|333     |
; |     32A|3B3333  |3B3333  |        |
; |     32B|333     |333     |        |
; |     3A3|        |        |        |
; |     33 |        |        |        |
; |--------|--------|--------|--------|
$9D:A5E0             db 6B,6F,5F,7F,5B,7F,2A,3F,26,3F,37,3F,13,1F,1A,1F,00,06,00,26,00,01,00,07,00,17,00,17,00,1C,00,0D,
                        FB,9E,FF,CF,FF,C5,FF,EF,FC,FF,F8,FF,F6,FF,F3,FF,00,1C,00,08,00,00,00,83,00,C4,02,8C,00,1F,00,8B,
                        FB,9E,FF,CF,FF,C5,FF,EF,FC,FF,F8,FF,F6,FF,F3,FF,00,1C,00,08,00,00,00,83,00,C4,02,8C,00,1F,00,8B,
                        FD,3B,FF,1F,FC,FC,F8,F8,58,F8,48,F8,88,F8,88,F8,1B,1F,04,04,00,00,00,60,00,B0,00,98,20,58,00,08,
                        0F,0F,0F,0F,05,07,04,07,04,07,05,07,05,07,06,06,00,00,00,03,00,03,00,01,00,01,00,01,00,02,00,00,
                        91,FF,91,FF,B3,FF,BF,FF,FC,FC,E0,E0,00,00,00,00,00,4B,04,2A,00,4E,00,5C,00,40,00,00,00,00,00,00,
                        91,FF,91,FF,B3,FF,BF,FF,FC,FC,E0,E0,00,00,00,00,00,4B,04,2A,00,4E,00,5C,00,40,00,00,00,00,00,00,
                        88,F8,90,F0,F0,F0,E0,E0,00,00,00,00,00,00,00,00,00,58,00,F0,00,F0,00,00,00,00,00,00,00,00,00,00,
}


;;; $A6E0: Samus bottom tiles - set 0 - entry 1Fh ;;;
{
; 1Ah: Facing left  - spin jump - frame Bh
; 1Ch: Facing left  - space jump - frame Bh
; 82h: Facing left  - screw attack - frame 1Bh
; |--------|--------|--------|--------|
; |113BA226|2A3BA   |   33333|113BA226|
; |CC3BA222|2B323 33|    3311|CC3BA222|
; |C133BA22|A3B233A3|   33311|C133BA22|
; |1313BBAA|B323A23 |   3B331|1313BBAA|
; |31133BBB|3AA33A3 |   BBB33|31133BBB|
; |3111333B|BB3AB3  |   BAAB3|3111333B|
; |33311333|BB3AB3  |   3A2AB|33311333|
; |B33333B3|B33B3   |   3BA2B|B33333B3|
; |--------|--------|--------|--------|
; |BB3333B3|3BB33   |    3BAA|BB3333B3|
; |333333B3|33B3    |3    333|333333B3|
; |     333|BB3     |A3      |     333|
; |       3|333     |B3      |       3|
; |       3|BB3     |3       |       3|
; |        |BB3     |        |        |
; |        | B3     |        |        |
; |        | 33     |        |        |
; |--------|--------|--------|--------|
$9D:A6E0             db F0,3F,30,3F,78,3F,FC,5F,FF,9F,FF,8F,FF,E7,FF,FF,01,18,C0,D8,80,8C,00,0F,00,07,00,01,00,00,00,82,
                        30,F8,6B,FB,6D,FF,D2,FE,9A,FE,EC,FC,EC,FC,F8,F8,00,58,00,40,00,A2,00,88,00,64,00,D8,00,D8,00,90,
                        1F,1F,0F,0C,1F,1C,1F,1E,1F,1F,13,1F,11,1F,19,1F,00,00,00,00,00,00,00,08,00,1C,00,1E,00,0B,00,0D,
                        F0,3F,30,3F,78,3F,FC,5F,FF,9F,FF,8F,FF,E7,FF,FF,01,18,C0,D8,80,8C,00,0F,00,07,00,01,00,00,00,82,
                        FF,FF,FF,FF,07,07,01,01,01,01,00,00,00,00,00,00,00,C2,00,02,00,00,00,00,00,00,00,00,00,00,00,00,
                        F8,F8,F0,F0,E0,E0,E0,E0,E0,E0,E0,E0,60,60,60,60,00,60,00,20,00,C0,00,00,00,C0,00,C0,00,40,00,00,
                        0C,0F,87,87,40,C0,C0,C0,80,80,00,00,00,00,00,00,00,07,00,00,00,80,00,80,00,00,00,00,00,00,00,00,
                        FF,FF,FF,FF,07,07,01,01,01,01,00,00,00,00,00,00,00,C2,00,02,00,00,00,00,00,00,00,00,00,00,00,00,
}
}


;;; $A7E0..C97F: Samus bottom tiles - set 1 (general) ;;;
{
;;; $A7E0: Samus bottom tiles - set 1 - entry 0 ;;;
{
; 49h: Facing left  - moonwalk - frame 3
; 4Ah: Facing right - moonwalk - frame 3
; 75h: Facing left  - moonwalk - aiming up-left - frame 3
; 76h: Facing right - moonwalk - aiming up-right - frame 3
; 77h: Facing left  - moonwalk - aiming down-left - frame 3
; 78h: Facing right - moonwalk - aiming down-right - frame 3
; |--------|--------|--------|--------|--------|--------|
; |  BA22B3| 3BBAAB |     1CC|1333    |33      |        |
; |   BA2A3|  3BBBB3|     313|3BB33   |3       |        |
; |    AAB3|    3BBB|     33B|A2AB3   |        |        |
; |    BABB|     3BB|     BBA|222AB   |        |3       |
; |    BBBB|     3BB|    BBA2|262AB   |        |33      |
; |  A33BB3|    A333|   BAABA|22AAB   |        |3B3     |
; |   A333A|3    AB3|  BA22BA|AAAB3   |        |BB3     |
; |  BBAB2B|3    333| BA2222B|BB33    |        |3B3     |
; |--------|--------|--------|--------|--------|--------|
; |  A2BBBA|3    ABB| BA22AAB|3333    |
; |AABBB333|3 3BAABB|3BBAABB3|33BB    |
; |33333   |  333333|33BBB331|11BB    |
; |        |        |B3333333|11BB    |
; |        |        |23B333B3|3333    |
; |        |        |A3BAA33B|33BBB   |
; |        |        |B3AA2A33|3BBAAB  |
; |        |        | BA226B |3BBAAA3 |
; |--------|--------|--------|--------|
$9D:A7E0             db 23,3F,11,1F,03,0F,0B,0F,0F,0F,1F,3F,0E,1F,35,3F,00,32,00,1A,00,0E,00,0F,00,0F,00,26,00,11,00,3D,
                        72,7E,3F,3F,0F,0F,07,07,07,07,07,0F,83,87,87,87,00,3E,00,1E,00,07,00,03,00,03,00,08,00,06,00,00,
                        04,00,07,05,07,07,06,07,0C,0F,12,1F,22,3F,41,7F,03,03,00,00,00,01,00,07,00,0E,00,1F,00,33,00,61,
                        F0,70,F8,F8,18,F8,08,F8,08,F8,08,F8,18,F8,F0,F0,00,00,00,60,00,B0,00,18,40,18,00,38,00,F0,00,C0,
                        C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,80,80,C0,C0,E0,E0,E0,E0,E0,E0,00,00,00,00,00,00,00,00,00,00,00,40,00,C0,00,40,
                        0E,3F,3F,FF,F8,F8,00,00,00,00,00,00,00,00,00,00,00,2F,00,F8,00,00,00,00,00,00,00,00,00,00,00,00,
                        83,87,B3,BF,3F,3F,00,00,00,00,00,00,00,00,00,00,00,07,00,1F,00,00,00,00,00,00,00,00,00,00,00,00,
                        41,7F,E7,FF,FF,FE,FF,FF,7F,FF,67,FF,C3,FF,42,7E,00,67,00,7E,00,38,00,80,00,22,00,B9,00,B4,04,62,
                        F0,F0,F0,F0,F0,30,F0,30,F0,F0,F8,F8,E4,FC,E2,FE,00,00,00,30,00,30,00,30,00,00,00,38,00,7C,00,7C,
}


;;; $A920: Samus bottom tiles - set 1 - entry 1 ;;;
{
; 25h: Facing right - turning - standing - frame 1
; 26h: Facing left  - turning - standing - frame 1
; 8Bh: Facing right - turning - standing - aiming up - frame 1
; 8Ch: Facing left  - turning - standing - aiming up - frame 1
; 8Dh: Facing right - turning - standing - aiming down-right - frame 1
; 8Eh: Facing left  - turning - standing - aiming down-left - frame 1
; 9Ch: Facing right - turning - standing - aiming up-right - frame 1
; 9Dh: Facing left  - turning - standing - aiming up-left - frame 1
; BFh: Facing right - moonwalking - turn/jump left - frame 1
; C0h: Facing left  - moonwalking - turn/jump right - frame 1
; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right - frame 1
; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left - frame 1
; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right - frame 1
; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left - frame 1
; C6h: Unused - frame 1
; |--------|--------|--------|--------|
; |   B311C|CC113   | BAA2AAB| 33B333 |
; |  BA3311|11C33B  | BBA2ABB|  BBBB3 |
; | 3AAA331|C133BA3 |  BAAAB |  BBAB3 |
; | BAA2B31|C33B2AB |  BBAB3 |  3BAB3 |
; | BA62B13|131CA6B3|  BB33  |  3BAB  |
; | BA22B13|331CBBAB|  33323 |   333  |
; | BBABAB1|311CB22B|  33AAB |    3   |
; |  BB22B1|311CBA2B|  ABA33 |        |
; |--------|--------|--------|--------|
; |  BA2BB1|331CB2AB|  B332B3|        |
; |  BA2AB1| 31CBAAB|  BA222A|        |
; |  BA2BB3|  1CBBBB|  333333|3       |
; |  3BABB3| B31B33 |        |        |
; |  33333 |3B33A23B|        |        |
; |  BA6AB |3BB3BB3B|        |        |
; | BBA2BBB| 3ABBBA |        |        |
; | BABBB3B| 33ABAB |        |        |
; |--------|--------|--------|--------|
$9D:A920             db 1E,18,2F,3C,47,7E,47,7E,47,7D,47,7D,6B,7E,33,3E,01,11,00,30,00,38,00,74,10,64,00,64,00,7E,00,32,
                        38,08,DC,1C,7A,3E,72,7E,E3,4F,ED,CF,E9,8F,E9,8F,C0,C0,20,24,80,8C,80,96,14,1A,10,1F,10,19,10,1D,
                        41,7F,63,7F,22,3E,36,3E,3C,3C,3A,3E,32,3E,16,3E,00,77,00,77,00,3E,00,3C,00,30,00,00,00,0E,00,38,
                        7E,7E,3E,3E,36,3E,36,3E,34,3C,1C,1C,08,08,00,00,00,10,00,3C,00,3C,00,1C,00,1C,00,00,00,00,00,00,
                        27,3E,23,3E,27,3F,37,3F,3E,3E,22,3E,67,7F,5F,7F,00,36,00,36,00,36,00,1E,00,00,08,36,00,77,00,7D,
                        E9,CF,69,4F,2F,0F,7E,6E,F3,FF,FF,FF,5C,7E,6A,7E,10,1B,10,1F,10,1F,00,48,00,49,00,6D,00,3E,00,1E,
                        3B,3F,20,3F,3F,3F,00,00,00,00,00,00,00,00,00,00,00,22,00,31,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,80,80,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $AA20: Samus bottom tiles - set 1 - entry 2 ;;;
{
; 2Fh: Facing right - turning - jumping - frame 1
; 30h: Facing left  - turning - jumping - frame 1
; 43h: Facing right - turning - crouching - frame 1
; 44h: Facing left  - turning - crouching - frame 1
; 87h: Facing right - turning - falling - frame 1
; 88h: Facing left  - turning - falling - frame 1
; 8Fh: Facing right - turning - in air - aiming up - frame 1
; 90h: Facing left  - turning - in air - aiming up - frame 1
; 91h: Facing right - turning - in air - aiming down/down-right - frame 1
; 92h: Facing left  - turning - in air - aiming down/down-left - frame 1
; 93h: Facing right - turning - falling - aiming up - frame 1
; 94h: Facing left  - turning - falling - aiming up - frame 1
; 95h: Facing right - turning - falling - aiming down/down-right - frame 1
; 96h: Facing left  - turning - falling - aiming down/down-left - frame 1
; 97h: Facing right - turning - crouching - aiming up - frame 1
; 98h: Facing left  - turning - crouching - aiming up - frame 1
; 99h: Facing right - turning - crouching - aiming down/down-right - frame 1
; 9Ah: Facing left  - turning - crouching - aiming down/down-left - frame 1
; 9Eh: Facing right - turning - in air - aiming up-right - frame 1
; 9Fh: Facing left  - turning - in air - aiming up-left - frame 1
; A0h: Facing right - turning - falling - aiming up-right - frame 1
; A1h: Facing left  - turning - falling - aiming up-left - frame 1
; A2h: Facing right - turning - crouching - aiming up-right - frame 1
; A3h: Facing left  - turning - crouching - aiming up-left - frame 1
; |--------|--------|
; | BB311CC|1133B3  |
; | BBB3111|133AB3B |
; |BA2B3311|33B2ABB |
; |B22B3311|3BBBA3BA|
; |A62B1331|3BA22AB2|
; |A2AB1333|13A22A32|
; |AAAB113B|13BAAB32|
; |BBBC113B|13BBBBAA|
; |--------|--------|
; |BABC113B|33B333A3|
; |A2BC113B|333BB3B3|
; |B2BC1333| 33AB33 |
; |3AB113BB|  B2A3  |
; |33B113B3| 3B2233 |
; | 3BB33B3| 3BAAB3 |
; |  333BB3|3BA22AB3|
; |        |33333333|
; |--------|--------|
$9D:AA20             db 7C,70,7F,78,9F,FC,9F,FC,1F,F6,1F,F7,1F,F3,EF,E3,03,63,00,70,00,D0,00,90,40,90,00,B0,00,F1,10,F1,
                        FC,3C,EE,7E,E6,FE,F6,FF,C2,FF,C2,7F,E6,7F,FC,7F,00,08,00,1A,00,2E,00,7B,00,66,00,24,00,3C,00,3F,
                        AF,E3,2F,E3,AF,E7,BF,E7,FF,E7,7F,7F,3F,3F,00,00,10,F1,10,B1,10,B0,00,63,00,22,00,32,00,06,00,00,
                        FD,FF,FF,FF,6E,7E,24,3C,66,7E,66,7E,C3,FF,FF,FF,00,22,00,1A,00,18,00,28,00,20,00,3C,00,66,00,00,
}


;;; $AAA0: Samus bottom tiles - set 1 - entry 3 ;;;
{
; 49h: Facing left  - moonwalk - frame 0
; 4Ah: Facing right - moonwalk - frame 0
; 75h: Facing left  - moonwalk - aiming up-left - frame 0
; 76h: Facing right - moonwalk - aiming up-right - frame 0
; 77h: Facing left  - moonwalk - aiming down-left - frame 0
; 78h: Facing right - moonwalk - aiming down-right - frame 0
; |--------|--------|--------|--------|--------|--------|
; |BAAAB3  |BAAB3   |  333311|C1      |     3BA|        |
; |BABB3   |BBBB    |  BAAB31|C3B     |      3B|       3|
; |BBB3    |BBB     | 3A22AB3|13BB    |       3|       B|
; |BB3    3|BBB     | 32622A3|13AB    |        |      3B|
; |B33A   3|BB3     | 3A222AB|33BAB   |        |     A33|
; |3A2    3|3333A   | 3A222BB|31BBA   |        |    3233|
; |A23   3A|33B23   |  BABAAB|311BBA  |        |    3ABB|
; |BBB   3B|ABABB   |  3BA22B|B311BB3 |        |    3BAA|
; |--------|--------|--------|--------|--------|--------|
; |22B   3A|BBBA2B  |   BA22A|B3111BB3|
; |BAAA3 33|33BBBAA3|   3B22A|B33111B3|
; |33333   |  333333|    BAAA|B333133A|
; |        |        |    3BB3|333333BB|
; |        |        |   B333B|A3BBB33B|
; |        |        | 3BA2BBB|B3BBBB3 |
; |        |        |3B622AB3|3BABB3  |
; |        |        |3A22AB33|3BAAB   |
; |--------|--------|--------|--------|
$9D:AAA0             db 8C,FC,B8,F8,F0,F0,E1,E1,E1,F1,81,E1,22,E3,E3,E3,00,F8,00,F0,00,E0,00,C0,00,90,00,40,00,81,00,E1,
                        98,F8,F0,F0,E0,E0,E0,E0,E0,E0,F0,F8,E8,F8,58,F8,00,F0,00,F0,00,E0,00,E0,00,C0,00,08,00,20,00,F8,
                        3F,3C,27,3E,43,7F,41,7F,41,7F,43,7F,29,3F,31,3F,00,00,00,3C,00,26,10,02,00,23,00,23,00,3F,00,19,
                        40,00,60,60,F0,70,D0,70,E8,F8,F0,B8,F8,9C,FE,CE,80,80,80,A0,00,30,00,30,00,38,00,38,00,1C,00,8C,
                        06,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,03,00,01,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,01,01,01,01,03,03,03,07,0B,0F,0B,0F,0C,0F,00,00,00,00,00,01,00,01,00,04,00,00,00,07,00,07,
                        22,E3,8B,FB,F8,F8,00,00,00,00,00,00,00,00,00,00,00,21,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        E4,FC,F9,FF,3F,3F,00,00,00,00,00,00,00,00,00,00,00,F4,00,3E,00,00,00,00,00,00,00,00,00,00,00,00,
                        10,1F,18,1F,08,0F,0F,0F,1F,1F,67,7F,C3,FF,87,FF,00,19,00,09,00,0F,00,06,00,11,00,37,20,46,00,4C,
                        FF,C7,FF,E3,FE,F7,FF,FF,7F,FF,FE,FE,DC,FC,C8,F8,00,86,00,82,00,81,00,03,00,B9,00,BC,00,78,00,78,
}


;;; $ABE0: Samus bottom tiles - set 1 - entry 4 ;;;
{
; 49h: Facing left  - moonwalk - frame 1
; 4Ah: Facing right - moonwalk - frame 1
; 75h: Facing left  - moonwalk - aiming up-left - frame 1
; 76h: Facing right - moonwalk - aiming up-right - frame 1
; 77h: Facing left  - moonwalk - aiming down-left - frame 1
; 78h: Facing right - moonwalk - aiming down-right - frame 1
; |--------|--------|--------|--------|
; |    33BB|3BBA26B |       1|C11333  |
; |       3|B3BA22A |       3|113BBB3 |
; |        | 33BA2A |       3|13BBAAB3|
; |        | 3B3BAA3|       B|13BA22A3|
; |        |  B3BBB3|      BB|3BB262A3|
; |        | BB33BB3|      AB|3BA22AB3|
; |        |BB3A3BB3|     ABB|3BB22AB3|
; |       B|B3323333|    AAB3|3BABBB3 |
; |--------|--------|--------|--------|
; |       3|33B2B3AA|    AB31|3A22AB3 |
; |        | BA2A3AB|   AB311|3A22A3  |
; |       B|A22BB3BB|   B1111|3BAAB3  |
; |       3|33333333|   31113|3BBBB   |
; |        |        |  B33333|B3333   |
; |        |        |  B33333|2BB33   |
; |        |        |  BBBBB3|3A3BB3  |
; |        |        |  33BBBB|33BBAB3 |
; |--------|--------|--------|--------|
$9D:ABE0             db 0F,0F,01,01,00,00,00,00,00,00,00,00,00,00,01,01,00,03,00,00,00,00,00,00,00,00,00,00,00,00,00,01,
                        E2,FE,E0,FE,70,7E,79,7F,3F,3F,7F,7F,EF,FF,EF,FF,04,72,00,B2,00,1A,00,2E,00,2E,00,66,00,D6,00,80,
                        01,00,01,01,01,01,01,01,03,03,01,03,03,07,03,0F,00,00,00,00,00,00,00,01,00,03,00,03,00,07,00,0E,
                        7C,1C,FE,3E,F3,7F,E1,7F,E1,FF,C3,FF,E3,FF,DE,FE,80,80,00,1C,00,3E,00,32,08,62,00,66,00,66,00,7C,
                        01,01,00,00,01,01,01,01,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,00,00,
                        EC,FF,45,7F,1F,FF,FF,FF,00,00,00,00,00,00,00,00,00,2B,00,6B,00,9B,00,00,00,00,00,00,00,00,00,00,
                        07,0E,0F,1C,1F,10,1F,11,3F,3F,3F,3F,3F,3F,3F,3F,00,0C,00,18,00,10,00,00,00,20,00,20,00,3E,00,0F,
                        86,FE,84,FC,CC,FC,F8,F8,F8,F8,78,F8,BC,FC,F6,FE,00,4C,00,48,00,78,00,78,00,80,00,60,00,58,00,3C,
}


;;; $ACE0: Samus bottom tiles - set 1 - entry 5 ;;;
{
; 49h: Facing left  - moonwalk - frame 4
; 4Ah: Facing right - moonwalk - frame 4
; 75h: Facing left  - moonwalk - aiming up-left - frame 4
; 76h: Facing right - moonwalk - aiming up-right - frame 4
; 77h: Facing left  - moonwalk - aiming down-left - frame 4
; 78h: Facing right - moonwalk - aiming down-right - frame 4
; |--------|--------|--------|--------|
; |      33|3BBB3BB |       1|CC133   |
; |        | 3B3333 |       3|13BBB3  |
; |        |  33AB3 |       3|3BA2ABB |
; |        |B2B3ABB3|       3|BA222AB |
; |        | 32AABB3|       B|A2262AB |
; |        | A2AB33 |      BB|A222AAB |
; |        |22BB333 |      BA|B22AAB  |
; |       A|AB33333 |     3A2|ABAAB3  |
; |--------|--------|--------|--------|
; |       3|33 3B333|    3A22|2ABB3   |
; |        |  3B33B3|    BBA2|ABB33   |
; |       3|BBBBB3B3|   23BBA|BB33B   |
; |       3|33333333|   AB333|333BB   |
; |        |        |   BBBBA|B3333   |
; |        |        |   3BA22|6A3BB   |
; |        |        |   3BBA2|2AB3BB  |
; |        |        |    33BB|AAAB3B  |
; |--------|--------|--------|--------|
$9D:ACE0             db 03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,
                        FE,FE,7E,7E,36,3E,B7,FF,47,7F,0E,7E,3E,FE,7E,FE,00,76,00,20,00,0C,00,AE,00,1E,00,58,00,30,00,C0,
                        01,00,01,01,01,01,01,01,01,01,03,03,02,03,04,07,00,00,00,00,00,00,00,00,00,01,00,03,00,03,00,02,
                        38,18,FC,7C,C6,FE,82,FE,02,FE,02,FE,84,FC,4C,FC,C0,C0,00,38,00,6E,00,C6,10,86,00,8E,00,9C,00,F8,
                        01,01,00,00,01,01,01,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        DF,DF,3F,3F,FF,FF,FF,FF,00,00,00,00,00,00,00,00,00,08,00,12,00,FA,00,00,00,00,00,00,00,00,00,00,
                        08,0F,0C,0F,0E,1F,0F,1F,1E,1F,18,1F,1C,1F,0F,0F,00,04,00,0E,00,07,00,18,00,1F,00,0C,00,0E,00,03,
                        38,F8,78,F8,F8,F8,F8,F8,F8,F8,38,F8,3C,FC,1C,FC,00,70,00,E0,00,C8,00,18,00,80,80,58,00,6C,00,F4,
}


;;; $ADE0: Samus bottom tiles - set 1 - entry 6 ;;;
{
; 35h: Facing right - crouching transition - frame 0
; 3Bh: Facing right - standing transition - frame 0
; 4Bh: Facing right - normal jump transition - frame 0
; 55h: Facing right - normal jump transition - aiming up - frame 0
; 57h: Facing right - normal jump transition - aiming up-right - frame 0
; 59h: Facing right - normal jump transition - aiming down-right - frame 0
; A4h: Facing right - landing from normal jump - frame 0
; A6h: Facing right - landing from spin jump - frame 1
; D3h: Facing right - crystal flash - frame Eh
; D7h: Facing right - crystal flash ending - frame 3
; DBh: Unused - frame 0
; DCh: Unused - frame 0
; DDh: Unused - frame 2
; DEh: Unused - frame 2
; E0h: Facing right - landing from normal jump - aiming up - frame 0
; E2h: Facing right - landing from normal jump - aiming up-right - frame 0
; E4h: Facing right - landing from normal jump - aiming down-right - frame 0
; E6h: Facing right - landing from normal jump - firing - frame 0
; E8h: Facing right - Samus drained - crouching/falling - frames 2 / Eh
; EAh: Facing right - Samus drained - standing - frame 5
; F1h: Facing right - crouching transition - aiming up - frame 0
; F3h: Facing right - crouching transition - aiming up-right - frame 0
; F5h: Facing right - crouching transition - aiming down-right - frame 0
; F7h: Facing right - standing transition - aiming up - frame 0
; F9h: Facing right - standing transition - aiming up-right - frame 0
; FBh: Facing right - standing transition - aiming down-right - frame 0
; |--------|--------|--------|--------|--------|--------|
; |3A22ABBB|3BAB33  |        |        |     33B|        |
; |BA2AAB3 |BAABB   |        |        |      33|        |
; |BAAB3   |BABB    |        |        |       3|       3|
; |BBB3    |BBB3    |  311CCC|1       |        |       3|
; |B333   B|BB3     | 33331C1|3       |        |      BB|
; |33BA   B|BB33A   |3BBB3311|B3      |        |     323|
; |B2A3  3A|333AB   |BBAAB331|3B      |        |     3AB|
; |BB3   3B|ABAB3   |BA22ABB3|3AB     |        |     3BA|
; |--------|--------|--------|--------|--------|--------|
; |A2A    3|BBAABB  |BA622AB3|BBAB    |
; |BBAA3   |33BBAAA3|3A22A2AB|3BBAB   |
; |33333   | 3333333|3BAB222A|31BBAB  |
; |        |        | 3BBA22A|B11BBBB |
; |        |        |  33BABB|3311BABB|
; |        |        |   33333|3311133B|
; |        |        | 3BAB3A2|B3333BA |
; |        |        |3B62ABAB|33BB3BB |
; |--------|--------|--------|--------|
$9D:ADE0             db 87,FF,86,FE,98,F8,F0,F0,F1,F1,E1,F1,92,F3,E3,E3,00,4F,00,DC,00,F0,00,E0,00,81,00,31,00,A1,00,C1,
                        DC,FC,98,F8,B0,F0,F0,F0,E0,E0,F0,F8,E8,F8,58,F8,00,70,00,F8,00,F0,00,E0,00,C0,00,C8,00,18,00,F0,
                        00,00,00,00,00,00,38,20,7D,78,FF,FC,CF,FE,87,FF,00,00,00,00,00,00,07,07,02,02,00,70,00,F8,00,CE,
                        00,00,00,00,00,00,80,00,80,80,C0,C0,C0,C0,A0,E0,00,00,00,00,00,00,00,00,00,00,00,80,00,40,00,60,
                        07,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,01,01,03,03,05,07,05,07,06,07,00,00,00,00,00,00,00,00,00,03,00,00,00,03,00,03,
                        01,E1,C8,F8,F8,F8,00,00,00,00,00,00,00,00,00,00,00,A0,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        CC,FC,F1,FF,7F,7F,00,00,00,00,00,00,00,00,00,00,00,FC,00,3E,00,00,00,00,00,00,00,00,00,00,00,00,
                        83,FF,81,FF,D0,FF,70,7F,3B,3F,1F,1F,6C,7F,C5,FF,20,C6,00,4B,00,71,00,39,00,0F,00,00,00,3A,20,4F,
                        D0,F0,E8,F8,F4,BC,FE,9E,FB,CF,FF,C7,FC,FE,FE,FE,00,F0,00,78,00,3C,00,9E,00,0F,00,01,00,86,00,36,
}


;;; $AF20: Samus bottom tiles - set 1 - entry 7 ;;;
{
; 36h: Facing left  - crouching transition - frame 0
; 3Ch: Facing left  - standing transition - frame 0
; 4Ch: Facing left  - normal jump transition - frame 0
; 56h: Facing left  - normal jump transition - aiming up - frame 0
; 58h: Facing left  - normal jump transition - aiming up-left - frame 0
; 5Ah: Facing left  - normal jump transition - aiming down-left - frame 0
; A5h: Facing left  - landing from normal jump - frame 0
; A7h: Facing left  - landing from spin jump - frame 1
; D4h: Facing left  - crystal flash - frame Eh
; D8h: Facing left  - crystal flash ending - frame 3
; E1h: Facing left  - landing from normal jump - aiming up - frame 0
; E3h: Facing left  - landing from normal jump - aiming up-left - frame 0
; E5h: Facing left  - landing from normal jump - aiming down-left - frame 0
; E7h: Facing left  - landing from normal jump - firing - frame 0
; E9h: Facing left  - Samus drained - crouching/falling - frames 7 / Fh / 14h / 16h
; EBh: Facing left  - Samus drained - standing - frame 5
; F2h: Facing left  - crouching transition - aiming up - frame 0
; F4h: Facing left  - crouching transition - aiming up-left - frame 0
; F6h: Facing left  - crouching transition - aiming down-left - frame 0
; F8h: Facing left  - standing transition - aiming up - frame 0
; FAh: Facing left  - standing transition - aiming up-left - frame 0
; FCh: Facing left  - standing transition - aiming down-left - frame 0
; |--------|--------|--------|--------|--------|--------|
; |3A22ABBB|3BAB33  |        |        |     33B|        |
; |BA2AAB3 |BAABB   |        |        |      33|        |
; |BAAB3   |BABB    |        |        |       3|       3|
; |BBB3    |BBB3    |  311CCC|1       |        |       3|
; |B333   B|BB3     | 33331C1|3       |        |      BB|
; |33BA   B|BB33A   |3BBB3311|B3      |        |     323|
; |B2A3  3A|333AB   |BBAAB331|3B      |        |     3AB|
; |BB3   3B|ABAB3   |BA22ABB3|3AB     |        |     3BA|
; |--------|--------|--------|--------|--------|--------|
; |A2A    3|BBAABB  |BA622AB3|BBAB    |
; |BBAA3   |33BBAAA3|3A22A2AB|3BBAB   |
; |33333   | 3333333|3BAB222A|31BBAB  |
; |        |        | 3BBA22A|B11BBBB |
; |        |        |  33BABB|3311BABB|
; |        |        |   33333|3311133B|
; |        |        | 3BAB3A2|B3333BA |
; |        |        |3B62ABAB|33BB3BB |
; |--------|--------|--------|--------|
$9D:AF20             db 87,FF,86,FE,98,F8,F0,F0,F1,F1,E1,F1,92,F3,E3,E3,00,4F,00,DC,00,F0,00,E0,00,81,00,31,00,A1,00,C1,
                        DC,FC,98,F8,B0,F0,F0,F0,E0,E0,F0,F8,E8,F8,58,F8,00,70,00,F8,00,F0,00,E0,00,C0,00,C8,00,18,00,F0,
                        00,00,00,00,00,00,38,20,7D,78,FF,FC,CF,FE,87,FF,00,00,00,00,00,00,07,07,02,02,00,70,00,F8,00,CE,
                        00,00,00,00,00,00,80,00,80,80,C0,C0,C0,C0,A0,E0,00,00,00,00,00,00,00,00,00,00,00,80,00,40,00,60,
                        07,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,01,01,03,03,05,07,05,07,06,07,00,00,00,00,00,00,00,00,00,03,00,00,00,03,00,03,
                        01,E1,C8,F8,F8,F8,00,00,00,00,00,00,00,00,00,00,00,A0,00,F0,00,00,00,00,00,00,00,00,00,00,00,00,
                        CC,FC,F1,FF,7F,7F,00,00,00,00,00,00,00,00,00,00,00,FC,00,3E,00,00,00,00,00,00,00,00,00,00,00,00,
                        83,FF,81,FF,D0,FF,70,7F,3B,3F,1F,1F,6C,7F,C5,FF,20,C6,00,4B,00,71,00,39,00,0F,00,00,00,3A,20,4F,
                        D0,F0,E8,F8,F4,BC,FE,9E,FB,CF,FF,C7,FC,FE,FE,FE,00,F0,00,78,00,3C,00,9E,00,0F,00,01,00,86,00,36,
}


;;; $B060: Samus bottom tiles - set 1 - entry 8 ;;;
{
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frames 2..3
; C7h: Facing right - vertical shinespark windup - frames 2..3
; F0h: Facing right - grabbed by Draygon - moving - frame 5
; |--------|--------|--------|--------|--------|--------|--------|
; |     333|BB      |        |2AB     | 3AAB333|  3B3B  |        |
; |    33BA|AABBBB  |        |AB      |  3BAA22|  3BB   |        |
; |    3BA2|2ABAABBB|B       |B       |   33BAA|  3BB   |33      |
; |    3A26|22A222AB|AB      |3       |     3BA|  3B    |3BAB    |
; |    3B22|22B222AB|33      |        |      33|  3B    |3B2A    |
; |    3BAA|AABAAAB3|        |3       |        |   3    |B3AB    |
; |     3BA|ABBBBB3B|        |B       |        |        |ABBB    |
; |      33|333333BA|        |        |        |        |62B3    |
; |--------|--------|--------|--------|--------|--------|--------|
; |        | 3333BA2|
; |        |33333B2A|
; |      3B|BBB3BAAB|
; |    33BA|AB3BAAB3|
; | 333BBBB|B3333333|
; | 3BB3BB3|33B33B33|
; | 3BB3333| 3BA3332|
; | 333BBBB| 3AABA2B|
; |--------|--------|
$9D:B060             db 07,07,0E,0F,0C,0F,08,0F,0C,0F,0C,0F,06,07,03,03,00,00,00,03,00,06,01,04,00,04,00,07,00,03,00,00,
                        C0,C0,3C,FC,27,FF,01,FF,21,FF,23,FF,7F,FF,FE,FF,00,C0,00,FC,00,7F,00,23,00,23,00,FE,00,FD,00,03,
                        00,00,00,00,80,80,40,C0,C0,C0,00,00,00,00,00,00,00,00,00,00,00,80,00,C0,00,00,00,00,00,00,00,00,
                        20,E0,40,C0,80,80,80,80,00,00,80,80,80,80,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,80,00,00,
                        4F,7F,30,3F,1C,1F,06,07,03,03,00,00,00,00,00,00,00,38,00,1C,00,07,00,03,00,00,00,00,00,00,00,00,
                        3C,3C,38,38,38,38,30,30,30,30,10,10,00,00,00,00,00,14,00,18,00,18,00,10,00,10,00,00,00,00,00,00,
                        00,00,00,00,C0,C0,D0,F0,C0,F0,D0,F0,70,F0,30,F0,00,00,00,00,00,00,00,70,00,50,00,B0,00,F0,80,20,
                        00,00,00,00,03,03,0E,0F,7F,7F,7F,7F,7F,7F,7F,7F,00,00,00,00,00,01,00,03,00,0F,00,36,00,30,00,0F,
                        7C,7F,FC,FF,F9,FF,73,FF,FF,FF,FF,FF,6E,7F,49,7F,00,06,00,05,00,EF,00,DE,00,80,00,24,00,30,00,3D,
}


;;; $B180: Samus bottom tiles - set 1 - entry 9 ;;;
{
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frames 2..3
; BEh: Facing left  - grabbed by Draygon - moving - frame 5
; C8h: Facing left  - vertical shinespark windup - frames 2..3
; |--------|--------|--------|--------|--------|--------|--------|
; |     333|BB      |        |2AB     | 3AAB333|  3B3B  |        |
; |    33BA|AABBBB  |        |AB      |  3BAA22|  3BB   |        |
; |    3BA2|2ABAABBB|B       |B       |   33BAA|  3BB   |33      |
; |    3A26|22A222AB|AB      |3       |     3BA|  3B    |3BAB    |
; |    3B22|22B222AB|33      |        |      33|  3B    |3B2A    |
; |    3BAA|AABAAAB3|        |3       |        |   3    |B3AB    |
; |     3BA|ABBBBB3B|        |B       |        |        |ABBB    |
; |      33|333333BA|        |        |        |        |62B3    |
; |--------|--------|--------|--------|--------|--------|--------|
; |        | 3333BA2|
; |        |33333B2A|
; |      3B|BBB3BAAB|
; |    33BA|AB3BAAB3|
; | 333BBBB|B3333333|
; | 3BB3BB3|33B33B33|
; | 3BB3333| 3BA3332|
; | 333BBBB| 3AABA2B|
; |--------|--------|
$9D:B180             db 07,07,0E,0F,0C,0F,08,0F,0C,0F,0C,0F,06,07,03,03,00,00,00,03,00,06,01,04,00,04,00,07,00,03,00,00,
                        C0,C0,3C,FC,27,FF,01,FF,21,FF,23,FF,7F,FF,FE,FF,00,C0,00,FC,00,7F,00,23,00,23,00,FE,00,FD,00,03,
                        00,00,00,00,80,80,40,C0,C0,C0,00,00,00,00,00,00,00,00,00,00,00,80,00,C0,00,00,00,00,00,00,00,00,
                        20,E0,40,C0,80,80,80,80,00,00,80,80,80,80,00,00,00,60,00,C0,00,80,00,00,00,00,00,00,00,80,00,00,
                        4F,7F,30,3F,1C,1F,06,07,03,03,00,00,00,00,00,00,00,38,00,1C,00,07,00,03,00,00,00,00,00,00,00,00,
                        3C,3C,38,38,38,38,30,30,30,30,10,10,00,00,00,00,00,14,00,18,00,18,00,10,00,10,00,00,00,00,00,00,
                        00,00,00,00,C0,C0,D0,F0,C0,F0,D0,F0,70,F0,30,F0,00,00,00,00,00,00,00,70,00,50,00,B0,00,F0,80,20,
                        00,00,00,00,03,03,0E,0F,7F,7F,7F,7F,7F,7F,7F,7F,00,00,00,00,00,01,00,03,00,0F,00,36,00,30,00,0F,
                        7C,7F,FC,FF,F9,FF,73,FF,FF,FF,FF,FF,6E,7F,49,7F,00,06,00,05,00,EF,00,DE,00,80,00,24,00,30,00,3D,
}


;;; $B2A0: Samus bottom tiles - set 1 - entry Ah ;;;
{
; 13h: Facing right - normal jump - not aiming - not moving - gun extended - frame 0
; 15h: Facing right - normal jump - aiming up - frame 0
; 17h: Facing right - normal jump - aiming down - frame 0
; 29h: Facing right - falling - frames 0 / 5
; 2Bh: Facing right - falling - aiming up - frame 0
; 2Dh: Facing right - falling - aiming down - frame 0
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 4
; 50h: Facing right - damage boost - frame 1
; 51h: Facing right - normal jump - not aiming - moving forward - frame 0
; 67h: Facing right - falling - gun extended - frames 0 / 5
; 69h: Facing right - normal jump - aiming up-right - frame 0
; 6Bh: Facing right - normal jump - aiming down-right - frame 0
; 6Dh: Facing right - falling - aiming up-right - frame 0
; 6Fh: Facing right - falling - aiming down-right - frame 0
; ACh: Unused. Facing right - grappling - in air - frame 0
; AEh: Unused. Facing right - grappling - in air - aiming down - frame 0
; B0h: Unused. Facing right - grappling - in air - aiming down-right - frame 0
; C7h: Facing right - vertical shinespark windup - frame 4
; |--------|--------|--------|--------|--------|
; |BB3BBB33|        |     33B|BBB33   |        |
; |A2B333B |        |   3B3BB|AAAB3   |        |
; |3AABA22A|B       |  3B3BBA|222AB   |       3|
; | BBA2262|AB3     |3BB3BAB2|262AB   |      33|
; | 33BBAA2|2AB33   |BB3BA2AA|222A3   |      33|
; |  333BBB|BBAB33B3|B3BA222B|A2AB    |      B3|
; |   3B333|BBBB3BB3|3BA2222A|B33     |      33|
; |    3B33|3333BAB3|33BA2ABB|3       |       3|
; |--------|--------|--------|--------|--------|
; |   ABB3B|3BA2AAB3|BB3BBB33|        |
; |     ABB|33333B3 |A2B333B |        |
; |     ABB|33B2AB3 |3AABA22A|B       |
; |    ABB3|   B2A3 | BBA2262|AB3     |
; |    BB3 |   AAB  | 33BBAA2|2AB33   |
; |   BB3  |   AB3  |  333BBB|BBAB33B3|
; |   33   |  BB3   |   3B333|BBBB3BB3|
; |        |  333   |    3B33|3333BAB3|
; |--------|--------|--------|--------|
$9D:B2A0             db FF,FF,3E,FE,90,FF,60,7F,78,7F,3F,3F,1F,1F,0F,0F,00,DC,00,A2,00,79,02,70,00,1E,00,07,00,08,00,04,
                        00,00,00,00,80,80,60,E0,38,F8,DF,FF,FF,FF,FB,FF,00,00,00,00,00,80,00,C0,00,60,00,F2,00,F6,00,0E,
                        07,07,1F,1F,3E,3F,FA,FF,F0,FF,E1,FF,C0,FF,E3,FF,00,01,00,0B,00,17,00,6E,00,DB,00,B1,00,61,00,37,
                        F8,F8,18,F8,08,F8,08,F8,08,F8,10,F0,E0,E0,80,80,00,E0,00,F0,00,18,40,18,00,10,00,B0,00,80,00,00,
                        00,00,00,00,01,01,03,03,03,03,03,03,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,02,00,00,00,00,
                        0F,1F,03,07,03,07,07,0F,0E,0E,1C,1C,18,18,00,00,00,1D,00,07,00,07,00,0E,00,0C,00,18,00,00,00,00,
                        C3,FF,FE,FE,E6,FE,12,1E,04,1C,0C,1C,38,38,38,38,00,6E,00,04,00,2C,00,14,00,1C,00,18,00,30,00,00,
                        FF,FF,3E,FE,90,FF,60,7F,78,7F,3F,3F,1F,1F,0F,0F,00,DC,00,A2,00,79,02,70,00,1E,00,07,00,08,00,04,
                        00,00,00,00,80,80,60,E0,38,F8,DF,FF,FF,FF,FB,FF,00,00,00,00,00,80,00,C0,00,60,00,F2,00,F6,00,0E,
}


;;; $B3C0: Samus bottom tiles - set 1 - entry Bh ;;;
{
; 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frame 0
; 16h: Facing left  - normal jump - aiming up - frame 0
; 18h: Facing left  - normal jump - aiming down - frame 0
; 2Ah: Facing left  - falling - frames 0 / 5
; 2Ch: Facing left  - falling - aiming up - frame 0
; 2Eh: Facing left  - falling - aiming down - frame 0
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 4
; 4Fh: Facing left  - damage boost - frame 1
; 52h: Facing left  - normal jump - not aiming - moving forward - frame 0
; 68h: Facing left  - falling - gun extended - frames 0 / 5
; 6Ah: Facing left  - normal jump - aiming up-left - frame 0
; 6Ch: Facing left  - normal jump - aiming down-left - frame 0
; 6Eh: Facing left  - falling - aiming up-left - frame 0
; 70h: Facing left  - falling - aiming down-left - frame 0
; ADh: Unused. Facing left  - grappling - in air - frame 0
; AFh: Unused. Facing left  - grappling - in air - aiming down - frame 0
; B1h: Unused. Facing left  - grappling - in air - aiming down-left - frame 0
; C8h: Facing left  - vertical shinespark windup - frame 4
; |--------|--------|--------|--------|--------|
; |BB3BBB33|        |     33B|BBB33   |        |
; |A2B333B |        |   3B3BB|AAAB3   |        |
; |3AABA22A|B       |  3B3BBA|222AB   |       3|
; | BBA2262|AB3     |3BB3BAB2|262AB   |      33|
; | 33BBAA2|2AB33   |BB3BA2AA|222A3   |      33|
; |  333BBB|BBAB33B3|B3BA222B|A2AB    |      B3|
; |   3B333|BBBB3BB3|3BA2222A|B33     |      33|
; |    3B33|3333BAB3|33BA2ABB|3       |       3|
; |--------|--------|--------|--------|--------|
; |   ABB3B|3BA2AAB3|BB3BBB33|        |
; |     ABB|33333B3 |A2B333B |        |
; |     ABB|33B2AB3 |3AABA22A|B       |
; |    ABB3|   B2A3 | BBA2262|AB3     |
; |    BB3 |   AAB  | 33BBAA2|2AB33   |
; |   BB3  |   AB3  |  333BBB|BBAB33B3|
; |   33   |  BB3   |   3B333|BBBB3BB3|
; |        |  333   |    3B33|3333BAB3|
; |--------|--------|--------|--------|
$9D:B3C0             db FF,FF,3E,FE,90,FF,60,7F,78,7F,3F,3F,1F,1F,0F,0F,00,DC,00,A2,00,79,02,70,00,1E,00,07,00,08,00,04,
                        00,00,00,00,80,80,60,E0,38,F8,DF,FF,FF,FF,FB,FF,00,00,00,00,00,80,00,C0,00,60,00,F2,00,F6,00,0E,
                        07,07,1F,1F,3E,3F,FA,FF,F0,FF,E1,FF,C0,FF,E3,FF,00,01,00,0B,00,17,00,6E,00,DB,00,B1,00,61,00,37,
                        F8,F8,18,F8,08,F8,08,F8,08,F8,10,F0,E0,E0,80,80,00,E0,00,F0,00,18,40,18,00,10,00,B0,00,80,00,00,
                        00,00,00,00,01,01,03,03,03,03,03,03,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,02,00,00,00,00,
                        0F,1F,03,07,03,07,07,0F,0E,0E,1C,1C,18,18,00,00,00,1D,00,07,00,07,00,0E,00,0C,00,18,00,00,00,00,
                        C3,FF,FE,FE,E6,FE,12,1E,04,1C,0C,1C,38,38,38,38,00,6E,00,04,00,2C,00,14,00,1C,00,18,00,30,00,00,
                        FF,FF,3E,FE,90,FF,60,7F,78,7F,3F,3F,1F,1F,0F,0F,00,DC,00,A2,00,79,02,70,00,1E,00,07,00,08,00,04,
                        00,00,00,00,80,80,60,E0,38,F8,DF,FF,FF,FF,FB,FF,00,00,00,00,00,80,00,C0,00,60,00,F2,00,F6,00,0E,
}


;;; $B4E0: Samus bottom tiles - set 1 - entry Ch ;;;
{
; 29h: Facing right - falling - frames 1..2
; 2Bh: Facing right - falling - aiming up - frame 1
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 5
; 53h: Facing right - knockback - frame 0
; 67h: Facing right - falling - gun extended - frames 1..2
; C7h: Facing right - vertical shinespark windup - frame 5
; D7h: Facing right - crystal flash ending - frame 4
; E8h: Facing right - Samus drained - crouching/falling - frames 3 / 5
; F0h: Facing right - grabbed by Draygon - moving - frames 0 / 3
; |--------|--------|--------|--------|
; |   333B3|B262B   |       3|313333  |
; |   BB333|BA22B3  |      3B|33BAAB3 |
; |    BB33|3BAAA3  |    33BA|3BA22A3 |
; |    333B|B3BBA3  |   3BAAB|3B2262B |
; |    3B3B|B33BBB3 |  3BAAB3|BA2222B |
; |   3BB3B|3333B33 | 33ABB13|BAA22A3 |
; | 3BBB333|B2B33A33|33BBB113|A2AAAB  |
; | 3333   | BABB2A3|B331113B|A222B3  |
; |--------|--------|--------|--------|
; |        | 3333BB3|BB33333B|222AB3  |
; |        | BBBB33 |3B333 3B|A2AB3   |
; |        |3A2AB3  | 3BBB3B3|BAB3    |
; |      3B|A2B33   | 3BBB3A3|333     |
; |      33|333     |  3BB32B|BB3     |
; |        |        |   3BBBA|BAB3    |
; |        |        |    3B3B|BAAB3   |
; |        |        |    333B|A22AB   |
; |--------|--------|--------|--------|
$9D:B4E0             db 1F,1F,1F,1F,0F,0F,0F,0F,0F,0F,1F,1F,7F,7F,78,78,00,02,00,18,00,0C,00,01,00,05,00,0D,00,38,00,00,
                        88,F8,8C,FC,C4,FC,F4,FC,FE,FE,FE,FE,BB,FF,59,7F,20,88,00,C8,00,78,00,B8,00,9C,00,08,00,A4,00,7A,
                        01,01,03,03,0E,0F,19,1F,33,3F,6F,7D,FF,F9,FF,E3,00,00,00,01,00,03,00,0F,00,1E,00,1C,00,38,00,81,
                        FC,BC,E6,FE,C2,FE,C2,FE,82,FE,82,FE,04,FC,0C,FC,00,00,00,3C,00,64,08,42,00,C2,00,E4,00,BC,00,88,
                        00,00,00,00,00,00,03,03,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,
                        7F,7F,7E,7E,8C,FC,38,F8,E0,E0,00,00,00,00,00,00,00,06,00,78,00,58,00,A0,00,00,00,00,00,00,00,00,
                        FF,FF,FB,FB,7F,7F,7D,7F,3D,3F,1E,1F,0F,0F,0F,0F,00,C1,00,41,00,3A,00,3A,00,19,00,0F,00,05,00,01,
                        0C,FC,18,F8,B0,F0,E0,E0,E0,E0,B0,F0,98,F8,08,F8,00,18,00,B0,00,E0,00,00,00,C0,00,E0,00,F0,00,98,
}


;;; $B5E0: Samus bottom tiles - set 1 - entry Dh ;;;
{
; 2Ah: Facing left  - falling - frames 1..2
; 2Ch: Facing left  - falling - aiming up - frame 1
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 5
; 54h: Facing left  - knockback - frame 0
; 68h: Facing left  - falling - gun extended - frames 1..2
; BEh: Facing left  - grabbed by Draygon - moving - frames 0 / 3
; C8h: Facing left  - vertical shinespark windup - frame 5
; D8h: Facing left  - crystal flash ending - frame 4
; E9h: Facing left  - Samus drained - crouching/falling - frames 2 / 4
; |--------|--------|--------|--------|
; |   333B3|B262B   |       3|313333  |
; |   BB333|BA22B3  |      3B|33BAAB3 |
; |    BB33|3BAAA3  |    33BA|3BA22A3 |
; |    333B|B3BBA3  |   3BAAB|3B2262B |
; |    3B3B|B33BBB3 |  3BAAB3|BA2222B |
; |   3BB3B|3333B33 | 33ABB13|BAA22A3 |
; | 3BBB333|B2B33A33|33BBB113|A2AAAB  |
; | 3333   | BABB2A3|B331113B|A222B3  |
; |--------|--------|--------|--------|
; |        | 3333BB3|BB33333B|222AB3  |
; |        | BBBB33 |3B333 3B|A2AB3   |
; |        |3A2AB3  | 3BBB3B3|BAB3    |
; |      3B|A2B33   | 3BBB3A3|333     |
; |      33|333     |  3BB32B|BB3     |
; |        |        |   3BBBA|BAB3    |
; |        |        |    3B3B|BAAB3   |
; |        |        |    333B|A22AB   |
; |--------|--------|--------|--------|
$9D:B5E0             db 1F,1F,1F,1F,0F,0F,0F,0F,0F,0F,1F,1F,7F,7F,78,78,00,02,00,18,00,0C,00,01,00,05,00,0D,00,38,00,00,
                        88,F8,8C,FC,C4,FC,F4,FC,FE,FE,FE,FE,BB,FF,59,7F,20,88,00,C8,00,78,00,B8,00,9C,00,08,00,A4,00,7A,
                        01,01,03,03,0E,0F,19,1F,33,3F,6F,7D,FF,F9,FF,E3,00,00,00,01,00,03,00,0F,00,1E,00,1C,00,38,00,81,
                        FC,BC,E6,FE,C2,FE,C2,FE,82,FE,82,FE,04,FC,0C,FC,00,00,00,3C,00,64,08,42,00,C2,00,E4,00,BC,00,88,
                        00,00,00,00,00,00,03,03,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,00,
                        7F,7F,7E,7E,8C,FC,38,F8,E0,E0,00,00,00,00,00,00,00,06,00,78,00,58,00,A0,00,00,00,00,00,00,00,00,
                        FF,FF,FB,FB,7F,7F,7D,7F,3D,3F,1E,1F,0F,0F,0F,0F,00,C1,00,41,00,3A,00,3A,00,19,00,0F,00,05,00,01,
                        0C,FC,18,F8,B0,F0,E0,E0,E0,E0,B0,F0,98,F8,08,F8,00,18,00,B0,00,E0,00,00,00,C0,00,E0,00,F0,00,98,
}


;;; $B6E0: Samus bottom tiles - set 1 - entry Eh ;;;
{
; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended - frame 1
; C7h: Facing right - vertical shinespark windup - frame 1
; F0h: Facing right - grabbed by Draygon - moving - frame 4
; |--------|--------|--------|--------|--------|--------|
; | 333BB3B|BBBB333 | 3BAA   |        |BAB3    |3BABB33 |
; |33BAABBA|AAAB3BAA|  3333  |        |3BAB    |3BBBB3  |
; |3BA222B2|22AB3B2A|        |       3|33BA    |BBB33   |
; |3A2622A2|22A3B3AB|        |       3| 33BB   |3B33    |
; |3B222ABA|AB3BAB33|        |      3B|  333   |33333   |
; |3BAAAABB|B3BA62BB|        |     33B|        |B3BBAA  |
; | 3BBBB33|3BA22AB |        |      3B|        |BABAB   |
; |  333333|3A2AAB  |        |       3|        |33333   |
; |--------|--------|--------|--------|--------|--------|
; |   33113|BAABB   |
; |    3113|BAB3    |
; |    3133|BB33A   |
; |    113B|3332B   |
; |   333BA|BA2B    |
; |  3B33BA|B333    |
; | 3BAB33B|AA22    |
; | 3AABB33|3BAAB   |
; |--------|--------|
$9D:B6E0             db 7F,7F,E6,FF,C2,FF,80,FF,C2,FF,C3,FF,7F,7F,3F,3F,00,0D,00,3F,00,62,10,42,00,47,00,7F,00,3C,00,00,
                        FE,FE,1C,FF,1C,FF,1D,FF,77,FF,E3,FF,C2,FE,84,FC,00,F0,00,F7,00,35,00,2B,00,DC,08,B3,00,66,00,5C,
                        60,78,3C,3C,00,00,00,00,00,00,00,00,00,00,00,00,00,38,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,01,01,03,03,07,07,03,03,01,01,00,00,00,00,00,00,00,00,00,01,00,01,00,01,00,00,
                        B0,F0,D0,F0,E0,F0,78,78,38,38,00,00,00,00,00,00,00,E0,00,70,00,30,00,18,00,00,00,00,00,00,00,00,
                        DE,FE,FC,FC,F8,F8,F0,F0,F8,F8,F0,FC,A8,F8,F8,F8,00,78,00,78,00,E0,00,40,00,00,00,BC,00,F8,00,00,
                        1F,19,0F,09,0F,0B,0F,03,1E,1F,3E,3F,6F,7F,4F,7F,00,00,00,00,00,00,00,01,00,03,00,13,00,39,00,3C,
                        98,F8,B0,F0,F0,F8,E8,F8,90,F0,F0,F0,00,F0,C8,F8,00,F8,00,E0,00,C8,00,08,00,D0,00,80,00,C0,00,78,
}


;;; $B7E0: Samus bottom tiles - set 1 - entry Fh ;;;
{
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended - frame 1
; BEh: Facing left  - grabbed by Draygon - moving - frame 4
; C8h: Facing left  - vertical shinespark windup - frame 1
; |--------|--------|--------|--------|--------|--------|
; | 333BB3B|BBBB333 | 3BAA   |        |BAB3    |3BABB33 |
; |33BAABBA|AAAB3BAA|  3333  |        |3BAB    |3BBBB3  |
; |3BA222B2|22AB3B2A|        |       3|33BA    |BBB33   |
; |3A2622A2|22A3B3AB|        |       3| 33BB   |3B33    |
; |3B222ABA|AB3BAB33|        |      3B|  333   |33333   |
; |3BAAAABB|B3BA62BB|        |     33B|        |B3BBAA  |
; | 3BBBB33|3BA22AB |        |      3B|        |BABAB   |
; |  333333|3A2AAB  |        |       3|        |33333   |
; |--------|--------|--------|--------|--------|--------|
; |   33113|BAABB   |
; |    3113|BAB3    |
; |    3133|BB33A   |
; |    113B|3332B   |
; |   333BA|BA2B    |
; |  3B33BA|B333    |
; | 3BAB33B|AA22    |
; | 3AABB33|3BAAB   |
; |--------|--------|
$9D:B7E0             db 7F,7F,E6,FF,C2,FF,80,FF,C2,FF,C3,FF,7F,7F,3F,3F,00,0D,00,3F,00,62,10,42,00,47,00,7F,00,3C,00,00,
                        FE,FE,1C,FF,1C,FF,1D,FF,77,FF,E3,FF,C2,FE,84,FC,00,F0,00,F7,00,35,00,2B,00,DC,08,B3,00,66,00,5C,
                        60,78,3C,3C,00,00,00,00,00,00,00,00,00,00,00,00,00,38,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,01,01,03,03,07,07,03,03,01,01,00,00,00,00,00,00,00,00,00,01,00,01,00,01,00,00,
                        B0,F0,D0,F0,E0,F0,78,78,38,38,00,00,00,00,00,00,00,E0,00,70,00,30,00,18,00,00,00,00,00,00,00,00,
                        DE,FE,FC,FC,F8,F8,F0,F0,F8,F8,F0,FC,A8,F8,F8,F8,00,78,00,78,00,E0,00,40,00,00,00,BC,00,F8,00,00,
                        1F,19,0F,09,0F,0B,0F,03,1E,1F,3E,3F,6F,7F,4F,7F,00,00,00,00,00,00,00,01,00,03,00,13,00,39,00,3C,
                        98,F8,B0,F0,F0,F8,E8,F8,90,F0,F0,F0,00,F0,C8,F8,00,F8,00,E0,00,C8,00,08,00,D0,00,80,00,C0,00,78,
}


;;; $B8E0: Samus bottom tiles - set 1 - entry 10h ;;;
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
$9D:B8E0             db E0,00,80,00,E0,00,8E,00,E9,00,0E,00,08,00,08,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
}


;;; $B900: Samus bottom tiles - set 1 - entry 11h ;;;
{
; 17h: Facing right - normal jump - aiming down - frame 1
; 2Dh: Facing right - falling - aiming down - frame 1
; AEh: Unused. Facing right - grappling - in air - aiming down - frame 1
; |--------|--------|--------|--------|--------|--------|--------|
; |        |3BB311BB|3BB3    |      3B|A23BA3  |        |B3      |
; |        |AAB31BAA|3BB3    |       3|AB32A3  |        |AB3     |
; |      BA|BB333B22|3333    |      3B|   2A3  |3       |2AB     |
; |    3BBB|3333BA26|B33     |      AB|   2B   |B3      |22B     |
; |   333B3|1133BA22|3       |    BAB3|   A3   |BB3BBB3 |22B     |
; |   A3311|113BABA2|        |    333 |   B3   |AB3A2B3 |2A3     |
; |   AB331|333A22BA|        |        |   3    |A3BBAB3 |A3      |
; |   BB333|33B222AB|        |        |        |3B2BB3  |3       |
; |--------|--------|--------|--------|--------|--------|--------|
; |    33BB|B3BA2AB3|
; |     BBA|333BAB33|
; |     3BB|3AB333BB|
; |      BB|3A2BAA2A|
; |      3B|3BABA262|
; |      33|3333BBAA|
; |     AB3|3B3 333B|
; |      AB|333    3|
; |--------|--------|
$9D:B900             db 00,00,00,00,02,03,0F,0F,1F,1F,0F,1C,0F,1E,1F,1F,00,00,00,00,00,03,00,07,00,02,00,10,00,18,00,18,
                        FF,F3,3C,F7,FC,FF,F8,FF,F8,3F,F4,3F,E2,FF,E1,FF,00,63,00,E7,00,C4,01,0C,00,0C,00,1E,00,13,00,23,
                        F0,F0,F0,F0,F0,F0,E0,E0,80,80,00,00,00,00,00,00,00,60,00,60,00,00,00,80,00,00,00,00,00,00,00,00,
                        03,03,01,01,03,03,01,03,0B,0F,0E,0E,00,00,00,00,00,01,00,00,00,01,00,03,00,0E,00,00,00,00,00,00,
                        34,FC,64,FC,04,1C,08,18,08,18,18,18,10,10,00,00,00,98,00,C8,00,08,00,08,00,10,00,10,00,00,00,00,
                        00,00,00,00,80,80,C0,C0,FE,FE,66,FE,76,FE,DC,FC,00,00,00,00,00,00,00,80,00,DC,00,D4,00,BC,00,58,
                        C0,C0,60,E0,20,E0,20,E0,20,E0,20,E0,40,C0,80,80,00,80,00,C0,00,60,00,20,00,20,00,40,00,80,00,00,
                        0F,0F,06,07,07,07,03,03,03,03,03,03,03,07,01,03,00,03,00,07,00,03,00,03,00,01,00,00,00,06,00,03,
                        E3,FF,F7,FF,BF,FF,90,FF,D0,FF,FC,FF,EF,EF,E1,E1,00,B6,00,1C,00,63,00,5D,02,78,00,0F,00,41,00,00,
}


;;; $BA20: Samus bottom tiles - set 1 - entry 12h ;;;
{
; 18h: Facing left  - normal jump - aiming down - frame 1
; 2Eh: Facing left  - falling - aiming down - frame 1
; AFh: Unused. Facing left  - grappling - in air - aiming down - frame 1
; |--------|--------|--------|--------|--------|--------|--------|
; |        |3BB311BB|3BB3    |      3B|A23BA3  |        |B3      |
; |        |AAB31BAA|3BB3    |       3|AB32A3  |        |AB3     |
; |      BA|BB333B22|3333    |      3B|   2A3  |3       |2AB     |
; |    3BBB|3333BA26|B33     |      AB|   2B   |B3      |22B     |
; |   333B3|1133BA22|3       |    BAB3|   A3   |BB3BBB3 |22B     |
; |   A3311|113BABA2|        |    333 |   B3   |AB3A2B3 |2A3     |
; |   AB331|333A22BA|        |        |   3    |A3BBAB3 |A3      |
; |   BB333|33B222AB|        |        |        |3B2BB3  |3       |
; |--------|--------|--------|--------|--------|--------|--------|
; |    33BB|B3BA2AB3|
; |     BBA|333BAB33|
; |     3BB|3AB333BB|
; |      BB|3A2BAA2A|
; |      3B|3BABA262|
; |      33|3333BBAA|
; |     AB3|3B3 333B|
; |      AB|333    3|
; |--------|--------|
$9D:BA20             db 00,00,00,00,02,03,0F,0F,1F,1F,0F,1C,0F,1E,1F,1F,00,00,00,00,00,03,00,07,00,02,00,10,00,18,00,18,
                        FF,F3,3C,F7,FC,FF,F8,FF,F8,3F,F4,3F,E2,FF,E1,FF,00,63,00,E7,00,C4,01,0C,00,0C,00,1E,00,13,00,23,
                        F0,F0,F0,F0,F0,F0,E0,E0,80,80,00,00,00,00,00,00,00,60,00,60,00,00,00,80,00,00,00,00,00,00,00,00,
                        03,03,01,01,03,03,01,03,0B,0F,0E,0E,00,00,00,00,00,01,00,00,00,01,00,03,00,0E,00,00,00,00,00,00,
                        34,FC,64,FC,04,1C,08,18,08,18,18,18,10,10,00,00,00,98,00,C8,00,08,00,08,00,10,00,10,00,00,00,00,
                        00,00,00,00,80,80,C0,C0,FE,FE,66,FE,76,FE,DC,FC,00,00,00,00,00,00,00,80,00,DC,00,D4,00,BC,00,58,
                        C0,C0,60,E0,20,E0,20,E0,20,E0,20,E0,40,C0,80,80,00,80,00,C0,00,60,00,20,00,20,00,40,00,80,00,00,
                        0F,0F,06,07,07,07,03,03,03,03,03,03,03,07,01,03,00,03,00,07,00,03,00,03,00,01,00,00,00,06,00,03,
                        E3,FF,F7,FF,BF,FF,90,FF,D0,FF,FC,FF,EF,EF,E1,E1,00,B6,00,1C,00,63,00,5D,02,78,00,0F,00,41,00,00,
}


;;; $BB40: Samus bottom tiles - set 1 - entry 13h ;;;
{
; 65h: Unused - frame 0
; 83h: Facing right - wall jump - frame 0
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3BBB3BA2|2AB13FF9|        |        |  B333B3|32A     |        |3       |
; |BBAA3BB2|2B313F  |D       |3DDDDDD3|   3BB3 |3A      |     3BB|        |
; |BA2233BA|AB33    |53D     |35555553|    3B3 |3A      |3BB3BBAA|        |
; |BA62B333|33BBB   |738     |38888873|    333 |3       |3A233BBA|AA3     |
; |3A22BA2B|3AAABB3B|535     |35555553|     3B |        |3ABB33BB|A2A     |
; | BAAA3A3|A2622A3B|D3D     |3DDDDDD3|      3 |        |3BA2B333|AAB     |
; | 3BBAB33|BAAAAA3B|333     |33333333|        |        |3BB32B3 |B33     |
; |  3BBA33|3BBBBB33|        |        |        |        |3ABBBA  |3       |
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |3333BBBB|3333333B|
; |AABB3B33|333333BB|
; |262A3333|BB3BB3B |
; |AAABB33A|A3BBB   |
; |BBB3333B|3B3     |
; |33333333|3       |
; |  333333|        |
; | 3BB333B|B       |
; |--------|--------|
$9D:BB40             db FC,FF,CE,FF,8E,FF,8F,FF,89,FF,45,7F,77,7F,3B,3F,00,76,00,F6,00,C3,20,C8,00,4D,00,7A,00,3C,00,1C,
                        3F,EE,7C,EC,70,F0,F8,F8,8F,FF,03,FF,83,FF,FF,FF,06,67,04,44,00,C0,00,38,00,7D,20,85,00,FD,00,7C,
                        00,00,80,00,E0,40,C0,C0,E0,40,E0,40,E0,E0,00,00,00,00,80,80,A0,20,80,20,A0,00,A0,A0,00,00,00,00,
                        00,00,FF,81,FF,81,83,83,FF,81,FF,81,FF,FF,00,00,00,00,7E,7E,7E,00,02,7C,7E,00,7E,7E,00,00,00,00,
                        3F,3F,1E,1E,0E,0E,0E,0E,06,06,02,02,00,00,00,00,00,22,00,0C,00,04,00,00,00,02,00,00,00,00,00,00,
                        80,E0,80,C0,80,C0,80,80,00,00,00,00,00,00,00,00,00,20,00,40,00,40,00,00,00,00,00,00,00,00,00,00,
                        00,00,07,07,FC,FF,9E,FF,BF,FF,CF,FF,F6,FE,B8,FC,00,00,00,03,00,6F,00,47,00,73,00,68,00,64,00,7C,
                        80,80,00,00,00,00,20,E0,00,E0,20,E0,E0,E0,80,80,00,00,00,00,00,00,00,C0,00,A0,00,E0,00,80,00,00,
                        FF,FF,3F,FF,0F,FF,1E,FF,FF,FF,FF,FF,3F,3F,7F,7F,00,0F,00,F4,40,10,00,F9,00,E1,00,00,00,00,00,31,
                        FF,FF,FF,FF,FE,FE,78,F8,E0,E0,80,80,00,00,80,80,00,01,00,03,00,DA,00,B8,00,40,00,00,00,00,00,80,
}


;;; $BC80: Samus bottom tiles - set 1 - entry 14h ;;;
{
; 66h: Unused - frame 0
; 84h: Facing left  - wall jump - frame 0
; |--------|--------|--------|--------|--------|--------|
; |3BBB3BA2|2AB13FF9|  B333B3|32A     |        |3       |
; |BBAA3BB2|2B313F  |   3BB3 |3A      |     3BB|        |
; |BA2233BA|AB33    |    3B3 |3A      |3BB3BBAA|        |
; |BA62B333|33BBB   |    333 |3       |3A233BBA|AA3     |
; |3A22BA2B|3AAABB3B|     3B |        |3ABB33BB|A2A     |
; | BAAA3A3|A2622A3B|      3 |        |3BA2B333|AAB     |
; | 3BBAB33|BAAAAA3B|        |        |3BB32B3 |B33     |
; |  3BBA33|3BBBBB33|        |        |3ABBBA  |3       |
; |--------|--------|--------|--------|--------|--------|
; |3333BBBB|3333333B|
; |AABB3B33|333333BB|
; |262A3333|BB3BB3B |
; |AAABB33A|A3BBB   |
; |BBB3333B|3B3     |
; |33333333|3       |
; |  333333|        |
; | 3BB333B|B       |
; |--------|--------|
$9D:BC80             db FC,FF,CE,FF,8E,FF,8F,FF,89,FF,45,7F,77,7F,3B,3F,00,76,00,F6,00,C3,20,C8,00,4D,00,7A,00,3C,00,1C,
                        3F,EE,7C,EC,70,F0,F8,F8,8F,FF,03,FF,83,FF,FF,FF,06,67,04,44,00,C0,00,38,00,7D,20,85,00,FD,00,7C,
                        3F,3F,1E,1E,0E,0E,0E,0E,06,06,02,02,00,00,00,00,00,22,00,0C,00,04,00,00,00,02,00,00,00,00,00,00,
                        80,E0,80,C0,80,C0,80,80,00,00,00,00,00,00,00,00,00,20,00,40,00,40,00,00,00,00,00,00,00,00,00,00,
                        00,00,07,07,FC,FF,9E,FF,BF,FF,CF,FF,F6,FE,B8,FC,00,00,00,03,00,6F,00,47,00,73,00,68,00,64,00,7C,
                        80,80,00,00,00,00,20,E0,00,E0,20,E0,E0,E0,80,80,00,00,00,00,00,00,00,C0,00,A0,00,E0,00,80,00,00,
                        FF,FF,3F,FF,0F,FF,1E,FF,FF,FF,FF,FF,3F,3F,7F,7F,00,0F,00,F4,40,10,00,F9,00,E1,00,00,00,00,00,31,
                        FF,FF,FF,FF,FE,FE,78,F8,E0,E0,80,80,00,00,80,80,00,01,00,03,00,DA,00,B8,00,40,00,00,00,00,00,80,
}


;;; $BD80: Samus bottom tiles - set 1 - entry 15h ;;;
{
; 49h: Facing left  - moonwalk - frame 2
; 63h: Unused - frame 0
; |--------|--------|--------|--------|--------|
; |   BA262| 33BBB3 |     11C|C113    |        |
; |   BAA22|   33B33|     311|33B3    |3       |
; |    BAAA|   B333B|     313|BBAB3   |33      |
; |    BAAB|   BB33B|     B3B|A2AAB   |B3      |
; |     BAB|    B3BB|     33A|262AB   |B3      |
; |     BBB|    BBB3|     3B2|22AB3   |3       |
; |   B3BBB|   BBB33|     3BA|22BB3   |        |
; |   23333|   BB33 |    33BB|AAB3    |        |
; |--------|--------|--------|--------|--------|
; |   AB3BB|3 B333  |    3BA2|ABB     |
; |   32333|3 33    |    3BA2|2B3     |
; |  33AAB3|BB      |    3BA2|AB      |
; | 3AA3BB3|BB      |   A3BBB|B3      |
; |AABBB333|33      |   AA3BB|3333    |
; |33333   |        |   B3333|33BB3   |
; |        |        |   3BAB3|33BBB3  |
; |        |        |   3A22B|33BBB3  |
; |--------|--------|--------|--------|
$9D:BD80             db 10,1F,10,1F,08,0F,09,0F,05,07,07,07,1F,1F,0F,1F,02,18,00,1C,00,0F,00,0F,00,07,00,07,00,17,00,00,
                        7E,7E,1F,1F,1F,1F,1F,1F,0F,0F,0F,0F,1F,1F,1E,1E,00,1C,00,04,00,11,00,19,00,0B,00,0E,00,1C,00,18,
                        06,00,07,04,07,05,07,07,06,07,06,07,06,07,0F,0F,01,01,00,00,00,00,00,05,00,01,00,02,00,03,00,03,
                        70,10,F0,F0,D8,F8,08,F8,08,F8,18,F8,38,F8,30,F0,80,80,00,20,00,F0,00,B8,40,18,00,30,00,30,00,E0,
                        00,00,80,80,C0,C0,C0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,80,00,80,00,00,00,00,00,00,
                        0F,1F,17,1F,33,3F,4F,7F,3F,FF,F8,F8,00,00,00,00,00,1B,00,00,00,0E,00,36,00,F8,00,00,00,00,00,00,
                        BC,BC,B0,B0,C0,C0,C0,C0,C0,C0,00,00,00,00,00,00,00,20,00,00,00,C0,00,C0,00,00,00,00,00,00,00,00,
                        0C,0F,0C,0F,0C,0F,0F,1F,07,1F,1F,1F,1B,1F,11,1F,00,06,00,06,00,06,00,17,00,1B,00,10,00,0E,00,09,
                        60,E0,60,E0,40,C0,C0,C0,F0,F0,F8,F8,FC,FC,FC,FC,00,E0,00,40,00,C0,00,80,00,00,00,30,00,38,00,38,
}


;;; $BEA0: Samus bottom tiles - set 1 - entry 16h ;;;
{
; 49h: Facing left  - moonwalk - frame 5
; 64h: Unused - frame 0
; |--------|--------|--------|--------|--------|
; |   BB333|33BBBB3 |     11C|C113    |        |
; |   BB333|  333B33|     311|33B3    |3       |
; |    BBB3|   B333B|     313|BBAB3   |A3      |
; |    BBBB|   A233A|     B3B|A22AB   |B3      |
; |     BBB|    AABA|     33A|262AB   |B3      |
; |     BBB|    BAA3|     3B2|222B3   |3       |
; |   B3BBB|   BAAB3|    33BA|22AB    |        |
; |   A3333|   AB33 |    33BB|AAB3    |        |
; |--------|--------|--------|--------|--------|
; |   A33BB|3 B333  |    3BA2|ABB     |
; |   3A333|3 33    |   33BA2|2A3     |
; |  33AAB3|BB      |   33BA2|AB      |
; | 3AA3BB3|BB      |   B3BBB|B33     |
; |AABBB333|33      |   B33BB|3BBB    |
; |33333   |        |   33233|BA6AB   |
; |        |        |   B3A23|AAA2B3  |
; |        |        |   B33B3|BBAAAB3 |
; |--------|--------|--------|--------|
$9D:BEA0             db 1F,1F,1F,1F,0F,0F,0F,0F,07,07,07,07,1F,1F,0F,1F,00,18,00,18,00,0E,00,0F,00,07,00,07,00,17,00,10,
                        FE,FE,3F,3F,1F,1F,06,1F,02,0F,09,0F,13,1F,0E,1E,00,3C,00,04,00,11,00,11,00,0F,00,0E,00,1E,00,18,
                        06,00,07,04,07,05,07,07,06,07,06,07,0E,0F,0F,0F,01,01,00,00,00,00,00,05,00,01,00,02,00,03,00,03,
                        70,10,F0,F0,D8,F8,08,F8,08,F8,18,F8,10,F0,30,F0,80,80,00,20,00,F0,00,98,40,18,00,10,00,30,00,E0,
                        00,00,80,80,40,C0,C0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,80,00,80,00,80,00,00,00,00,00,00,
                        0F,1F,17,1F,33,3F,4F,7F,3F,FF,F8,F8,00,00,00,00,00,13,00,08,00,0E,00,36,00,F8,00,00,00,00,00,00,
                        BC,BC,B0,B0,C0,C0,C0,C0,C0,C0,00,00,00,00,00,00,00,20,00,00,00,C0,00,C0,00,00,00,00,00,00,00,00,
                        0C,0F,1C,1F,1C,1F,1F,1F,1F,1F,1B,1F,19,1F,1F,1F,00,06,00,06,00,06,00,17,00,13,00,00,00,14,00,12,
                        60,E0,20,E0,40,C0,E0,E0,F0,F0,88,F8,0C,FC,C6,FE,00,E0,00,40,00,C0,00,80,00,70,20,D8,00,E8,00,FC,
}


;;; $BFC0: Samus bottom tiles - set 1 - entry 17h ;;;
{
; 4Ah: Facing right - moonwalk - frame 2
; 75h: Facing left  - moonwalk - aiming up-left - frame 2
; 76h: Facing right - moonwalk - aiming up-right - frame 2
; 77h: Facing left  - moonwalk - aiming down-left - frame 2
; 78h: Facing right - moonwalk - aiming down-right - frame 2
; |--------|--------|--------|--------|--------|
; |   BA262| 33BBB3 |     11C|C113    |        |
; |   BAA22|   33B33|     311|33B3    |3       |
; |    BAAA|   B333B|     313|BBAB3   |33      |
; |    BAAB|   BB33B|     B3B|A2AAB   |B3      |
; |     BAB|    B3BB|     33A|262AB   |B3      |
; |     BBB|    BBB3|     3B2|22AB3   |3       |
; |   B3BBB|   BBB33|     3BA|22BB3   |        |
; |   23333|   BB33 |    33BB|AAB3    |        |
; |--------|--------|--------|--------|--------|
; |   AB3BB|3 B333  |    3BA2|ABB     |
; |   32333|3 33    |    3BA2|2B3     |
; |  33AAB3|BB      |    3BA2|AB      |
; | 3AA3BB3|BB      |   A3BBB|B3      |
; |AABBB333|33      |   AA3BB|3333    |
; |33333   |        |   B3333|33BB3   |
; |        |        |   3BAB3|33BBB3  |
; |        |        |   3A22B|33BBB3  |
; |--------|--------|--------|--------|
$9D:BFC0             db 10,1F,10,1F,08,0F,09,0F,05,07,07,07,1F,1F,0F,1F,02,18,00,1C,00,0F,00,0F,00,07,00,07,00,17,00,00,
                        7E,7E,1F,1F,1F,1F,1F,1F,0F,0F,0F,0F,1F,1F,1E,1E,00,1C,00,04,00,11,00,19,00,0B,00,0E,00,1C,00,18,
                        06,00,07,04,07,05,07,07,06,07,06,07,06,07,0F,0F,01,01,00,00,00,00,00,05,00,01,00,02,00,03,00,03,
                        70,10,F0,F0,D8,F8,08,F8,08,F8,18,F8,38,F8,30,F0,80,80,00,20,00,F0,00,B8,40,18,00,30,00,30,00,E0,
                        00,00,80,80,C0,C0,C0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,00,00,80,00,80,00,00,00,00,00,00,
                        0F,1F,17,1F,33,3F,4F,7F,3F,FF,F8,F8,00,00,00,00,00,1B,00,00,00,0E,00,36,00,F8,00,00,00,00,00,00,
                        BC,BC,B0,B0,C0,C0,C0,C0,C0,C0,00,00,00,00,00,00,00,20,00,00,00,C0,00,C0,00,00,00,00,00,00,00,00,
                        0C,0F,0C,0F,0C,0F,0F,1F,07,1F,1F,1F,1B,1F,11,1F,00,06,00,06,00,06,00,17,00,1B,00,10,00,0E,00,09,
                        60,E0,60,E0,40,C0,C0,C0,F0,F0,F8,F8,FC,FC,FC,FC,00,E0,00,40,00,C0,00,80,00,00,00,30,00,38,00,38,
}


;;; $C0E0: Samus bottom tiles - set 1 - entry 18h ;;;
{
; 4Ah: Facing right - moonwalk - frame 5
; 75h: Facing left  - moonwalk - aiming up-left - frame 5
; 76h: Facing right - moonwalk - aiming up-right - frame 5
; 77h: Facing left  - moonwalk - aiming down-left - frame 5
; 78h: Facing right - moonwalk - aiming down-right - frame 5
; |--------|--------|--------|--------|--------|
; |   BB333|33BBBB3 |     11C|C113    |        |
; |   BB333|  333B33|     311|33B3    |3       |
; |    BBB3|   B333B|     313|BBAB3   |A3      |
; |    BBBB|   A233A|     B3B|A22AB   |B3      |
; |     BBB|    AABA|     33A|262AB   |B3      |
; |     BBB|    BAA3|     3B2|222B3   |3       |
; |   B3BBB|   BAAB3|    33BA|22AB    |        |
; |   A3333|   AB33 |    33BB|AAB3    |        |
; |--------|--------|--------|--------|--------|
; |   A33BB|3 B333  |    3BA2|ABB     |
; |   3A333|3 33    |   33BA2|2A3     |
; |  33AAB3|BB      |   33BA2|AB      |
; | 3AA3BB3|BB      |   B3BBB|B33     |
; |AABBB333|33      |   B33BB|3BBB    |
; |33333   |        |   33233|BA6AB   |
; |        |        |   B3A23|AAA2B3  |
; |        |        |   B33B3|BBAAAB3 |
; |--------|--------|--------|--------|
$9D:C0E0             db 1F,1F,1F,1F,0F,0F,0F,0F,07,07,07,07,1F,1F,0F,1F,00,18,00,18,00,0E,00,0F,00,07,00,07,00,17,00,10,
                        FE,FE,3F,3F,1F,1F,06,1F,02,0F,09,0F,13,1F,0E,1E,00,3C,00,04,00,11,00,11,00,0F,00,0E,00,1E,00,18,
                        06,00,07,04,07,05,07,07,06,07,06,07,0E,0F,0F,0F,01,01,00,00,00,00,00,05,00,01,00,02,00,03,00,03,
                        70,10,F0,F0,D8,F8,08,F8,08,F8,18,F8,10,F0,30,F0,80,80,00,20,00,F0,00,98,40,18,00,10,00,30,00,E0,
                        00,00,80,80,40,C0,C0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,00,80,00,80,00,80,00,00,00,00,00,00,
                        0F,1F,17,1F,33,3F,4F,7F,3F,FF,F8,F8,00,00,00,00,00,13,00,08,00,0E,00,36,00,F8,00,00,00,00,00,00,
                        BC,BC,B0,B0,C0,C0,C0,C0,C0,C0,00,00,00,00,00,00,00,20,00,00,00,C0,00,C0,00,00,00,00,00,00,00,00,
                        0C,0F,1C,1F,1C,1F,1F,1F,1F,1F,1B,1F,19,1F,1F,1F,00,06,00,06,00,06,00,17,00,13,00,00,00,14,00,12,
                        60,E0,20,E0,40,C0,E0,E0,F0,F0,88,F8,0C,FC,C6,FE,00,E0,00,40,00,C0,00,80,00,70,20,D8,00,E8,00,FC,
}


;;; $C200: Samus bottom tiles - set 1 - entry 19h ;;;
{
; 13h: Facing right - normal jump - not aiming - not moving - gun extended - frame 1
; 19h: Facing right - spin jump - frame 0
; 1Bh: Facing right - space jump - frame 0
; 29h: Facing right - falling - frame 6
; 2Bh: Facing right - falling - aiming up - frame 2
; 50h: Facing right - damage boost - frame 9
; 51h: Facing right - normal jump - not aiming - moving forward - frame 1
; 67h: Facing right - falling - gun extended - frame 6
; 6Bh: Facing right - normal jump - aiming down-right - frame 1
; 6Dh: Facing right - falling - aiming up-right - frame 2
; 6Fh: Facing right - falling - aiming down-right - frame 2
; 81h: Facing right - screw attack - frame 0
; 83h: Facing right - wall jump - frame 1
; A6h: Facing right - landing from spin jump - frame 0
; ACh: Unused. Facing right - grappling - in air - frame 1
; B0h: Unused. Facing right - grappling - in air - aiming down-right - frame 1
; F0h: Facing right - grabbed by Draygon - moving - frame 2
; |--------|--------|--------|--------|--------|--------|--------|
; |     3BB|B3BAAB3 |        | BB313BB|  A23   |        |B3      |
; |      32|AB33BB33|     BAA|ABB33BA2|  BA3   |        |2A3     |
; |       3|ABA262AB|   33BBB|BB33BA22|   A3   |B3AAB3  |62B     |
; |       3|3BAA222A|   A3333|3333BA22|   B3   |B32AB3  |22B     |
; |     ABB|33BBBBBB|   A3311|113BABA2|        |3BBAB3  |2AB     |
; |      AB|B3333333|   B3B31|13BA22AB|        |B2BB3   |AB3     |
; |      33|33BB3  B|   33BB3|3BA222AB|        |23BA3   |B3      |
; |       A|B3BB3  A|    3BA3|3BA22AB3|        |B3223   |3       |
; |--------|--------|--------|--------|--------|--------|--------|
; |      3B|B333    |     3BB|B3BAAB3 |
; |      AB|33      |      32|AB33BB33|
; |    BA33|        |       3|ABA262AB|
; |    33  |        |       3|3BAA222A|
; |        |        |     ABB|33BBBBBB|
; |        |        |      AB|B3333333|
; |        |        |      33|33BB3  B|
; |        |        |       A|B3BB3  A|
; |--------|--------|--------|--------|
$9D:C200             db 07,07,02,03,01,01,01,01,03,07,01,03,03,03,00,01,00,03,00,00,00,00,00,00,00,07,00,03,00,00,00,01,
                        E6,FE,7F,FF,41,FF,C0,FF,FF,FF,FF,FF,F9,F9,F8,F9,00,BC,00,CC,08,E3,00,71,00,3F,00,80,00,31,00,B1,
                        00,00,04,07,1F,1F,0F,1F,0F,1C,1F,1E,1F,1F,0D,0F,00,00,00,07,00,07,00,10,00,10,00,14,00,06,00,06,
                        7F,77,7C,FF,F8,FF,F8,FF,F4,3F,E1,7F,C1,FF,C3,FF,00,63,00,E6,00,CC,00,0C,00,1E,00,33,00,63,00,66,
                        08,38,28,38,08,18,18,18,00,00,00,00,00,00,00,00,00,20,00,30,00,10,00,10,00,00,00,00,00,00,00,00,
                        00,00,00,00,CC,FC,CC,FC,EC,FC,B8,F8,68,F8,C8,F8,00,00,00,00,00,B8,00,98,00,78,00,B0,00,30,00,80,
                        C0,C0,20,E0,20,E0,20,E0,20,E0,60,E0,C0,C0,80,80,00,80,00,40,80,20,00,20,00,60,00,C0,00,80,00,00,
                        03,03,01,03,0B,0F,0C,0C,00,00,00,00,00,00,00,00,00,01,00,03,00,0C,00,00,00,00,00,00,00,00,00,00,
                        F0,F0,C0,C0,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        07,07,02,03,01,01,01,01,03,07,01,03,03,03,00,01,00,03,00,00,00,00,00,00,00,07,00,03,00,00,00,01,
                        E6,FE,7F,FF,41,FF,C0,FF,FF,FF,FF,FF,F9,F9,F8,F9,00,BC,00,CC,08,E3,00,71,00,3F,00,80,00,31,00,B1,
}


;;; $C360: Samus bottom tiles - set 1 - entry 1Ah ;;;
{
; 14h: Facing left  - normal jump - not aiming - not moving - gun extended - frame 1
; 1Ah: Facing left  - spin jump - frame 0
; 1Ch: Facing left  - space jump - frame 0
; 2Ah: Facing left  - falling - frame 6
; 2Ch: Facing left  - falling - aiming up - frame 2
; 4Fh: Facing left  - damage boost - frame 9
; 52h: Facing left  - normal jump - not aiming - moving forward - frame 1
; 68h: Facing left  - falling - gun extended - frame 6
; 6Ch: Facing left  - normal jump - aiming down-left - frame 1
; 6Eh: Facing left  - falling - aiming up-left - frame 2
; 70h: Facing left  - falling - aiming down-left - frame 2
; 82h: Facing left  - screw attack - frame 0
; 84h: Facing left  - wall jump - frame 1
; A7h: Facing left  - landing from spin jump - frame 0
; ADh: Unused. Facing left  - grappling - in air - frame 1
; B1h: Unused. Facing left  - grappling - in air - aiming down-left - frame 1
; BEh: Facing left  - grabbed by Draygon - moving - frame 2
; E9h: Facing left  - Samus drained - crouching/falling - frames Eh / 13h / 17h
; |--------|--------|--------|--------|--------|--------|--------|
; |     3BB|B3BAAB3 |        | BB313BB|  A23   |        |B3      |
; |      32|AB33BB33|     BAA|ABB33BA2|  BA3   |        |2A3     |
; |       3|ABA262AB|   33BBB|BB33BA22|   A3   |B3AAB3  |62B     |
; |       3|3BAA222A|   A3333|3333BA22|   B3   |B32AB3  |22B     |
; |     ABB|33BBBBBB|   A3311|113BABA2|        |3BBAB3  |2AB     |
; |      AB|B3333333|   B3B31|13BA22AB|        |B2BB3   |AB3     |
; |      33|33BB3  B|   33BB3|3BA222AB|        |23BA3   |B3      |
; |       A|B3BB3  A|    3BA3|3BA22AB3|        |B3223   |3       |
; |--------|--------|--------|--------|--------|--------|--------|
; |      3B|B333    |     3BB|B3BAAB3 |
; |      AB|33      |      32|AB33BB33|
; |    BA33|        |       3|ABA262AB|
; |    33  |        |       3|3BAA222A|
; |        |        |     ABB|33BBBBBB|
; |        |        |      AB|B3333333|
; |        |        |      33|33BB3  B|
; |        |        |       A|B3BB3  A|
; |--------|--------|--------|--------|
$9D:C360             db 07,07,02,03,01,01,01,01,03,07,01,03,03,03,00,01,00,03,00,00,00,00,00,00,00,07,00,03,00,00,00,01,
                        E6,FE,7F,FF,41,FF,C0,FF,FF,FF,FF,FF,F9,F9,F8,F9,00,BC,00,CC,08,E3,00,71,00,3F,00,80,00,31,00,B1,
                        00,00,04,07,1F,1F,0F,1F,0F,1C,1F,1E,1F,1F,0D,0F,00,00,00,07,00,07,00,10,00,10,00,14,00,06,00,06,
                        7F,77,7C,FF,F8,FF,F8,FF,F4,3F,E1,7F,C1,FF,C3,FF,00,63,00,E6,00,CC,00,0C,00,1E,00,33,00,63,00,66,
                        08,38,28,38,08,18,18,18,00,00,00,00,00,00,00,00,00,20,00,30,00,10,00,10,00,00,00,00,00,00,00,00,
                        00,00,00,00,CC,FC,CC,FC,EC,FC,B8,F8,68,F8,C8,F8,00,00,00,00,00,B8,00,98,00,78,00,B0,00,30,00,80,
                        C0,C0,20,E0,20,E0,20,E0,20,E0,60,E0,C0,C0,80,80,00,80,00,40,80,20,00,20,00,60,00,C0,00,80,00,00,
                        03,03,01,03,0B,0F,0C,0C,00,00,00,00,00,00,00,00,00,01,00,03,00,0C,00,00,00,00,00,00,00,00,00,00,
                        F0,F0,C0,C0,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        07,07,02,03,01,01,01,01,03,07,01,03,03,03,00,01,00,03,00,00,00,00,00,00,00,07,00,03,00,00,00,01,
                        E6,FE,7F,FF,41,FF,C0,FF,FF,FF,FF,FF,F9,F9,F8,F9,00,BC,00,CC,08,E3,00,71,00,3F,00,80,00,31,00,B1,
}


;;; $C4C0: Samus bottom tiles - set 1 - entry 1Bh ;;;
{
; 53h: Facing right - knockback - frame 1
; D7h: Facing right - crystal flash ending - frame 5
; ECh: Facing right - grabbed by Draygon - not moving - not aiming - frame 0
; EDh: Facing right - grabbed by Draygon - not moving - aiming up-right - frame 0
; EEh: Facing right - grabbed by Draygon - firing - frame 0
; EFh: Facing right - grabbed by Draygon - not moving - aiming down-right - frame 0
; F0h: Facing right - grabbed by Draygon - moving - frame 1
; |--------|--------|--------|--------|--------|--------|
; |   3BBBB|3 BA22AB|       B|33C13333|BABABAB3|3       |
; |    3BBB|3 3A22A3| 3BA222A|2B13BBBB| B33BA33|3       |
; |     3BB|3 3BAAB3| A3BBBAB|AB3BA2AB| 3AABB3 |3       |
; |    A33B|B33BBB3 | AB31CBB|B3BA222A| 3AAB3  |33      |
; |    BB33|B3A3333 | B33311C|C3BA262A| 2AB3   |B3      |
; |     BB3|332ABB3 | 3333331|13BA222A|BAA3    |B3      |
; |     33B|33ABAAB3| 3BBBB33|33BBA2AB|AA3     |33B3    |
; |     233|333B22AB|  33BBB3|33BABBBB|333     |3BB3    |
; |--------|--------|--------|--------|--------|--------|
; |    AABB|B33BA26B|   3BBBB|3 BA22AB|
; |   ABBB3|3  3BA2A|    3BBB|3 3A22A3|
; |  BBB33 |    3BAA|     3BB|3 3BAAB3|
; |  333   |     3BA|    A33B|B33BBB3 |
; |        |      BB|    BB33|B3A3333 |
; |        |      3B|     BB3|332ABB3 |
; |        |    A333|     33B|33ABAAB3|
; |        |    BABB|     233|333B22AB|
; |--------|--------|--------|--------|
$9D:C4C0             db 1F,1F,0F,0F,07,07,07,0F,0F,0F,07,07,07,07,03,07,00,0F,00,07,00,03,00,09,00,0C,00,06,00,01,00,00,
                        A1,BF,A1,BF,B3,BF,FE,FE,DE,FE,CE,FE,D3,FF,F1,FF,00,33,00,12,00,1E,00,9C,00,A0,00,1C,00,3E,00,13,
                        01,01,60,7F,3D,7F,3B,73,7E,78,7F,7E,7F,7F,3F,3F,00,01,00,31,00,5F,04,67,01,41,00,00,00,3C,00,0E,
                        DF,CF,7F,DF,71,FF,E0,FF,60,7F,E0,7F,F1,FF,EF,FF,20,20,00,4F,00,DB,00,B1,84,B1,00,31,00,3B,00,3F,
                        AB,FF,7B,7F,4E,7E,4C,7C,18,78,90,F0,20,E0,E0,E0,00,FE,00,4C,00,3C,00,38,00,30,00,E0,00,C0,00,00,
                        80,80,80,80,80,80,C0,C0,C0,C0,C0,C0,F0,F0,F0,F0,00,00,00,00,00,00,00,00,00,80,00,80,00,20,00,60,
                        03,0F,0F,1F,3E,3E,38,38,00,00,00,00,00,00,00,00,00,0F,00,1E,00,38,00,00,00,00,00,00,00,00,00,00,
                        F1,FF,98,9F,0C,0F,06,07,03,03,03,03,07,0F,0B,0F,02,99,00,0D,00,07,00,03,00,03,00,01,00,08,00,0F,
                        1F,1F,0F,0F,07,07,07,0F,0F,0F,07,07,07,07,03,07,00,0F,00,07,00,03,00,09,00,0C,00,06,00,01,00,00,
                        A1,BF,A1,BF,B3,BF,FE,FE,DE,FE,CE,FE,D3,FF,F1,FF,00,33,00,12,00,1E,00,9C,00,A0,00,1C,00,3E,00,13,
}


;;; $C600: Samus bottom tiles - set 1 - entry 1Ch ;;;
{
; 54h: Facing left  - knockback - frame 1
; BAh: Facing left  - grabbed by Draygon - not moving - not aiming - frame 0
; BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left - frame 0
; BCh: Facing left  - grabbed by Draygon - firing - frame 0
; BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left - frame 0
; BEh: Facing left  - grabbed by Draygon - moving - frame 1
; D8h: Facing left  - crystal flash ending - frame 5
; |--------|--------|--------|--------|--------|--------|
; |   3BBBB|3 BA22AB|       B|33C13333|BABABAB3|3       |
; |    3BBB|3 3A22A3| 3BA222A|2B13BBBB| B33BA33|3       |
; |     3BB|3 3BAAB3| A3BBBAB|AB3BA2AB| 3AABB3 |3       |
; |    A33B|B33BBB3 | AB31CBB|B3BA222A| 3AAB3  |33      |
; |    BB33|B3A3333 | B33311C|C3BA262A| 2AB3   |B3      |
; |     BB3|332ABB3 | 3333331|13BA222A|BAA3    |B3      |
; |     33B|33ABAAB3| 3BBBB33|33BBA2AB|AA3     |33B3    |
; |     233|333B22AB|  33BBB3|33BABBBB|333     |3BB3    |
; |--------|--------|--------|--------|--------|--------|
; |    AABB|B33BA26B|   3BBBB|3 BA22AB|
; |   ABBB3|3  3BA2A|    3BBB|3 3A22A3|
; |  BBB33 |    3BAA|     3BB|3 3BAAB3|
; |  333   |     3BA|    A33B|B33BBB3 |
; |        |      BB|    BB33|B3A3333 |
; |        |      3B|     BB3|332ABB3 |
; |        |    A333|     33B|33ABAAB3|
; |        |    BABB|     233|333B22AB|
; |--------|--------|--------|--------|
$9D:C600             db 1F,1F,0F,0F,07,07,07,0F,0F,0F,07,07,07,07,03,07,00,0F,00,07,00,03,00,09,00,0C,00,06,00,01,00,00,
                        A1,BF,A1,BF,B3,BF,FE,FE,DE,FE,CE,FE,D3,FF,F1,FF,00,33,00,12,00,1E,00,9C,00,A0,00,1C,00,3E,00,13,
                        01,01,60,7F,3D,7F,3B,73,7E,78,7F,7E,7F,7F,3F,3F,00,01,00,31,00,5F,04,67,01,41,00,00,00,3C,00,0E,
                        DF,CF,7F,DF,71,FF,E0,FF,60,7F,E0,7F,F1,FF,EF,FF,20,20,00,4F,00,DB,00,B1,84,B1,00,31,00,3B,00,3F,
                        AB,FF,7B,7F,4E,7E,4C,7C,18,78,90,F0,20,E0,E0,E0,00,FE,00,4C,00,3C,00,38,00,30,00,E0,00,C0,00,00,
                        80,80,80,80,80,80,C0,C0,C0,C0,C0,C0,F0,F0,F0,F0,00,00,00,00,00,00,00,00,00,80,00,80,00,20,00,60,
                        03,0F,0F,1F,3E,3E,38,38,00,00,00,00,00,00,00,00,00,0F,00,1E,00,38,00,00,00,00,00,00,00,00,00,00,
                        F1,FF,98,9F,0C,0F,06,07,03,03,03,03,07,0F,0B,0F,02,99,00,0D,00,07,00,03,00,03,00,01,00,08,00,0F,
                        1F,1F,0F,0F,07,07,07,0F,0F,0F,07,07,07,07,03,07,00,0F,00,07,00,03,00,09,00,0C,00,06,00,01,00,00,
                        A1,BF,A1,BF,B3,BF,FE,FE,DE,FE,CE,FE,D3,FF,F1,FF,00,33,00,12,00,1E,00,9C,00,A0,00,1C,00,3E,00,13,
}


;;; $C740: Samus bottom tiles - set 1 - entry 1Dh ;;;
{
; Unused
; |--------|--------|--------|--------|
; |    3B3B|A2A3    |       3|3BBBB3  |
; |   33333|BAA3    |      3B|3BAAAB3 |
; |   BA333|3BAB    |     3B3|BA222AB |
; |    BB3B|3BBB3   |    3BB3|B2262AB |
; |   B333B|33B33   |   3BA3B|BA222B3 |
; |  BAAB33|33333B  |  3BA33A|AAA2AB3 |
; | BBB333 |B2B3BA3 | 33BB3BA|22BAB3  |
; | 333    | BABA2A3|3B3B3BA2|22AB3   |
; |--------|--------|--------|--------|
; |        | 333BAB3|3B333BAA|2AB3    |
; |        |  BB3B3 |333333BA|AB3     |
; |        | A2AB3  | 3BBAB3B|B3      |
; |       3|AAB33   | 33B2AB3|3       |
; |       3|333     |  3BABB3|B3      |
; |        |        |   B3BA2|AB3     |
; |        |        |   3B3BA|26B3    |
; |        |        |    B3BA|22A3    |
; |--------|--------|--------|--------|
$9D:C740             db 0F,0F,1F,1F,17,1F,0F,0F,1F,1F,27,3F,7E,7E,70,70,00,05,00,00,00,18,00,0D,00,11,00,3C,00,70,00,00,
                        10,F0,90,F0,D0,F0,F8,F8,F8,F8,FC,FC,BA,FE,51,7F,00,A0,00,E0,00,70,00,70,00,20,00,04,00,AC,00,7A,
                        01,01,03,03,07,07,0F,0F,1B,1F,36,3F,7E,7F,FC,FF,00,00,00,01,00,02,00,06,00,0D,00,19,00,1B,00,56,
                        FC,FC,C6,FE,82,FE,82,FE,86,FE,06,FE,2C,FC,18,F8,00,78,00,7C,00,C6,10,86,00,C4,00,EC,00,38,00,30,
                        00,00,00,00,00,00,01,01,01,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        7B,7F,3E,3E,0C,7C,38,F8,E0,E0,00,00,00,00,00,00,00,0E,00,34,00,58,00,E0,00,00,00,00,00,00,00,00,
                        FC,FF,FE,FF,77,7F,73,7F,37,3F,1C,1F,1E,1F,0E,0F,00,47,00,03,00,3D,00,16,00,1E,00,16,00,0B,00,0B,
                        30,F0,60,E0,C0,C0,80,80,C0,C0,60,E0,30,F0,10,F0,00,60,00,C0,00,80,00,00,00,80,00,C0,40,20,00,20,
}


;;; $C840: Samus bottom tiles - set 1 - entry 1Eh ;;;
{
; E9h: Facing left  - Samus drained - crouching/falling - frames 8..Bh / 1Ah / 1Dh
; EBh: Facing left  - Samus drained - standing - frames 0..3
; |--------|--------|--------|
; |  3BAAAB|2AB31113|   3333 |
; | A3BBBBB|BB313B33| 333BB3 |
; | B3111BB|BB33BAAB|3BB33A33|
; | 3B33111|113BA22A|2AB33333|
; |  BBB331|133B2622|2B3332A3|
; |  3ABB33|33BA222A|B33BAAA3|
; |   BABB3| 3BAA2AB|3BAAAB33|
; |   3BBB3| BA2ABBB| 333333 |
; |--------|--------|--------|
; |   3BBB3| B222AB3|
; |   B3B33|3AA2AB3 |
; |   AB333|3BAAB333|
; |    AABB|33B333BA|
; |   B3B33|3333BAA2|
; |  BAB33B|3A2BBBAA|
; |BA2AAB3B|33BB3333|
; |33333333|3333    |
; |--------|--------|
$9D:C840             db 31,3F,3F,7F,7F,63,7F,78,3F,3E,2F,3F,17,1F,1F,1F,00,1F,00,5F,00,43,00,20,00,38,00,1C,00,1E,00,0E,
                        3F,F1,FF,EF,F9,FF,F0,3F,F0,7F,E0,FF,61,7F,47,7F,00,60,00,C4,00,CF,00,19,04,10,00,31,00,3B,00,6F,
                        1E,1E,7E,7E,FB,FF,3F,FF,79,FF,F1,FF,C7,FF,7E,7E,00,00,00,0C,00,64,00,60,00,42,00,9E,00,7C,00,00,
                        1F,1F,1F,1F,0F,1F,03,0F,1F,1F,2F,3F,87,FF,FF,FF,00,0E,00,14,00,18,00,0F,00,14,00,39,00,DD,00,00,
                        43,7F,86,FE,CF,FF,FE,FF,F8,FF,9C,FF,FF,FF,F0,F0,00,46,00,6C,00,78,00,23,00,0E,00,5F,00,30,00,00,
}


;;; $C8E0: Samus bottom tiles - set 1 - entry 1Fh ;;;
{
; E8h: Facing right - Samus drained - crouching/falling - frames 8..Bh
; EAh: Facing right - Samus drained - standing - frames 0..3
; |--------|--------|--------|
; |  3BAAAB|2AB31113|   3333 |
; | A3BBBBB|BB313B33| 333BB3 |
; | B3111BB|BB33BAAB|3BB33A33|
; | 3B33111|113BA22A|2AB33333|
; |  BBB331|133B2622|2B3332A3|
; |  3ABB33|33BA222A|B33BAAA3|
; |   BABB3| 3BAA2AB|3BAAAB33|
; |   3BBB3| BA2ABBB| 333333 |
; |--------|--------|--------|
; |   3BBB3| B222AB3|
; |   B3B33|3AA2AB3 |
; |   AB333|3BAAB333|
; |    AABB|33B333BA|
; |   B3B33|3333BAA2|
; |  BAB33B|3A2BBBAA|
; |BA2AAB3B|33BB3333|
; |33333333|3333    |
; |--------|--------|
$9D:C8E0             db 31,3F,3F,7F,7F,63,7F,78,3F,3E,2F,3F,17,1F,1F,1F,00,1F,00,5F,00,43,00,20,00,38,00,1C,00,1E,00,0E,
                        3F,F1,FF,EF,F9,FF,F0,3F,F0,7F,E0,FF,61,7F,47,7F,00,60,00,C4,00,CF,00,19,04,10,00,31,00,3B,00,6F,
                        1E,1E,7E,7E,FB,FF,3F,FF,79,FF,F1,FF,C7,FF,7E,7E,00,00,00,0C,00,64,00,60,00,42,00,9E,00,7C,00,00,
                        1F,1F,1F,1F,0F,1F,03,0F,1F,1F,2F,3F,87,FF,FF,FF,00,0E,00,14,00,18,00,0F,00,14,00,39,00,DD,00,00,
                        43,7F,86,FE,CF,FF,FE,FF,F8,FF,9C,FF,FF,FF,F0,F0,00,46,00,6C,00,78,00,23,00,0E,00,5F,00,30,00,00,
}
}


;;; $C980..E13F: Samus top tiles - set 5 (facing clockwise - grapple swinging - upside down) ;;;
{
;;; $C980: Samus top tiles - set 5 - entry 0 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 8 / 28h
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
$9D:C980             db 00,00,00,00,00,00,06,06,38,3F,70,7F,E8,FF,E7,FE,00,00,00,00,00,00,00,06,00,0F,04,38,00,7A,01,6E,
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


;;; $CAC0: Samus top tiles - set 5 - entry 1 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 7 / 27h
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
$9D:CAC0             db 00,00,00,00,00,00,00,00,06,06,19,1F,73,7F,E7,FF,00,00,00,00,00,00,00,00,00,04,00,06,01,1A,01,74,
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


;;; $CC00: Samus top tiles - set 5 - entry 2 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 6 / 26h
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
$9D:CC00             db 00,00,00,00,00,00,00,00,00,00,07,07,1F,1C,3F,20,00,00,00,00,00,00,00,00,00,00,00,00,03,03,1F,1C,
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


;;; $CD80: Samus top tiles - set 5 - entry 3 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 5 / 25h
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
$9D:CD80             db 00,00,00,00,00,00,00,00,06,06,19,1F,73,7F,E7,FF,00,00,00,00,00,00,00,00,00,04,00,06,01,1A,01,74,
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


;;; $CF00: Samus top tiles - set 5 - entry 4 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 4 / 24h
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
$9D:CF00             db 00,00,00,00,00,00,00,00,01,00,03,01,07,06,0F,0B,00,00,00,00,00,00,00,01,01,03,02,06,01,01,04,04,
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


;;; $D080: Samus top tiles - set 5 - entry 5 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 3 / 23h
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
$9D:D080             db 00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
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


;;; $D200: Samus top tiles - set 5 - entry 6 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 2 / 22h
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
$9D:D200             db 00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
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


;;; $D380: Samus top tiles - set 5 - entry 7 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 1 / 21h
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
$9D:D380             db 01,01,03,03,06,07,0C,0F,18,1F,5C,77,16,77,8B,F3,00,00,00,01,00,03,00,02,01,06,18,62,00,5B,08,C5,
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


;;; $D4C0: Samus top tiles - set 5 - entry 8 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 0 / 20h
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
$9D:D4C0             db 00,00,00,00,00,00,00,00,01,01,01,01,07,05,07,06,00,00,00,00,00,00,00,00,00,00,00,00,02,00,03,04,
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


;;; $D600: Samus top tiles - set 5 - entry 9 ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 1Fh / 3Fh
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
$9D:D600             db 00,00,01,01,01,01,01,01,01,01,01,01,01,01,03,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,
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


;;; $D740: Samus top tiles - set 5 - entry Ah ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 1Eh / 3Eh
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
$9D:D740             db 00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
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


;;; $D8C0: Samus top tiles - set 5 - entry Bh ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 1Dh / 3Dh
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
$9D:D8C0             db 00,00,00,00,02,02,03,02,07,01,06,06,07,01,0F,02,00,00,00,00,00,04,01,05,06,04,00,01,06,04,0F,08,
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


;;; $DA40: Samus top tiles - set 5 - entry Ch ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 1Ch / 3Ch
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
$9D:DA40             db 00,00,00,00,00,00,00,00,01,00,03,01,07,06,0F,0B,00,00,00,00,00,00,00,01,01,03,02,06,01,01,04,04,
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


;;; $DBC0: Samus top tiles - set 5 - entry Dh ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 1Bh / 3Bh
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
$9D:DBC0             db 00,00,00,00,00,00,00,00,01,00,03,01,07,06,0F,0B,00,00,00,00,00,00,00,01,01,03,02,06,01,01,04,04,
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


;;; $DD40: Samus top tiles - set 5 - entry Eh ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 1Ah / 3Ah
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
$9D:DD40             db 00,00,00,00,00,00,00,00,00,00,07,07,1F,1C,3F,20,00,00,00,00,00,00,00,00,00,00,00,00,03,03,1F,1C,
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


;;; $DEC0: Samus top tiles - set 5 - entry Fh ;;;
{
; B2h: Facing clockwise     - grapple swinging - frames 19h / 39h
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
$9D:DEC0             db 00,00,30,30,67,7F,7F,7F,67,7F,60,7F,60,7F,70,7F,00,00,00,00,00,30,00,0D,00,3F,00,33,04,39,00,1F,
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


;;; $E000: Samus top tiles - set 5 - entry 10h ;;;
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
$9D:E000             db 00,00,00,00,00,00,7C,7C,8F,FF,FF,FF,C1,FF,C1,FF,00,00,00,00,00,00,00,00,00,50,00,0E,00,7B,04,61,
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


;;; $E140..F77F: Samus top tiles - set 6 - part 1/2 (facing anticlockwise - grapple swinging - upside down) ;;;
{
;;; $E140: Samus top tiles - set 6 - entry 0 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 18h / 38h
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
$9D:E140             db 00,00,00,00,00,00,00,00,05,05,0F,0D,3F,3D,3D,3D,00,00,00,00,00,00,00,00,00,00,02,00,02,00,00,1A,
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


;;; $E300: Samus top tiles - set 6 - entry 1 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 19h / 39h
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
$9D:E300             db 00,00,00,00,00,00,00,00,05,05,0F,0D,3F,3D,3D,3D,00,00,00,00,00,00,00,00,00,00,02,00,02,00,00,1A,
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


;;; $E4C0: Samus top tiles - set 6 - entry 2 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 1Ah / 3Ah
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
$9D:E4C0             db 00,00,00,00,0E,0E,3F,3D,7F,7D,8D,FD,C5,FD,8F,FF,00,00,00,00,00,00,02,10,02,38,00,7A,00,CA,12,6C,
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


;;; $E6C0: Samus top tiles - set 6 - entry 3 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 1Bh / 3Bh
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
$9D:E6C0             db 00,00,00,00,0E,0E,3F,3D,7F,7D,8D,FD,C5,FD,8F,FF,00,00,00,00,00,00,02,10,02,38,00,7A,00,CA,12,6C,
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


;;; $E8C0: Samus top tiles - set 6 - entry 4 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 1Ch / 3Ch
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
$9D:E8C0             db 00,00,00,00,00,00,00,00,0E,0E,2F,3D,7F,7D,CF,FD,00,00,00,00,00,00,00,00,00,00,02,10,02,38,02,78,
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


;;; $EAA0: Samus top tiles - set 6 - entry 5 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 1Dh / 3Dh
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
$9D:EAA0             db 00,00,00,00,00,00,00,00,00,00,0F,0F,3D,3F,30,3F,00,00,00,00,00,00,00,00,00,00,00,00,00,0F,00,1F,
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


;;; $EC80: Samus top tiles - set 6 - entry 6 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 1Eh / 3Eh
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
$9D:EC80             db 00,00,00,00,00,00,00,00,00,00,0F,0F,3D,3F,30,3F,00,00,00,00,00,00,00,00,00,00,00,00,00,0F,00,1F,
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


;;; $EE60: Samus top tiles - set 6 - entry 7 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 1Fh / 3Fh
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
$9D:EE60             db 00,00,07,07,0E,0F,1C,1F,1A,1F,31,3F,31,3F,3B,3F,00,00,00,00,00,07,01,0C,00,1E,00,19,00,1B,00,1F,
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


;;; $F020: Samus top tiles - set 6 - entry 8 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 0 / 20h
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
$9D:F020             db 00,00,00,00,03,03,07,07,0E,0F,0D,0F,0D,0F,0F,0F,00,00,00,00,00,00,00,03,00,03,00,07,00,07,00,07,
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


;;; $F1E0: Samus top tiles - set 6 - entry 9 ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 1 / 21h
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
$9D:F1E0             db 00,00,00,00,00,00,00,00,01,01,03,03,06,07,06,07,00,00,00,00,00,00,00,00,00,00,00,01,00,03,00,03,
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


;;; $F3A0: Samus top tiles - set 6 - entry Ah ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 2 / 22h
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
$9D:F3A0             db 01,01,07,07,06,07,0E,0F,0D,0F,0F,0F,0E,08,0F,0E,00,00,00,01,00,03,00,07,00,07,00,07,06,05,01,00,
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


;;; $F580: Samus top tiles - set 6 - entry Bh ;;;
{
; B3h: Facing anticlockwise - grapple swinging - frames 3 / 23h
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
$9D:F580             db 00,00,01,01,03,03,03,03,07,07,05,05,06,06,CF,CF,00,00,00,00,00,01,00,01,00,03,00,02,00,01,00,00,
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
}


;;; $F780: Free space ;;;
{
$9D:F780             fillto $9E8000, $FF
}
