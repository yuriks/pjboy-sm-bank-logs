;;; $8000: Enemy sets ;;;
{
; Room $DA60, state $DA8C: Enemy set
; Room $DD58, state $DDA2: Enemy set
$B4:8000             dw FFFF

; Room $94FD, state $950A: Enemy set name
$B4:8002             db 53,46,31,5F,31,30,20 ; "SF1_10 "

; Room $94FD, state $950A: Enemy set
$B4:8009             dw D3BF,0001, D6FF,0002, D83F,0003, FFFF

$B4:8017             db 00

; Room $93AA, state $93B7: Enemy set name
$B4:8018             db 73,66,31,5F,30,34,20 ; "sf1_04 "

; Room $93AA, state $93B7: Enemy set
$B4:801F             dw E9BF,0001, D7BF,0001, FFFF

$B4:8029             db 00

; Room $990D, state $991A: Enemy set name
$B4:802A             db 73,66,32,5F,30,36,20 ; "sf2_06 "

; Room $990D, state $991A: Enemy set
$B4:8031             dw D63F,0001, DCFF,0002, FFFF

$B4:803B             db 00

; Room $9A44, state $9A70: Enemy set name
$B4:803C             db 53,46,32,5F,31,32,61 ; "SF2_12a"

; Room $9A44, state $9A70: Enemy set
$B4:8043             dw EA7F,0007, CEFF,0007, FFFF

$B4:804D             db 00

; Room $9A44, state $9A56: Enemy set name
$B4:804E             db 53,46,32,5F,31,32,20 ; "SF2_12 "

; Room $9A44, state $9A56: Enemy set
$B4:8055             dw EA7F,0007, CEFF,0007, FFFF

$B4:805F             db 00

; Room $92FD, state $932E: Enemy set name
$B4:8060             db 73,66,31,5F,30,32,41 ; "sf1_02A"

; Room $92FD, state $932E: Enemy set
$B4:8067             dw DCFF,0001, DB7F,0002, D47F,0003, FFFF

$B4:8075             db 00

; Room $9879, state $9890: Enemy set name
; Room $9879, state $98AA: Enemy set name
$B4:8076             db 73,66,32,5F,30,34,20 ; "sf2_04 "

; Room $9879, state $9890: Enemy set
; Room $9879, state $98AA: Enemy set
$B4:807D             dw D63F,0001, D0FF,0002, FFFF

$B4:8087             db 00

; Room $975C, state $9787: Enemy set name
$B4:8088             db 73,66,32,5F,30,31,41 ; "sf2_01A"

; Room $975C, state $9787: Enemy set
$B4:808F             dw F653,0001, F353,0002, FFFF

$B4:8099             db 00

; Room $92B3, state $92C5: Enemy set name
; Room $92B3, state $92DF: Enemy set name
$B4:809A             db 73,66,31,5F,30,31,20 ; "sf1_01 "

; Room $92B3, state $92C5: Enemy set
; Room $92B3, state $92DF: Enemy set
$B4:80A1             dw E7BF,0001, D63F,0002, FFFF

$B4:80AB             db 00

; Room $9804, state $981B: Enemy set name
; Room $9804, state $9835: Enemy set name
$B4:80AC             db 73,66,32,5F,30,33,20 ; "sf2_03 "

; Room $9804, state $981B: Enemy set
; Room $9804, state $9835: Enemy set
$B4:80B3             dw EEFF,0001, FFFF

$B4:80B9             db 00

; Room $99BD, state $99CA: Enemy set name
$B4:80BA             db 73,66,32,5F,31,30,20 ; "sf2_10 "

; Room $99BD, state $99CA: Enemy set
$B4:80C1             dw F693,0001, E87F,0002, FFFF

$B4:80CB             db 00

; Room $9938, state $9945: Enemy set name
$B4:80CC             db 73,66,32,5F,30,37,20 ; "sf2_07 "

; Room $9938, state $9945: Enemy set
$B4:80D3             dw FFFF

$B4:80D5             db 00

; Room $9A90, state $9AA2: Enemy set name
$B4:80D6             db 53,46,32,5F,31,33,20 ; "SF2_13 "

; Room $9A90, state $9AA2: Enemy set
$B4:80DD             dw E6BF,0001, FFFF

$B4:80E3             db 00

; Room $9994, state $99A1: Enemy set name
$B4:80E4             db 73,66,32,5F,30,39,20 ; "sf2_09 "

; Room $9994, state $99A1: Enemy set
$B4:80EB             dw EEFF,0001, FFFF

$B4:80F1             db 00

; Unused enemy set name
$B4:80F2             db 53,46,32,5F,31,34,20 ; "SF2_14 "

; Unused enemy set
$B4:80F9             dw EA7F,0001, FFFF

$B4:80FF             db 00

; Room $9A90, state $9ABC: Enemy set name
$B4:8100             db 53,46,32,5F,31,33,61 ; "SF2_13a"

; Room $9A90, state $9ABC: Enemy set
$B4:8107             dw FFFF

$B4:8109             db 00

; Room $96BA, state $9705: Enemy set name
$B4:810A             db 73,66,32,5F,30,30,20 ; "sf2_00 "

; Room $96BA, state $9705: Enemy set
$B4:8111             dw F613,0002, FFFF

$B4:8117             db 00

; Unused enemy set name
$B4:8118             db 73,66,31,5F,30,33,20 ; "sf1_03 "

; Unused enemy set
$B4:811F             dw FFFF

$B4:8121             db 00

; Room $93D5, state $93E2: Enemy set name
$B4:8122             db 53,46,31,5F,30,35,20 ; "SF1_05 "

; Room $93D5, state $93E2: Enemy set
$B4:8129             dw FFFF

$B4:812B             db 00

; Room $95A8, state $95B5: Enemy set name
$B4:812C             db 53,46,31,5F,31,33,20 ; "SF1_13 "

; Room $95A8, state $95B5: Enemy set
$B4:8133             dw EA7F,0001, FFFF

$B4:8139             db 00

; Room $95FF, state $960C: Enemy set name
$B4:813A             db 53,46,31,5F,31,35,20 ; "SF1_15 "

; Room $95FF, state $960C: Enemy set
$B4:8141             dw EA7F,0001, FFFF

$B4:8147             db 00

; Room $96BA, state $96D1: Enemy set name
$B4:8148             db 73,66,32,5F,30,30,20 ; "sf2_00 "

; Room $96BA, state $96D1: Enemy set
$B4:814F             dw D87F,0007, EA7F,0007, FFFF

$B4:8159             db 00

; Room $93FE, state $940B: Enemy set name
$B4:815A             db 53,46,31,5F,30,36,20 ; "SF1_06 "

; Room $93FE, state $940B: Enemy set
$B4:8161             dw D6FF,0001, F193,0002, D3FF,0003, D7FF,0007, FFFF

$B4:8173             db 00

; Unused enemy set name
$B4:8174             db 53,46,31,5F,32,30,20 ; "SF1_20 "

; Unused enemy set
$B4:817B             dw FFFF

$B4:817D             db 00

; Room $92FD, state $9314: Enemy set name
$B4:817E             db 73,66,31,5F,30,32,20 ; "sf1_02 "

; Room $92FD, state $9314: Enemy set
$B4:8185             dw D87F,0007, FFFF

$B4:818B             db 00

; Room $91F8, state $9213: Enemy set name
; Room $91F8, state $922D: Enemy set name
; Room $91F8, state $9247: Enemy set name
$B4:818C             db 73,66,31,5F,30,30,20 ; "sf1_00 "

; Room $91F8, state $9213: Enemy set
; Room $91F8, state $922D: Enemy set
; Room $91F8, state $9247: Enemy set
$B4:8193             dw D07F,0002, D0BF,0007, FFFF

$B4:819D             db 00

; Room $99F9, state $9A06: Enemy set name
$B4:819E             db 53,46,32,5F,31,31,20 ; "SF2_11 "

; Room $99F9, state $9A06: Enemy set
$B4:81A5             dw CEBF,0001, E7BF,0002, FFFF

$B4:81AF             db 00

; Unused enemy set name
$B4:81B0             db 53,46,31,5F,31,39,20 ; "SF1_19 "

; Unused enemy set
$B4:81B7             dw FFFF

$B4:81B9             db 00

; Room $968F, state $969C: Enemy set name
$B4:81BA             db 53,46,31,5F,31,38,20 ; "SF1_18 "

; Room $968F, state $969C: Enemy set
$B4:81C1             dw DC3F,0001, DCBF,0001, FFFF

$B4:81CB             db 00

; Room $96BA, state $96EB: Enemy set name
$B4:81CC             db 73,66,32,5F,30,30,41 ; "sf2_00A"

; Room $96BA, state $96EB: Enemy set
$B4:81D3             dw F353,0001, FFFF

$B4:81D9             db 00

; Room $9461, state $946E: Enemy set name
$B4:81DA             db 53,46,31,5F,30,37,20 ; "SF1_07 "

; Room $9461, state $946E: Enemy set
$B4:81E1             dw D63F,0001, D3BF,0007, FFFF

$B4:81EB             db 00

; Room $962A, state $9637: Enemy set name
$B4:81EC             db 53,46,31,5F,31,36,20 ; "SF1_16 "

; Room $962A, state $9637: Enemy set
$B4:81F3             dw FFFF

$B4:81F5             db 00

; Room $965B, state $9668: Enemy set name
$B4:81F6             db 53,46,31,5F,31,37,20 ; "SF1_17 "

; Room $965B, state $9668: Enemy set
$B4:81FD             dw E7BF,0001, F1D3,0002, FFFF

$B4:8207             db 00

; Room $975C, state $976D: Enemy set name
$B4:8208             db 73,66,32,5F,30,31,20 ; "sf2_01 "

; Room $975C, state $976D: Enemy set
$B4:820F             dw D87F,0007, EA7F,0007, FFFF

$B4:8219             db 00

; Room $957D, state $958A: Enemy set name
$B4:821A             db 53,46,31,5F,31,32,20 ; "SF1_12 "

; Room $957D, state $958A: Enemy set
$B4:8221             dw D77F,0007, CFBF,0007, FFFF

$B4:822B             db 00

; Room $95D4, state $95E1: Enemy set name
$B4:822C             db 53,46,31,5F,31,34,20 ; "SF1_14 "

; Room $95D4, state $95E1: Enemy set
$B4:8233             dw FFFF

$B4:8235             db 00

; Room $9552, state $955F: Enemy set name
$B4:8236             db 53,46,31,5F,31,31,20 ; "SF1_11 "

; Room $9552, state $955F: Enemy set
$B4:823D             dw E7FF,0001, FFFF

$B4:8243             db 00

; Room $97B5, state $97C6: Enemy set name
; Room $97B5, state $97E0: Enemy set name
$B4:8244             db 73,66,32,5F,30,32,20 ; "sf2_02 "

; Room $97B5, state $97C6: Enemy set
; Room $97B5, state $97E0: Enemy set
$B4:824B             dw FFFF

$B4:824D             db 00

; Room $94CC, state $94D9: Enemy set name
$B4:824E             db 53,46,31,5F,30,39,20 ; "SF1_09 "

; Room $94CC, state $94D9: Enemy set
$B4:8255             dw FFFF

$B4:8257             db 00

; Room $98E2, state $98EF: Enemy set name
$B4:8258             db 73,66,32,5F,30,35,20 ; "sf2_05 "

; Room $98E2, state $98EF: Enemy set
$B4:825F             dw D0FF,0001, D27F,0002, FFFF

$B4:8269             db 00

; Room $9969, state $9976: Enemy set name
$B4:826A             db 73,66,32,5F,30,38,20 ; "sf2_08 "

; Room $9969, state $9976: Enemy set
$B4:8271             dw E7FF,0002, DD3F,0003, FFFF

$B4:827B             db 00

; Room $91F8, state $9261: Enemy set name
$B4:827C             db 73,66,31,5F,30,30,20 ; "sf1_00 "

; Room $91F8, state $9261: Enemy set
$B4:8283             dw D07F,0002, D0BF,0007, FFFF

$B4:828D             db 00

; Room $92FD, state $9348: Enemy set name
$B4:828E             db 73,66,31,5F,30,32,20 ; "sf1_02 "

; Room $92FD, state $9348: Enemy set
$B4:8295             dw D87F,0007, FFFF

$B4:829B             db 00

; Room $9804, state $984F: Enemy set name
$B4:829C             db 73,66,32,5F,30,33,20 ; "sf2_03 "

; Room $9804, state $984F: Enemy set
$B4:82A3             dw F2D3,0001, F313,0007, FFFF

$B4:82AD             db 00

; Room $9879, state $98C4: Enemy set name
$B4:82AE             db 73,66,32,5F,30,34,20 ; "sf2_04 "

; Room $9879, state $98C4: Enemy set
$B4:82B5             dw FFFF

$B4:82B7             db 00

; Room $948C, state $9499: Enemy set name
$B4:82B8             db 53,46,31,5F,30,38,20 ; "SF1_08 "

; Room $948C, state $9499: Enemy set
$B4:82BF             dw EABF,0001, D77F,0002, D7BF,0002, FFFF

$B4:82CD             db 00

; Room $9B9D, state $9BAA: Enemy set name
$B4:82CE             db 62,6C,31,5F,30,32,20 ; "bl1_02 "

; Room $9B9D, state $9BAA: Enemy set
$B4:82D5             dw D93F,0001, DC7F,0002, FFFF

$B4:82DF             db 00

; Room $9C35, state $9C42: Enemy set name
$B4:82E0             db 62,6C,31,5F,30,35,20 ; "bl1_05 "

; Room $9C35, state $9C42: Enemy set
$B4:82E7             dw FFFF

$B4:82E9             db 00

; Room $9C89, state $9C96: Enemy set name
$B4:82EA             db 62,6C,31,5F,30,37,20 ; "bl1_07 "

; Room $9C89, state $9C96: Enemy set
$B4:82F1             dw FFFF

$B4:82F3             db 00

; Room $9D9C, state $9DA9: Enemy set name
$B4:82F4             db 42,4C,31,5F,31,30,20 ; "BL1_10 "

; Room $9D9C, state $9DA9: Enemy set
$B4:82FB             dw EABF,0007, FFFF

$B4:8301             db 00

; Room $A051, state $A05E: Enemy set name
$B4:8302             db 42,4C,31,5F,32,30,20 ; "BL1_20 "

; Room $A051, state $A05E: Enemy set
$B4:8309             dw FFFF

$B4:830B             db 00

; Room $A07B, state $A088: Enemy set name
$B4:830C             db 42,4C,31,5F,32,31,20 ; "BL1_21 "

; Room $A07B, state $A088: Enemy set
$B4:8313             dw EA7F,0001, FFFF

$B4:8319             db 00

; Room $A0A4, state $A0B1: Enemy set name
$B4:831A             db 42,4C,31,5F,32,32,20 ; "BL1_22 "

; Room $A0A4, state $A0B1: Enemy set
$B4:8321             dw F193,0001, DC7F,0002, FFFF

$B4:832B             db 00

; Room $A66A, state $A677: Enemy set name
$B4:832C             db 42,4C,32,5F,31,39,20 ; "BL2_19 "

; Room $A66A, state $A677: Enemy set
$B4:8333             dw EFFF,0001, F03F,D003, FFFF

$B4:833D             db 00

; Room $A15B, state $A168: Enemy set name
$B4:833E             db 42,4C,31,5F,32,36,20 ; "BL1_26 "

; Room $A15B, state $A168: Enemy set
$B4:8345             dw FFFF

$B4:8347             db 00

; Room $A37C, state $A389: Enemy set name
$B4:8348             db 42,4C,32,5F,30,35,20 ; "BL2_05 "

; Room $A37C, state $A389: Enemy set
$B4:834F             dw E7BF,0001, D9BF,0002, FFFF

$B4:8359             db 00

; Room $A0D2, state $A0DF: Enemy set name
$B4:835A             db 42,4C,31,5F,32,33,20 ; "BL1_23 "

; Room $A0D2, state $A0DF: Enemy set
$B4:8361             dw D6FF,0001, CFBF,0002, D7BF,0003, FFFF

$B4:836F             db 00

; Room $9F11, state $9F3D: Enemy set name
$B4:8370             db 42,4C,31,5F,31,35,41 ; "BL1_15A"

; Room $9F11, state $9F3D: Enemy set
$B4:8377             dw DCFF,0001, EA7F,0002, FFFF

$B4:8381             db 00

; Room $9F64, state $9F90: Enemy set name
$B4:8382             db 42,4C,31,5F,31,36,41 ; "BL1_16A"

; Room $9F64, state $9F90: Enemy set
$B4:8389             dw EA7F,0001, DCFF,0002, DB7F,0003, D27F,0007, FFFF

$B4:839B             db 00

; Room $9FBA, state $9FC7: Enemy set name
$B4:839C             db 42,4C,31,5F,31,37,20 ; "BL1_17 "

; Room $9FBA, state $9FC7: Enemy set
$B4:83A3             dw CFFF,0001, DC7F,0002, FFFF

$B4:83AD             db 00

; Room $9E9F, state $9ECB: Enemy set name
$B4:83AE             db 42,4C,31,5F,31,34,41 ; "BL1_14A"

; Room $9E9F, state $9ECB: Enemy set
$B4:83B5             dw D9BF,0002, EA7F,0007, FFFF

$B4:83BF             db 00

; Room $A70B, state $A718: Enemy set name
$B4:83C0             db 42,4C,32,5F,32,32,20 ; "BL2_22 "

; Room $A70B, state $A718: Enemy set
$B4:83C7             dw FFFF

$B4:83C9             db 00

; Room $9E9F, state $9EB1: Enemy set name
$B4:83CA             db 42,4C,31,5F,31,34,20 ; "BL1_14 "

; Room $9E9F, state $9EB1: Enemy set
$B4:83D1             dw E6BF,0007, EA7F,0007, FFFF

$B4:83DB             db 00

; Room $A471, state $A47E: Enemy set name
$B4:83DC             db 42,4C,32,5F,31,30,20 ; "BL2_10 "

; Room $A471, state $A47E: Enemy set
$B4:83E3             dw DC7F,0001, FFFF

$B4:83E9             db 00

; Room $A253, state $A260: Enemy set name
$B4:83EA             db 42,4C,32,5F,30,30,20 ; "BL2_00 "

; Room $A253, state $A260: Enemy set
$B4:83F1             dw D47F,0001, E87F,0002, F253,0003, FFFF

$B4:83FF             db 00

; Room $A1AD, state $A1BA: Enemy set name
$B4:8400             db 62,6C,31,5F,32,38,20 ; "bl1_28 "

; Room $A1AD, state $A1BA: Enemy set
$B4:8407             dw DFBF,0001, FFFF

$B4:840D             db 00

; Room $A1D8, state $A1E5: Enemy set name
$B4:840E             db 62,6C,31,5F,32,39,20 ; "bl1_29 "

; Room $A1D8, state $A1E5: Enemy set
$B4:8415             dw FFFF

$B4:8417             db 00

; Room $A184, state $A191: Enemy set name
$B4:8418             db 62,6C,31,5F,32,37,20 ; "bl1_27 "

; Room $A184, state $A191: Enemy set
$B4:841F             dw FFFF

$B4:8421             db 00

; Room $9D19, state $9D26: Enemy set name
$B4:8422             db 42,4C,31,5F,30,39,20 ; "BL1_09 "

; Room $9D19, state $9D26: Enemy set
$B4:8429             dw D27F,0001, D93F,0002, F193,0003, FFFF

$B4:8437             db 00

; Room $A22A, state $A237: Enemy set name
$B4:8438             db 62,6C,31,5F,33,31,20 ; "bl1_31 "

; Room $A22A, state $A237: Enemy set
$B4:843F             dw FFFF

$B4:8441             db 00

; Room $A408, state $A415: Enemy set name
$B4:8442             db 42,4C,32,5F,30,38,20 ; "BL2_08 "

; Room $A408, state $A415: Enemy set
$B4:8449             dw E7BF,0001, CFFF,0002, FFFF

$B4:8453             db 00

; Room $A201, state $A20E: Enemy set name
$B4:8454             db 62,6C,31,5F,33,30,20 ; "bl1_30 "

; Room $A201, state $A20E: Enemy set
$B4:845B             dw FFFF

$B4:845D             db 00

; Room $A447, state $A454: Enemy set name
$B4:845E             db 42,4C,32,5F,30,39,20 ; "BL2_09 "

; Room $A447, state $A454: Enemy set
$B4:8465             dw FFFF

$B4:8467             db 00

; Room $9E11, state $9E1E: Enemy set name
$B4:8468             db 42,4C,31,5F,31,32,20 ; "BL1_12 "

; Room $9E11, state $9E1E: Enemy set
$B4:846F             dw D53F,0001, D67F,0001, D9BF,0002, FFFF

$B4:847D             db 00

; Room $A618, state $A625: Enemy set name
$B4:847E             db 42,4C,32,5F,31,37,20 ; "BL2_17 "

; Room $A618, state $A625: Enemy set
$B4:8485             dw FFFF

$B4:8487             db 00

; Room $A641, state $A64E: Enemy set name
$B4:8488             db 42,4C,32,5F,31,38,20 ; "BL2_18 "

; Room $A641, state $A64E: Enemy set
$B4:848F             dw FFFF

$B4:8491             db 00

; Room $A6E2, state $A6EF: Enemy set name
$B4:8492             db 42,4C,32,5F,32,31,20 ; "BL2_21 "

; Room $A6E2, state $A6EF: Enemy set
$B4:8499             dw FFFF

$B4:849B             db 00

; Room $A734, state $A741: Enemy set name
$B4:849C             db 42,4C,32,5F,32,33,20 ; "BL2_23 "

; Room $A734, state $A741: Enemy set
$B4:84A3             dw FFFF

$B4:84A5             db 00

; Unused enemy set name
$B4:84A6             db 42,4C,31,5F,32,34,61 ; "BL1_24a"

; Unused enemy set
$B4:84AD             dw FFFF

$B4:84AF             db 00

; Room $9F64, state $9F76: Enemy set name
$B4:84B0             db 42,4C,31,5F,31,36,20 ; "BL1_16 "

; Room $9F64, state $9F76: Enemy set
$B4:84B7             dw E6BF,0007, EA7F,0007, FFFF

$B4:84C1             db 00

; Room $9C5E, state $9C6B: Enemy set name
$B4:84C2             db 62,6C,31,5F,30,36,20 ; "bl1_06 "

; Room $9C5E, state $9C6B: Enemy set
$B4:84C9             dw D6BF,0002, FFFF

$B4:84CF             db 00

; Room $9FE5, state $9FF2: Enemy set name
$B4:84D0             db 42,4C,31,5F,31,38,20 ; "BL1_18 "

; Room $9FE5, state $9FF2: Enemy set
$B4:84D7             dw E87F,0001, FFFF

$B4:84DD             db 00

; Room $A011, state $A01E: Enemy set name
$B4:84DE             db 42,4C,31,5F,31,39,20 ; "BL1_19 "

; Room $A011, state $A01E: Enemy set
$B4:84E5             dw F1D3,0001, E87F,0002, FFFF

$B4:84EF             db 00

; Room $A130, state $A13D: Enemy set name
$B4:84F0             db 42,4C,31,5F,32,35,20 ; "BL1_25 "

; Room $A130, state $A13D: Enemy set
$B4:84F7             dw D9BF,0001, D93F,0002, D53F,0003, FFFF

$B4:8505             db 00

; Room $A4B1, state $A4BE: Enemy set name
$B4:8506             db 42,4C,32,5F,31,31,20 ; "BL2_11 "

; Room $A4B1, state $A4BE: Enemy set
$B4:850D             dw DBFF,0001, E87F,0002, FFFF

$B4:8517             db 00

; Unused enemy set name
$B4:8518             db 42,4C,32,5F,32,30,61 ; "BL2_20a"

; Unused enemy set
$B4:851F             dw FFFF

$B4:8521             db 00

; Room $A6A1, state $A6AE: Enemy set name
$B4:8522             db 42,4C,32,5F,32,30,20 ; "BL2_20 "

; Room $A6A1, state $A6AE: Enemy set
$B4:8529             dw FFFF

$B4:852B             db 00

; Room $A4DA, state $A4E7: Enemy set name
$B4:852C             db 42,4C,32,5F,31,32,20 ; "BL2_12 "

; Room $A4DA, state $A4E7: Enemy set
$B4:8533             dw EABF,0001, FFFF

$B4:8539             db 00

; Room $9AD9, state $9AE6: Enemy set name
$B4:853A             db 62,6C,31,5F,30,30,20 ; "bl1_00 "

; Room $9AD9, state $9AE6: Enemy set
$B4:8541             dw E5BF,0001, DC7F,0002, D43F,0003, FFFF

$B4:854F             db 00

; Room $9B5B, state $9B68: Enemy set name
$B4:8550             db 62,6C,31,5F,30,31,20 ; "bl1_01 "

; Room $9B5B, state $9B68: Enemy set
$B4:8557             dw F193,0001, FFFF

$B4:855D             db 00

; Room $9BC8, state $9BD5: Enemy set name
$B4:855E             db 62,6C,31,5F,30,33,20 ; "bl1_03 "

; Room $9BC8, state $9BD5: Enemy set
$B4:8565             dw D93F,0001, D4FF,0002, D63F,0003, F193,0007, FFFF

$B4:8577             db 00

; Room $A293, state $A2A0: Enemy set name
$B4:8578             db 42,4C,32,5F,30,31,20 ; "BL2_01 "

; Room $A293, state $A2A0: Enemy set
$B4:857F             dw D6BF,0001, D63F,0002, E7BF,0003, FFFF

$B4:858D             db 00

; Room $9F11, state $9F23: Enemy set name
$B4:858E             db 42,4C,31,5F,31,35,20 ; "BL1_15 "

; Room $9F11, state $9F23: Enemy set
$B4:8595             dw D87F,0007, EA7F,0007, FFFF

$B4:859F             db 00

; Room $9E52, state $9E5F: Enemy set name
$B4:85A0             db 42,4C,31,5F,31,33,20 ; "BL1_13 "

; Room $9E52, state $9E5F: Enemy set
$B4:85A7             dw D93F,0001, F253,0002, FFFF

$B4:85B1             db 00

; Room $9CB3, state $9CC0: Enemy set name
$B4:85B2             db 42,4C,31,5F,30,38,20 ; "BL1_08 "

; Room $9CB3, state $9CC0: Enemy set
$B4:85B9             dw DC7F,0001, D67F,0002, D27F,0003, E5FF,0007, FFFF

$B4:85CB             db 00

; Room $A2F7, state $A304: Enemy set name
$B4:85CC             db 42,4C,32,5F,30,33,20 ; "BL2_03 "

; Room $A2F7, state $A304: Enemy set
$B4:85D3             dw DC7F,0001, F1D3,0002, FFFF

$B4:85DD             db 00

; Room $A107, state $A114: Enemy set name
$B4:85DE             db 42,4C,31,5F,32,34,20 ; "BL1_24 "

; Room $A107, state $A114: Enemy set
$B4:85E5             dw FFFF

$B4:85E7             db 00

; Room $A59F, state $A5B1: Enemy set name
; Room $A59F, state $A5CB: Enemy set name
$B4:85E8             db 42,4C,32,5F,31,35,20 ; "BL2_15 "

; Room $A59F, state $A5B1: Enemy set
; Room $A59F, state $A5CB: Enemy set
$B4:85EF             dw E2BF,0007, FFFF

$B4:85F5             db 00

; Room $9C07, state $9C14: Enemy set name
$B4:85F6             db 62,6C,31,5F,30,34,20 ; "bl1_04 "

; Room $9C07, state $9C14: Enemy set
$B4:85FD             dw FFFF

$B4:85FF             db 00

; Room $A2CE, state $A2DB: Enemy set name
$B4:8600             db 42,4C,32,5F,30,32,20 ; "BL2_02 "

; Room $A2CE, state $A2DB: Enemy set
$B4:8607             dw D53F,0001, FFFF

$B4:860D             db 00

; Room $A5ED, state $A5FA: Enemy set name
$B4:860E             db 42,4C,32,5F,31,36,20 ; "BL2_16 "

; Room $A5ED, state $A5FA: Enemy set
$B4:8615             dw FFFF

$B4:8617             db 00

; Room $A3AE, state $A3BB: Enemy set name
$B4:8618             db 42,4C,32,5F,30,36,20 ; "BL2_06 "

; Room $A3AE, state $A3BB: Enemy set
$B4:861F             dw CEBF,0001, FFFF

$B4:8625             db 00

; Room $A56B, state $A578: Enemy set name
$B4:8626             db 42,4C,32,5F,31,34,20 ; "BL2_14 "

; Room $A56B, state $A578: Enemy set
$B4:862D             dw F193,0001, D87F,0002, FFFF

$B4:8637             db 00

; Room $A322, state $A32F: Enemy set name
$B4:8638             db 42,4C,32,5F,30,34,20 ; "BL2_04 "

; Room $A322, state $A32F: Enemy set
$B4:863F             dw D7BF,0002, CFFF,0003, FFFF

$B4:8649             db 00

; Room $A521, state $A533: Enemy set name
; Room $A521, state $A54D: Enemy set name
$B4:864A             db 42,4C,32,5F,31,33,20 ; "BL2_13 "

; Room $A521, state $A533: Enemy set
; Room $A521, state $A54D: Enemy set
$B4:8651             dw F693,0001, E0FF,0003, FFFF

$B4:865B             db 00

; Room $9DC7, state $9DD9: Enemy set name
; Room $9DC7, state $9DF3: Enemy set name
$B4:865C             db 42,4C,31,5F,31,31,20 ; "BL1_11 "

; Room $9DC7, state $9DD9: Enemy set
; Room $9DC7, state $9DF3: Enemy set
$B4:8663             dw DF3F,0001, FFFF

$B4:8669             db 00

; Room $A3DD, state $A3EA: Enemy set name
$B4:866A             db 42,4C,32,5F,30,37,20 ; "BL2_07 "

; Room $A3DD, state $A3EA: Enemy set
$B4:8671             dw DB7F,0001, CEBF,0007, FFFF

$B4:867B             db 00

; Room $AB64, state $AB71: Enemy set name
$B4:867C             db 4E,4F,31,5F,31,39,20 ; "NO1_19 "

; Room $AB64, state $AB71: Enemy set
$B4:8683             dw F213,0001, CFBF,0002, FFFF

$B4:868D             db 00

; Room $AB07, state $AB14: Enemy set name
$B4:868E             db 4E,4F,31,5F,31,37,20 ; "NO1_17 "

; Room $AB07, state $AB14: Enemy set
$B4:8695             dw DABF,0001, FFFF

$B4:869B             db 00

; Room $B62B, state $B638: Enemy set name
$B4:869C             db 4E,4F,32,5F,31,38,20 ; "NO2_18 "

; Room $B62B, state $B638: Enemy set
$B4:86A3             dw F593,0001, FFFF

$B4:86A9             db 00

; Room $B1E5, state $B1F2: Enemy set name
$B4:86AA             db 4E,4F,32,5F,30,30,20 ; "NO2_00 "

; Room $B1E5, state $B1F2: Enemy set
$B4:86B1             dw F0FF,0001, E83F,0003, D33F,0007, FFFF

$B4:86BF             db 00

; Room $B051, state $B05E: Enemy set name
$B4:86C0             db 4E,4F,31,5F,34,34,20 ; "NO1_44 "

; Room $B051, state $B05E: Enemy set
$B4:86C7             dw F213,0001, FFFF

$B4:86CD             db 00

; Room $A815, state $A822: Enemy set name
$B4:86CE             db 4E,4F,31,5F,30,34,20 ; "NO1_04 "

; Room $A815, state $A822: Enemy set
$B4:86D5             dw D4FF,0001, D97F,0002, D13F,0003, DCBF,0007, FFFF

$B4:86E7             db 00

; Room $AFFB, state $B008: Enemy set name
$B4:86E8             db 4E,4F,31,5F,34,32,20 ; "NO1_42 "

; Room $AFFB, state $B008: Enemy set
$B4:86EF             dw E7BF,0001, FFFF

$B4:86F5             db 00

; Room $B585, state $B592: Enemy set name
$B4:86F6             db 4E,4F,32,5F,31,36,20 ; "NO2_16 "

; Room $B585, state $B592: Enemy set
$B4:86FD             dw EBBF,0001, DBFF,0002, FFFF

$B4:8707             db 00

; Room $B2DA, state $B2E7: Enemy set name
$B4:8708             db 4E,4F,32,5F,30,33,20 ; "NO2_03 "

; Room $B2DA, state $B2E7: Enemy set
$B4:870F             dw D43F,0001, FFFF

$B4:8715             db 00

; Room $ADDE, state $ADEB: Enemy set name
$B4:8716             db 4E,4F,31,5F,33,31,20 ; "NO1_31 "

; Room $ADDE, state $ADEB: Enemy set
$B4:871D             dw FFFF

$B4:871F             db 00

; Room $B3A5, state $B3B2: Enemy set name
$B4:8720             db 4E,4F,32,5F,30,37,20 ; "NO2_07 "

; Room $B3A5, state $B3B2: Enemy set
$B4:8727             dw F413,0001, F713,0002, DABF,0003, FFFF

$B4:8735             db 00

; Room $AF3F, state $AF4C: Enemy set name
$B4:8736             db 4E,4F,31,5F,33,38,20 ; "NO1_38 "

; Room $AF3F, state $AF4C: Enemy set
$B4:873D             dw FFFF

$B4:873F             db 00

; Room $B741, state $B74E: Enemy set name
$B4:8740             db 4E,4F,32,5F,32,33,20 ; "NO2_23 "

; Room $B741, state $B74E: Enemy set
$B4:8747             dw FFFF

$B4:8749             db 00

; Room $B026, state $B033: Enemy set name
$B4:874A             db 4E,4F,31,5F,34,33,20 ; "NO1_43 "

; Room $B026, state $B033: Enemy set
$B4:8751             dw FFFF

$B4:8753             db 00

; Room $B0B4, state $B0C1: Enemy set name
$B4:8754             db 4E,4F,31,5F,34,36,20 ; "NO1_46 "

; Room $B0B4, state $B0C1: Enemy set
$B4:875B             dw FFFF

$B4:875D             db 00

; Room $B40A, state $B417: Enemy set name
$B4:875E             db 4E,4F,32,5F,30,39,20 ; "NO2_09 "

; Room $B40A, state $B417: Enemy set
$B4:8765             dw DA3F,0001, D1BF,0002, FFFF

$B4:876F             db 00

; Room $B305, state $B312: Enemy set name
$B4:8770             db 4E,4F,32,5F,30,34,20 ; "NO2_04 "

; Room $B305, state $B312: Enemy set
$B4:8777             dw FFFF

$B4:8779             db 00

; Room $B32E, state $B340: Enemy set name
; Room $B32E, state $B35A: Enemy set name
$B4:877A             db 4E,4F,32,5F,30,35,20 ; "NO2_05 "

; Room $B32E, state $B340: Enemy set
; Room $B32E, state $B35A: Enemy set
$B4:8781             dw E17F,0001, E1BF,E001, FFFF

$B4:878B             db 00

; Room $AADE, state $AAEB: Enemy set name
$B4:878C             db 4E,4F,31,5F,31,36,20 ; "NO1_16 "

; Room $AADE, state $AAEB: Enemy set
$B4:8793             dw FFFF

$B4:8795             db 00

; Room $A890, state $A89D: Enemy set name
$B4:8796             db 4E,4F,31,5F,30,36,20 ; "NO1_06 "

; Room $A890, state $A89D: Enemy set
$B4:879D             dw FFFF

$B4:879F             db 00

; Room $A9E5, state $A9F2: Enemy set name
$B4:87A0             db 4E,4F,31,5F,31,31,20 ; "NO1_11 "

; Room $A9E5, state $A9F2: Enemy set
$B4:87A7             dw FFFF

$B4:87A9             db 00

; Room $AAB5, state $AAC2: Enemy set name
$B4:87AA             db 4E,4F,31,5F,31,35,20 ; "NO1_15 "

; Room $AAB5, state $AAC2: Enemy set
$B4:87B1             dw FFFF

$B4:87B3             db 00

; Room $B106, state $B113: Enemy set name
$B4:87B4             db 4E,4F,31,5F,34,38,20 ; "NO1_48 "

; Room $B106, state $B113: Enemy set
$B4:87BB             dw E87F,0001, FFFF

$B4:87C1             db 00

; Room $AFA3, state $AFB0: Enemy set name
$B4:87C2             db 4E,4F,31,5F,34,30,20 ; "NO1_40 "

; Room $AFA3, state $AFB0: Enemy set
$B4:87C9             dw D2BF,0001, DCBF,0002, D4BF,0003, FFFF

$B4:87D7             db 00

; Room $AA82, state $AA8F: Enemy set name
$B4:87D8             db 4E,4F,31,5F,31,34,20 ; "NO1_14 "

; Room $AA82, state $AA8F: Enemy set
$B4:87DF             dw F213,0001, D3FF,0002, D83F,0003, FFFF

$B4:87ED             db 00

; Room $B4AD, state $B4BA: Enemy set name
$B4:87EE             db 4E,4F,32,5F,31,32,20 ; "NO2_12 "

; Room $B4AD, state $B4BA: Enemy set
$B4:87F5             dw E73F,0001, F413,0002, F713,0003, FFFF

$B4:8803             db 00

; Room $ADAD, state $ADBA: Enemy set name
$B4:8804             db 4E,4F,31,5F,33,30,20 ; "NO1_30 "

; Room $ADAD, state $ADBA: Enemy set
$B4:880B             dw E6FF,0001, D5FF,0002, E7FF,0003, D3FF,0007, FFFF

$B4:881D             db 00

; Room $AC2B, state $AC38: Enemy set name
$B4:881E             db 4E,4F,31,5F,32,33,20 ; "NO1_23 "

; Room $AC2B, state $AC38: Enemy set
$B4:8825             dw D1BF,0001, FFFF

$B4:882B             db 00

; Room $B139, state $B146: Enemy set name
$B4:882C             db 4E,4F,31,5F,34,39,20 ; "NO1_49 "

; Room $B139, state $B146: Enemy set
$B4:8833             dw F6D3,0001, DD3F,0003, FFFF

$B4:883D             db 00

; Room $A923, state $A930: Enemy set name
$B4:883E             db 4E,4F,31,5F,30,39,20 ; "NO1_09 "

; Room $A923, state $A930: Enemy set
$B4:8845             dw F6D3,0001, D1BF,0002, CFFF,0003, DCBF,0003, FFFF

$B4:8857             db 00

; Room $B482, state $B48F: Enemy set name
$B4:8858             db 4E,4F,32,5F,31,31,20 ; "NO2_11 "

; Room $B482, state $B48F: Enemy set
$B4:885F             dw F1D3,0001, D33F,0007, FFFF

$B4:8869             db 00

; Room $B6EE, state $B6FB: Enemy set name
$B4:886A             db 4E,4F,32,5F,32,32,20 ; "NO2_22 "

; Room $B6EE, state $B6FB: Enemy set
$B4:8871             dw D6BF,0001, DFBF,0002, E6FF,0003, FFFF

$B4:887F             db 00

; Room $AEB4, state $AEC1: Enemy set name
$B4:8880             db 4E,4F,31,5F,33,35,20 ; "NO1_35 "

; Room $AEB4, state $AEC1: Enemy set
$B4:8887             dw D1BF,0001, E83F,0007, FFFF

$B4:8891             db 00

; Room $B3E1, state $B3EE: Enemy set name
$B4:8892             db 4E,4F,32,5F,30,38,20 ; "NO2_08 "

; Room $B3E1, state $B3EE: Enemy set
$B4:8899             dw FFFF

$B4:889B             db 00

; Room $AF14, state $AF21: Enemy set name
$B4:889C             db 4E,4F,31,5F,33,37,20 ; "NO1_37 "

; Room $AF14, state $AF21: Enemy set
$B4:88A3             dw E73F,0001, FFFF

$B4:88A9             db 00

; Room $B457, state $B464: Enemy set name
$B4:88AA             db 4E,4F,32,5F,31,30,20 ; "NO2_10 "

; Room $B457, state $B464: Enemy set
$B4:88B1             dw E0BF,0007, FFFF

$B4:88B7             db 00

; Room $AA0E, state $AA1B: Enemy set name
$B4:88B8             db 4E,4F,31,5F,31,32,20 ; "NO1_12 "

; Room $AA0E, state $AA1B: Enemy set
$B4:88BF             dw D4BF,0001, D2FF,0002, FFFF

$B4:88C9             db 00

; Room $B510, state $B51D: Enemy set name
$B4:88CA             db 4E,4F,32,5F,31,34,20 ; "NO2_14 "

; Room $B510, state $B51D: Enemy set
$B4:88D1             dw E9BF,0001, FFFF

$B4:88D7             db 00

; Room $B55A, state $B567: Enemy set name
$B4:88D8             db 4E,4F,32,5F,31,35,20 ; "NO2_15 "

; Room $B55A, state $B567: Enemy set
$B4:88DF             dw FFFF

$B4:88E1             db 00

; Room $AEDF, state $AEEC: Enemy set name
$B4:88E2             db 4E,4F,31,5F,33,36,20 ; "NO1_36 "

; Room $AEDF, state $AEEC: Enemy set
$B4:88E9             dw FFFF

$B4:88EB             db 00

; Room $B698, state $B6A5: Enemy set name
$B4:88EC             db 4E,4F,32,5F,32,30,20 ; "NO2_20 "

; Room $B698, state $B6A5: Enemy set
$B4:88F3             dw FFFF

$B4:88F5             db 00

; Room $B6C1, state $B6CE: Enemy set name
$B4:88F6             db 4E,4F,32,5F,32,31,20 ; "NO2_21 "

; Room $B6C1, state $B6CE: Enemy set
$B4:88FD             dw FFFF

$B4:88FF             db 00

; Room $AC83, state $AC90: Enemy set name
$B4:8900             db 4E,4F,31,5F,32,35,20 ; "NO1_25 "

; Room $AC83, state $AC90: Enemy set
$B4:8907             dw D53F,0007, DCBF,0002, D2FF,0003, FFFF

$B4:8915             db 00

; Room $B4E5, state $B4F2: Enemy set name
$B4:8916             db 4E,4F,32,5F,31,33,20 ; "NO2_13 "

; Room $B4E5, state $B4F2: Enemy set
$B4:891D             dw F713,0007, FFFF

$B4:8923             db 00

; Room $A7B3, state $A7C0: Enemy set name
$B4:8924             db 4E,4F,31,5F,30,32,20 ; "NO1_02 "

; Room $A7B3, state $A7C0: Enemy set
$B4:892B             dw DCBF,0001, D97F,0002, FFFF

$B4:8935             db 00

; Room $B236, state $B243: Enemy set name
$B4:8936             db 4E,4F,32,5F,30,31,20 ; "NO2_01 "

; Room $B236, state $B243: Enemy set
$B4:893D             dw E07F,0001, D4BF,0007, F213,0007, FFFF

$B4:894B             db 00

; Room $AB8F, state $AB9C: Enemy set name
$B4:894C             db 4E,4F,31,5F,32,30,20 ; "NO1_20 "

; Room $AB8F, state $AB9C: Enemy set
$B4:8953             dw D13F,0001, D3FF,0002, D83F,0003, FFFF

$B4:8961             db 00

; Room $B167, state $B174: Enemy set name
$B4:8962             db 4E,4F,31,5F,35,30,20 ; "NO1_50 "

; Room $B167, state $B174: Enemy set
$B4:8969             dw FFFF

$B4:896B             db 00

; Room $B192, state $B19F: Enemy set name
$B4:896C             db 4E,4F,31,5F,35,31,20 ; "NO1_51 "

; Room $B192, state $B19F: Enemy set
$B4:8973             dw FFFF

$B4:8975             db 00

; Room $A8F8, state $A905: Enemy set name
$B4:8976             db 4E,4F,31,5F,30,38,20 ; "NO1_08 "

; Room $A8F8, state $A905: Enemy set
$B4:897D             dw DCBF,0001, FFFF

$B4:8983             db 00

; Room $B5D5, state $B5E2: Enemy set name
$B4:8984             db 4E,4F,32,5F,31,37,20 ; "NO2_17 "

; Room $B5D5, state $B5E2: Enemy set
$B4:898B             dw E07F,0001, DA3F,0002, D53F,0003, DFFF,0007, FFFF

$B4:899D             db 00

; Room $AFCE, state $AFDB: Enemy set name
$B4:899E             db 4E,4F,31,5F,34,31,20 ; "NO1_41 "

; Room $AFCE, state $AFDB: Enemy set
$B4:89A5             dw D4BF,0001, F213,0002, FFFF

$B4:89AF             db 00

; Room $AC00, state $AC0D: Enemy set name
$B4:89B0             db 4E,4F,31,5F,32,32,20 ; "NO1_22 "

; Room $AC00, state $AC0D: Enemy set
$B4:89B7             dw FFFF

$B4:89B9             db 00

; Room $B0DD, state $B0EA: Enemy set name
$B4:89BA             db 4E,4F,31,5F,34,37,20 ; "NO1_47 "

; Room $B0DD, state $B0EA: Enemy set
$B4:89C1             dw FFFF

$B4:89C3             db 00

; Room $AA41, state $AA4E: Enemy set name
$B4:89C4             db 4E,4F,31,5F,31,33,20 ; "NO1_13 "

; Room $AA41, state $AA4E: Enemy set
$B4:89CB             dw DCBF,0001, FFFF

$B4:89D1             db 00

; Room $ACB3, state $ACC0: Enemy set name
$B4:89D2             db 4E,4F,31,5F,32,36,20 ; "NO1_26 "

; Room $ACB3, state $ACC0: Enemy set
$B4:89D9             dw D63F,0001, D43F,0001, CFFF,0002, DCBF,0002, FFFF

$B4:89EB             db 00

; Room $A75D, state $A76A: Enemy set name
$B4:89EC             db 4E,4F,31,5F,30,30,20 ; "NO1_00 "

; Room $A75D, state $A76A: Enemy set
$B4:89F3             dw D7FF,0007, FFFF

$B4:89F9             db 00

; Room $A865, state $A872: Enemy set name
$B4:89FA             db 4E,4F,31,5F,30,35,20 ; "NO1_05 "

; Room $A865, state $A872: Enemy set
$B4:8A01             dw CEBF,0001, D43F,0002, FFFF

$B4:8A0B             db 00

; Room $AB3B, state $AB48: Enemy set name
$B4:8A0C             db 4E,4F,31,5F,31,38,20 ; "NO1_18 "

; Room $AB3B, state $AB48: Enemy set
$B4:8A13             dw D67F,0001, F213,0002, FFFF

$B4:8A1D             db 00

; Room $A788, state $A795: Enemy set name
$B4:8A1E             db 4E,4F,31,5F,30,31,20 ; "NO1_01 "

; Room $A788, state $A795: Enemy set
$B4:8A25             dw DCBF,0001, D2FF,0002, FFFF

$B4:8A2F             db 00

; Room $AC5A, state $AC67: Enemy set name
$B4:8A30             db 4E,4F,31,5F,32,34,20 ; "NO1_24 "

; Room $AC5A, state $AC67: Enemy set
$B4:8A37             dw D4BF,0001, DCBF,0002, FFFF

$B4:8A41             db 00

; Room $ABD2, state $ABDF: Enemy set name
$B4:8A42             db 4E,4F,31,5F,32,31,20 ; "NO1_21 "

; Room $ABD2, state $ABDF: Enemy set
$B4:8A49             dw E6FF,0001, D1BF,0002, FFFF

$B4:8A53             db 00

; Room $A8B9, state $A8C6: Enemy set name
$B4:8A54             db 4E,4F,31,5F,30,37,20 ; "NO1_07 "

; Room $A8B9, state $A8C6: Enemy set
$B4:8A5B             dw DCBF,0001, E6FF,0002, FFFF

$B4:8A65             db 00

; Room $B283, state $B295: Enemy set name
; Room $B283, state $B2AF: Enemy set name
$B4:8A66             db 4E,4F,32,5F,30,32,20 ; "NO2_02 "

; Room $B283, state $B295: Enemy set
; Room $B283, state $B2AF: Enemy set
$B4:8A6D             dw EF7F,0001, FFFF

$B4:8A73             db 00

; Room $AE07, state $AE14: Enemy set name
$B4:8A74             db 4E,4F,31,5F,33,32,20 ; "NO1_32 "

; Room $AE07, state $AE14: Enemy set
$B4:8A7B             dw D7FF,0007, D53F,0002, FFFF

$B4:8A85             db 00

; Room $AD1B, state $AD28: Enemy set name
$B4:8A86             db 4E,4F,31,5F,32,38,20 ; "NO1_28 "

; Room $AD1B, state $AD28: Enemy set
$B4:8A8D             dw FFFF

$B4:8A8F             db 00

; Room $B37A, state $B387: Enemy set name
$B4:8A90             db 4E,4F,32,5F,30,36,20 ; "NO2_06 "

; Room $B37A, state $B387: Enemy set
$B4:8A97             dw DABF,0001, F1D3,0007, FFFF

$B4:8AA1             db 00

; Room $AD5E, state $AD6B: Enemy set name
$B4:8AA2             db 4E,4F,31,5F,32,39,20 ; "NO1_29 "

; Room $AD5E, state $AD6B: Enemy set
$B4:8AA9             dw D1BF,0001, E9BF,0002, FFFF

$B4:8AB3             db 00

; Room $ACF0, state $ACFD: Enemy set name
$B4:8AB4             db 4E,4F,31,5F,32,37,20 ; "NO1_27 "

; Room $ACF0, state $ACFD: Enemy set
$B4:8ABB             dw D2FF,0001, D67F,0002, FFFF

$B4:8AC5             db 00

; Room $B07A, state $B087: Enemy set name
$B4:8AC6             db 4E,4F,31,5F,34,35,20 ; "NO1_45 "

; Room $B07A, state $B087: Enemy set
$B4:8ACD             dw F213,0001, DB7F,0002, FFFF

$B4:8AD7             db 00

; Room $AE74, state $AE81: Enemy set name
$B4:8AD8             db 4E,4F,31,5F,33,34,20 ; "NO1_34 "

; Room $AE74, state $AE81: Enemy set
$B4:8ADF             dw DABF,0001, FFFF

$B4:8AE5             db 00

; Room $A7DE, state $A7EB: Enemy set name
$B4:8AE6             db 4E,4F,31,5F,30,33,20 ; "NO1_03 "

; Room $A7DE, state $A7EB: Enemy set
$B4:8AED             dw DCBF,0002, FFFF

$B4:8AF3             db 00

; Room $B656, state $B663: Enemy set name
$B4:8AF4             db 4E,4F,32,5F,31,39,20 ; "NO2_19 "

; Room $B656, state $B663: Enemy set
$B4:8AFB             dw E07F,0001, EBBF,0002, D53F,0003, FFFF

$B4:8B09             db 00

; Room $A98D, state $A99F: Enemy set name
; Room $A98D, state $A9B9: Enemy set name
$B4:8B0A             db 4E,4F,31,5F,31,30,20 ; "NO1_10 "

; Room $A98D, state $A99F: Enemy set
; Room $A98D, state $A9B9: Enemy set
$B4:8B11             dw DDBF,D007, FFFF

$B4:8B17             db 00

; Room $B1BB, state $B1C8: Enemy set name
$B4:8B18             db 4E,4F,31,5F,35,32,20 ; "NO1_52 "

; Room $B1BB, state $B1C8: Enemy set
$B4:8B1F             dw FFFF

$B4:8B21             db 00

; Room $AE32, state $AE3F: Enemy set name
$B4:8B22             db 4E,4F,31,5F,33,33,20 ; "NO1_33 "

; Room $AE32, state $AE3F: Enemy set
$B4:8B29             dw E6FF,0001, D1FF,0002, FFFF

$B4:8B33             db 00

; Room $AF72, state $AF7F: Enemy set name
$B4:8B34             db 4E,4F,31,5F,33,39,20 ; "NO1_39 "

; Room $AF72, state $AF7F: Enemy set
$B4:8B3B             dw E6FF,0001, F213,0002, FFFF

$B4:8B45             db 00

; Room $CD5C, state $CD88: Enemy set name
$B4:8B46             db 4E,50,31,5F,31,31,61 ; "NP1_11a"

; Room $CD5C, state $CD88: Enemy set
$B4:8B4D             dw E97F,0001, FFFF

$B4:8B53             db 00

; Room $CC27, state $CC53: Enemy set name
$B4:8B54             db 4E,50,31,5F,30,37,61 ; "NP1_07a"

; Room $CC27, state $CC53: Enemy set
$B4:8B5B             dw D83F,0001, D6FF,0002, FFFF

$B4:8B65             db 00

; Room $CAF6, state $CB08: Enemy set name
$B4:8B66             db 4E,50,31,5F,30,34,20 ; "NP1_04 "

; Room $CAF6, state $CB08: Enemy set
$B4:8B6D             dw E77F,0001, DFFF,0002, E9FF,0003, D87F,0003, FFFF

$B4:8B7F             db 00

; Room $C98E, state $C9A0: Enemy set name
$B4:8B80             db 4E,50,31,5F,30,30,20 ; "NP1_00 "

; Room $C98E, state $C9A0: Enemy set
$B4:8B87             dw F0FF,0001, D87F,0007, FFFF

$B4:8B91             db 00

; Room $CA52, state $CA7E: Enemy set name
$B4:8B92             db 4E,50,31,5F,30,32,61 ; "NP1_02a"

; Room $CA52, state $CA7E: Enemy set
$B4:8B99             dw EB3F,0001, E9FF,0002, EA3F,0003, FFFF

$B4:8BA7             db 00

; Room $CC6F, state $CC9B: Enemy set name
$B4:8BA8             db 4E,50,31,5F,30,38,61 ; "NP1_08a"

; Room $CC6F, state $CC9B: Enemy set
$B4:8BAF             dw E8FF,0001, E9FF,0002, EA3F,0003, FFFF

$B4:8BBD             db 00

; Room $CCCB, state $CCF7: Enemy set name
$B4:8BBE             db 4E,50,31,5F,30,39,61 ; "NP1_09a"

; Room $CCCB, state $CCF7: Enemy set
$B4:8BC5             dw FFFF

$B4:8BC7             db 00

; Room $CDA8, state $CDBA: Enemy set name
$B4:8BC8             db 4E,50,31,5F,31,32,20 ; "NP1_12 "

; Room $CDA8, state $CDBA: Enemy set
$B4:8BCF             dw FFFF

$B4:8BD1             db 00

; Room $CB8B, state $CB9D: Enemy set name
$B4:8BD2             db 4E,50,31,5F,30,35,20 ; "NP1_05 "

; Room $CB8B, state $CB9D: Enemy set
$B4:8BD9             dw FFFF

$B4:8BDB             db 00

; Room $CD5C, state $CD6E: Enemy set name
$B4:8BDC             db 4E,50,31,5F,31,31,20 ; "NP1_11 "

; Room $CD5C, state $CD6E: Enemy set
$B4:8BE3             dw FFFF

$B4:8BE5             db 00

; Room $CA08, state $CA34: Enemy set name
$B4:8BE6             db 4E,50,31,5F,30,31,61 ; "NP1_01a"

; Room $CA08, state $CA34: Enemy set
$B4:8BED             dw FFFF

$B4:8BEF             db 00

; Room $CBD5, state $CBE7: Enemy set name
$B4:8BF0             db 4E,50,31,5F,30,36,20 ; "NP1_06 "

; Room $CBD5, state $CBE7: Enemy set
$B4:8BF7             dw FFFF

$B4:8BF9             db 00

; Room $C98E, state $C9BA: Enemy set name
$B4:8BFA             db 4E,50,31,5F,30,30,61 ; "NP1_00a"

; Room $C98E, state $C9BA: Enemy set
$B4:8C01             dw F0FF,0001, E8FF,0003, FFFF

$B4:8C0B             db 00

; Room $CAAE, state $CAC0: Enemy set name
$B4:8C0C             db 4E,50,31,5F,30,33,20 ; "NP1_03 "

; Room $CAAE, state $CAC0: Enemy set
$B4:8C13             dw FFFF

$B4:8C15             db 00

; Room $CD13, state $CD3F: Enemy set name
$B4:8C16             db 4E,50,31,5F,31,30,61 ; "NP1_10a"

; Room $CD13, state $CD3F: Enemy set
$B4:8C1D             dw FFFF

$B4:8C1F             db 00

; Room $CC27, state $CC39: Enemy set name
$B4:8C20             db 4E,50,31,5F,30,37,20 ; "NP1_07 "

; Room $CC27, state $CC39: Enemy set
$B4:8C27             dw FFFF

$B4:8C29             db 00

; Room $CE40, state $CE52: Enemy set name
$B4:8C2A             db 4E,50,31,5F,31,34,20 ; "NP1_14 "

; Room $CE40, state $CE52: Enemy set
$B4:8C31             dw FFFF

$B4:8C33             db 00

; Room $CCCB, state $CCDD: Enemy set name
$B4:8C34             db 4E,50,31,5F,30,39,20 ; "NP1_09 "

; Room $CCCB, state $CCDD: Enemy set
$B4:8C3B             dw E77F,0001, D87F,0007, E97F,0007, FFFF

$B4:8C49             db 00

; Room $CE40, state $CE6C: Enemy set name
$B4:8C4A             db 4E,50,31,5F,31,34,61 ; "NP1_14a"

; Room $CE40, state $CE6C: Enemy set
$B4:8C51             dw FFFF

$B4:8C53             db 00

; Room $CC6F, state $CC81: Enemy set name
$B4:8C54             db 4E,50,31,5F,30,38,20 ; "NP1_08 "

; Room $CC6F, state $CC81: Enemy set
$B4:8C5B             dw E93F,0007, D87F,0007, FFFF

$B4:8C65             db 00

; Room $CA08, state $CA1A: Enemy set name
$B4:8C66             db 4E,50,31,5F,30,31,20 ; "NP1_01 "

; Room $CA08, state $CA1A: Enemy set
$B4:8C6D             dw D87F,0001, FFFF

$B4:8C73             db 00

; Room $CAAE, state $CADA: Enemy set name
$B4:8C74             db 4E,50,31,5F,30,33,61 ; "NP1_03a"

; Room $CAAE, state $CADA: Enemy set
$B4:8C7B             dw EA3F,0001, CFBF,0002, E8FF,0003, FFFF

$B4:8C89             db 00

; Room $CE8A, state $CEB6: Enemy set name
$B4:8C8A             db 4E,50,31,5F,31,35,61 ; "NP1_15a"

; Room $CE8A, state $CEB6: Enemy set
$B4:8C91             dw FFFF

$B4:8C93             db 00

; Room $CDA8, state $CDD4: Enemy set name
$B4:8C94             db 4E,50,31,5F,31,32,61 ; "NP1_12a"

; Room $CDA8, state $CDD4: Enemy set
$B4:8C9B             dw EA3F,0001, FFFF

$B4:8CA1             db 00

; Room $CA52, state $CA64: Enemy set name
$B4:8CA2             db 4E,50,31,5F,30,32,20 ; "NP1_02 "

; Room $CA52, state $CA64: Enemy set
$B4:8CA9             dw E77F,0001, E9FF,0002, D87F,0002, FFFF

$B4:8CB7             db 00

; Room $CDF1, state $CE03: Enemy set name
$B4:8CB8             db 4E,50,31,5F,31,33,20 ; "NP1_13 "

; Room $CDF1, state $CE03: Enemy set
$B4:8CBF             dw E77F,0001, E9FF,0002, D87F,0002, E93F,0007, FFFF

$B4:8CD1             db 00

; Room $CE8A, state $CE9C: Enemy set name
$B4:8CD2             db 4E,50,31,5F,31,35,20 ; "NP1_15 "

; Room $CE8A, state $CE9C: Enemy set
$B4:8CD9             dw E77F,0001, D87F,0002, FFFF

$B4:8CE3             db 00

; Room $CBD5, state $CC01: Enemy set name
$B4:8CE4             db 4E,50,31,5F,30,36,61 ; "NP1_06a"

; Room $CBD5, state $CC01: Enemy set
$B4:8CEB             dw EA3F,0001, FFFF

$B4:8CF1             db 00

; Room $CB8B, state $CBB7: Enemy set name
$B4:8CF2             db 4E,50,31,5F,30,35,61 ; "NP1_05a"

; Room $CB8B, state $CBB7: Enemy set
$B4:8CF9             dw DFFF,0007, FFFF

$B4:8CFF             db 00

; Room $CDF1, state $CE1D: Enemy set name
$B4:8D00             db 4E,50,31,5F,31,33,61 ; "NP1_13a"

; Room $CDF1, state $CE1D: Enemy set
$B4:8D07             dw E8FF,0001, E97F,0002, EA3F,0003, FFFF

$B4:8D15             db 00

; Room $CD13, state $CD25: Enemy set name
$B4:8D16             db 4E,50,31,5F,31,30,20 ; "NP1_10 "

; Room $CD13, state $CD25: Enemy set
$B4:8D1D             dw E4BF,0007, FFFF

$B4:8D23             db 00

; Room $CAF6, state $CB22: Enemy set name
$B4:8D24             db 4E,50,31,5F,30,34,61 ; "NP1_04a"

; Room $CAF6, state $CB22: Enemy set
$B4:8D2B             dw EA3F,0001, E9FF,0002, DFFF,0003, FFFF

$B4:8D39             db 00

; Room $D0B9, state $D0C6: Enemy set name
$B4:8D3A             db 4D,4C,31,5F,30,38,20 ; "ML1_08 "

; Room $D0B9, state $D0C6: Enemy set
$B4:8D41             dw E8BF,0001, D77F,0003, FFFF

$B4:8D4B             db 00

; Room $D913, state $D920: Enemy set name
$B4:8D4C             db 4D,4C,32,5F,32,35,20 ; "ML2_25 "

; Room $D913, state $D920: Enemy set
$B4:8D53             dw D37F,0001, D8FF,0002, FFFF

$B4:8D5D             db 00

; Room $D13B, state $D148: Enemy set name
$B4:8D5E             db 4D,4C,31,5F,31,30,20 ; "ML1_10 "

; Room $D13B, state $D148: Enemy set
$B4:8D65             dw D3BF,0001, F193,0002, FFFF

$B4:8D6F             db 00

; Room $D1A3, state $D1B0: Enemy set name
$B4:8D70             db 4D,4C,31,5F,31,32,20 ; "ML1_12 "

; Room $D1A3, state $D1B0: Enemy set
$B4:8D77             dw D77F,0001, FFFF

$B4:8D7D             db 00

; Room $D30B, state $D318: Enemy set name
$B4:8D7E             db 4D,4C,31,5F,31,39,20 ; "ML1_19 "

; Room $D30B, state $D318: Enemy set
$B4:8D85             dw D47F,0003, D03F,0007, FFFF

$B4:8D8F             db 00

; Room $D72A, state $D737: Enemy set name
$B4:8D90             db 4D,4C,32,5F,31,36,20 ; "ML2_16 "

; Room $D72A, state $D737: Enemy set
$B4:8D97             dw D8FF,0001, FFFF

$B4:8D9D             db 00

; Room $D765, state $D772: Enemy set name
$B4:8D9E             db 4D,4C,32,5F,31,37,20 ; "ML2_17 "

; Room $D765, state $D772: Enemy set
$B4:8DA5             dw FFFF

$B4:8DA7             db 00

; Room $D78F, state $D7A1: Enemy set name
; Room $D78F, state $D7BB: Enemy set name
$B4:8DA8             db 4D,4C,32,5F,31,38,20 ; "ML2_18 "

; Room $D78F, state $D7A1: Enemy set
; Room $D78F, state $D7BB: Enemy set
$B4:8DAF             dw FFFF

$B4:8DB1             db 00

; Room $D7E4, state $D7F1: Enemy set name
$B4:8DB2             db 4D,4C,32,5F,31,39,20 ; "ML2_19 "

; Room $D7E4, state $D7F1: Enemy set
$B4:8DB9             dw CFBF,0001, D77F,0001, DA7F,0002, FFFF

$B4:8DC7             db 00

; Room $D81A, state $D827: Enemy set name
$B4:8DC8             db 4D,4C,32,5F,32,30,20 ; "ML2_20 "

; Room $D81A, state $D827: Enemy set
$B4:8DCF             dw FFFF

$B4:8DD1             db 00

; Room $D845, state $D852: Enemy set name
$B4:8DD2             db 4D,4C,32,5F,32,31,20 ; "ML2_21 "

; Room $D845, state $D852: Enemy set
$B4:8DD9             dw FFFF

$B4:8DDB             db 00

; Room $D86E, state $D87B: Enemy set name
$B4:8DDC             db 4D,4C,32,5F,32,32,20 ; "ML2_22 "

; Room $D86E, state $D87B: Enemy set
$B4:8DE3             dw E97F,0001, FFFF

$B4:8DE9             db 00

; Room $D898, state $D8A5: Enemy set name
$B4:8DEA             db 4D,4C,32,5F,32,33,20 ; "ML2_23 "

; Room $D898, state $D8A5: Enemy set
$B4:8DF1             dw E97F,0001, FFFF

$B4:8DF7             db 00

; Room $D8C5, state $D8D7: Enemy set name
; Room $D8C5, state $D8F1: Enemy set name
$B4:8DF8             db 4D,4C,32,5F,32,34,20 ; "ML2_24 "

; Room $D8C5, state $D8D7: Enemy set
; Room $D8C5, state $D8F1: Enemy set
$B4:8DFF             dw F07F,0001, DBBF,0002, FFFF

; Room $DA60, state $DA72: Enemy set name
$B4:8E09             db 00,4D,4C,42,5F,30,30 ; " MLB_00"

; Room $DA60, state $DA72: Enemy set
$B4:8E10             dw DE3F,0007, FFFF

$B4:8E16             db 00

; Room $D5A7, state $D5B4: Enemy set name
$B4:8E17             db 4D,4C,32,5F,30,39,20 ; "ML2_09 "

; Room $D5A7, state $D5B4: Enemy set
$B4:8E1E             dw DBBF,0001, FFFF

$B4:8E24             db 00

; Room $D104, state $D111: Enemy set name
$B4:8E25             db 4D,4C,31,5F,30,39,20 ; "ML1_09 "

; Room $D104, state $D111: Enemy set
$B4:8E2C             dw D6FF,0001, D77F,0001, F1D3,0002, FFFF

$B4:8E3A             db 00

; Room $D2AA, state $D2B7: Enemy set name
$B4:8E3B             db 4D,4C,31,5F,31,37,20 ; "ML1_17 "

; Room $D2AA, state $D2B7: Enemy set
$B4:8E42             dw F753,0001, F453,0002, FFFF

$B4:8E4C             db 00

; Room $D9AA, state $D9B7: Enemy set name
$B4:8E4D             db 4D,4C,32,5F,32,37,20 ; "ML2_27 "

; Room $D9AA, state $D9B7: Enemy set
$B4:8E54             dw FFFF

$B4:8E56             db 00

; Room $D646, state $D653: Enemy set name
$B4:8E57             db 4D,4C,32,5F,31,32,20 ; "ML2_12 "

; Room $D646, state $D653: Enemy set
$B4:8E5E             dw D17F,0001, CFBF,0002, D7FF,0002, FFFF

$B4:8E6C             db 00

; Room $CED2, state $CEDF: Enemy set name
$B4:8E6D             db 4D,4C,31,5F,30,30,20 ; "ML1_00 "

; Room $CED2, state $CEDF: Enemy set
$B4:8E74             dw FFFF

$B4:8E76             db 00

; Room $CEFB, state $CF0D: Enemy set name
; Room $CEFB, state $CF27: Enemy set name
$B4:8E77             db 4D,4C,31,5F,30,31,20 ; "ML1_01 "

; Room $CEFB, state $CF0D: Enemy set
; Room $CEFB, state $CF27: Enemy set
$B4:8E7E             dw F0BF,0007, FFFF

$B4:8E84             db 00

; Room $CF54, state $CF61: Enemy set name
$B4:8E85             db 4D,4C,31,5F,30,32,20 ; "ML1_02 "

; Room $CF54, state $CF61: Enemy set
$B4:8E8C             dw FFFF

$B4:8E8E             db 00

; Room $CF80, state $CF8D: Enemy set name
$B4:8E8F             db 4D,4C,31,5F,30,33,20 ; "ML1_03 "

; Room $CF80, state $CF8D: Enemy set
$B4:8E96             dw CEBF,0001, F1D3,0002, FFFF

$B4:8EA0             db 00

; Room $D055, state $D062: Enemy set name
$B4:8EA1             db 4D,4C,31,5F,30,36,20 ; "ML1_06 "

; Room $D055, state $D062: Enemy set
$B4:8EA8             dw CF3F,0001, FFFF

$B4:8EAE             db 00

; Room $D08A, state $D097: Enemy set name
$B4:8EAF             db 4D,4C,31,5F,30,37,20 ; "ML1_07 "

; Room $D08A, state $D097: Enemy set
$B4:8EB6             dw D77F,0001, FFFF

$B4:8EBC             db 00

; Room $D16D, state $D17A: Enemy set name
$B4:8EBD             db 4D,4C,31,5F,31,31,20 ; "ML1_11 "

; Room $D16D, state $D17A: Enemy set
$B4:8EC4             dw D03F,0001, D17F,0002, FFFF

$B4:8ECE             db 00

; Room $D1DD, state $D1EA: Enemy set name
$B4:8ECF             db 4D,4C,31,5F,31,33,20 ; "ML1_13 "

; Room $D1DD, state $D1EA: Enemy set
$B4:8ED6             dw D03F,0001, D3BF,0002, D6FF,0003, FFFF

$B4:8EE4             db 00

; Room $D252, state $D25F: Enemy set name
$B4:8EE5             db 4D,4C,31,5F,31,35,20 ; "ML1_15 "

; Room $D252, state $D25F: Enemy set
$B4:8EEC             dw D77F,0001, FFFF

$B4:8EF2             db 00

; Room $D27E, state $D28B: Enemy set name
$B4:8EF3             db 4D,4C,31,5F,31,36,20 ; "ML1_16 "

; Room $D27E, state $D28B: Enemy set
$B4:8EFA             dw CFBF,0001, DD3F,0001, FFFF

$B4:8F04             db 00

; Room $D2D9, state $D2E6: Enemy set name
$B4:8F05             db 4D,4C,31,5F,31,38,20 ; "ML1_18 "

; Room $D2D9, state $D2E6: Enemy set
$B4:8F0C             dw CFBF,0001, CEBF,0001, D3BF,0002, FFFF

$B4:8F1A             db 00

; Room $D340, state $D34D: Enemy set name
$B4:8F1B             db 4D,4C,31,5F,32,30,20 ; "ML1_20 "

; Room $D340, state $D34D: Enemy set
$B4:8F22             dw D03F,0001, D3BF,0002, D6FF,0003, FFFF

$B4:8F30             db 00

; Room $D408, state $D415: Enemy set name
$B4:8F31             db 4D,4C,32,5F,30,30,20 ; "ML2_00 "

; Room $D408, state $D415: Enemy set
$B4:8F38             dw D8FF,0001, CFBF,0002, D77F,0002, DBBF,0003, FFFF

$B4:8F4A             db 00

; Room $D461, state $D46E: Enemy set name
$B4:8F4B             db 4D,4C,32,5F,30,32,20 ; "ML2_02 "

; Room $D461, state $D46E: Enemy set
$B4:8F52             dw E63F,0001, FFFF

$B4:8F58             db 00

; Room $D48E, state $D49B: Enemy set name
$B4:8F59             db 4D,4C,32,5F,30,33,20 ; "ML2_03 "

; Room $D48E, state $D49B: Enemy set
$B4:8F60             dw FFFF

$B4:8F62             db 00

; Room $D4C2, state $D4CF: Enemy set name
$B4:8F63             db 4D,4C,32,5F,30,34,20 ; "ML2_04 "

; Room $D4C2, state $D4CF: Enemy set
$B4:8F6A             dw E63F,0001, FFFF

$B4:8F70             db 00

; Room $D54D, state $D55A: Enemy set name
$B4:8F71             db 4D,4C,32,5F,30,37,20 ; "ML2_07 "

; Room $D54D, state $D55A: Enemy set
$B4:8F78             dw E97F,0001, FFFF

$B4:8F7E             db 00

; Room $D57A, state $D587: Enemy set name
$B4:8F7F             db 4D,4C,32,5F,30,38,20 ; "ML2_08 "

; Room $D57A, state $D587: Enemy set
$B4:8F86             dw E97F,0001, FFFF

$B4:8F8C             db 00

; Room $D5EC, state $D5F9: Enemy set name
$B4:8F8D             db 4D,4C,32,5F,31,30,20 ; "ML2_10 "

; Room $D5EC, state $D5F9: Enemy set
$B4:8F94             dw DA7F,0001, FFFF

$B4:8F9A             db 00

; Room $D617, state $D624: Enemy set name
$B4:8F9B             db 4D,4C,32,5F,31,31,20 ; "ML2_11 "

; Room $D617, state $D624: Enemy set
$B4:8FA2             dw D8FF,0001, CFBF,0002, D77F,0002, FFFF

$B4:8FB0             db 00

; Room $D69A, state $D6A7: Enemy set name
$B4:8FB1             db 4D,4C,32,5F,31,33,20 ; "ML2_13 "

; Room $D69A, state $D6A7: Enemy set
$B4:8FB8             dw CFBF,0001, D7FF,0001, FFFF

$B4:8FC2             db 00

; Room $D6D0, state $D6DD: Enemy set name
$B4:8FC3             db 4D,4C,32,5F,31,34,20 ; "ML2_14 "

; Room $D6D0, state $D6DD: Enemy set
$B4:8FCA             dw FFFF

$B4:8FCC             db 00

; Room $D6FD, state $D70A: Enemy set name
$B4:8FCD             db 4D,4C,32,5F,31,35,20 ; "ML2_15 "

; Room $D6FD, state $D70A: Enemy set
$B4:8FD4             dw DA7F,0001, D03F,0002, FFFF

$B4:8FDE             db 00

; Room $D387, state $D394: Enemy set name
$B4:8FDF             db 4D,4C,31,5F,32,31,20 ; "ML1_21 "

; Room $D387, state $D394: Enemy set
$B4:8FE6             dw D3BF,0001, CFBF,0002, CEBF,0002, FFFF

$B4:8FF4             db 00

; Room $D3DF, state $D3EC: Enemy set name
$B4:8FF5             db 4D,4C,31,5F,32,33,20 ; "ML1_23 "

; Room $D3DF, state $D3EC: Enemy set
$B4:8FFC             dw FFFF

$B4:8FFE             db 00

; Room $D9D4, state $D9E1: Enemy set name
$B4:8FFF             db 4D,4C,32,5F,32,38,20 ; "ML2_28 "

; Room $D9D4, state $D9E1: Enemy set
$B4:9006             dw FFFF

$B4:9008             db 00

; Room $D3B6, state $D3C3: Enemy set name
$B4:9009             db 4D,4C,31,5F,32,32,20 ; "ML1_22 "

; Room $D3B6, state $D3C3: Enemy set
$B4:9010             dw FFFF

$B4:9012             db 00

; Room $D21C, state $D229: Enemy set name
$B4:9013             db 4D,4C,31,5F,31,34,20 ; "ML1_14 "

; Room $D21C, state $D229: Enemy set
$B4:901A             dw D77F,0001, FFFF

$B4:9020             db 00

; Room $D95E, state $D970: Enemy set name
; Room $D95E, state $D98A: Enemy set name
$B4:9021             db 4D,4C,32,5F,32,36,20 ; "ML2_26 "

; Room $D95E, state $D970: Enemy set
; Room $D95E, state $D98A: Enemy set
$B4:9028             dw D03F,0001, F293,0007, FFFF

$B4:9032             db 00

; Room $CFC9, state $CFD6: Enemy set name
$B4:9033             db 4D,4C,31,5F,30,34,20 ; "ML1_04 "

; Room $CFC9, state $CFD6: Enemy set
$B4:903A             dw D6FF,0001, D77F,0002, FFFF

$B4:9044             db 00

; Room $D433, state $D440: Enemy set name
$B4:9045             db 4D,4C,32,5F,30,31,20 ; "ML2_01 "

; Room $D433, state $D440: Enemy set
$B4:904C             dw E7BF,0001, DA7F,0007, FFFF

$B4:9056             db 00

; Room $D51E, state $D52B: Enemy set name
$B4:9057             db 4D,4C,32,5F,30,36,20 ; "ML2_06 "

; Room $D51E, state $D52B: Enemy set
$B4:905E             dw DFBF,0001, FFFF

$B4:9064             db 00

; Room $D4EF, state $D4FC: Enemy set name
$B4:9065             db 4D,4C,32,5F,30,35,20 ; "ML2_05 "

; Room $D4EF, state $D4FC: Enemy set
$B4:906C             dw DFBF,0001, FFFF

$B4:9072             db 00

; Room $D9FE, state $DA0B: Enemy set name
$B4:9073             db 4D,4C,32,5F,32,39,20 ; "ML2_29 "

; Room $D9FE, state $DA0B: Enemy set
$B4:907A             dw CFFF,0007, DA7F,0007, FFFF

$B4:9084             db 00

; Room $DA2B, state $DA38: Enemy set name
$B4:9085             db 4D,4C,32,5F,33,30,20 ; "ML2_30 "

; Room $DA2B, state $DA38: Enemy set
$B4:908C             dw CFFF,0001, DA7F,0001, FFFF

$B4:9096             db 00

; Room $D017, state $D024: Enemy set name
$B4:9097             db 4D,4C,31,5F,30,35,20 ; "ML1_05 "

; Room $D017, state $D024: Enemy set
$B4:909E             dw D6FF,0001, F753,0002, FFFF

$B4:90A8             db 00

; Room $DEDE, state $DEEB: Enemy set name
$B4:90A9             db 54,53,31,5F,31,37,20 ; "TS1_17 "

; Room $DEDE, state $DEEB: Enemy set
$B4:90B0             dw F493,0001, F793,0002, FFFF

$B4:90BA             db 00

; Room $DE23, state $DE30: Enemy set name
$B4:90BB             db 54,53,31,5F,31,33,20 ; "TS1_13 "

; Room $DE23, state $DE30: Enemy set
$B4:90C2             dw FFFF

$B4:90C4             db 00

; Room $DAE1, state $DAF3: Enemy set name
$B4:90C5             db 54,53,31,5F,30,31,20 ; "TS1_01 "

; Room $DAE1, state $DAF3: Enemy set
$B4:90CC             dw DD7F,0001, D23F,0002, FFFF

$B4:90D6             db 00

; Room $DC65, state $DC77: Enemy set name
; Room $DC65, state $DC91: Enemy set name
$B4:90D7             db 54,53,31,5F,30,36,20 ; "TS1_06 "

; Room $DC65, state $DC77: Enemy set
; Room $DC65, state $DC91: Enemy set
$B4:90DE             dw ED3F,0001, FFFF

$B4:90E4             db 00

; Room $DCB1, state $DCC3: Enemy set name
; Room $DCB1, state $DCDD: Enemy set name
$B4:90E5             db 54,53,31,5F,30,37,20 ; "TS1_07 "

; Room $DCB1, state $DCC3: Enemy set
; Room $DCB1, state $DCDD: Enemy set
$B4:90EC             dw ED7F,0001, EDBF,0001, EEBF,0001, FFFF

$B4:90FA             db 00

; Room $DD58, state $DD6E: Enemy set name
; Room $DD58, state $DD88: Enemy set name
$B4:90FB             db 54,53,31,5F,31,30,20 ; "TS1_10 "

; Room $DD58, state $DD6E: Enemy set
; Room $DD58, state $DD88: Enemy set
$B4:9102             dw EC3F,0001, D23F,0002, EC7F,D001, FFFF

$B4:9110             db 00

; Room $DDC4, state $DDD1: Enemy set name
$B4:9111             db 54,53,31,5F,31,31,20 ; "TS1_11 "

; Room $DDC4, state $DDD1: Enemy set
$B4:9118             dw FFFF

$B4:911A             db 00

; Room $DC19, state $DC2B: Enemy set name
; Room $DC19, state $DC45: Enemy set name
$B4:911B             db 54,53,31,5F,30,35,20 ; "TS1_05 "

; Room $DC19, state $DC2B: Enemy set
; Room $DC19, state $DC45: Enemy set
$B4:9122             dw D9FF,0001, FFFF

$B4:9128             db 00

; Room $DE4D, state $DE5A: Enemy set name
$B4:9129             db 54,53,31,5F,31,34,20 ; "TS1_14 "

; Room $DE4D, state $DE5A: Enemy set
$B4:9130             dw D5BF,0001, FFFF

$B4:9136             db 00

; Room $DAAE, state $DABB: Enemy set name
$B4:9137             db 54,53,31,5F,30,30,20 ; "TS1_00 "

; Room $DAAE, state $DABB: Enemy set
$B4:913E             dw FFFF

$B4:9140             db 00

; Room $DB31, state $DB43: Enemy set name
$B4:9141             db 54,53,31,5F,30,32,20 ; "TS1_02 "

; Room $DB31, state $DB43: Enemy set
$B4:9148             dw DD7F,0001, D23F,0002, FFFF

$B4:9152             db 00

; Room $DBCD, state $DBDF: Enemy set name
$B4:9153             db 54,53,31,5F,30,34,20 ; "TS1_04 "

; Room $DBCD, state $DBDF: Enemy set
$B4:915A             dw DD7F,0001, D23F,0002, FFFF

$B4:9164             db 00

; Room $DAE1, state $DB0D: Enemy set name
$B4:9165             db 54,53,31,5F,30,31,20 ; "TS1_01 "

; Room $DAE1, state $DB0D: Enemy set
$B4:916C             dw D23F,0002, FFFF

$B4:9172             db 00

; Room $DB31, state $DB5D: Enemy set name
$B4:9173             db 54,53,31,5F,30,32,20 ; "TS1_02 "

; Room $DB31, state $DB5D: Enemy set
$B4:917A             dw D23F,0002, FFFF

$B4:9180             db 00

; Room $DE7A, state $DE87: Enemy set name
$B4:9181             db 54,53,31,5F,31,35,20 ; "TS1_15 "

; Room $DE7A, state $DE87: Enemy set
$B4:9188             dw F493,0001, FFFF

$B4:918E             db 00

; Room $DB7D, state $DBA9: Enemy set name
$B4:918F             db 54,53,31,5F,30,33,20 ; "TS1_03 "

; Room $DB7D, state $DBA9: Enemy set
$B4:9196             dw D23F,0002, FFFF

$B4:919C             db 00

; Room $DBCD, state $DBF9: Enemy set name
$B4:919D             db 54,53,31,5F,30,34,20 ; "TS1_04 "

; Room $DBCD, state $DBF9: Enemy set
$B4:91A4             dw D23F,0002, FFFF

$B4:91AA             db 00

; Room $DEA7, state $DEB4: Enemy set name
$B4:91AB             db 54,53,31,5F,31,36,20 ; "TS1_16 "

; Room $DEA7, state $DEB4: Enemy set
$B4:91B2             dw F793,0001, D4FF,0002, FFFF

$B4:91BC             db 00

; Room $DCFF, state $DD0C: Enemy set name
$B4:91BD             db 54,53,31,5F,30,38,20 ; "TS1_08 "

; Room $DCFF, state $DD0C: Enemy set
$B4:91C4             dw FFFF

$B4:91C6             db 00

; Room $DD2E, state $DD3B: Enemy set name
$B4:91C7             db 54,53,31,5F,30,39,20 ; "TS1_09 "

; Room $DD2E, state $DD3B: Enemy set
$B4:91CE             dw FFFF

$B4:91D0             db 00

; Unused enemy set name
$B4:91D1             db 54,53,31,5F,30,37,20 ; "TS1_07 "

; Unused enemy set
$B4:91D8             dw ED7F,0001, EDBF,0001, EEBF,0001, FFFF

$B4:91E6             db 00

; Room $DF1B, state $DF28: Enemy set name
$B4:91E7             db 54,53,31,5F,31,38,20 ; "TS1_18 "

; Room $DF1B, state $DF28: Enemy set
$B4:91EE             dw FFFF

$B4:91F0             db 00

; Room $DB7D, state $DB8F: Enemy set name
$B4:91F1             db 54,53,31,5F,30,33,20 ; "TS1_03 "

; Room $DB7D, state $DB8F: Enemy set
$B4:91F8             dw DD7F,0001, D23F,0002, FFFF

$B4:9202             db 00

; Room $DDF3, state $DE00: Enemy set name
$B4:9203             db 54,53,31,5F,31,32,20 ; "TS1_12 "

; Room $DDF3, state $DE00: Enemy set
$B4:920A             dw D23F,0002, FFFF

$B4:9210             db 00

; Room $DF45, state $DF57: Enemy set name
$B4:9211             db 63,6C,31,5F,30,30,20 ; "cl1_00 "

; Room $DF45, state $DF57: Enemy set
$B4:9218             dw E23F,D002, FFFF

$B4:921E             db 00

; Room $DF8D, state $DF9F: Enemy set name
$B4:921F             db 63,6C,31,5F,30,31,20 ; "cl1_01 "

; Room $DF8D, state $DF9F: Enemy set
$B4:9226             dw E23F,D002, FFFF

$B4:922C             db 00

; Room $DFD7, state $DFE9: Enemy set name
$B4:922D             db 63,6C,31,5F,30,32,20 ; "cl1_02 "

; Room $DFD7, state $DFE9: Enemy set
$B4:9234             dw E23F,D002, FFFF

$B4:923A             db 00

; Room $E021, state $E033: Enemy set name
$B4:923B             db 63,6C,31,5F,30,33,20 ; "cl1_03 "

; Room $E021, state $E033: Enemy set
$B4:9242             dw E23F,D002, FFFF

$B4:9248             db 00

; Room $E06B, state $E07D: Enemy set name
$B4:9249             db 63,6C,31,5F,30,34,20 ; "cl1_04 "

; Room $E06B, state $E07D: Enemy set
$B4:9250             dw E23F,D002, FFFF

$B4:9256             db 00

; Room $E0B5, state $E0C7: Enemy set name
$B4:9257             db 63,6C,31,5F,30,35,20 ; "cl1_05 "

; Room $E0B5, state $E0C7: Enemy set
$B4:925E             dw E13F,0001, E23F,D002, FFFF

$B4:9268             db 00

; Room $DF45, state $DF71: Enemy set name
$B4:9269             db 63,6C,31,5F,30,30,20 ; "cl1_00 "

; Room $DF45, state $DF71: Enemy set
$B4:9270             dw E23F,D002, FFFF

$B4:9276             db 00

; Room $DF8D, state $DFB9: Enemy set name
$B4:9277             db 63,6C,31,5F,30,31,20 ; "cl1_01 "

; Room $DF8D, state $DFB9: Enemy set
$B4:927E             dw E23F,D002, FFFF

$B4:9284             db 00

; Room $DFD7, state $E003: Enemy set name
$B4:9285             db 63,6C,31,5F,30,32,20 ; "cl1_02 "

; Room $DFD7, state $E003: Enemy set
$B4:928C             dw E23F,D002, FFFF

$B4:9292             db 00

; Room $E021, state $E04D: Enemy set name
$B4:9293             db 63,6C,31,5F,30,33,20 ; "cl1_03 "

; Room $E021, state $E04D: Enemy set
$B4:929A             dw E23F,D002, FFFF

$B4:92A0             db 00

; Room $E06B, state $E097: Enemy set name
$B4:92A1             db 63,6C,31,5F,30,34,20 ; "cl1_04 "

; Room $E06B, state $E097: Enemy set
$B4:92A8             dw E23F,D002, FFFF

$B4:92AE             db 00

; Room $E0B5, state $E0E1: Enemy set name
$B4:92AF             db 63,6C,31,5F,30,35,20 ; "cl1_05 "

; Room $E0B5, state $E0E1: Enemy set
$B4:92B6             dw E23F,D002, FFFF

; Room $E82C, state $E839: Enemy set name
$B4:92BC             db 00,54,54,5F,30,30,20 ; " TT_00 "

; Room $E82C, state $E839: Enemy set
$B4:92C3             dw FFFF

$B4:92C5             db 00
}


;;; $92C6..A200: Debug handler ;;;
{
;;; $92C6: Debug handler - [debug index] = 7: enemy debugger - enemy spawn data editor ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame
$B4:92C6 20 46 96    JSR $9646  [$B4:9646]  ; Handle cursor movement
$B4:92C9 20 AB 96    JSR $96AB  [$B4:96AB]  ; Handle digit modification
$B4:92CC A9 00 08    LDA #$0800             ;\
$B4:92CF 85 26       STA $26    [$7E:0026]  ;|
$B4:92D1 AD 60 18    LDA $1860  [$7E:1860]  ;|
$B4:92D4 85 14       STA $14    [$7E:0014]  ;|
$B4:92D6 AD 62 18    LDA $1862  [$7E:1862]  ;} Add debug spritemap index 1Ch to OAM at position ([$1860], [$1862]) with palette 4 (text cursor)
$B4:92D9 85 12       STA $12    [$7E:0012]  ;|
$B4:92DB A9 1C 00    LDA #$001C             ;|
$B4:92DE 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:92E2 A9 00 0A    LDA #$0A00             ;\
$B4:92E5 85 26       STA $26    [$7E:0026]  ;|
$B4:92E7 A9 B0 00    LDA #$00B0             ;|
$B4:92EA 85 14       STA $14    [$7E:0014]  ;|
$B4:92EC A9 48 00    LDA #$0048             ;} Add debug spritemap index 2Fh to OAM at position (B0h, 48h) with palette 5 (enemy spawn data editor text)
$B4:92EF 85 12       STA $12    [$7E:0012]  ;|
$B4:92F1 A9 2F 00    LDA #$002F             ;|
$B4:92F4 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:92F8 A9 00 0A    LDA #$0A00             ;\
$B4:92FB 85 26       STA $26    [$7E:0026]  ;} Debug spritemap palette = 5
$B4:92FD A9 B0 00    LDA #$00B0             ;\
$B4:9300 85 14       STA $14    [$7E:0014]  ;} Debug spritemap X position = B0h
$B4:9302 A9 48 00    LDA #$0048             ;\
$B4:9305 85 12       STA $12    [$7E:0012]  ;} Debug spritemap Y position = 48h
$B4:9307 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:930A BD 78 0F    LDA $0F78,x            ;|
$B4:930D AA          TAX                    ;} If [debug enemy name] = 0:
$B4:930E BF 3E 00 A0 LDA $A0003E,x          ;|
$B4:9312 D0 05       BNE $05    [$9319]     ;/
$B4:9314 A9 30 00    LDA #$0030             ; Debug spritemap index = 30h
$B4:9317 80 09       BRA $09    [$9322]

$B4:9319 AA          TAX                    ;\ Else ([debug enemy name] != 0):
$B4:931A BF 0C 00 B4 LDA $B4000C,x          ;|
$B4:931E 18          CLC                    ;} Debug spritemap index = 30h + [[debug enemy name] + Ch]
$B4:931F 69 30 00    ADC #$0030             ;/

$B4:9322 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ; Add debug spritemap to OAM
$B4:9326 20 6D 93    JSR $936D  [$B4:936D]  ; Draw debug enemy spawn values
$B4:9329 A5 91       LDA $91    [$7E:0091]  ;\
$B4:932B 89 10 00    BIT #$0010             ;} If controller 2 newly pressed R:
$B4:932E F0 07       BEQ $07    [$9337]     ;/
$B4:9330 9C 5C 18    STZ $185C  [$7E:185C]  ; Debug index = 0
$B4:9333 A9 01 00    LDA #$0001             ;\
$B4:9336 60          RTS                    ;} Return A = 1

$B4:9337 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9339 89 00 20    BIT #$2000             ;} If controller 2 newly pressed select:
$B4:933C F0 06       BEQ $06    [$9344]     ;/
$B4:933E EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = 8
$B4:9341 9C 5E 18    STZ $185E  [$7E:185E]  ; Enemy time is frozen flag = 0

$B4:9344 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9346 89 80 00    BIT #$0080             ;} If controller 2 newly pressed A:
$B4:9349 F0 11       BEQ $11    [$935C]     ;/
$B4:934B AE 46 18    LDX $1846  [$7E:1846]
$B4:934E BD 7A 0F    LDA $0F7A,x            ;\
$B4:9351 9F 20 70 7E STA $7E7020,x          ;} Debug enemy spawn X position = [debug enemy X position]
$B4:9355 BD 7E 0F    LDA $0F7E,x            ;\
$B4:9358 9F 22 70 7E STA $7E7022,x          ;} Debug enemy spawn Y position = [debug enemy Y position]

$B4:935C A5 91       LDA $91    [$7E:0091]  ;\
$B4:935E 89 20 00    BIT #$0020             ;} If controller 2 newly pressed L:
$B4:9361 F0 06       BEQ $06    [$9369]     ;/
$B4:9363 EE 5C 18    INC $185C  [$7E:185C]  ;\
$B4:9366 EE 5C 18    INC $185C  [$7E:185C]  ;} Debug index = 9

$B4:9369 A9 01 00    LDA #$0001             ;\
$B4:936C 60          RTS                    ;} Return A = 1
}


;;; $936D: Draw debug enemy spawn values ;;;
{
; When drawn with the text, result looks like:
;     PosX: [X position]
;     PosY: [Y position]
;     Pose: [initialisation parameter]
;     Swt1: [properties]
;     Swt2: [extra properties]
;     Opt0: [parameter 1]
;     Opt1: [parameter 2]
$B4:936D AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9370 BF 20 70 7E LDA $7E7020,x          ;|
$B4:9374 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9377 A9 C8 00    LDA #$00C8             ;|
$B4:937A 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy spawn X position] at position (C8h, 38h)
$B4:937D A9 38 00    LDA #$0038             ;|
$B4:9380 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9383 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9386 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9389 BF 22 70 7E LDA $7E7022,x          ;|
$B4:938D 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9390 A9 C8 00    LDA #$00C8             ;|
$B4:9393 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy spawn Y position] at position (C8h, 40h)
$B4:9396 A9 40 00    LDA #$0040             ;|
$B4:9399 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:939C 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:939F AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:93A2 BF 24 70 7E LDA $7E7024,x          ;|
$B4:93A6 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:93A9 A9 C8 00    LDA #$00C8             ;|
$B4:93AC 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy spawn initialisation parameter] at position (C8h, 48h)
$B4:93AF A9 48 00    LDA #$0048             ;|
$B4:93B2 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:93B5 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:93B8 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:93BB BF 26 70 7E LDA $7E7026,x          ;|
$B4:93BF 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:93C2 A9 C8 00    LDA #$00C8             ;|
$B4:93C5 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy spawn properties] at position (C8h, 50h)
$B4:93C8 A9 50 00    LDA #$0050             ;|
$B4:93CB 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:93CE 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:93D1 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:93D4 BF 28 70 7E LDA $7E7028,x          ;|
$B4:93D8 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:93DB A9 C8 00    LDA #$00C8             ;|
$B4:93DE 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy spawn extra properties] at position (C8h, 58h)
$B4:93E1 A9 58 00    LDA #$0058             ;|
$B4:93E4 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:93E7 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:93EA AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:93ED BF 2A 70 7E LDA $7E702A,x          ;|
$B4:93F1 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:93F4 A9 C8 00    LDA #$00C8             ;|
$B4:93F7 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy spawn parameter 1] at position (C8h, 60h)
$B4:93FA A9 60 00    LDA #$0060             ;|
$B4:93FD 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9400 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9403 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9406 BF 2C 70 7E LDA $7E702C,x          ;|
$B4:940A 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:940D A9 C8 00    LDA #$00C8             ;|
$B4:9410 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy spawn parameter 2] at position (C8h, 68h)
$B4:9413 A9 68 00    LDA #$0068             ;|
$B4:9416 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9419 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:941C 60          RTS
}


;;; $941D: Debug. Draw enemy set name ;;;
{
$B4:941D DA          PHX
$B4:941E A9 00 0A    LDA #$0A00             ;\
$B4:9421 85 26       STA $26    [$7E:0026]  ;|
$B4:9423 A9 B0 00    LDA #$00B0             ;|
$B4:9426 85 14       STA $14    [$7E:0014]  ;|
$B4:9428 A9 58 00    LDA #$0058             ;|
$B4:942B 85 12       STA $12    [$7E:0012]  ;} Add debug spritemap index (14h + [area index]) to OAM at position (B0h, 58h) with palette 5
$B4:942D AD 9F 07    LDA $079F  [$7E:079F]  ;|
$B4:9430 18          CLC                    ;|
$B4:9431 69 14 00    ADC #$0014             ;|
$B4:9434 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9438 AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$B4:943B 38          SEC                    ;|
$B4:943C E9 07 00    SBC #$0007             ;|
$B4:943F AA          TAX                    ;|
$B4:9440 BF 02 00 B4 LDA $B40002,x          ;|
$B4:9444 29 FF 00    AND #$00FF             ;|
$B4:9447 38          SEC                    ;|
$B4:9448 E9 2C 00    SBC #$002C             ;|
$B4:944B 85 16       STA $16    [$7E:0016]  ;} Add debug spritemap index ([[enemy set pointer] - 7 + 2] - 2Ch) to OAM at position (A8h, 58h) with palette 5
$B4:944D A9 00 0A    LDA #$0A00             ;|
$B4:9450 85 26       STA $26    [$7E:0026]  ;|
$B4:9452 A9 A8 00    LDA #$00A8             ;|
$B4:9455 85 14       STA $14    [$7E:0014]  ;|
$B4:9457 A9 58 00    LDA #$0058             ;|
$B4:945A 85 12       STA $12    [$7E:0012]  ;|
$B4:945C A5 16       LDA $16    [$7E:0016]  ;|
$B4:945E 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9462 AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$B4:9465 38          SEC                    ;|
$B4:9466 E9 07 00    SBC #$0007             ;|
$B4:9469 AA          TAX                    ;|
$B4:946A BF 04 00 B4 LDA $B40004,x          ;|
$B4:946E 29 FF 00    AND #$00FF             ;|
$B4:9471 38          SEC                    ;|
$B4:9472 E9 2C 00    SBC #$002C             ;|
$B4:9475 85 16       STA $16    [$7E:0016]  ;} Add debug spritemap index ([[enemy set pointer] - 7 + 4] - 2Ch) to OAM at position (B8h, 58h) with palette 5
$B4:9477 A9 00 0A    LDA #$0A00             ;|
$B4:947A 85 26       STA $26    [$7E:0026]  ;|
$B4:947C A9 B8 00    LDA #$00B8             ;|
$B4:947F 85 14       STA $14    [$7E:0014]  ;|
$B4:9481 A9 58 00    LDA #$0058             ;|
$B4:9484 85 12       STA $12    [$7E:0012]  ;|
$B4:9486 A5 16       LDA $16    [$7E:0016]  ;|
$B4:9488 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:948C AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$B4:948F 38          SEC                    ;|
$B4:9490 E9 07 00    SBC #$0007             ;|
$B4:9493 AA          TAX                    ;|
$B4:9494 BF 05 00 B4 LDA $B40005,x          ;|
$B4:9498 29 FF 00    AND #$00FF             ;|
$B4:949B 38          SEC                    ;|
$B4:949C E9 2C 00    SBC #$002C             ;|
$B4:949F 85 16       STA $16    [$7E:0016]  ;} Add debug spritemap index ([[enemy set pointer] - 7 + 5] - 2Ch) to OAM at position (C0h, 58h) with palette 5
$B4:94A1 A9 00 0A    LDA #$0A00             ;|
$B4:94A4 85 26       STA $26    [$7E:0026]  ;|
$B4:94A6 A9 C0 00    LDA #$00C0             ;|
$B4:94A9 85 14       STA $14    [$7E:0014]  ;|
$B4:94AB A9 58 00    LDA #$0058             ;|
$B4:94AE 85 12       STA $12    [$7E:0012]  ;|
$B4:94B0 A5 16       LDA $16    [$7E:0016]  ;|
$B4:94B2 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:94B6 FA          PLX
$B4:94B7 60          RTS
}


;;; $94B8: Debug handler - [debug index] = 8: enemy debugger - respawn enemy ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame
$B4:94B8 8B          PHB
$B4:94B9 F4 7E 7E    PEA $7E7E              ;\
$B4:94BC AB          PLB                    ;} DB = $7E
$B4:94BD AB          PLB                    ;/
$B4:94BE A9 1E 70    LDA #$701E             ;\
$B4:94C1 18          CLC                    ;|
$B4:94C2 6D 46 18    ADC $1846  [$7E:1846]  ;} X = $701E + [debug enemy index]
$B4:94C5 AA          TAX                    ;/
$B4:94C6 AC 46 18    LDY $1846  [$7E:1846]  ; Y = [debug enemy index]
$B4:94C9 22 4B 92 A0 JSL $A0924B[$A0:924B]  ; Spawn enemy to enemy index [Y]
$B4:94CD AB          PLB
$B4:94CE 9C 5C 18    STZ $185C  [$7E:185C]  ; Debug index = 0
$B4:94D1 A9 01 00    LDA #$0001             ; Return A = 1
$B4:94D4 60          RTS
}


;;; $94D5: Debug handler - [debug index] = 9: enemy debugger - enemy spawner ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame
$B4:94D5 AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$B4:94D8 AA          TAX                    ;} $0E26 = [enemy set pointer] (enemy set entry pointer)
$B4:94D9 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$B4:94DC AE 26 0E    LDX $0E26  [$7E:0E26]  ;\
$B4:94DF A9 38 00    LDA #$0038             ;} $0E2A = 38h (row Y position)
$B4:94E2 8D 2A 0E    STA $0E2A  [$7E:0E2A]  ;/

; LOOP
$B4:94E5 AE 26 0E    LDX $0E26  [$7E:0E26]  ;\
$B4:94E8 BF 00 00 B4 LDA $B40000,x          ;|
$B4:94EC C9 FF FF    CMP #$FFFF             ;} If enemy set entry enemy ID != FFFFh:
$B4:94EF F0 5B       BEQ $5B    [$954C]     ;/
$B4:94F1 AA          TAX                    ;\
$B4:94F2 BF 3E 00 A0 LDA $A0003E,x          ;|
$B4:94F6 AA          TAX                    ;|
$B4:94F7 BF 0C 00 B4 LDA $B4000C,x          ;} $16 = [$B4:000C + enemy set entry enemy name] + 30h
$B4:94FB 18          CLC                    ;|
$B4:94FC 69 30 00    ADC #$0030             ;|
$B4:94FF 85 16       STA $16    [$7E:0016]  ;/
$B4:9501 A9 00 0A    LDA #$0A00             ;\
$B4:9504 85 26       STA $26    [$7E:0026]  ;|
$B4:9506 A9 A8 00    LDA #$00A8             ;|
$B4:9509 85 14       STA $14    [$7E:0014]  ;|
$B4:950B AD 2A 0E    LDA $0E2A  [$7E:0E2A]  ;|
$B4:950E 18          CLC                    ;} Add debug spritemap index [$16] to OAM at position (A8h, [$0E2A] + 18h) with palette 5
$B4:950F 69 18 00    ADC #$0018             ;|
$B4:9512 85 12       STA $12    [$7E:0012]  ;|
$B4:9514 A5 16       LDA $16    [$7E:0016]  ;|
$B4:9516 29 FF 00    AND #$00FF             ;|
$B4:9519 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:951D AE 26 0E    LDX $0E26  [$7E:0E26]  ;\
$B4:9520 BF 02 00 B4 LDA $B40002,x          ;|
$B4:9524 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9527 A9 D8 00    LDA #$00D8             ;|
$B4:952A 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value (enemy set entry palette index) at position (D8h, [$0E2A])
$B4:952D AD 2A 0E    LDA $0E2A  [$7E:0E2A]  ;|
$B4:9530 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9533 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9536 AD 2A 0E    LDA $0E2A  [$7E:0E2A]  ;\
$B4:9539 18          CLC                    ;|
$B4:953A 69 08 00    ADC #$0008             ;} $0E2A += 8 (next row)
$B4:953D 8D 2A 0E    STA $0E2A  [$7E:0E2A]  ;/
$B4:9540 AD 26 0E    LDA $0E26  [$7E:0E26]  ;\
$B4:9543 18          CLC                    ;|
$B4:9544 69 04 00    ADC #$0004             ;} $0E26 += 4 (next enemy set entry)
$B4:9547 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$B4:954A 80 99       BRA $99    [$94E5]     ; Go to LOOP

$B4:954C A9 00 0A    LDA #$0A00
$B4:954F 85 26       STA $26    [$7E:0026]
$B4:9551 A9 B0 00    LDA #$00B0
$B4:9554 85 14       STA $14    [$7E:0014]
$B4:9556 A9 48 00    LDA #$0048
$B4:9559 85 12       STA $12    [$7E:0012]
$B4:955B AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:955E BF 1E 70 7E LDA $7E701E,x          ;} If [debug enemy spawn ID] = 0:
$B4:9562 D0 05       BNE $05    [$9569]     ;/
$B4:9564 A9 30 00    LDA #$0030             ; A = 30h
$B4:9567 80 15       BRA $15    [$957E]     ; Go to BRANCH_RESOLVED_NAME

$B4:9569 AA          TAX                    ;\
$B4:956A BF 3E 00 A0 LDA $A0003E,x          ;} If debug enemy name = 0:
$B4:956E D0 05       BNE $05    [$9575]     ;/
$B4:9570 A9 30 00    LDA #$0030             ; A = 30h
$B4:9573 80 09       BRA $09    [$957E]     ; Go to BRANCH_RESOLVED_NAME

$B4:9575 AA          TAX                    ;\
$B4:9576 BF 0C 00 B4 LDA $B4000C,x          ;\
$B4:957A 18          CLC                    ;} A = [$B4:000C + debug enemy name] + 30h
$B4:957B 69 30 00    ADC #$0030             ;/

; BRANCH_RESOLVED_NAME
$B4:957E 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ; Add debug spritemap index [A] to OAM at position (B0h, 48h) with palette 5
$B4:9582 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9584 89 00 04    BIT #$0400             ;} If controller 2 newly pressed down:
$B4:9587 F0 12       BEQ $12    [$959B]     ;/
$B4:9589 AD 64 18    LDA $1864  [$7E:1864]  ;\
$B4:958C 18          CLC                    ;|
$B4:958D 69 04 00    ADC #$0004             ;|
$B4:9590 C9 10 00    CMP #$0010             ;|
$B4:9593 D0 03       BNE $03    [$9598]     ;} Debug enemy set entry index = ([debug enemy set entry index] + 4) % 10h
$B4:9595 A9 00 00    LDA #$0000             ;|
                                            ;|
$B4:9598 8D 64 18    STA $1864  [$7E:1864]  ;/

$B4:959B AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$B4:959E 18          CLC                    ;|
$B4:959F 6D 64 18    ADC $1864  [$7E:1864]  ;|
$B4:95A2 AA          TAX                    ;} If debug enemy set entry enemy ID = FFFFh:
$B4:95A3 BF 00 00 B4 LDA $B40000,x          ;|
$B4:95A7 C9 FF FF    CMP #$FFFF             ;|
$B4:95AA D0 0A       BNE $0A    [$95B6]     ;/
$B4:95AC 9C 64 18    STZ $1864  [$7E:1864]  ; Debug enemy set entry index = 0
$B4:95AF AE D1 07    LDX $07D1  [$7E:07D1]
$B4:95B2 BF 00 00 B4 LDA $B40000,x

$B4:95B6 85 12       STA $12    [$7E:0012]
$B4:95B8 AA          TAX                    ;\
$B4:95B9 BF 3E 00 A0 LDA $A0003E,x          ;|
$B4:95BD AA          TAX                    ;|
$B4:95BE BF 0A 00 B4 LDA $B4000A,x          ;} Debug enemy population pointer = [$B4:000A + [debug enemy set entry name]]
$B4:95C2 AA          TAX                    ;|
$B4:95C3 8E 66 18    STX $1866  [$7E:1866]  ;/
$B4:95C6 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:95C9 A5 12       LDA $12    [$7E:0012]  ;} Debug enemy spawn ID = debug enemy set entry enemy ID
$B4:95CB 9F 1E 70 7E STA $7E701E,x          ;/
$B4:95CF A5 91       LDA $91    [$7E:0091]  ;\
$B4:95D1 89 10 00    BIT #$0010             ;} If controller 2 newly pressed R:
$B4:95D4 F0 07       BEQ $07    [$95DD]     ;/
$B4:95D6 9C 5C 18    STZ $185C  [$7E:185C]  ; Debug index = 0
$B4:95D9 A9 01 00    LDA #$0001             ;\
$B4:95DC 60          RTS                    ;} Return A = 1

$B4:95DD A5 91       LDA $91    [$7E:0091]  ;\
$B4:95DF 89 20 00    BIT #$0020             ;} If controller 2 not newly pressed L:
$B4:95E2 D0 04       BNE $04    [$95E8]     ;/
$B4:95E4 A9 01 00    LDA #$0001             ;\
$B4:95E7 60          RTS                    ;} Return A = 1

$B4:95E8 AE 66 18    LDX $1866  [$7E:1866]
$B4:95EB C9 00 80    CMP #$8000             ;\
$B4:95EE 30 17       BMI $17    [$9607]     ;} If controller 2 newly pressed B:
$B4:95F0 BF 00 00 B4 LDA $B40000,x          ;\
$B4:95F4 AA          TAX                    ;} X = [$B4:0000 + [debug enemy population pointer]] (enemy ID)
$B4:95F5 BF 3E 00 A0 LDA $A0003E,x          ;\
$B4:95F9 AA          TAX                    ;|
$B4:95FA BF 0C 00 B4 LDA $B4000C,x          ;} If [$B4:000C + ([X] enemy name)] = 0:
$B4:95FE D0 07       BNE $07    [$9607]     ;/
$B4:9600 9C 5C 18    STZ $185C  [$7E:185C]  ; Debug index = 0
$B4:9603 A9 01 00    LDA #$0001             ;\
$B4:9606 60          RTS                    ;} Return A = 1

$B4:9607 AC 46 18    LDY $1846  [$7E:1846]  ;\
$B4:960A B9 7A 0F    LDA $0F7A,y            ;} Debug enemy spawn X position = [debug enemy X position]
$B4:960D 8D 68 18    STA $1868  [$7E:1868]  ;/
$B4:9610 B9 7E 0F    LDA $0F7E,y            ;\
$B4:9613 8D 6A 18    STA $186A  [$7E:186A]  ;} Debug enemy spawn Y position = [debug enemy Y position]
$B4:9616 8B          PHB                    ;\
$B4:9617 F4 B4 B4    PEA $B4B4              ;|
$B4:961A AB          PLB                    ;|
$B4:961B AB          PLB                    ;|
$B4:961C AC 46 18    LDY $1846  [$7E:1846]  ;} Spawn enemy with debug enemy population to debug enemy index
$B4:961F AE 66 18    LDX $1866  [$7E:1866]  ;|
$B4:9622 22 4B 92 A0 JSL $A0924B[$A0:924B]  ;|
$B4:9626 AB          PLB                    ;/
$B4:9627 AC 46 18    LDY $1846  [$7E:1846]  ;\
$B4:962A AD 68 18    LDA $1868  [$7E:1868]  ;} Debug enemy X position = [debug enemy spawn X position]
$B4:962D 99 7A 0F    STA $0F7A,y            ;/
$B4:9630 AD 6A 18    LDA $186A  [$7E:186A]  ;\
$B4:9633 99 7E 0F    STA $0F7E,y            ;} Debug enemy Y position = [debug enemy spawn Y position]
$B4:9636 DA          PHX
$B4:9637 5A          PHY
$B4:9638 BB          TYX
$B4:9639 22 D0 88 A0 JSL $A088D0[$A0:88D0]  ; Record enemy spawn data
$B4:963D 7A          PLY
$B4:963E FA          PLX
$B4:963F 9C 5C 18    STZ $185C  [$7E:185C]  ; Debug index = 0
$B4:9642 A9 01 00    LDA #$0001             ;\
$B4:9645 60          RTS                    ;} Return A = 1
}


;;; $9646: Debug. Handle cursor movement ;;;
{
$B4:9646 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9648 89 00 01    BIT #$0100             ;} If controller 2 not newly pressed right: go to BRANCH_NO_RIGHT
$B4:964B F0 14       BEQ $14    [$9661]     ;/
$B4:964D AD 60 18    LDA $1860  [$7E:1860]  ;\
$B4:9650 18          CLC                    ;} Text cursor X position += 8
$B4:9651 69 08 00    ADC #$0008             ;/
$B4:9654 C9 E0 00    CMP #$00E0             ;\
$B4:9657 D0 03       BNE $03    [$965C]     ;} If [text cursor X position] = E0h:
$B4:9659 A9 C0 00    LDA #$00C0             ; Text cursor X position = C0h

$B4:965C 8D 60 18    STA $1860  [$7E:1860]
$B4:965F 80 49       BRA $49    [$96AA]     ; Return

; BRANCH_NO_RIGHT
$B4:9661 89 00 02    BIT #$0200             ;\
$B4:9664 F0 14       BEQ $14    [$967A]     ;} If controller 2 not newly pressed left: go to BRANCH_NO_LEFT
$B4:9666 AD 60 18    LDA $1860  [$7E:1860]  ;\
$B4:9669 38          SEC                    ;} Text cursor X position -= 8
$B4:966A E9 08 00    SBC #$0008             ;/
$B4:966D C9 B8 00    CMP #$00B8             ;\
$B4:9670 D0 03       BNE $03    [$9675]     ;} If [text cursor X position] = B8h:
$B4:9672 A9 D8 00    LDA #$00D8             ; Text cursor X position = D8h

$B4:9675 8D 60 18    STA $1860  [$7E:1860]
$B4:9678 80 30       BRA $30    [$96AA]     ; Return

; BRANCH_NO_LEFT
$B4:967A 89 00 04    BIT #$0400             ;\
$B4:967D F0 14       BEQ $14    [$9693]     ;} If controller 2 not newly pressed down: go to BRANCH_NO_LEFT
$B4:967F AD 62 18    LDA $1862  [$7E:1862]  ;\
$B4:9682 18          CLC                    ;} Text cursor Y position += 8
$B4:9683 69 08 00    ADC #$0008             ;/
$B4:9686 C9 68 00    CMP #$0068             ;\
$B4:9689 D0 03       BNE $03    [$968E]     ;} If [text cursor Y position] = 68h:
$B4:968B A9 30 00    LDA #$0030             ; Text cursor X position = 30h

$B4:968E 8D 62 18    STA $1862  [$7E:1862]
$B4:9691 80 17       BRA $17    [$96AA]     ; Return

; BRANCH_NO_DOWN
$B4:9693 89 00 08    BIT #$0800             ;\
$B4:9696 F0 12       BEQ $12    [$96AA]     ;} If controller 2 not newly pressed up: return
$B4:9698 AD 62 18    LDA $1862  [$7E:1862]  ;\
$B4:969B 38          SEC                    ;} Text cursor Y position -= 8
$B4:969C E9 08 00    SBC #$0008             ;/
$B4:969F C9 28 00    CMP #$0028             ;\
$B4:96A2 D0 03       BNE $03    [$96A7]     ;} If [text cursor Y position] = 28h:
$B4:96A4 A9 60 00    LDA #$0060             ; Text cursor Y position = 60h

$B4:96A7 8D 62 18    STA $1862  [$7E:1862]

$B4:96AA 60          RTS
}


;;; $96AB: Debug. Handle digit modification ;;;
{
$B4:96AB AE 46 18    LDX $1846  [$7E:1846]
$B4:96AE BF 20 70 7E LDA $7E7020,x          ;\
$B4:96B2 85 12       STA $12    [$7E:0012]  ;} $12 = [debug enemy spawn X position]
$B4:96B4 BF 22 70 7E LDA $7E7022,x          ;\
$B4:96B8 85 14       STA $14    [$7E:0014]  ;} $14 = [debug enemy spawn Y position]
$B4:96BA BF 24 70 7E LDA $7E7024,x          ;\
$B4:96BE 85 16       STA $16    [$7E:0016]  ;} $16 = [debug enemy spawn initialisation parameter]
$B4:96C0 BF 26 70 7E LDA $7E7026,x          ;\
$B4:96C4 85 18       STA $18    [$7E:0018]  ;} $18 = [debug enemy spawn properties]
$B4:96C6 BF 28 70 7E LDA $7E7028,x          ;\
$B4:96CA 85 1A       STA $1A    [$7E:001A]  ;} $1A = [debug enemy spawn extra properties]
$B4:96CC BF 2A 70 7E LDA $7E702A,x          ;\
$B4:96D0 85 1C       STA $1C    [$7E:001C]  ;} $1C = [debug enemy spawn parameter 1]
$B4:96D2 BF 2C 70 7E LDA $7E702C,x          ;\
$B4:96D6 85 1E       STA $1E    [$7E:001E]  ;} $1E = [debug enemy spawn parameter 2]
$B4:96D8 A5 91       LDA $91    [$7E:0091]  ;\
$B4:96DA 89 40 00    BIT #$0040             ;} If controller 2 newly pressed X:
$B4:96DD F0 20       BEQ $20    [$96FF]     ;/
$B4:96DF AD 60 18    LDA $1860  [$7E:1860]  ;\
$B4:96E2 38          SEC                    ;|
$B4:96E3 E9 C0 00    SBC #$00C0             ;|
$B4:96E6 4A          LSR A                  ;|
$B4:96E7 4A          LSR A                  ;|
$B4:96E8 AA          TAX                    ;|
$B4:96E9 AD 62 18    LDA $1862  [$7E:1862]  ;|
$B4:96EC 38          SEC                    ;|
$B4:96ED E9 30 00    SBC #$0030             ;} $12 + ([text cursor Y position] - 30h) / 4 += [$9750 + ([text cursor X position] - C0h) / 4]
$B4:96F0 4A          LSR A                  ;|
$B4:96F1 4A          LSR A                  ;|
$B4:96F2 A8          TAY                    ;|
$B4:96F3 B9 12 00    LDA $0012,y            ;|
$B4:96F6 18          CLC                    ;|
$B4:96F7 7D 50 97    ADC $9750,x            ;|
$B4:96FA 99 12 00    STA $0012,y            ;/
$B4:96FD 80 23       BRA $23    [$9722]

$B4:96FF 89 00 80    BIT #$8000             ;\ Else (controller 2 not newly pressed X):
$B4:9702 F0 1E       BEQ $1E    [$9722]     ;} If controller 2 newly pressed B:
$B4:9704 AD 60 18    LDA $1860  [$7E:1860]  ;\
$B4:9707 38          SEC                    ;|
$B4:9708 E9 C0 00    SBC #$00C0             ;|
$B4:970B 4A          LSR A                  ;|
$B4:970C 4A          LSR A                  ;|
$B4:970D AA          TAX                    ;|
$B4:970E AD 62 18    LDA $1862  [$7E:1862]  ;|
$B4:9711 38          SEC                    ;|
$B4:9712 E9 30 00    SBC #$0030             ;} $12 + ([text cursor Y position] - 30h) / 4 -= [$9750 + ([text cursor X position] - C0h) / 4]
$B4:9715 4A          LSR A                  ;|
$B4:9716 4A          LSR A                  ;|
$B4:9717 A8          TAY                    ;|
$B4:9718 B9 12 00    LDA $0012,y            ;|
$B4:971B 38          SEC                    ;|
$B4:971C FD 50 97    SBC $9750,x            ;|
$B4:971F 99 12 00    STA $0012,y            ;/

$B4:9722 AE 46 18    LDX $1846  [$7E:1846]
$B4:9725 A5 12       LDA $12    [$7E:0012]  ;\
$B4:9727 9F 20 70 7E STA $7E7020,x          ;} Debug enemy spawn X position = [$12]
$B4:972B A5 14       LDA $14    [$7E:0014]  ;\
$B4:972D 9F 22 70 7E STA $7E7022,x          ;} Debug enemy spawn Y position = [$14]
$B4:9731 A5 16       LDA $16    [$7E:0016]  ;\
$B4:9733 9F 24 70 7E STA $7E7024,x          ;} Debug enemy spawn initialisation parameter = [$16]
$B4:9737 A5 18       LDA $18    [$7E:0018]  ;\
$B4:9739 9F 26 70 7E STA $7E7026,x          ;} Debug enemy spawn properties = [$18]
$B4:973D A5 1A       LDA $1A    [$7E:001A]  ;\
$B4:973F 9F 28 70 7E STA $7E7028,x          ;} Debug enemy spawn extra properties = [$1A]
$B4:9743 A5 1C       LDA $1C    [$7E:001C]  ;\
$B4:9745 9F 2A 70 7E STA $7E702A,x          ;} Debug enemy spawn parameter 1 = [$1C]
$B4:9749 A5 1E       LDA $1E    [$7E:001E]  ;\
$B4:974B 9F 2C 70 7E STA $7E702C,x          ;} Debug enemy spawn parameter 2 = [$1E]
$B4:974F 60          RTS

$B4:9750             dw 1000, 0100, 0010, 0001
}


;;; $9758: Debug handler - [debug index] = 10h: enemy debugger - enemy allocation viewer ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame

; Shows the palette index of each enemy and total number of VRAM rows required for all enemies
$B4:9758 A5 91       LDA $91    [$7E:0091]  ;\
$B4:975A 89 00 20    BIT #$2000             ;} If controller 2 newly pressed select:
$B4:975D F0 07       BEQ $07    [$9766]     ;/
$B4:975F 9C 5C 18    STZ $185C  [$7E:185C]  ; Debug index = 0
$B4:9762 A9 00 00    LDA #$0000             ;\
$B4:9765 60          RTS                    ;} Return A = 0

$B4:9766 AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$B4:9769 AA          TAX                    ;} $0E26 = [enemy set pointer] (enemy set entry pointer)
$B4:976A 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$B4:976D AE 26 0E    LDX $0E26  [$7E:0E26]
$B4:9770 A9 38 00    LDA #$0038             ;\
$B4:9773 8D 2A 0E    STA $0E2A  [$7E:0E2A]  ;} $0E2A = 38h (row Y position)
$B4:9776 9C 2C 0E    STZ $0E2C  [$7E:0E2C]  ; $0E2C = 0 (rows of VRAM)

; LOOP
$B4:9779 AE 26 0E    LDX $0E26  [$7E:0E26]  ;\
$B4:977C BF 00 00 B4 LDA $B40000,x          ;|
$B4:9780 C9 FF FF    CMP #$FFFF             ;} If enemy set entry enemy ID != FFFFh:
$B4:9783 F0 6B       BEQ $6B    [$97F0]     ;/
$B4:9785 AA          TAX                    ;\
$B4:9786 BF 00 00 A0 LDA $A00000,x          ;|
$B4:978A EB          XBA                    ;|
$B4:978B 29 FF 00    AND #$00FF             ;|
$B4:978E 4A          LSR A                  ;} $0E2C += (enemy set entry enemy tile data size) / 200h
$B4:978F 18          CLC                    ;|
$B4:9790 6D 2C 0E    ADC $0E2C  [$7E:0E2C]  ;|
$B4:9793 8D 2C 0E    STA $0E2C  [$7E:0E2C]  ;/
$B4:9796 BF 3E 00 A0 LDA $A0003E,x          ;\
$B4:979A AA          TAX                    ;|
$B4:979B BF 0C 00 B4 LDA $B4000C,x          ;} $16 = [$B4:000C + (enemy set entry enemy name)] + 30h
$B4:979F 18          CLC                    ;|
$B4:97A0 69 30 00    ADC #$0030             ;|
$B4:97A3 85 16       STA $16    [$7E:0016]  ;/
$B4:97A5 A9 00 0A    LDA #$0A00             ;\
$B4:97A8 85 26       STA $26    [$7E:0026]  ;|
$B4:97AA A9 A8 00    LDA #$00A8             ;|
$B4:97AD 85 14       STA $14    [$7E:0014]  ;|
$B4:97AF AD 2A 0E    LDA $0E2A  [$7E:0E2A]  ;|
$B4:97B2 18          CLC                    ;} Add debug spritemap index [$16] to OAM at position (A8h, [$0E2A] + 18h) with palette 5
$B4:97B3 69 18 00    ADC #$0018             ;|
$B4:97B6 85 12       STA $12    [$7E:0012]  ;|
$B4:97B8 A5 16       LDA $16    [$7E:0016]  ;|
$B4:97BA 29 FF 00    AND #$00FF             ;|
$B4:97BD 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:97C1 AE 26 0E    LDX $0E26  [$7E:0E26]  ;\
$B4:97C4 BF 02 00 B4 LDA $B40002,x          ;|
$B4:97C8 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:97CB A9 D8 00    LDA #$00D8             ;|
$B4:97CE 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value (enemy set entry palette index) at position (D8h, [$0E2A])
$B4:97D1 AD 2A 0E    LDA $0E2A  [$7E:0E2A]  ;|
$B4:97D4 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:97D7 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:97DA AD 2A 0E    LDA $0E2A  [$7E:0E2A]  ;\
$B4:97DD 18          CLC                    ;|
$B4:97DE 69 08 00    ADC #$0008             ;} $0E2A += 8 (next row)
$B4:97E1 8D 2A 0E    STA $0E2A  [$7E:0E2A]  ;/
$B4:97E4 AD 26 0E    LDA $0E26  [$7E:0E26]  ;\
$B4:97E7 18          CLC                    ;|
$B4:97E8 69 04 00    ADC #$0004             ;} $0E26 += 4 (next enemy set entry)
$B4:97EB 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$B4:97EE 80 89       BRA $89    [$9779]     ; Go to LOOP

$B4:97F0 AD 2C 0E    LDA $0E2C  [$7E:0E2C]  ;\
$B4:97F3 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:97F6 A9 A8 00    LDA #$00A8             ;|
$B4:97F9 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [$0E2C] at position (A8h, [$0E2A])
$B4:97FC AD 2A 0E    LDA $0E2A  [$7E:0E2A]  ;|
$B4:97FF 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9802 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9805 A9 00 00    LDA #$0000             ; Return A = 0
$B4:9808 60          RTS
}


;;; $9809: Debug handler ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame
$B4:9809 8B          PHB
$B4:980A E2 20       SEP #$20
$B4:980C A9 B4       LDA #$B4               ;\
$B4:980E 48          PHA                    ;} DB = $B4
$B4:980F AB          PLB                    ;/
$B4:9810 C2 30       REP #$30
$B4:9812 AD 5C 18    LDA $185C  [$7E:185C]  ;\
$B4:9815 29 FF 00    AND #$00FF             ;|
$B4:9818 0A          ASL A                  ;} Execute [$981F + [debug index] * 2]
$B4:9819 AA          TAX                    ;|
$B4:981A FC 1F 98    JSR ($981F,x)[$B4:9961];/
$B4:981D AB          PLB
$B4:981E 6B          RTL

$B4:981F             dw 9961, 98DA, 9925, 986A, 9841, 9A1D, 9A59, 92C6, 94B8, 94D5, 9BD5, 9C5D, 9CE5, 9D6D, 9DF5, 9E7D,
                        9758
}


;;; $9841: Debug handler - [debug index] = 4: sprite tiles viewer - 1st half ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame
$B4:9841 A9 00 0A    LDA #$0A00             ;\
$B4:9844 85 26       STA $26    [$7E:0026]  ;|
$B4:9846 A9 80 00    LDA #$0080             ;|
$B4:9849 85 14       STA $14    [$7E:0014]  ;|
$B4:984B A9 80 00    LDA #$0080             ;} Add debug spritemap index 3 to OAM at position (80h, 80h) with palette 5
$B4:984E 85 12       STA $12    [$7E:0012]  ;|
$B4:9850 A9 03 00    LDA #$0003             ;|
$B4:9853 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9857 AD C5 05    LDA $05C5  [$7E:05C5]  ;\
$B4:985A 89 40 00    BIT #$0040             ;} If not newly pressed X whilst select + L is pressed:
$B4:985D D0 04       BNE $04    [$9863]     ;/
$B4:985F A9 01 00    LDA #$0001             ;\
$B4:9862 60          RTS                    ;} Return A = 1

$B4:9863 9C 5C 18    STZ $185C  [$7E:185C]  ; Debug index = 0
$B4:9866 A9 01 00    LDA #$0001             ;\
$B4:9869 60          RTS                    ;} Return A = 1
}


;;; $986A: Debug handler - [debug index] = 3: sprite tiles viewer - 2nd half ;;;
{
$B4:986A AD C5 05    LDA $05C5  [$7E:05C5]  ;\
$B4:986D 89 80 00    BIT #$0080             ;} If not newly pressed A whilst select + L is pressed: go to BRANCH_NO_CHANGE
$B4:9870 F0 3F       BEQ $3F    [$98B1]     ;/
$B4:9872 AD 5A 18    LDA $185A  [$7E:185A]  ;\
$B4:9875 C9 00 00    CMP #$0000             ;} If [debug spritemap palette bits] = 0:
$B4:9878 D0 08       BNE $08    [$9882]     ;/
$B4:987A A9 00 02    LDA #$0200             ;\
$B4:987D 8D 5A 18    STA $185A  [$7E:185A]  ;} Debug spritemap palette bits = 200h
$B4:9880 80 32       BRA $32    [$98B4]     ; Go to BRANCH_MERGE

$B4:9882 C9 00 02    CMP #$0200             ;\
$B4:9885 D0 08       BNE $08    [$988F]     ;} If [debug spritemap palette bits] = 200h:
$B4:9887 A9 00 04    LDA #$0400             ;\
$B4:988A 8D 5A 18    STA $185A  [$7E:185A]  ;} Debug spritemap palette bits = 400h
$B4:988D 80 25       BRA $25    [$98B4]     ; Go to BRANCH_MERGE

$B4:988F C9 00 04    CMP #$0400             ;\
$B4:9892 D0 08       BNE $08    [$989C]     ;} If [debug spritemap palette bits] = 400h:
$B4:9894 A9 00 06    LDA #$0600             ;\
$B4:9897 8D 5A 18    STA $185A  [$7E:185A]  ;} Debug spritemap palette bits = 600h
$B4:989A 80 18       BRA $18    [$98B4]     ; Go to BRANCH_MERGE

$B4:989C C9 00 06    CMP #$0600             ;\
$B4:989F D0 08       BNE $08    [$98A9]     ;} If [debug spritemap palette bits] = 600h:
$B4:98A1 A9 00 0E    LDA #$0E00             ;\
$B4:98A4 8D 5A 18    STA $185A  [$7E:185A]  ;} Debug spritemap palette bits = E00h
$B4:98A7 80 0B       BRA $0B    [$98B4]     ; Go to BRANCH_MERGE

$B4:98A9 A9 00 00    LDA #$0000             ;\
$B4:98AC 8D 5A 18    STA $185A  [$7E:185A]  ;} Debug spritemap palette bits = 0
$B4:98AF 80 03       BRA $03    [$98B4]     ; Go to BRANCH_MERGE

; BRANCH_NO_CHANGE
$B4:98B1 AD 5A 18    LDA $185A  [$7E:185A]

; BRANCH_MERGE
$B4:98B4 85 26       STA $26    [$7E:0026]  ;\
$B4:98B6 A9 80 00    LDA #$0080             ;|
$B4:98B9 85 14       STA $14    [$7E:0014]  ;|
$B4:98BB A9 80 00    LDA #$0080             ;} Add debug spritemap index 2 to OAM at position (80h, 80h) with palette bits [$185A]
$B4:98BE 85 12       STA $12    [$7E:0012]  ;|
$B4:98C0 A9 02 00    LDA #$0002             ;|
$B4:98C3 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:98C7 AD C5 05    LDA $05C5  [$7E:05C5]  ;\
$B4:98CA 89 40 00    BIT #$0040             ;} If not newly pressed X whilst select + L is pressed:
$B4:98CD D0 04       BNE $04    [$98D3]     ;/
$B4:98CF A9 01 00    LDA #$0001             ;\
$B4:98D2 60          RTS                    ;} Return A = 1

$B4:98D3 EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = 4
$B4:98D6 A9 01 00    LDA #$0001             ;\
$B4:98D9 60          RTS                    ;} Return A = 1
}


;;; $98DA: Debug handler - [debug index] = 1: palette viewer - sprite palettes ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame

; Note that this routine overwrites the sprite palettes with the BG palettes when switching over to the next debug index
$B4:98DA A9 00 00    LDA #$0000             ;\
$B4:98DD 85 26       STA $26    [$7E:0026]  ;|
$B4:98DF A9 60 00    LDA #$0060             ;|
$B4:98E2 85 14       STA $14    [$7E:0014]  ;} Add debug spritemap index 0 to OAM at position (60h, 60h)
$B4:98E4 85 12       STA $12    [$7E:0012]  ;|
$B4:98E6 A9 00 00    LDA #$0000             ;|
$B4:98E9 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:98ED A9 00 00    LDA #$0000             ;\
$B4:98F0 85 26       STA $26    [$7E:0026]  ;|
$B4:98F2 A9 A0 00    LDA #$00A0             ;|
$B4:98F5 85 14       STA $14    [$7E:0014]  ;|
$B4:98F7 A9 60 00    LDA #$0060             ;} Add debug spritemap index 1 to OAM at position (A0h, 60h)
$B4:98FA 85 12       STA $12    [$7E:0012]  ;|
$B4:98FC A9 01 00    LDA #$0001             ;|
$B4:98FF 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9903 AD C5 05    LDA $05C5  [$7E:05C5]  ;\
$B4:9906 89 80 00    BIT #$0080             ;} If not newly pressed A whilst select + L is pressed:
$B4:9909 D0 04       BNE $04    [$990F]     ;/
$B4:990B A9 01 00    LDA #$0001             ;\
$B4:990E 60          RTS                    ;} Return A = 1

$B4:990F A2 FE 00    LDX #$00FE             ;\
                                            ;|
$B4:9912 BF 00 C0 7E LDA $7EC000,x          ;|
$B4:9916 9F 00 C1 7E STA $7EC100,x          ;} $7E:C100..FF = [$7E:C000..FF]
$B4:991A CA          DEX                    ;|
$B4:991B CA          DEX                    ;|
$B4:991C D0 F4       BNE $F4    [$9912]     ;/
$B4:991E EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = 2
$B4:9921 A9 01 00    LDA #$0001             ;\
$B4:9924 60          RTS                    ;} Return A = 1
}


;;; $9925: Debug handler - [debug index] = 2: palette viewer - BG palettes ;;;
{
$B4:9925 A9 00 00    LDA #$0000             ;\
$B4:9928 85 26       STA $26    [$7E:0026]  ;|
$B4:992A A9 60 00    LDA #$0060             ;|
$B4:992D 85 14       STA $14    [$7E:0014]  ;} Add debug spritemap index 0 to OAM at position (60h, 60h)
$B4:992F 85 12       STA $12    [$7E:0012]  ;|
$B4:9931 A9 00 00    LDA #$0000             ;|
$B4:9934 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9938 A9 00 00    LDA #$0000             ;\
$B4:993B 85 26       STA $26    [$7E:0026]  ;|
$B4:993D A9 A0 00    LDA #$00A0             ;|
$B4:9940 85 14       STA $14    [$7E:0014]  ;|
$B4:9942 A9 60 00    LDA #$0060             ;} Add debug spritemap index 1 to OAM at position (A0h, 60h)
$B4:9945 85 12       STA $12    [$7E:0012]  ;|
$B4:9947 A9 01 00    LDA #$0001             ;|
$B4:994A 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:994E AD C5 05    LDA $05C5  [$7E:05C5]  ;\
$B4:9951 89 80 00    BIT #$0080             ;} If not newly pressed A whilst select + L is pressed:
$B4:9954 D0 04       BNE $04    [$995A]     ;/
$B4:9956 A9 01 00    LDA #$0001             ;\
$B4:9959 60          RTS                    ;} Return A = 1

$B4:995A 9C 5C 18    STZ $185C  [$7E:185C]  ; Debug index = 0
$B4:995D A9 01 00    LDA #$0001             ;\
$B4:9960 60          RTS                    ;} Return A = 1
}


;;; $9961: Debug handler - [debug index] = 0: default ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame
$B4:9961 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9963 89 00 10    BIT #$1000             ;} If controller 2 newly pressed start:
$B4:9966 F0 09       BEQ $09    [$9971]     ;/
$B4:9968 A2 1D 00    LDX #$001D             ;\
$B4:996B 8E 98 09    STX $0998  [$7E:0998]  ;} Game state = 1Dh (debug game over menu)
$B4:996E 9C 27 07    STZ $0727  [$7E:0727]  ; Menu index = 0

$B4:9971 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9973 89 20 00    BIT #$0020             ;} If controller 2 newly pressed L:
$B4:9976 F0 09       BEQ $09    [$9981]     ;/
$B4:9978 AD 5E 18    LDA $185E  [$7E:185E]  ;\
$B4:997B 49 01 00    EOR #$0001             ;} Toggle enemy time is frozen flag
$B4:997E 8D 5E 18    STA $185E  [$7E:185E]  ;/

$B4:9981 AD C5 05    LDA $05C5  [$7E:05C5]  ;\
$B4:9984 89 80 00    BIT #$0080             ;} If newly pressed A whilst select + L is pressed: go to BRANCH_SELECT_L_A
$B4:9987 D0 61       BNE $61    [$99EA]     ;/
$B4:9989 AD C5 05    LDA $05C5  [$7E:05C5]  ;\
$B4:998C 89 40 00    BIT #$0040             ;} If newly pressed X whilst select + L is pressed: go to BRANCH_SELECT_L_X
$B4:998F D0 39       BNE $39    [$99CA]     ;/
$B4:9991 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9993 29 10 00    AND #$0010             ;} If controller 2 newly pressed R: go to BRANCH_P2_R
$B4:9996 D0 3F       BNE $3F    [$99D7]     ;/
$B4:9998 A5 91       LDA $91    [$7E:0091]  ;\
$B4:999A 89 00 20    BIT #$2000             ;} If controller 2 newly pressed select: go to BRANCH_P2_SELECT
$B4:999D D0 21       BNE $21    [$99C0]     ;/
$B4:999F A5 91       LDA $91    [$7E:0091]  ;\
$B4:99A1 89 80 00    BIT #$0080             ;} If controller 2 newly pressed A: go to BRANCH_P2_A
$B4:99A4 D0 07       BNE $07    [$99AD]     ;/
$B4:99A6 9C 5C 18    STZ $185C  [$7E:185C]
$B4:99A9 A9 00 00    LDA #$0000             ;\
$B4:99AC 60          RTS                    ;} Return A = 0

; BRANCH_P2_A
$B4:99AD A0 01 00    LDY #$0001             ;\
$B4:99B0 AD 12 0E    LDA $0E12  [$7E:0E12]  ;|
$B4:99B3 F0 03       BEQ $03    [$99B8]     ;|
$B4:99B5 A0 00 00    LDY #$0000             ;} Toggle sprite interactions flag
                                            ;|
$B4:99B8 98          TYA                    ;|
$B4:99B9 8D 12 0E    STA $0E12  [$7E:0E12]  ;/
$B4:99BC A9 00 00    LDA #$0000             ;\
$B4:99BF 60          RTS                    ;} Return A = 0

; BRANCH_P2_SELECT
$B4:99C0 A9 10 00    LDA #$0010             ;\
$B4:99C3 8D 5C 18    STA $185C  [$7E:185C]  ;} Debug index = 10h
$B4:99C6 A9 00 00    LDA #$0000             ;\
$B4:99C9 60          RTS                    ;} Return A = 0

; BRANCH_SELECT_L_X
$B4:99CA EE 5C 18    INC $185C  [$7E:185C]  ;\
$B4:99CD EE 5C 18    INC $185C  [$7E:185C]  ;} Debug index = 3
$B4:99D0 EE 5C 18    INC $185C  [$7E:185C]  ;/
$B4:99D3 A9 01 00    LDA #$0001             ;\
$B4:99D6 60          RTS                    ;} Return A = 1

; BRANCH_P2_R
$B4:99D7 EE 5C 18    INC $185C  [$7E:185C]  ;\
$B4:99DA EE 5C 18    INC $185C  [$7E:185C]  ;|
$B4:99DD EE 5C 18    INC $185C  [$7E:185C]  ;} Debug index = 5
$B4:99E0 EE 5C 18    INC $185C  [$7E:185C]  ;|
$B4:99E3 EE 5C 18    INC $185C  [$7E:185C]  ;/
$B4:99E6 A9 00 00    LDA #$0000             ;\
$B4:99E9 60          RTS                    ;} Return A = 0

; BRANCH_SELECT_L_A
$B4:99EA E2 20       SEP #$20
$B4:99EC A9 80       LDA #$80               ;\
$B4:99EE 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank
$B4:99F1 A9 00       LDA #$00               ;\
$B4:99F3 8D 16 21    STA $2116  [$7E:2116]  ;|
$B4:99F6 A9 70       LDA #$70               ;|
$B4:99F8 8D 17 21    STA $2117  [$7E:2117]  ;|
$B4:99FB A9 80       LDA #$80               ;|
$B4:99FD 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $7000..77FF = [$B0:8000..8FFF] (palette viewer tiles)
$B4:9A00 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$B4:9A04             dx 01,01,18,B08000,1000;|
$B4:9A0C A9 02       LDA #$02               ;|
$B4:9A0E 8D 0B 42    STA $420B  [$7E:420B]  ;/
$B4:9A11 9C 00 21    STZ $2100  [$7E:2100]  ; Disable forced blank
$B4:9A14 C2 20       REP #$20
$B4:9A16 EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = 1
$B4:9A19 A9 01 00    LDA #$0001             ;\
$B4:9A1C 60          RTS                    ;} Return A = 1
}


;;; $9A1D: Debug handler - [debug index] = 5: enemy debugger - initialise ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame
$B4:9A1D E2 20       SEP #$20
$B4:9A1F A9 80       LDA #$80               ;\
$B4:9A21 8D 00 21    STA $2100  [$7E:2100]  ;} Enable forced blank
$B4:9A24 A9 00       LDA #$00               ;\
$B4:9A26 8D 16 21    STA $2116  [$7E:2116]  ;|
$B4:9A29 A9 6B       LDA #$6B               ;|
$B4:9A2B 8D 17 21    STA $2117  [$7E:2117]  ;|
$B4:9A2E A9 80       LDA #$80               ;|
$B4:9A30 8D 15 21    STA $2115  [$7E:2115]  ;} VRAM $6B00..6FFF = [$AB:EA00..F3FF] (debugger font)
$B4:9A33 22 A9 91 80 JSL $8091A9[$80:91A9]  ;|
$B4:9A37             dx 01,01,18,ABEA00,0A00;|
$B4:9A3F A9 02       LDA #$02               ;|
$B4:9A41 8D 0B 42    STA $420B  [$7E:420B]  ;/
$B4:9A44 9C 00 21    STZ $2100  [$7E:2100]  ; Disable forced blank
$B4:9A47 C2 20       REP #$20
$B4:9A49 A9 C0 00    LDA #$00C0             ;\
$B4:9A4C 8D 60 18    STA $1860  [$7E:1860]  ;} Text cursor X position = C0h
$B4:9A4F A9 30 00    LDA #$0030             ;\
$B4:9A52 8D 62 18    STA $1862  [$7E:1862]  ;} Text cursor Y position = 30h
$B4:9A55 EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = 6
$B4:9A58 60          RTS
}


;;; $9A59: Debug handler - [debug index] = 6: enemy debugger - enemy mover ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame
$B4:9A59 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9A5B 89 10 00    BIT #$0010             ;} If controller 2 newly pressed R:
$B4:9A5E F0 07       BEQ $07    [$9A67]     ;/
$B4:9A60 EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = 7
$B4:9A63 A9 00 00    LDA #$0000             ;\
$B4:9A66 60          RTS                    ;} Return A = 0

$B4:9A67 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9A69 89 00 20    BIT #$2000             ;} If controller 2 not newly pressed select: go to BRANCH_NO_P2_SELECT
$B4:9A6C F0 2A       BEQ $2A    [$9A98]     ;/
$B4:9A6E A5 8D       LDA $8D    [$7E:008D]  ;\
$B4:9A70 89 00 80    BIT #$8000             ;} If controller 2 not pressing B:
$B4:9A73 D0 14       BNE $14    [$9A89]     ;/
$B4:9A75 AD 46 18    LDA $1846  [$7E:1846]  ;\
$B4:9A78 18          CLC                    ;|
$B4:9A79 69 40 00    ADC #$0040             ;|
$B4:9A7C C9 00 08    CMP #$0800             ;|
$B4:9A7F 30 03       BMI $03    [$9A84]     ;} Debug enemy index = ([debug enemy index] + 40h) % 800h
$B4:9A81 A9 00 00    LDA #$0000             ;|
                                            ;|
$B4:9A84 8D 46 18    STA $1846  [$7E:1846]  ;/
$B4:9A87 80 0F       BRA $0F    [$9A98]

$B4:9A89 AD 46 18    LDA $1846  [$7E:1846]  ;\ Else (controller 2 pressing B):
$B4:9A8C 38          SEC                    ;|
$B4:9A8D E9 40 00    SBC #$0040             ;|
$B4:9A90 D0 03       BNE $03    [$9A95]     ;} Debug enemy index = ([debug enemy index] - 40h) % 800h
$B4:9A92 A9 C0 07    LDA #$07C0             ;|
                                            ;|
$B4:9A95 8D 46 18    STA $1846  [$7E:1846]  ;/

; BRANCH_NO_P2_SELECT
$B4:9A98 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9A9A 89 80 00    BIT #$0080             ;} If controller 2 newly pressed A:
$B4:9A9D F0 13       BEQ $13    [$9AB2]     ;/
$B4:9A9F AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9AA2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$B4:9AA5 18          CLC                    ;} Debug enemy X position = [Samus X position] + 20h
$B4:9AA6 69 20 00    ADC #$0020             ;|
$B4:9AA9 9D 7A 0F    STA $0F7A,x            ;/
$B4:9AAC AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$B4:9AAF 9D 7E 0F    STA $0F7E,x            ;} Debug enemy Y position = [Samus Y position]

$B4:9AB2 AE 46 18    LDX $1846  [$7E:1846]
$B4:9AB5 A5 8D       LDA $8D    [$7E:008D]  ;\
$B4:9AB7 89 40 00    BIT #$0040             ;} If controller 2 pressing X:
$B4:9ABA F0 06       BEQ $06    [$9AC2]     ;/
$B4:9ABC 22 36 9F B4 JSL $B49F36[$B4:9F36]  ; Move enemy with d-pad 4 px/frame
$B4:9AC0 80 04       BRA $04    [$9AC6]

                                            ; Else (controller 2 not pressing X):
$B4:9AC2 22 05 9F B4 JSL $B49F05[$B4:9F05]  ; Move enemy with d-pad 1/4 px/frame

$B4:9AC6 AE 46 18    LDX $1846  [$7E:1846]
$B4:9AC9 BD 7A 0F    LDA $0F7A,x            ;\
$B4:9ACC CD 11 09    CMP $0911  [$7E:0911]  ;|
$B4:9ACF 30 59       BMI $59    [$9B2A]     ;|
$B4:9AD1 AD 11 09    LDA $0911  [$7E:0911]  ;|
$B4:9AD4 18          CLC                    ;} If [layer 1 X position] <= [debug enemy X position] <= [layer 1 X position] + 100h:
$B4:9AD5 69 00 01    ADC #$0100             ;|
$B4:9AD8 DD 7A 0F    CMP $0F7A,x            ;|
$B4:9ADB 30 4D       BMI $4D    [$9B2A]     ;/
$B4:9ADD BD 7E 0F    LDA $0F7E,x            ;\
$B4:9AE0 CD 15 09    CMP $0915  [$7E:0915]  ;|
$B4:9AE3 30 45       BMI $45    [$9B2A]     ;|
$B4:9AE5 AD 15 09    LDA $0915  [$7E:0915]  ;|
$B4:9AE8 18          CLC                    ;} If [layer 1 Y position] <= [debug enemy Y position] <= [layer 1 Y position] + 100h:
$B4:9AE9 69 00 01    ADC #$0100             ;|
$B4:9AEC DD 7E 0F    CMP $0F7E,x            ;|
$B4:9AEF 30 39       BMI $39    [$9B2A]     ;/
$B4:9AF1 AE 46 18    LDX $1846  [$7E:1846]
$B4:9AF4 BD 7A 0F    LDA $0F7A,x            ;\
$B4:9AF7 38          SEC                    ;|
$B4:9AF8 ED 11 09    SBC $0911  [$7E:0911]  ;|
$B4:9AFB 85 14       STA $14    [$7E:0014]  ;|
$B4:9AFD 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9B00 BD 7E 0F    LDA $0F7E,x            ;|
$B4:9B03 38          SEC                    ;|
$B4:9B04 ED 15 09    SBC $0915  [$7E:0915]  ;|
$B4:9B07 85 12       STA $12    [$7E:0012]  ;|
$B4:9B09 8D 20 0E    STA $0E20  [$7E:0E20]  ;|
$B4:9B0C AD 22 0E    LDA $0E22  [$7E:0E22]  ;|
$B4:9B0F 18          CLC                    ;} Add debug spritemap index 25h to OAM at position ([debug enemy X position] - [layer 1 X position] + 20h, [debug enemy Y position] - [layer 1 Y position] + 4) with palette 5 (<=: Move)
$B4:9B10 69 20 00    ADC #$0020             ;|
$B4:9B13 85 14       STA $14    [$7E:0014]  ;|
$B4:9B15 AD 20 0E    LDA $0E20  [$7E:0E20]  ;|
$B4:9B18 18          CLC                    ;|
$B4:9B19 69 04 00    ADC #$0004             ;|
$B4:9B1C 85 12       STA $12    [$7E:0012]  ;|
$B4:9B1E A9 00 0A    LDA #$0A00             ;|
$B4:9B21 85 26       STA $26    [$7E:0026]  ;|
$B4:9B23 A9 25 00    LDA #$0025             ;|
$B4:9B26 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/

$B4:9B2A A9 B0 00    LDA #$00B0             ;\
$B4:9B2D 85 14       STA $14    [$7E:0014]  ;|
$B4:9B2F A9 50 00    LDA #$0050             ;|
$B4:9B32 85 12       STA $12    [$7E:0012]  ;|
$B4:9B34 A9 00 0A    LDA #$0A00             ;} Add debug spritemap index 27h to OAM at position (B0h, 50h) with palette 5 (enemy debugger text)
$B4:9B37 85 26       STA $26    [$7E:0026]  ;|
$B4:9B39 A9 27 00    LDA #$0027             ;|
$B4:9B3C 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9B40 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9B43 BD 7A 0F    LDA $0F7A,x            ;|
$B4:9B46 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9B49 A9 E0 00    LDA #$00E0             ;|
$B4:9B4C 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy X position] at position (E0h, 38h)
$B4:9B4F A9 38 00    LDA #$0038             ;|
$B4:9B52 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9B55 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9B58 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9B5B BD 7E 0F    LDA $0F7E,x            ;|
$B4:9B5E 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9B61 A9 E0 00    LDA #$00E0             ;|
$B4:9B64 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy Y position] at position (E0h, 40h)
$B4:9B67 A9 40 00    LDA #$0040             ;|
$B4:9B6A 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9B6D 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9B70 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9B73 BD 8C 0F    LDA $0F8C,x            ;|
$B4:9B76 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9B79 A9 E0 00    LDA #$00E0             ;|
$B4:9B7C 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy health] at position (E0h, 48h)
$B4:9B7F A9 48 00    LDA #$0048             ;|
$B4:9B82 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9B85 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9B88 AD 46 18    LDA $1846  [$7E:1846]  ;\
$B4:9B8B 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9B8E A9 E0 00    LDA #$00E0             ;|
$B4:9B91 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy index] at position (E0h, 50h)
$B4:9B94 A9 50 00    LDA #$0050             ;|
$B4:9B97 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9B9A 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9B9D A9 00 0A    LDA #$0A00             ;\
$B4:9BA0 85 26       STA $26    [$7E:0026]  ;} Debug spritemap palette = 5
$B4:9BA2 A9 B0 00    LDA #$00B0             ;\
$B4:9BA5 85 14       STA $14    [$7E:0014]  ;} Debug spritemap X position = B0h
$B4:9BA7 A9 48 00    LDA #$0048             ;\
$B4:9BAA 85 12       STA $12    [$7E:0012]  ;} Debug spritemap Y position = 48h
$B4:9BAC AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9BAF BD 78 0F    LDA $0F78,x            ;|
$B4:9BB2 AA          TAX                    ;} If [debug enemy name] = 0:
$B4:9BB3 BF 3E 00 A0 LDA $A0003E,x          ;|
$B4:9BB7 D0 05       BNE $05    [$9BBE]     ;/
$B4:9BB9 A9 30 00    LDA #$0030             ; Debug spritemap index = 30h
$B4:9BBC 80 09       BRA $09    [$9BC7]

$B4:9BBE AA          TAX                    ;\ Else ([debug enemy name] != 0):
$B4:9BBF BF 0C 00 B4 LDA $B4000C,x          ;|
$B4:9BC3 18          CLC                    ;} Debug spritemap index = 30h + [[debug enemy name] + Ch]
$B4:9BC4 69 30 00    ADC #$0030             ;/

$B4:9BC7 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ; Add debug spritemap to OAM
$B4:9BCB 20 1D 94    JSR $941D  [$B4:941D]  ; Draw enemy set name
$B4:9BCE 9C 64 18    STZ $1864  [$7E:1864]  ; Debug enemy set entry index = 0
$B4:9BD1 A9 00 00    LDA #$0000             ; Return A = 0
$B4:9BD4 60          RTS
}


;;; $9BD5: Debug handler - [debug index] = Ah: enemy debugger - RAM viewer - page 0 ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame

; When drawn with the text, result looks like:
;     TK_UPTM: [frame counter]
;     TK_Stat: [AI handler]
;     TK_Num : [ID]
;     TK_Bank: [bank]
$B4:9BD5 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9BD7 89 10 00    BIT #$0010             ;} If controller 2 newly pressed R:
$B4:9BDA F0 07       BEQ $07    [$9BE3]     ;/
$B4:9BDC EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = Bh
$B4:9BDF A9 00 00    LDA #$0000             ;\
$B4:9BE2 60          RTS                    ;} Return A = 0

$B4:9BE3 A9 B0 00    LDA #$00B0             ;\
$B4:9BE6 85 14       STA $14    [$7E:0014]  ;|
$B4:9BE8 A9 50 00    LDA #$0050             ;|
$B4:9BEB 85 12       STA $12    [$7E:0012]  ;|
$B4:9BED A9 00 0A    LDA #$0A00             ;} Add debug spritemap index 29h to OAM at position (B0h, 50h) with palette 5
$B4:9BF0 85 26       STA $26    [$7E:0026]  ;|
$B4:9BF2 A9 29 00    LDA #$0029             ;|
$B4:9BF5 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9BF9 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9BFC BD A4 0F    LDA $0FA4,x            ;|
$B4:9BFF 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9C02 A9 E0 00    LDA #$00E0             ;|
$B4:9C05 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy frame counter] at position (E0h, 38h)
$B4:9C08 A9 38 00    LDA #$0038             ;|
$B4:9C0B 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9C0E 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9C11 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9C14 BD 8A 0F    LDA $0F8A,x            ;|
$B4:9C17 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9C1A A9 E0 00    LDA #$00E0             ;|
$B4:9C1D 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy AI handler] at position (E0h, 40h)
$B4:9C20 A9 40 00    LDA #$0040             ;|
$B4:9C23 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9C26 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9C29 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9C2C BD 78 0F    LDA $0F78,x            ;|
$B4:9C2F 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9C32 A9 E0 00    LDA #$00E0             ;|
$B4:9C35 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy ID] at position (E0h, 48h)
$B4:9C38 A9 48 00    LDA #$0048             ;|
$B4:9C3B 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9C3E 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9C41 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9C44 BD A6 0F    LDA $0FA6,x            ;|
$B4:9C47 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9C4A A9 E0 00    LDA #$00E0             ;|
$B4:9C4D 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy bank] at position (E0h, 50h)
$B4:9C50 A9 50 00    LDA #$0050             ;|
$B4:9C53 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9C56 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9C59 A9 00 00    LDA #$0000             ;\
$B4:9C5C 60          RTS                    ;} Return A = 0
}


;;; $9C5D: Debug handler - [debug index] = Bh: enemy debugger - RAM viewer - page 1 ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame

; When drawn with the text, result looks like:
;     Switch : [properties]
;     Switch2: [extra properties]
;     ColorPa: [palette index]
;     CharaOf: [VRAM tiles index]
$B4:9C5D A5 91       LDA $91    [$7E:0091]  ;\
$B4:9C5F 89 10 00    BIT #$0010             ;} If controller 2 newly pressed R:
$B4:9C62 F0 07       BEQ $07    [$9C6B]     ;/
$B4:9C64 EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = Ch
$B4:9C67 A9 00 00    LDA #$0000             ;\
$B4:9C6A 60          RTS                    ;} Return A = 0

$B4:9C6B A9 B0 00    LDA #$00B0             ;\
$B4:9C6E 85 14       STA $14    [$7E:0014]  ;|
$B4:9C70 A9 50 00    LDA #$0050             ;|
$B4:9C73 85 12       STA $12    [$7E:0012]  ;|
$B4:9C75 A9 00 0A    LDA #$0A00             ;} Add debug spritemap index 2Ah to OAM at position (B0h, 50h) with palette 5
$B4:9C78 85 26       STA $26    [$7E:0026]  ;|
$B4:9C7A A9 2A 00    LDA #$002A             ;|
$B4:9C7D 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9C81 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9C84 BD 86 0F    LDA $0F86,x            ;|
$B4:9C87 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9C8A A9 E0 00    LDA #$00E0             ;|
$B4:9C8D 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy properties] at position (E0h, 38h)
$B4:9C90 A9 38 00    LDA #$0038             ;|
$B4:9C93 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9C96 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9C99 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9C9C BD 88 0F    LDA $0F88,x            ;|
$B4:9C9F 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9CA2 A9 E0 00    LDA #$00E0             ;|
$B4:9CA5 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy extra properties] at position (E0h, 40h)
$B4:9CA8 A9 40 00    LDA #$0040             ;|
$B4:9CAB 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9CAE 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9CB1 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9CB4 BD 96 0F    LDA $0F96,x            ;|
$B4:9CB7 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9CBA A9 E0 00    LDA #$00E0             ;|
$B4:9CBD 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy palette index] at position (E0h, 48h)
$B4:9CC0 A9 48 00    LDA #$0048             ;|
$B4:9CC3 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9CC6 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9CC9 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9CCC BD 98 0F    LDA $0F98,x            ;|
$B4:9CCF 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9CD2 A9 E0 00    LDA #$00E0             ;|
$B4:9CD5 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy VRAM tiles index] at position (E0h, 50h)
$B4:9CD8 A9 50 00    LDA #$0050             ;|
$B4:9CDB 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9CDE 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9CE1 A9 00 00    LDA #$0000             ;\
$B4:9CE4 60          RTS                    ;} Return A = 0
}


;;; $9CE5: Debug handler - [debug index] = Ch: enemy debugger - RAM viewer - page 2 ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame

; When drawn with the text, result looks like:
;     PoseAdr: [instruction list pointer]
;     WaitTim: [instruction timer]
;     LpCnt  : [timer]
;     Patern : [spritemap pointer]
$B4:9CE5 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9CE7 89 10 00    BIT #$0010             ;} If controller 2 newly pressed R:
$B4:9CEA F0 07       BEQ $07    [$9CF3]     ;/
$B4:9CEC EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = Dh
$B4:9CEF A9 00 00    LDA #$0000             ;\
$B4:9CF2 60          RTS                    ;} Return A = 0

$B4:9CF3 A9 B0 00    LDA #$00B0             ;\
$B4:9CF6 85 14       STA $14    [$7E:0014]  ;|
$B4:9CF8 A9 50 00    LDA #$0050             ;|
$B4:9CFB 85 12       STA $12    [$7E:0012]  ;|
$B4:9CFD A9 00 0A    LDA #$0A00             ;} Add debug spritemap index 2Bh to OAM at position (B0h, 50h) with palette 5
$B4:9D00 85 26       STA $26    [$7E:0026]  ;|
$B4:9D02 A9 2B 00    LDA #$002B             ;|
$B4:9D05 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9D09 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9D0C BD 92 0F    LDA $0F92,x            ;|
$B4:9D0F 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9D12 A9 E0 00    LDA #$00E0             ;|
$B4:9D15 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy instruction list pointer] at position (E0h, 38h)
$B4:9D18 A9 38 00    LDA #$0038             ;|
$B4:9D1B 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9D1E 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9D21 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9D24 BD 94 0F    LDA $0F94,x            ;|
$B4:9D27 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9D2A A9 E0 00    LDA #$00E0             ;|
$B4:9D2D 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy instruction timer] at position (E0h, 40h)
$B4:9D30 A9 40 00    LDA #$0040             ;|
$B4:9D33 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9D36 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9D39 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9D3C BD 90 0F    LDA $0F90,x            ;|
$B4:9D3F 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9D42 A9 E0 00    LDA #$00E0             ;|
$B4:9D45 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy timer] at position (E0h, 48h)
$B4:9D48 A9 48 00    LDA #$0048             ;|
$B4:9D4B 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9D4E 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9D51 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9D54 BD 8E 0F    LDA $0F8E,x            ;|
$B4:9D57 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9D5A A9 E0 00    LDA #$00E0             ;|
$B4:9D5D 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy spritemap pointer] at position (E0h, 50h)
$B4:9D60 A9 50 00    LDA #$0050             ;|
$B4:9D63 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9D66 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9D69 A9 00 00    LDA #$0000             ;\
$B4:9D6C 60          RTS                    ;} Return A = 0
}


;;; $9D6D: Debug handler - [debug index] = Dh: enemy debugger - RAM viewer - page 3 ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame

; When drawn with the text, result looks like:
;     FlashCo: [flash timer]
;     IceCoun: [frozen timer]
;     HitCoun: [invincibility timer]
;     PlplCou: [shake timer]
$B4:9D6D A5 91       LDA $91    [$7E:0091]  ;\
$B4:9D6F 89 10 00    BIT #$0010             ;} If controller 2 newly pressed R:
$B4:9D72 F0 07       BEQ $07    [$9D7B]     ;/
$B4:9D74 EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = Eh
$B4:9D77 A9 00 00    LDA #$0000             ;\
$B4:9D7A 60          RTS                    ;} Return A = 0

$B4:9D7B A9 B0 00    LDA #$00B0             ;\
$B4:9D7E 85 14       STA $14    [$7E:0014]  ;|
$B4:9D80 A9 50 00    LDA #$0050             ;|
$B4:9D83 85 12       STA $12    [$7E:0012]  ;|
$B4:9D85 A9 00 0A    LDA #$0A00             ;} Add debug spritemap index 2Ch to OAM at position (B0h, 50h) with palette 5
$B4:9D88 85 26       STA $26    [$7E:0026]  ;|
$B4:9D8A A9 2C 00    LDA #$002C             ;|
$B4:9D8D 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9D91 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9D94 BD 9C 0F    LDA $0F9C,x            ;|
$B4:9D97 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9D9A A9 E0 00    LDA #$00E0             ;|
$B4:9D9D 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy flash timer] at position (E0h, 38h)
$B4:9DA0 A9 38 00    LDA #$0038             ;|
$B4:9DA3 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9DA6 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9DA9 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9DAC BD 9E 0F    LDA $0F9E,x            ;|
$B4:9DAF 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9DB2 A9 E0 00    LDA #$00E0             ;|
$B4:9DB5 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy frozen timer] at position (E0h, 40h)
$B4:9DB8 A9 40 00    LDA #$0040             ;|
$B4:9DBB 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9DBE 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9DC1 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9DC4 BD A0 0F    LDA $0FA0,x            ;|
$B4:9DC7 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9DCA A9 E0 00    LDA #$00E0             ;|
$B4:9DCD 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy invincibility] at position (E0h, 48h)
$B4:9DD0 A9 48 00    LDA #$0048             ;|
$B4:9DD3 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9DD6 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9DD9 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9DDC BD A2 0F    LDA $0FA2,x            ;|
$B4:9DDF 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9DE2 A9 E0 00    LDA #$00E0             ;|
$B4:9DE5 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy shake timer] at position (E0h, 50h)
$B4:9DE8 A9 50 00    LDA #$0050             ;|
$B4:9DEB 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9DEE 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9DF1 A9 00 00    LDA #$0000             ;\
$B4:9DF4 60          RTS                    ;} Return A = 0
}


;;; $9DF5: Debug handler - [debug index] = Eh: enemy debugger - RAM viewer - page 4 ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame

; When drawn with the text, result looks like:
;     Pwork0 : [$0FA8]
;     Pwork1 : [$0FAA]
;     Pwork2 : [$0FAC]
;     Pwork3 : [$0FAE]
$B4:9DF5 A5 91       LDA $91    [$7E:0091]  ;\
$B4:9DF7 89 10 00    BIT #$0010             ;} If controller 2 newly pressed R:
$B4:9DFA F0 07       BEQ $07    [$9E03]     ;/
$B4:9DFC EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = Fh
$B4:9DFF A9 00 00    LDA #$0000             ;\
$B4:9E02 60          RTS                    ;} Return A = 0

$B4:9E03 A9 B0 00    LDA #$00B0             ;\
$B4:9E06 85 14       STA $14    [$7E:0014]  ;|
$B4:9E08 A9 50 00    LDA #$0050             ;|
$B4:9E0B 85 12       STA $12    [$7E:0012]  ;|
$B4:9E0D A9 00 0A    LDA #$0A00             ;} Add debug spritemap index 2Dh to OAM at position (B0h, 50h) with palette 5
$B4:9E10 85 26       STA $26    [$7E:0026]  ;|
$B4:9E12 A9 2D 00    LDA #$002D             ;|
$B4:9E15 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9E19 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9E1C BD A8 0F    LDA $0FA8,x            ;|
$B4:9E1F 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9E22 A9 E0 00    LDA #$00E0             ;|
$B4:9E25 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy $0FA8] at position (E0h, 38h)
$B4:9E28 A9 38 00    LDA #$0038             ;|
$B4:9E2B 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9E2E 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9E31 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9E34 BD AA 0F    LDA $0FAA,x            ;|
$B4:9E37 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9E3A A9 E0 00    LDA #$00E0             ;|
$B4:9E3D 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy $0FAA] at position (E0h, 40h)
$B4:9E40 A9 40 00    LDA #$0040             ;|
$B4:9E43 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9E46 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9E49 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9E4C BD AC 0F    LDA $0FAC,x            ;|
$B4:9E4F 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9E52 A9 E0 00    LDA #$00E0             ;|
$B4:9E55 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy $0FAC] at position (E0h, 48h)
$B4:9E58 A9 48 00    LDA #$0048             ;|
$B4:9E5B 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9E5E 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9E61 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9E64 BD AE 0F    LDA $0FAE,x            ;|
$B4:9E67 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9E6A A9 E0 00    LDA #$00E0             ;|
$B4:9E6D 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy $0FAE] at position (E0h, 50h)
$B4:9E70 A9 50 00    LDA #$0050             ;|
$B4:9E73 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9E76 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9E79 A9 00 00    LDA #$0000             ;\
$B4:9E7C 60          RTS                    ;} Return A = 0
}


;;; $9E7D: Debug handler - [debug index] = Fh: enemy debugger - RAM viewer - page 5 ;;;
{
;; Returns:
;;     A: Non-zero to skip processing frame

; When drawn with the text, result looks like:
;     Pwork4 : [$0FB0]
;     Pwork5 : [$0FB2]
;     InitOP0: [$0FB4]
;     InitOP1: [$0FB6]
$B4:9E7D A5 91       LDA $91    [$7E:0091]  ;\
$B4:9E7F 89 10 00    BIT #$0010             ;} If controller 2 newly pressed R:
$B4:9E82 F0 07       BEQ $07    [$9E8B]     ;/
$B4:9E84 EE 5C 18    INC $185C  [$7E:185C]  ; Debug index = 10h
$B4:9E87 A9 00 00    LDA #$0000             ;\
$B4:9E8A 60          RTS                    ;} Return A = 0

$B4:9E8B A9 B0 00    LDA #$00B0             ;\
$B4:9E8E 85 14       STA $14    [$7E:0014]  ;|
$B4:9E90 A9 50 00    LDA #$0050             ;|
$B4:9E93 85 12       STA $12    [$7E:0012]  ;|
$B4:9E95 A9 00 0A    LDA #$0A00             ;} Add debug spritemap index 2Eh to OAM at position (B0h, 50h) with palette 5
$B4:9E98 85 26       STA $26    [$7E:0026]  ;|
$B4:9E9A A9 2E 00    LDA #$002E             ;|
$B4:9E9D 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9EA1 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9EA4 BD B0 0F    LDA $0FB0,x            ;|
$B4:9EA7 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9EAA A9 E0 00    LDA #$00E0             ;|
$B4:9EAD 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy $0FB0] at position (E0h, 38h)
$B4:9EB0 A9 38 00    LDA #$0038             ;|
$B4:9EB3 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9EB6 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9EB9 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9EBC BD B2 0F    LDA $0FB2,x            ;|
$B4:9EBF 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9EC2 A9 E0 00    LDA #$00E0             ;|
$B4:9EC5 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy $0FB2] at position (E0h, 40h)
$B4:9EC8 A9 40 00    LDA #$0040             ;|
$B4:9ECB 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9ECE 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9ED1 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9ED4 BD B4 0F    LDA $0FB4,x            ;|
$B4:9ED7 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9EDA A9 E0 00    LDA #$00E0             ;|
$B4:9EDD 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy $0FB4] at position (E0h, 48h)
$B4:9EE0 A9 48 00    LDA #$0048             ;|
$B4:9EE3 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9EE6 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9EE9 AE 46 18    LDX $1846  [$7E:1846]  ;\
$B4:9EEC BD B6 0F    LDA $0FB6,x            ;|
$B4:9EEF 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$B4:9EF2 A9 E0 00    LDA #$00E0             ;|
$B4:9EF5 8D 20 0E    STA $0E20  [$7E:0E20]  ;} Draw hex value [debug enemy $0FB6] at position (E0h, 50h)
$B4:9EF8 A9 50 00    LDA #$0050             ;|
$B4:9EFB 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$B4:9EFE 20 7E 9F    JSR $9F7E  [$B4:9F7E]  ;/
$B4:9F01 A9 00 00    LDA #$0000             ;\
$B4:9F04 60          RTS                    ;} Return A = 0
}


;;; $9F05: Debug. Move enemy with d-pad 1/4 px/frame ;;;
{
;; Parameters:
;;     X: Debug enemy index
$B4:9F05 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$B4:9F08 29 03 00    AND #$0003             ;} If [frame counter] % 4 = 0:
$B4:9F0B D0 28       BNE $28    [$9F35]     ;/
$B4:9F0D A5 8D       LDA $8D    [$7E:008D]  ;\
$B4:9F0F 89 00 02    BIT #$0200             ;} If controller 2 pressing left:
$B4:9F12 F0 05       BEQ $05    [$9F19]     ;/
$B4:9F14 DE 7A 0F    DEC $0F7A,x            ; Decrement debug enemy X position
$B4:9F17 80 08       BRA $08    [$9F21]

$B4:9F19 89 00 01    BIT #$0100             ;\ Else (controller 2 not pressing left):
$B4:9F1C F0 03       BEQ $03    [$9F21]     ;} If controller 2 pressing right:
$B4:9F1E FE 7A 0F    INC $0F7A,x            ; Increment debug enemy X position

$B4:9F21 A5 8D       LDA $8D    [$7E:008D]  ;\
$B4:9F23 89 00 08    BIT #$0800             ;} If controller 2 pressing up:
$B4:9F26 F0 05       BEQ $05    [$9F2D]     ;/
$B4:9F28 DE 7E 0F    DEC $0F7E,x            ; Decrement debug enemy Y position
$B4:9F2B 80 08       BRA $08    [$9F35]

$B4:9F2D 89 00 04    BIT #$0400             ;\ Else (controller 2 not pressing up):
$B4:9F30 F0 03       BEQ $03    [$9F35]     ;} If controller 2 pressing down:
$B4:9F32 FE 7E 0F    INC $0F7E,x            ; Increment debug enemy Y position

$B4:9F35 6B          RTL
}


;;; $9F36: Debug. Move enemy with d-pad 4 px/frame ;;;
{
$B4:9F36 A5 8D       LDA $8D    [$7E:008D]  ;\
$B4:9F38 89 00 02    BIT #$0200             ;} If controller 2 pressing left:
$B4:9F3B F0 0C       BEQ $0C    [$9F49]     ;/
$B4:9F3D BD 7A 0F    LDA $0F7A,x            ;\
$B4:9F40 38          SEC                    ;|
$B4:9F41 E9 04 00    SBC #$0004             ;} Debug enemy X position -= 4
$B4:9F44 9D 7A 0F    STA $0F7A,x            ;/
$B4:9F47 80 0F       BRA $0F    [$9F58]

$B4:9F49 89 00 01    BIT #$0100             ;\ Else (controller 2 not pressing left):
$B4:9F4C F0 0A       BEQ $0A    [$9F58]     ;} If controller 2 pressing right:
$B4:9F4E BD 7A 0F    LDA $0F7A,x            ;\
$B4:9F51 18          CLC                    ;|
$B4:9F52 69 04 00    ADC #$0004             ;} Debug enemy X position += 4
$B4:9F55 9D 7A 0F    STA $0F7A,x            ;/

$B4:9F58 A5 8D       LDA $8D    [$7E:008D]  ;\
$B4:9F5A 89 00 08    BIT #$0800             ;} If controller 2 pressing up:
$B4:9F5D F0 0C       BEQ $0C    [$9F6B]     ;/
$B4:9F5F BD 7E 0F    LDA $0F7E,x            ;\
$B4:9F62 38          SEC                    ;|
$B4:9F63 E9 04 00    SBC #$0004             ;} Debug enemy Y position -= 4
$B4:9F66 9D 7E 0F    STA $0F7E,x            ;/
$B4:9F69 80 12       BRA $12    [$9F7D]

$B4:9F6B 89 00 04    BIT #$0400             ;\ Else (controller 2 not pressing up):
$B4:9F6E F0 0D       BEQ $0D    [$9F7D]     ;} If controller 2 pressing down:
$B4:9F70 FE 7E 0F    INC $0F7E,x            ;\
$B4:9F73 BD 7E 0F    LDA $0F7E,x            ;|
$B4:9F76 18          CLC                    ;} Debug enemy Y position += 4
$B4:9F77 69 04 00    ADC #$0004             ;/
$B4:9F7A 9D 7E 0F    STA $0F7E,x

$B4:9F7D 6B          RTL
}


;;; $9F7E: Draw 4 digit hex value ;;;
{
;; Parameters:
;;     $0E20: X position
;;     $0E22: Y position
;;     $0E24: Hex value
$B4:9F7E AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$B4:9F81 18          CLC                    ;|
$B4:9F82 69 00 00    ADC #$0000             ;|
$B4:9F85 85 14       STA $14    [$7E:0014]  ;|
$B4:9F87 AD 22 0E    LDA $0E22  [$7E:0E22]  ;|
$B4:9F8A 18          CLC                    ;|
$B4:9F8B 69 00 00    ADC #$0000             ;|
$B4:9F8E 85 12       STA $12    [$7E:0012]  ;|
$B4:9F90 A9 00 0A    LDA #$0A00             ;|
$B4:9F93 85 26       STA $26    [$7E:0026]  ;|
$B4:9F95 AD 24 0E    LDA $0E24  [$7E:0E24]  ;} Add debug spritemap index ([$0E24] >> Ch) + 4 to OAM at position ([$0E20], [$0E22]) with palette 5
$B4:9F98 29 00 F0    AND #$F000             ;|
$B4:9F9B EB          XBA                    ;|
$B4:9F9C 4A          LSR A                  ;|
$B4:9F9D 4A          LSR A                  ;|
$B4:9F9E 4A          LSR A                  ;|
$B4:9F9F 4A          LSR A                  ;|
$B4:9FA0 18          CLC                    ;|
$B4:9FA1 69 04 00    ADC #$0004             ;|
$B4:9FA4 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9FA8 AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$B4:9FAB 18          CLC                    ;|
$B4:9FAC 69 08 00    ADC #$0008             ;|
$B4:9FAF 85 14       STA $14    [$7E:0014]  ;|
$B4:9FB1 AD 22 0E    LDA $0E22  [$7E:0E22]  ;|
$B4:9FB4 18          CLC                    ;|
$B4:9FB5 69 00 00    ADC #$0000             ;|
$B4:9FB8 85 12       STA $12    [$7E:0012]  ;|
$B4:9FBA A9 00 0A    LDA #$0A00             ;} Add debug spritemap index ([$0E24] >> 8 & Fh) + 4 to OAM at position ([$0E20] + 8, [$0E22]) with palette 5
$B4:9FBD 85 26       STA $26    [$7E:0026]  ;|
$B4:9FBF AD 24 0E    LDA $0E24  [$7E:0E24]  ;|
$B4:9FC2 29 00 0F    AND #$0F00             ;|
$B4:9FC5 EB          XBA                    ;|
$B4:9FC6 18          CLC                    ;|
$B4:9FC7 69 04 00    ADC #$0004             ;|
$B4:9FCA 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9FCE AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$B4:9FD1 18          CLC                    ;|
$B4:9FD2 69 10 00    ADC #$0010             ;|
$B4:9FD5 85 14       STA $14    [$7E:0014]  ;|
$B4:9FD7 AD 22 0E    LDA $0E22  [$7E:0E22]  ;|
$B4:9FDA 18          CLC                    ;|
$B4:9FDB 69 00 00    ADC #$0000             ;|
$B4:9FDE 85 12       STA $12    [$7E:0012]  ;|
$B4:9FE0 A9 00 0A    LDA #$0A00             ;|
$B4:9FE3 85 26       STA $26    [$7E:0026]  ;} Add debug spritemap index ([$0E24] >> 4 & Fh) + 4 to OAM at position ([$0E20] + 10h, [$0E22]) with palette 5
$B4:9FE5 AD 24 0E    LDA $0E24  [$7E:0E24]  ;|
$B4:9FE8 29 F0 00    AND #$00F0             ;|
$B4:9FEB 4A          LSR A                  ;|
$B4:9FEC 4A          LSR A                  ;|
$B4:9FED 4A          LSR A                  ;|
$B4:9FEE 4A          LSR A                  ;|
$B4:9FEF 18          CLC                    ;|
$B4:9FF0 69 04 00    ADC #$0004             ;|
$B4:9FF3 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:9FF7 AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$B4:9FFA 18          CLC                    ;|
$B4:9FFB 69 18 00    ADC #$0018             ;|
$B4:9FFE 85 14       STA $14    [$7E:0014]  ;|
$B4:A000 A9 00 0A    LDA #$0A00             ;|
$B4:A003 85 26       STA $26    [$7E:0026]  ;|
$B4:A005 AD 22 0E    LDA $0E22  [$7E:0E22]  ;|
$B4:A008 18          CLC                    ;} Add debug spritemap index ([$0E24] & Fh) + 4 to OAM at position ([$0E20] + 18h, [$0E22]) with palette 5
$B4:A009 69 00 00    ADC #$0000             ;|
$B4:A00C 85 12       STA $12    [$7E:0012]  ;|
$B4:A00E AD 24 0E    LDA $0E24  [$7E:0E24]  ;|
$B4:A011 29 0F 00    AND #$000F             ;|
$B4:A014 18          CLC                    ;|
$B4:A015 69 04 00    ADC #$0004             ;|
$B4:A018 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ;/
$B4:A01C 60          RTS
}


;;; $A01D: Add debug spritemap to OAM ;;;
{
;; Parameters:
;;     A:   Index into $A201 table
;;     $12: Y position of spritemap centre
;;     $14: X position of spritemap centre
;;     $26: Palette bits of sprite. If zero, spritemap entry palette is used

; Spritemap format is roughly:
;     nnnn         ; Number of entries (2 bytes)
;     xxxx yy attt ; Entry 0 (5 bytes)
;     ...          ; Entry 1...
; Where:
;     n = number of entries
;     x = X offset of sprite from centre
;     y = Y offset of sprite from centre
;     a = attributes
;     t = tile number

; More specifically, a spritemap entry is:
;     00000s0xxxxxxxxx yyyyyyyy YXppPPPttttttttt
; Where:
;     s = size bit <-- This is different to the regular spritemap format
;     x = X offset of sprite from centre
;     y = Y offset of sprite from centre
;     Y = Y flip
;     X = X flip
;     P = palette
;     p = priority (relative to background)
;     t = tile number
$B4:A01D 08          PHP
$B4:A01E E2 20       SEP #$20
$B4:A020 8B          PHB
$B4:A021 4B          PHK                    ;\
$B4:A022 AB          PLB                    ;} DB = $B4
$B4:A023 C2 30       REP #$30
$B4:A025 0A          ASL A                  ;\
$B4:A026 AA          TAX                    ;|
$B4:A027 BD 01 A2    LDA $A201,x            ;} Y = [$A201 + [A] * 2] (spritemap address)
$B4:A02A A8          TAY                    ;/
$B4:A02B B9 00 00    LDA $0000,y            ; $18 = [[Y]] (number of entries)
$B4:A02E C8          INY                    ;\
$B4:A02F C8          INY                    ;} Y += 2
$B4:A030 85 18       STA $18    [$7E:0018]
$B4:A032 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]

; LOOP
$B4:A035 B9 00 00    LDA $0000,y
$B4:A038 85 1A       STA $1A    [$7E:001A]
$B4:A03A 29 FF 01    AND #$01FF             ;\
$B4:A03D C8          INY                    ;|
$B4:A03E C8          INY                    ;|
$B4:A03F 18          CLC                    ;} OAM entry X position = [$14] + ([[Y]] & 1FFh)
$B4:A040 65 14       ADC $14    [$7E:0014]  ;|
$B4:A042 9D 70 03    STA $0370,x            ;/
$B4:A045 E8          INX
$B4:A046 A5 1B       LDA $1B    [$7E:001B]  ;\
$B4:A048 29 02 00    AND #$0002             ;} If [[Y]] & 200h != 0:
$B4:A04B F0 1A       BEQ $1A    [$A067]     ;/
$B4:A04D 8A          TXA                    ;\
$B4:A04E 85 1C       STA $1C    [$7E:001C]  ;|
$B4:A050 4A          LSR A                  ;|
$B4:A051 5A          PHY                    ;|
$B4:A052 A8          TAY                    ;|
$B4:A053 29 0E 00    AND #$000E             ;|
$B4:A056 AA          TAX                    ;|
$B4:A057 B9 01 A1    LDA $A101,y            ;} Set OAM entry size bit
$B4:A05A A8          TAY                    ;|
$B4:A05B BD E1 A0    LDA $A0E1,x            ;|
$B4:A05E 19 70 05    ORA $0570,y            ;|
$B4:A061 99 70 05    STA $0570,y            ;|
$B4:A064 7A          PLY                    ;|
$B4:A065 A6 1C       LDX $1C    [$7E:001C]  ;/

$B4:A067 BD 70 03    LDA $0370,x            ;\
$B4:A06A 29 01 00    AND #$0001             ;} If [OAM entry X position] & 100h != 0:
$B4:A06D F0 1A       BEQ $1A    [$A089]     ;/
$B4:A06F 8A          TXA                    ;\
$B4:A070 85 1C       STA $1C    [$7E:001C]  ;|
$B4:A072 4A          LSR A                  ;|
$B4:A073 5A          PHY                    ;|
$B4:A074 A8          TAY                    ;|
$B4:A075 29 0E 00    AND #$000E             ;|
$B4:A078 AA          TAX                    ;|
$B4:A079 B9 01 A1    LDA $A101,y            ;} Set OAM entry X position high bit
$B4:A07C A8          TAY                    ;|
$B4:A07D BD F1 A0    LDA $A0F1,x            ;|
$B4:A080 19 70 05    ORA $0570,y            ;|
$B4:A083 99 70 05    STA $0570,y            ;|
$B4:A086 7A          PLY                    ;|
$B4:A087 A6 1C       LDX $1C    [$7E:001C]  ;/

$B4:A089 E2 20       SEP #$20
$B4:A08B B9 00 00    LDA $0000,y            ;\
$B4:A08E 30 0B       BMI $0B    [$A09B]     ;|
$B4:A090 18          CLC                    ;|
$B4:A091 65 12       ADC $12    [$7E:0012]  ;|
$B4:A093 B0 15       BCS $15    [$A0AA]     ;|
$B4:A095 C9 F0       CMP #$F0               ;|
$B4:A097 90 13       BCC $13    [$A0AC]     ;|
$B4:A099 80 0F       BRA $0F    [$A0AA]     ;|
                                            ;|
$B4:A09B 18          CLC                    ;|
$B4:A09C 65 12       ADC $12    [$7E:0012]  ;|
$B4:A09E B0 06       BCS $06    [$A0A6]     ;} OAM entry Y position = clamp([$12] + [[Y] + 2], -10h, F0h)
$B4:A0A0 C9 F0       CMP #$F0               ;|
$B4:A0A2 B0 08       BCS $08    [$A0AC]     ;|
$B4:A0A4 80 04       BRA $04    [$A0AA]     ;|
                                            ;|
$B4:A0A6 C9 F0       CMP #$F0               ;|
$B4:A0A8 90 02       BCC $02    [$A0AC]     ;|
                                            ;|
$B4:A0AA A9 F0       LDA #$F0               ;|
                                            ;|
$B4:A0AC 9D 70 03    STA $0370,x            ;/
$B4:A0AF C2 20       REP #$20
$B4:A0B1 E8          INX
$B4:A0B2 C8          INY
$B4:A0B3 A5 26       LDA $26    [$7E:0026]  ;\
$B4:A0B5 F0 0A       BEQ $0A    [$A0C1]     ;} If [$26] != 0:
$B4:A0B7 B9 00 00    LDA $0000,y            ;\
$B4:A0BA 29 FF F1    AND #$F1FF             ;} OAM entry tile number and attributes = [[Y] + 3] & ~E00h | [$26]
$B4:A0BD 05 26       ORA $26    [$7E:0026]  ;/
$B4:A0BF 80 03       BRA $03    [$A0C4]

                                            ; Else ([$26] = 0):
$B4:A0C1 B9 00 00    LDA $0000,y            ; OAM entry tile number and attributes = [[Y] + 3]

$B4:A0C4 9D 70 03    STA $0370,x
$B4:A0C7 C8          INY                    ;\
$B4:A0C8 C8          INY                    ;} Y += 5 (next spritemap entry)
$B4:A0C9 E8          INX                    ;\
$B4:A0CA E8          INX                    ;} X += 4 (next OAM entry)
$B4:A0CB E0 FF 01    CPX #$01FF             ;\
$B4:A0CE 10 07       BPL $07    [$A0D7]     ;} If [X] < 1FFh:
$B4:A0D0 C6 18       DEC $18    [$7E:0018]  ; Decrement $18 (number of spritemap entries)
$B4:A0D2 F0 03       BEQ $03    [$A0D7]     ; If [$18] != 0:
$B4:A0D4 4C 35 A0    JMP $A035  [$B4:A035]  ; Go to LOOP

$B4:A0D7 8E 90 05    STX $0590  [$7E:0590]  ; OAM stack pointer = [X]
$B4:A0DA E2 20       SEP #$20
$B4:A0DC AB          PLB
$B4:A0DD C2 20       REP #$20
$B4:A0DF 28          PLP
$B4:A0E0 6B          RTL

; OAM size bits
$B4:A0E1             dw 0002, 0008, 0020, 0080, 0200, 0800, 2000, 8000

; OAM X position high bits
$B4:A0F1             dw 0001, 0004, 0010, 0040, 0100, 0400, 1000, 4000

; High OAM indices (indexed by [(low) OAM index] / 2)
$B4:A101             dw 0000,0000,0000,0000,0000,0000,0000,0000,
                        0002,0002,0002,0002,0002,0002,0002,0002,
                        0004,0004,0004,0004,0004,0004,0004,0004,
                        0006,0006,0006,0006,0006,0006,0006,0006,
                        0008,0008,0008,0008,0008,0008,0008,0008,
                        000A,000A,000A,000A,000A,000A,000A,000A,
                        000C,000C,000C,000C,000C,000C,000C,000C,
                        000E,000E,000E,000E,000E,000E,000E,000E,
                        0010,0010,0010,0010,0010,0010,0010,0010,
                        0012,0012,0012,0012,0012,0012,0012,0012,
                        0014,0014,0014,0014,0014,0014,0014,0014,
                        0016,0016,0016,0016,0016,0016,0016,0016,
                        0018,0018,0018,0018,0018,0018,0018,0018,
                        001A,001A,001A,001A,001A,001A,001A,001A,
                        001C,001C,001C,001C,001C,001C,001C,001C,
                        001E,001E,001E,001E,001E,001E,001E,001E
}
}


;;; $A201: Debug spritemap addresses ;;;
{
$B4:A201             dw A327,A469,A5AB,A6ED,A82F,A836,A83D,A844,A84B,A852,A859,A860,A867,A86E,A875,A87C,
                        A883,A88A,A891,A898,BB2D,BB3E,BB4F,BB60,BB71,BB82,BB93,BBA4,B886,A8DE,A8E5,A8EC,
                        A8F3,A8FA,A901,A908,A90F,AA49,A9AC,AA6E,AB9E,ABC8,AC65,AD02,AD95,AE37,AEC5,AF5D,
                        B88D,B00E,B02E,B044,B064,B084,B0A4,B0C4,B0DF,B109,B11F,B13F,B150,B161,B186,B19C,
                        B1AD,B1C8,B1E3,B203,B21E,B23E,B254,B279,B28F,B2AA,B2CA,B2EF,B305,B31B,B336,B34C,
                        B362,B378,B39D,B3B8,B3CE,B3E4,B409,B429,B44E,B469,B48E,B4A4,B4BA,B4D0,B4E1,B4F7,
                        B50D,B528,B548,B559,B56F,B58F,B5AA,B5BB,B5E0,B605,B61B,B63B,B660,B676,B696,B6B6,
                        B6E0,B70A,B720,B73B,B74C,B776,B791,B7AC,B7C2,B7DD,B7F8,B80E,B81F,B83A,B855,B866,
                        B8B7,B8E1,B90B,B935,B95F,B989,B9B3,B9DD,BA07,BA31,BA5B,BA85,BAAF,BAD9,BB03,BBB5,
                        BBCB,BBEB,BC0B
}


;;; $A327..BC25: Debug spritemaps ;;;
{
; 0: Palette viewer - left half
$B4:A327             dx 0040, 0018,18,3F77, 0010,18,3F76, 0008,18,3F75, 0000,18,3F74, 01F8,18,3F73, 01F0,18,3F72, 01E8,18,3F71, 01E0,18,3F70, 0018,10,3D67, 0010,10,3D66, 0008,10,3D65, 0000,10,3D64, 01F8,10,3D63, 01F0,10,3D62, 01E8,10,3D61, 01E0,10,3D60, 0018,08,3B57, 0010,08,3B56, 0008,08,3B55, 0000,08,3B54, 01F8,08,3B53, 01F0,08,3B52, 01E8,08,3B51, 01E0,08,3B50, 0018,00,3947, 0010,00,3946, 0008,00,3945, 0000,00,3944, 01F8,00,3943, 01F0,00,3942, 01E8,00,3941, 01E0,00,3940, 0018,F8,3737, 0010,F8,3736, 0008,F8,3735, 0000,F8,3734, 01F8,F8,3733, 01F0,F8,3732, 01E8,F8,3731, 01E0,F8,3730, 0018,F0,3527, 0010,F0,3526, 0008,F0,3525, 0000,F0,3524, 01F8,F0,3523, 01F0,F0,3522, 01E8,F0,3521, 01E0,F0,3520, 0018,E8,3317, 0010,E8,3316, 0008,E8,3315, 0000,E8,3314, 01F8,E8,3313, 01F0,E8,3312, 01E8,E8,3311, 01E0,E8,3310, 0018,E0,3107, 0010,E0,3106, 0008,E0,3105, 0000,E0,3104, 01F8,E0,3103, 01F0,E0,3102, 01E8,E0,3101, 01E0,E0,3300

; 1: Palette viewer - right half
$B4:A469             dx 0040, 0018,18,3F7F, 0010,18,3F7E, 0008,18,3F7D, 0000,18,3F7C, 01F8,18,3F7B, 01F0,18,3F7A, 01E8,18,3F79, 01E0,18,3F78, 0018,10,3D6F, 0010,10,3D6E, 0008,10,3D6D, 0000,10,3D6C, 01F8,10,3D6B, 01F0,10,3D6A, 01E8,10,3D69, 01E0,10,3D68, 0018,08,3B5F, 0010,08,3B5E, 0008,08,3B5D, 0000,08,3B5C, 01F8,08,3B5B, 01F0,08,3B5A, 01E8,08,3B59, 01E0,08,3B58, 0018,00,394F, 0010,00,394E, 0008,00,394D, 0000,00,394C, 01F8,00,394B, 01F0,00,394A, 01E8,00,3949, 01E0,00,3948, 0018,F8,373F, 0010,F8,373E, 0008,F8,373D, 0000,F8,373C, 01F8,F8,373B, 01F0,F8,373A, 01E8,F8,3739, 01E0,F8,3738, 0018,F0,352F, 0010,F0,352E, 0008,F0,352D, 0000,F0,352C, 01F8,F0,352B, 01F0,F0,352A, 01E8,F0,3529, 01E0,F0,3528, 0018,E8,331F, 0010,E8,331E, 0008,E8,331D, 0000,E8,331C, 01F8,E8,331B, 01F0,E8,331A, 01E8,E8,3319, 01E0,E8,3318, 0018,E0,310F, 0010,E0,310E, 0008,E0,310D, 0000,E0,310C, 01F8,E0,310B, 01F0,E0,310A, 01E8,E0,3109, 01E0,E0,3108

; 2: Sprite tiles viewer - 2nd half
$B4:A5AB             dx 0040, C230,30,33EE, C220,30,33EC, C210,30,33EA, C200,30,33E8, C3F0,30,33E6, C3E0,30,33E4, C3D0,30,33E2, C3C0,30,33E0, C230,20,33CE, C220,20,33CC, C210,20,33CA, C200,20,33C8, C3F0,20,33C6, C3E0,20,33C4, C3D0,20,33C2, C3C0,20,33C0, C230,10,33AE, C220,10,33AC, C210,10,33AA, C200,10,33A8, C3F0,10,33A6, C3E0,10,33A4, C3D0,10,33A2, C3C0,10,33A0, C230,00,338E, C220,00,338C, C210,00,338A, C200,00,3388, C3F0,00,3386, C3E0,00,3384, C3D0,00,3382, C3C0,00,3380, C230,F0,336E, C220,F0,336C, C210,F0,336A, C200,F0,3368, C3F0,F0,3366, C3E0,F0,3364, C3D0,F0,3362, C3C0,F0,3360, C230,E0,334E, C220,E0,334C, C210,E0,334A, C200,E0,3348, C3F0,E0,3346, C3E0,E0,3344, C3D0,E0,3342, C3C0,E0,3340, C230,D0,332E, C220,D0,332C, C210,D0,332A, C200,D0,3328, C3F0,D0,3326, C3E0,D0,3324, C3D0,D0,3322, C3C0,D0,3320, C230,C0,330E, C220,C0,330C, C210,C0,330A, C200,C0,3308, C3F0,C0,3306, C3E0,C0,3304, C3D0,C0,3302, C3C0,C0,3300

; 3: Sprite tiles viewer - 1st half
$B4:A6ED             dx 0040, C230,30,30EE, C220,30,30EC, C210,30,30EA, C200,30,30E8, C3F0,30,30E6, C3E0,30,30E4, C3D0,30,30E2, C3C0,30,30E0, C230,20,30CE, C220,20,30CC, C210,20,30CA, C200,20,30C8, C3F0,20,30C6, C3E0,20,30C4, C3D0,20,30C2, C3C0,20,30C0, C230,10,3AAE, C220,10,3AAC, C210,10,3AAA, C200,10,3AA8, C3F0,10,3AA6, C3E0,10,3AA4, C3D0,10,3AA2, C3C0,10,3AA0, C230,00,3A8E, C220,00,3A8C, C210,00,3A8A, C200,00,3A88, C3F0,00,3A86, C3E0,00,3A84, C3D0,00,3A82, C3C0,00,3A80, C230,F0,3A6E, C220,F0,3A6C, C210,F0,3A6A, C200,F0,3A68, C3F0,F0,3A66, C3E0,F0,3A64, C3D0,F0,3A62, C3C0,F0,3A60, C230,E0,3A4E, C220,E0,3A4C, C210,E0,3A4A, C200,E0,3A48, C3F0,E0,3A46, C3E0,E0,3A44, C3D0,E0,3A42, C3C0,E0,3A40, C230,D0,3A2E, C220,D0,3A2C, C210,D0,3A2A, C200,D0,3A28, C3F0,D0,3A26, C3E0,D0,3A24, C3D0,D0,3A22, C3C0,D0,3A20, C230,C0,380E, C220,C0,380C, C210,C0,380A, C200,C0,3808, C3F0,C0,3806, C3E0,C0,3804, C3D0,C0,3802, C3C0,C0,3800

; Hex digits
$B4:A82F             dx 0001, 01F8,F8,30D0 ; 4: '0'
$B4:A836             dx 0001, 01F8,F8,30D1 ; 5: '1'
$B4:A83D             dx 0001, 01F8,F8,30D2 ; 6: '2'
$B4:A844             dx 0001, 01F8,F8,30D3 ; 7: '3'
$B4:A84B             dx 0001, 01F8,F8,30D4 ; 8: '4'
$B4:A852             dx 0001, 01F8,F8,30D5 ; 9: '5'
$B4:A859             dx 0001, 01F8,F8,30D6 ; Ah: '6'
$B4:A860             dx 0001, 01F8,F8,30D7 ; Bh: '7'
$B4:A867             dx 0001, 01F8,F8,30D8 ; Ch: '8'
$B4:A86E             dx 0001, 01F8,F8,30D9 ; Dh: '9'
$B4:A875             dx 0001, 01F8,F8,30DA ; Eh: 'A'
$B4:A87C             dx 0001, 01F8,F8,30DB ; Fh: 'B'
$B4:A883             dx 0001, 01F8,F8,30DC ; 10h: 'C'
$B4:A88A             dx 0001, 01F8,F8,30DD ; 11h: 'D'
$B4:A891             dx 0001, 01F8,F8,30DE ; 12h: 'E'
$B4:A898             dx 0001, 01F8,F8,30DF ; 13h: 'F'

$B4:A89F             dx 0001, 01F8,F8,30E0 ; Unused: 'a'
$B4:A8A6             dx 0001, 01F8,F8,30E1 ; Unused: 'b'
$B4:A8AD             dx 0001, 01F8,F8,30E2 ; Unused: 'c'
$B4:A8B4             dx 0001, 01F8,F8,30E3 ; Unused: 'd'
$B4:A8BB             dx 0001, 01F8,F8,30E4 ; Unused: 'e'
$B4:A8C2             dx 0001, 01F8,F8,30E5 ; Unused: 'f'
$B4:A8C9             dx 0001, 01F8,F8,30E6 ; Unused: 'g'
$B4:A8D0             dx 0001, 01F8,F8,30E7 ; Unused: 'h'
$B4:A8D7             dx 0001, 01F8,F8,30E8 ; Unused: 'i'
$B4:A8DE             dx 0001, 01F8,F8,30E9 ; 1Dh: 'j'
$B4:A8E5             dx 0001, 01F8,F8,30EA ; 1Eh: 'k'
$B4:A8EC             dx 0001, 01F8,F8,30EB ; 1Fh: 'l'
$B4:A8F3             dx 0001, 01F8,F8,30EC ; 20h: 'm'
$B4:A8FA             dx 0001, 01F8,F8,30ED ; 21h: 'n'
$B4:A901             dx 0001, 01F8,F8,30EE ; 22h: 'o'
$B4:A908             dx 0001, 01F8,F8,30EF ; 23h: 'p'

; Unused. 24h ('    P  :', '   UPTM:', 'TK_POSE:', 'TK_OPT0:', 'TK_OPT1:')
$B4:A90F             dx 001F, 0018,18,30CC, 0018,10,30CC, 0010,18,30D1, 0010,10,30D0, 0008,18,30C5, 0008,10,30C5, 01F0,18,30FD, 01F8,18,30C0, 0000,18,30C1, 0000,10,30C1, 01F8,10,30C0, 01F0,10,30FD, 01E8,18,30BA, 01E8,10,30BA, 01E0,18,30C5, 01E0,10,30C5, 0008,08,30C4, 0010,08,30B4, 0000,08,30C0, 01F8,08,30C1, 01F0,08,30FD, 01E8,08,30BA, 01E0,08,30C5, 0018,08,30CC, 0018,00,30CC, 0018,F8,30CC, 0010,00,30BC, 0008,00,30C5, 0000,00,30C1, 01F8,00,30C6, 0000,F8,30C1

; Unused. 26h ('    P  P', '   :TK_X', 'TK_PYo::', 'itrosTK_', 'neTosK_H')
$B4:A9AC             dx 001F, 0018,18,30B7, 0018,10,30FD, 0010,18,30FD, 0010,10,30BA, 0008,18,30BA, 0008,10,30C5, 01F0,18,30C5, 01F8,18,30EE, 0000,18,30F2, 0000,10,30F2, 01F8,10,30EE, 01F0,10,30F1, 01E8,18,30E4, 01E8,10,30F3, 01E0,18,30ED, 01E0,10,30E8, 0008,08,30EE, 0010,08,30CC, 0000,08,30CA, 01F8,08,30C1, 01F0,08,30FD, 01E8,08,30BA, 01E0,08,30C5, 0018,08,30CC, 0018,00,30C9, 0018,F8,30C1, 0010,00,30FD, 0008,00,30BA, 0000,00,30C5, 01F8,00,30CC, 0000,F8,30C1

; 25h: Enemy debugger enemy indicator ('<=: Move')
$B4:AA49             dx 0007, 0010,F8,30E4, 0008,F8,30F5, 0000,F8,30EE, 01F8,F8,30BC, 01F0,F8,30CC, 01E8,F8,30FB, 01E0,F8,30FA

; 27h: Enemy debugger text ('TK_PosX:', 'TK_PosY:', 'TK_HP  :', 'Pointer:')
$B4:AA6E             dx 001E, 0010,F8,30F1, 0008,F8,30E4, 0000,F8,30F3, 01F8,F8,30ED, 01F0,F8,30E8, 01E8,F8,30EE, 0018,F8,30CC, 01E0,F8,30C1, 0018,F0,30CC, 0000,F0,30C1, 01F8,F0,30B7, 01F0,F0,30FD, 01E8,F0,30BA, 01E0,F0,30C5, 0000,E8,30EE, 0008,E8,30F2, 0008,E0,30F2, 0000,E0,30EE, 0018,E8,30CC, 0010,E8,30CA, 01F8,E8,30C1, 01F0,E8,30FD, 01E8,E8,30BA, 01E0,E8,30C5, 0018,E0,30CC, 0010,E0,30C9, 01F8,E0,30C1, 01F0,E0,30FD, 01E8,E0,30BA, 01E0,E0,30C5

; Unused. ('Pointer:', 'TK_PosX:', 'TK_PosY:', 'TK_HP  :')
$B4:AB06             dx 001E, 0018,F8,30CC, 0000,F8,30C1, 01F8,F8,30B7, 01F0,F8,30FD, 01E8,F8,30BA, 01E0,F8,30C5, 0000,F0,30EE, 0008,F0,30F2, 0008,E8,30F2, 0000,E8,30EE, 0010,E0,30F1, 0008,E0,30E4, 0000,E0,30F3, 01F8,E0,30ED, 01F0,E0,30E8, 01E8,E0,30EE, 0018,F0,30CC, 0010,F0,30CA, 01F8,F0,30C1, 01F0,F0,30FD, 01E8,F0,30BA, 01E0,F0,30C5, 0018,E8,30CC, 0010,E8,30C9, 01F8,E8,30C1, 01F0,E8,30FD, 01E8,E8,30BA, 01E0,E8,30C5, 0018,E0,30CC, 01E0,E0,30C1

; Unused. 28h: ('<=: Move:')
$B4:AB9E             dx 0008, 0018,F8,30CC, 0010,F8,30E4, 0008,F8,30F5, 0000,F8,30EE, 01F8,F8,30BC, 01F0,F8,30CC, 01E8,F8,30FB, 01E0,F8,30FA

; 29h: ('TK_UPTM:', 'TK_Stat:', 'TK_Num :', 'TK_Bank:')
$B4:ABC8             dx 001F, 0010,F8,30EA, 0008,F8,30ED, 0000,F8,30E0, 01F8,F8,30B1, 0000,F0,30F4, 0008,F0,30EC, 01F8,F0,30BD, 0010,E8,30F3, 0008,E8,30E0, 0000,E8,30F3, 01F8,E8,30C4, 0018,F8,30CC, 0018,F0,30CC, 01F0,F8,30FD, 01F0,F0,30FD, 01E8,F8,30BA, 01E8,F0,30BA, 01E0,F8,30C5, 01E0,F0,30C5, 01F0,E8,30FD, 01E8,E8,30BA, 01E0,E8,30C5, 0018,E8,30CC, 0018,E0,30CC, 0010,E0,30BC, 0008,E0,30C5, 0000,E0,30C1, 01F8,E0,30C6, 01F0,E0,30FD, 01E8,E0,30BA, 01E0,E0,30C5

; 2Ah: ('Switch :', 'Switch2:', 'ColorPa:', 'CharaOf:')
$B4:AC65             dx 001F, 0010,F8,30E5, 0008,F8,30C0, 0000,F8,30E0, 01F8,F8,30F1, 01F0,F8,30E0, 01E8,F8,30E7, 01E0,F8,30B2, 0018,F8,30CC, 0018,F0,30CC, 0010,F0,30E0, 0008,F0,30C1, 0000,F0,30F1, 01F8,F0,30EE, 01F0,F0,30EB, 01E8,F0,30EE, 01E0,F0,30B2, 01E8,E8,30F6, 01E0,E8,30C4, 0018,E8,30CC, 0018,E0,30CC, 0010,E8,30D2, 0008,E8,30E7, 0008,E0,30E7, 0000,E8,30E2, 0000,E0,30E2, 01F8,E8,30F3, 01F8,E0,30F3, 01F0,E8,30E8, 01F0,E0,30E8, 01E8,E0,30F6, 01E0,E0,30C4

; 2Bh: ('PoseAdr:', 'WaitTim:', 'LpCnt  :', 'Patern :')
$B4:AD02             dx 001D, 01F8,F0,30ED, 0000,F0,30F3, 01F0,F0,30B2, 01E8,F0,30EF, 01E0,F0,30BB, 0010,E8,30EC, 0008,E8,30E8, 0000,E8,30C5, 01F8,E8,30F3, 01F0,E8,30E8, 01E8,E8,30E0, 01E0,E8,30C8, 0018,F0,30CC, 0018,F8,30CC, 0018,E8,30CC, 0018,E0,30CC, 0010,E0,30F1, 0008,E0,30E3, 0000,E0,30B0, 01F8,E0,30E4, 01F0,E0,30F2, 01E8,E0,30EE, 0008,F8,30ED, 0000,F8,30F1, 01F8,F8,30E4, 01F0,F8,30F3, 01E8,F8,30E0, 01E0,F8,30C1, 01E0,E0,30C1

; 2Ch: ('FlashCo:', 'IceCoun:', 'HitCoun:', 'PlplCou:')
$B4:AD95             dx 0020, 0010,F8,30F4, 0008,F8,30EE, 0000,F8,30B2, 01F0,F8,30EF, 01F8,F8,30EB, 01E8,F8,30EB, 01E0,F8,30C1, 0010,F0,30ED, 0008,F0,30F4, 0000,F0,30EE, 01F8,F0,30B2, 01F0,F0,30F3, 01E8,F0,30E8, 01E0,F0,30B7, 0010,E8,30ED, 0008,E8,30F4, 0000,E8,30EE, 01F8,E8,30B2, 01F0,E8,30E4, 01E8,E8,30E2, 01E0,E8,30B8, 0010,E0,30EE, 0008,E0,30B2, 0000,E0,30E7, 01F8,E0,30F2, 01F0,E0,30E0, 01E8,E0,30EB, 01E0,E0,30B5, 0018,F8,30CC, 0018,F0,30CC, 0018,E8,30CC, 0018,E0,30CC

; 2Dh: ('Pwork0 :', 'Pwork1 :', 'Pwork2 :', 'Pwork3 :')
$B4:AE37             dx 001C, 0018,F8,30CC, 0018,F0,30CC, 0018,E8,30CC, 0018,E0,30CC, 0008,F8,30D3, 0008,F0,30D2, 0008,E8,30D1, 0008,E0,30D0, 0000,F8,30EA, 01F8,F8,30F1, 01F0,F8,30EE, 01E8,F8,30F6, 01E0,F8,30C1, 0000,F0,30EA, 01F8,F0,30F1, 01F0,F0,30EE, 01E8,F0,30F6, 01E0,F0,30C1, 0000,E8,30EA, 01F8,E8,30F1, 01F0,E8,30EE, 01E8,E8,30F6, 01E0,E8,30C1, 0000,E0,30EA, 01F8,E0,30F1, 01F0,E0,30EE, 01E8,E0,30F6, 01E0,E0,30C1

; 2Eh: ('Pwork4 :', 'Pwork5 :', 'InitOP0:', 'InitOP1:')
$B4:AEC5             dx 001E, 0010,F8,30D1, 0008,F8,30C1, 0000,F8,30C0, 01F8,F8,30F3, 01F0,F8,30E8, 01E8,F8,30ED, 01E0,F8,30B8, 0010,F0,30D0, 0008,F0,30C1, 0000,F0,30C0, 01F8,F0,30F3, 01F0,F0,30E8, 01E8,F0,30ED, 01E0,F0,30B8, 0008,E8,30D5, 0008,E0,30D4, 0018,F8,30CC, 0018,F0,30CC, 0018,E8,30CC, 0018,E0,30CC, 0000,E8,30EA, 01F8,E8,30F1, 01F0,E8,30EE, 01E8,E8,30F6, 01E0,E8,30C1, 0000,E0,30EA, 01F8,E0,30F1, 01F0,E0,30EE, 01E8,E0,30F6, 01E0,E0,30C1

; 2Fh: Enemy spawn data editor text ('PosX:', 'PosY:', 'Pose:', 'Swt1:', 'Swt2:', 'Opt0:', 'Opt1:')
$B4:AF5D             dx 0023, 0000,18,30CC, 0000,10,30CC, 0000,00,30CC, 0000,08,30CC, 0000,F8,30CC, 0000,F0,30CC, 0000,E8,30CC, 01F8,00,30D1, 01F8,18,30D1, 01F8,10,30D0, 01F0,F0,30F2, 01F0,E8,30F2, 01E8,F0,30EE, 01E8,E8,30EE, 01E0,F0,30C1, 01E0,E8,30C1, 01F8,F0,30CA, 01F8,E8,30C9, 01E0,F8,30C1, 01F0,18,30F3, 01E8,18,30EF, 01E0,18,30C0, 01F0,10,30F3, 01E8,10,30EF, 01E0,10,30C0, 01F8,08,30D2, 01F0,08,30F3, 01F0,00,30F3, 01E8,08,30F6, 01E0,08,30C4, 01E8,00,30F6, 01E0,00,30C4, 01F8,F8,30E4, 01F0,F8,30F2, 01E8,F8,30EE


;;; $B00E: Enemy names ;;;
{
; 31h: 'ATOMIC'
$B4:B00E             dx 0006, 0008,E0,30B2, 0000,E0,30B8, 01F8,E0,30BC, 01F0,E0,30C0, 01E8,E0,30C5, 01E0,E0,30B0

; 32h: 'BANG'
$B4:B02E             dx 0004, 01F8,E0,30B6, 01F0,E0,30BD, 01E8,E0,30B0, 01E0,E0,30B1

; 33h: 'BATTA1'
$B4:B044             dx 0006, 0008,E0,30D1, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 34h: 'BATTA2'
$B4:B064             dx 0006, 0008,E0,30D2, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 35h: 'BATTA3'
$B4:B084             dx 0006, 0008,E0,30D3, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 36h: 'BOTOON'
$B4:B0A4             dx 0006, 0008,E0,30BD, 01F0,E0,30C5, 0000,E0,30C0, 01F8,E0,30C0, 01E8,E0,30C0, 01E0,E0,30B1

; 37h: 'BOYON'
$B4:B0C4             dx 0005, 0000,E0,30BD, 01F8,E0,30C0, 01F0,E0,30CA, 01E8,E0,30C0, 01E0,E0,30B1

; 38h: 'DESSGEEG'
$B4:B0DF             dx 0008, 0018,E0,30B6, 0010,E0,30B4, 0008,E0,30B4, 0000,E0,30B6, 01F8,E0,30C4, 01F0,E0,30C4, 01E8,E0,30B4, 01E0,E0,30B3

; 39h: 'DORI'
$B4:B109             dx 0004, 01F8,E0,30B8, 01F0,E0,30C3, 01E8,E0,30C0, 01E0,E0,30B3

; 3Ah: 'DRAGON'
$B4:B11F             dx 0006, 0008,E0,30BD, 0000,E0,30C0, 01F8,E0,30B6, 01F0,E0,30B0, 01E8,E0,30C3, 01E0,E0,30B3

; 3Bh: 'EBI'
$B4:B13F             dx 0003, 01F0,E0,30B8, 01E8,E0,30B1, 01E0,E0,30B4

; 3Ch: 'EYE'
$B4:B150             dx 0003, 01F0,E0,30B4, 01E8,E0,30CA, 01E0,E0,30B4

; 3Dh: 'NAMIHEI'
$B4:B161             dx 0007, 0000,E0,30B7, 0010,E0,30B8, 0008,E0,30B4, 01F8,E0,30B8, 01F0,E0,30BC, 01E8,E0,30B0, 01E0,E0,30BD

; 3Eh: 'FISH'
$B4:B186             dx 0004, 01F8,E0,30B7, 01F0,E0,30C4, 01E8,E0,30B8, 01E0,E0,30B5

; 3Fh: 'GAI'
$B4:B19C             dx 0003, 01F0,E0,30B8, 01E8,E0,30B0, 01E0,E0,30B6

; 40h: 'GAMET'
$B4:B1AD             dx 0005, 0000,E0,30C5, 01F8,E0,30B4, 01F0,E0,30BC, 01E8,E0,30B0, 01E0,E0,30B6

; 41h: 'GEEGA'
$B4:B1C8             dx 0005, 01F0,E0,30B4, 0000,E0,30B0, 01F8,E0,30B6, 01E8,E0,30B4, 01E0,E0,30B6

; 42h: 'GERUDA'
$B4:B1E3             dx 0006, 0008,E0,30B0, 0000,E0,30B3, 01F8,E0,30C6, 01F0,E0,30C3, 01E8,E0,30B4, 01E0,E0,30B6

; 43h: 'GRAVY'
$B4:B203             dx 0005, 0000,E0,30CA, 01F8,E0,30C7, 01F0,E0,30B0, 01E8,E0,30C3, 01E0,E0,30B6

; 44h: 'HACHI1'
$B4:B21E             dx 0006, 0008,E0,30D1, 0000,E0,30B8, 01F8,E0,30B7, 01F0,E0,30B2, 01E8,E0,30B0, 01E0,E0,30B7

; 45h: 'HAND'
$B4:B23E             dx 0004, 01F8,E0,30B3, 01F0,E0,30BD, 01E8,E0,30B0, 01E0,E0,30B7

; 46h: 'HIBASHI'
$B4:B254             dx 0007, 0010,E0,30B8, 0008,E0,30B7, 0000,E0,30C4, 01F8,E0,30B0, 01F0,E0,30B1, 01E8,E0,30B8, 01E0,E0,30B7

; 47h: 'HIRU'
$B4:B279             dx 0004, 01F8,E0,30C6, 01F0,E0,30C3, 01E8,E0,30B8, 01E0,E0,30B7

; 48h: 'HOLTZ'
$B4:B28F             dx 0005, 0000,E0,30CB, 01F8,E0,30C5, 01F0,E0,30BB, 01E8,E0,30C0, 01E0,E0,30B7

; 49h: 'HOTARY'
$B4:B2AA             dx 0006, 0008,E0,30CA, 0000,E0,30C3, 01F8,E0,30B0, 01F0,E0,30C5, 01E8,E0,30C0, 01E0,E0,30B7

; 4Ah: 'HZOOMER'
$B4:B2CA             dx 0007, 0010,E0,30C3, 0008,E0,30B4, 0000,E0,30BC, 01F8,E0,30C0, 01F0,E0,30C0, 01E8,E0,30CB, 01E0,E0,30B7

; 4Bh: 'KAGO'
$B4:B2EF             dx 0004, 01F8,E0,30C0, 01F0,E0,30B6, 01E8,E0,30B0, 01E0,E0,30BA

; 4Ch: 'KAME'
$B4:B305             dx 0004, 01F8,E0,30B4, 01F0,E0,30BC, 01E8,E0,30B0, 01E0,E0,30BA

; 4Dh: 'KAMER'
$B4:B31B             dx 0005, 0000,E0,30C3, 01F8,E0,30B4, 01F0,E0,30BC, 01E8,E0,30B0, 01E0,E0,30BA

; 4Eh: 'KANI'
$B4:B336             dx 0004, 01F8,E0,30B8, 01F0,E0,30BD, 01E8,E0,30B0, 01E0,E0,30BA

; 4Fh: 'KOMA'
$B4:B34C             dx 0004, 01F8,E0,30B0, 01F0,E0,30BC, 01E8,E0,30C0, 01E0,E0,30BA

; 50h: 'KZAN'
$B4:B362             dx 0004, 01F8,E0,30BD, 01F0,E0,30B0, 01E8,E0,30CB, 01E0,E0,30BA

; 51h: 'LAVAMAN'
$B4:B378             dx 0007, 0010,E0,30BD, 0008,E0,30B0, 0000,E0,30BC, 01F8,E0,30B0, 01F0,E0,30C7, 01E0,E0,30BB, 01E8,E0,30B0

; 52h: 'MELLA'
$B4:B39D             dx 0005, 0000,E0,30B0, 01F8,E0,30BB, 01F0,E0,30BB, 01E8,E0,30B4, 01E0,E0,30BC

; 53h: 'MEMU'
$B4:B3B8             dx 0004, 01F8,E0,30C6, 01E8,E0,30B4, 01E0,E0,30BC, 01F0,E0,30BC

; 54h: 'MERO'
$B4:B3CE             dx 0004, 01F8,E0,30C0, 01F0,E0,30C3, 01E8,E0,30B4, 01E0,E0,30BC

; 55h: 'METALEE'
$B4:B3E4             dx 0007, 0010,E0,30B4, 0008,E0,30B4, 0000,E0,30BB, 01F8,E0,30B0, 01F0,E0,30C5, 01E8,E0,30B4, 01E0,E0,30BC

; 56h: 'METMOD'
$B4:B409             dx 0006, 0008,E0,30B3, 0000,E0,30C0, 01F8,E0,30BC, 01F0,E0,30C5, 01E8,E0,30B4, 01E0,E0,30BC

; 57h: 'METORID'
$B4:B429             dx 0007, 0010,E0,30B3, 0008,E0,30B8, 01F8,E0,30C3, 0000,E0,30C0, 01F0,E0,30C5, 01E8,E0,30B4, 01E0,E0,30BC

; 58h: 'MULTI'
$B4:B44E             dx 0005, 0000,E0,30B8, 01F8,E0,30C5, 01F0,E0,30BB, 01E8,E0,30C6, 01E0,E0,30BC

; 59h: 'MZOOMER'
$B4:B469             dx 0007, 01F8,E0,30C0, 01F0,E0,30C0, 01E8,E0,30CB, 0010,E0,30C3, 0008,E0,30B4, 0000,E0,30BC, 01E0,E0,30BC

; 5Ah: 'NDRA'
$B4:B48E             dx 0004, 01F8,E0,30B0, 01F0,E0,30C3, 01E8,E0,30B3, 01E0,E0,30BD

; 5Bh: 'NOMI'
$B4:B4A4             dx 0004, 01F8,E0,30B8, 01F0,E0,30BC, 01E8,E0,30C0, 01E0,E0,30BD

; 5Ch: 'NOVA'
$B4:B4BA             dx 0004, 01F8,E0,30B0, 01F0,E0,30C7, 01E8,E0,30C0, 01E0,E0,30BD

; 5Dh: 'OUM'
$B4:B4D0             dx 0003, 01F0,E0,30BC, 01E8,E0,30C6, 01E0,E0,30C0

; 5Eh: 'OUMU'
$B4:B4E1             dx 0004, 01F8,E0,30C6, 01F0,E0,30BC, 01E8,E0,30C6, 01E0,E0,30C0

; 5Fh: 'PIPE'
$B4:B4F7             dx 0004, 01F8,E0,30B4, 01F0,E0,30C1, 01E8,E0,30B8, 01E0,E0,30C1

; 60h: 'POLYP'
$B4:B50D             dx 0005, 0000,E0,30C1, 01F0,E0,30BB, 01F8,E0,30CA, 01E8,E0,30C0, 01E0,E0,30C1

; 61h: 'PUROMI'
$B4:B528             dx 0006, 0008,E0,30B8, 0000,E0,30BC, 01F8,E0,30C0, 01F0,E0,30C3, 01E8,E0,30C6, 01E0,E0,30C1

; 62h: 'PUU'
$B4:B548             dx 0003, 01F0,E0,30C6, 01E8,E0,30C6, 01E0,E0,30C1

; 63h: 'PUYO'
$B4:B559             dx 0004, 01F8,E0,30C0, 01F0,E0,30CA, 01E8,E0,30C6, 01E0,E0,30C1

; 64h: 'REFLEC'
$B4:B56F             dx 0006, 0008,E0,30B2, 0000,E0,30B4, 01F8,E0,30BB, 01F0,E0,30B5, 01E8,E0,30B4, 01E0,E0,30C3

; 65h: 'RINKA'
$B4:B58F             dx 0005, 0000,E0,30B0, 01F8,E0,30BA, 01F0,E0,30BD, 01E8,E0,30B8, 01E0,E0,30C3

; 66h: 'RIO'
$B4:B5AA             dx 0003, 01F0,E0,30C0, 01E8,E0,30B8, 01E0,E0,30C3

; 67h: 'RIPPER1'
$B4:B5BB             dx 0007, 0010,E0,30D1, 0000,E0,30B4, 01F8,E0,30C1, 01F0,E0,30C1, 01E8,E0,30B8, 0008,E0,30C3, 01E0,E0,30C3

; 68h: 'RIPPER2'
$B4:B5E0             dx 0007, 0010,E0,30D2, 0000,E0,30B4, 01F8,E0,30C1, 01F0,E0,30C1, 01E8,E0,30B8, 0008,E0,30C3, 01E0,E0,30C3

; 69h: 'ROBO'
$B4:B605             dx 0004, 01F8,E0,30C0, 01F0,E0,30B1, 01E8,E0,30C0, 01E0,E0,30C3

; 6Ah: 'RSTONE'
$B4:B61B             dx 0006, 0008,E0,30B4, 0000,E0,30BD, 01F8,E0,30C0, 01F0,E0,30C5, 01E8,E0,30C4, 01E0,E0,30C3

; 6Bh: 'SABOTEN'
$B4:B63B             dx 0007, 0010,E0,30BD, 0008,E0,30B4, 0000,E0,30C5, 01F8,E0,30C0, 01F0,E0,30B1, 01E8,E0,30B0, 01E0,E0,30C4

; 6Ch: 'SBUG'
$B4:B660             dx 0004, 01F8,E0,30B6, 01F0,E0,30C6, 01E8,E0,30B1, 01E0,E0,30C4

; 6Dh: 'SCLAYD'
$B4:B676             dx 0006, 0008,E0,30B3, 0000,E0,30CA, 01F8,E0,30B0, 01F0,E0,30BB, 01E8,E0,30B2, 01E0,E0,30C4

; 6Eh: 'SDEATH'
$B4:B696             dx 0006, 0008,E0,30B7, 0000,E0,30C5, 01F8,E0,30B0, 01F0,E0,30B4, 01E8,E0,30B3, 01E0,E0,30C4

; 6Fh: 'SHUTTER1'
$B4:B6B6             dx 0008, 0018,E0,30D1, 0010,E0,30C3, 0008,E0,30B4, 0000,E0,30C5, 01F8,E0,30C5, 01F0,E0,30C6, 01E8,E0,30B7, 01E0,E0,30C4

; 70h: 'SHUTTER2'
$B4:B6E0             dx 0008, 0018,E0,30D2, 0010,E0,30C3, 0008,E0,30B4, 0000,E0,30C5, 01F8,E0,30C5, 01F0,E0,30C6, 01E8,E0,30B7, 01E0,E0,30C4

; 71h: 'SIDE'
$B4:B70A             dx 0004, 01F8,E0,30B4, 01F0,E0,30B3, 01E8,E0,30B8, 01E0,E0,30C4

; 72h: 'SKREE'
$B4:B720             dx 0005, 0000,E0,30B4, 01F8,E0,30B4, 01F0,E0,30C3, 01E8,E0,30BA, 01E0,E0,30C4

; 73h: 'SPA'
$B4:B73B             dx 0003, 01F0,E0,30B0, 01E8,E0,30C1, 01E0,E0,30C4

; 74h: 'SQUEEWPT'
$B4:B74C             dx 0008, 0018,E0,30C5, 0010,E0,30C1, 0008,E0,30C8, 0000,E0,30B4, 01F8,E0,30B4, 01F0,E0,30C6, 01E8,E0,30C2, 01E0,E0,30C4

; 75h: 'SSIDE'
$B4:B776             dx 0005, 0000,E0,30B4, 01F8,E0,30B3, 01F0,E0,30B8, 01E8,E0,30C4, 01E0,E0,30C4

; 76h: 'STOKE'
$B4:B791             dx 0005, 0000,E0,30B4, 01F8,E0,30BA, 01F0,E0,30C0, 01E8,E0,30C5, 01E0,E0,30C4

; 77h: 'TOGE'
$B4:B7AC             dx 0004, 01E0,E0,30C5, 01F8,E0,30B4, 01F0,E0,30B6, 01E8,E0,30C0

; 78h: 'VIOLA'
$B4:B7C2             dx 0005, 01F8,E0,30BB, 0000,E0,30B0, 01F0,E0,30C0, 01E8,E0,30B8, 01E0,E0,30C7

; 79h: 'WAVER'
$B4:B7DD             dx 0005, 0000,E0,30C3, 01F8,E0,30B4, 01F0,E0,30C7, 01E8,E0,30B0, 01E0,E0,30C8

; 7Ah: 'YARD'
$B4:B7F8             dx 0004, 01F8,E0,30B3, 01F0,E0,30C3, 01E8,E0,30B0, 01E0,E0,30CA

; 7Bh: 'ZEB'
$B4:B80E             dx 0003, 01F0,E0,30B1, 01E8,E0,30B4, 01E0,E0,30CB

; 7Ch: 'ZEBBO'
$B4:B81F             dx 0005, 0000,E0,30C0, 01F8,E0,30B1, 01F0,E0,30B1, 01E8,E0,30B4, 01E0,E0,30CB

; 7Dh: 'ZEELA'
$B4:B83A             dx 0005, 0000,E0,30B0, 01F8,E0,30BB, 01F0,E0,30B4, 01E8,E0,30B4, 01E0,E0,30CB

; 7Eh: 'ZOA'
$B4:B855             dx 0003, 01F0,E0,30B0, 01E8,E0,30C0, 01E0,E0,30CB

; 7Fh: 'ZOOMER'
$B4:B866             dx 0006, 0008,E0,30C3, 0000,E0,30B4, 01F8,E0,30BC, 01F0,E0,30C0, 01E8,E0,30C0, 01E0,E0,30CB
}


; 1Ch: Text cursor
$B4:B886             dx 0001, 0000,00,303E


;;; $B88D: Enemy names ;;;
{
; 30h: 'NoDebug;'
$B4:B88D             dx 0008, 0018,E0,30CD, 0010,E0,30E6, 0008,E0,30F4, 0000,E0,30E1, 01F8,E0,30E4, 01F0,E0,30B3, 01E8,E0,30EE, 01E0,E0,30BD

; 80h: 'BATTA1br'
$B4:B8B7             dx 0008, 0018,E0,30F1, 0010,E0,30E1, 0008,E0,30D1, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 81h: 'BATTA1no'
$B4:B8E1             dx 0008, 0018,E0,30EE, 0010,E0,30ED, 0008,E0,30D1, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 82h: 'BATTA1np'
$B4:B90B             dx 0008, 0018,E0,30EF, 0010,E0,30ED, 0008,E0,30D1, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 83h: 'BATTA1ml'
$B4:B935             dx 0008, 0018,E0,30EB, 0010,E0,30EC, 0008,E0,30D1, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 84h: 'BATTA1ts'
$B4:B95F             dx 0008, 0018,E0,30F2, 0010,E0,30F3, 0008,E0,30D1, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 85h: 'BATTA2br'
$B4:B989             dx 0008, 0018,E0,30F1, 0010,E0,30E1, 0008,E0,30D2, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 86h: 'BATTA2no'
$B4:B9B3             dx 0008, 0008,E0,30D2, 0018,E0,30EE, 0010,E0,30ED, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 87h: 'BATTA2np'
$B4:B9DD             dx 0008, 0018,E0,30EF, 0008,E0,30D2, 0010,E0,30ED, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 88h: 'BATTA2ml'
$B4:BA07             dx 0008, 0018,E0,30EB, 0010,E0,30EC, 0008,E0,30D2, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 89h: 'BATTA2ts'
$B4:BA31             dx 0008, 0018,E0,30F2, 0010,E0,30F3, 0008,E0,30D2, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 8Ah: 'BATTA3br'
$B4:BA5B             dx 0008, 0018,E0,30F1, 0010,E0,30E1, 0008,E0,30D3, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 8Bh: 'BATTA3no'
$B4:BA85             dx 0008, 0018,E0,30EE, 0010,E0,30ED, 0008,E0,30D3, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 8Ch: 'BATTA3np'
$B4:BAAF             dx 0008, 0018,E0,30EF, 0010,E0,30ED, 0008,E0,30D3, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 8Dh: 'BATTA3ml'
$B4:BAD9             dx 0008, 0018,E0,30EB, 0010,E0,30EC, 0008,E0,30D3, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1

; 8Eh: 'BATTA3ts'
$B4:BB03             dx 0008, 0018,E0,30F2, 0010,E0,30F3, 0008,E0,30D3, 0000,E0,30B0, 01F8,E0,30C5, 01F0,E0,30C5, 01E8,E0,30B0, 01E0,E0,30B1
}


;;; $BB2D: Area names ;;;
{
$B4:BB2D             dx 0003, 01E8,F8,30B5, 01E0,F8,30C4, 01F8,F8,30FD ; 14h: 'SF _' (Crateria)
$B4:BB3E             dx 0003, 01E8,F8,30BB, 01E0,F8,30B1, 01F8,F8,30FD ; 15h: 'BL _' (Brinstar)
$B4:BB4F             dx 0003, 01E8,F8,30C0, 01E0,F8,30BD, 01F8,F8,30FD ; 16h: 'NO _' (Norfair)
$B4:BB60             dx 0003, 01E8,F8,30C1, 01E0,F8,30BD, 01F8,F8,30FD ; 17h: 'NP _' (Wrecked Ship)
$B4:BB71             dx 0003, 01E8,F8,30BB, 01E0,F8,30BC, 01F8,F8,30FD ; 18h: 'ML _' (Maridia)
$B4:BB82             dx 0003, 01E8,F8,30C4, 01E0,F8,30C5, 01F8,F8,30FD ; 19h: 'TS _' (Tourian)
$B4:BB93             dx 0003, 01E8,F8,30C0, 01E0,F8,30B2, 01F8,F8,30FD ; 1Ah: 'CO _' (Ceres)
$B4:BBA4             dx 0003, 01E8,F8,30C5, 01E0,F8,30C5, 01F8,F8,30FD ; 1Bh: 'TT _' (Debug)
}


;;; $BBB5: Enemy names ;;;
{
; 8Fh: 'FUNE'
$B4:BBB5             dx 0004, 01F8,E0,30B4, 01F0,E0,30BD, 01E8,E0,30C6, 01E0,E0,30B5

; 90h: 'HACHI2'
$B4:BBCB             dx 0006, 0008,E0,30D2, 0000,E0,30B8, 01F8,E0,30B7, 01F0,E0,30B2, 01E8,E0,30B0, 01E0,E0,30B7

; 91h: 'HACHI3'
$B4:BBEB             dx 0006, 0008,E0,30D3, 0000,E0,30B8, 01F8,E0,30B7, 01F0,E0,30B2, 01E8,E0,30B0, 01E0,E0,30B7

; 92h: 'ROBO2'
$B4:BC0B             dx 0005, 0000,E0,30D2, 01F8,E0,30C0, 01F0,E0,30B1, 01E8,E0,30C0, 01E0,E0,30C3
}
}


;;; $BC26..DD88: Sprite objects ;;;
{
;;; $BC26: Create sprite object ;;;
{
;; Parameters:
;;     $12: X position
;;     $14: Y position
;;     $16: Sprite object ID. See "Sprite objects.asm"
;;     $18: Base tile number and palette bits
;; Returns:
;;     $12: Index of created sprite object if successful
$B4:BC26 DA          PHX
$B4:BC27 5A          PHY
$B4:BC28 08          PHP
$B4:BC29 8B          PHB
$B4:BC2A F4 00 B4    PEA $B400              ;\
$B4:BC2D AB          PLB                    ;} DB = $B4
$B4:BC2E AB          PLB                    ;/
$B4:BC2F C2 30       REP #$30
$B4:BC31 A2 3E 00    LDX #$003E             ; X = 3Eh (sprite object index)

; LOOP
$B4:BC34 BF 78 EF 7E LDA $7EEF78,x[$7E:EFB6];\
$B4:BC38 F0 06       BEQ $06    [$BC40]     ;} If [sprite object instruction list pointer] = 0: go to BRANCH_FOUND
$B4:BC3A CA          DEX                    ;\
$B4:BC3B CA          DEX                    ;} X -= 2
$B4:BC3C 10 F6       BPL $F6    [$BC34]     ; If [X] >= 0: go to LOOP
$B4:BC3E 80 3D       BRA $3D    [$BC7D]     ; Return

; BRANCH_FOUND
$B4:BC40 A9 00 00    LDA #$0000
$B4:BC43 9F 78 F0 7E STA $7EF078,x[$7E:F0B6]
$B4:BC47 9F 78 F1 7E STA $7EF178,x[$7E:F1B6]; Sprite object X subposition = 0
$B4:BC4B 9F 78 F2 7E STA $7EF278,x[$7E:F2B6]; Sprite object Y subposition = 0
$B4:BC4F 9F F8 F2 7E STA $7EF2F8,x[$7E:F336]; Sprite object disable flag = 0
$B4:BC53 A5 12       LDA $12    [$7E:0012]  ;\
$B4:BC55 9F F8 F0 7E STA $7EF0F8,x[$7E:F136];} Sprite object X position = [$12]
$B4:BC59 A5 14       LDA $14    [$7E:0014]  ;\
$B4:BC5B 9F F8 F1 7E STA $7EF1F8,x[$7E:F236];} Sprite object Y position = [$14]
$B4:BC5F A5 18       LDA $18    [$7E:0018]  ;\
$B4:BC61 9F 78 F0 7E STA $7EF078,x[$7E:F0B6];} Sprite object palette and VRAM index = [$18]
$B4:BC65 A5 16       LDA $16    [$7E:0016]  ;\
$B4:BC67 0A          ASL A                  ;|
$B4:BC68 A8          TAY                    ;} Sprite object instruction list pointer = [$BDA8 + [$16] * 2]
$B4:BC69 B9 A8 BD    LDA $BDA8,y[$B4:BE16]  ;|
$B4:BC6C 9F 78 EF 7E STA $7EEF78,x[$7E:EFB6];/
$B4:BC70 DA          PHX                    ;\
$B4:BC71 AA          TAX                    ;|
$B4:BC72 BF 00 00 B4 LDA $B40000,x[$B4:C5C6];} Sprite object instruction/timer = [$B4:0000 + [sprite object instruction list pointer]]
$B4:BC76 FA          PLX                    ;|
$B4:BC77 9F F8 EF 7E STA $7EEFF8,x[$7E:F036];/
$B4:BC7B 86 12       STX $12    [$7E:0012]  ; $12 = [X]

$B4:BC7D AB          PLB
$B4:BC7E 28          PLP
$B4:BC7F 7A          PLY
$B4:BC80 FA          PLX
$B4:BC81 6B          RTL
}


;;; $BC82: Handle sprite objects ;;;
{
$B4:BC82 DA          PHX
$B4:BC83 5A          PHY
$B4:BC84 08          PHP
$B4:BC85 8B          PHB
$B4:BC86 F4 00 B4    PEA $B400              ;\
$B4:BC89 AB          PLB                    ;} DB = $B4
$B4:BC8A AB          PLB                    ;/
$B4:BC8B C2 30       REP #$30
$B4:BC8D AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$B4:BC90 0D 5E 18    ORA $185E  [$7E:185E]  ;} If time is frozen or enemy time is frozen != 0: return
$B4:BC93 D0 56       BNE $56    [$BCEB]     ;/
$B4:BC95 A2 3E 00    LDX #$003E             ;\
$B4:BC98 8E 44 18    STX $1844  [$7E:1844]  ;} Sprite object index = 3Eh

; LOOP
$B4:BC9B AE 44 18    LDX $1844  [$7E:1844]  ;\
$B4:BC9E BF 78 EF 7E LDA $7EEF78,x[$7E:EFB6];} If [sprite object instruction list pointer] = 0: go to BRANCH_NEXT
$B4:BCA2 F0 33       BEQ $33    [$BCD7]     ;/
$B4:BCA4 BF F8 F2 7E LDA $7EF2F8,x[$7E:F336];\
$B4:BCA8 89 01 00    BIT #$0001             ;} If [sprite object disable flag] & 1 != 0: return
$B4:BCAB D0 2A       BNE $2A    [$BCD7]     ;/
$B4:BCAD BF F8 EF 7E LDA $7EEFF8,x[$7E:F036];\
$B4:BCB1 30 30       BMI $30    [$BCE3]     ;} If [sprite object instruction/timer] & 8000h: go to BRANCH_ASM_INSTRUCTION
$B4:BCB3 3A          DEC A                  ;\
$B4:BCB4 9F F8 EF 7E STA $7EEFF8,x[$7E:F036];} Decrement sprite object instruction timer
$B4:BCB8 D0 1D       BNE $1D    [$BCD7]     ; If [sprite object instruction timer] != 0: go to BRANCH_RETURN
$B4:BCBA BF 78 EF 7E LDA $7EEF78,x[$7E:EFB6];\
$B4:BCBE 1A          INC A                  ;|
$B4:BCBF 1A          INC A                  ;|
$B4:BCC0 1A          INC A                  ;} Sprite object instruction list pointer += 4
$B4:BCC1 1A          INC A                  ;|
$B4:BCC2 9F 78 EF 7E STA $7EEF78,x[$7E:EFB6];/
$B4:BCC6 AA          TAX                    ;\
$B4:BCC7 BF 00 00 B4 LDA $B40000,x[$B4:C5CA];|
$B4:BCCB C9 00 80    CMP #$8000             ;} If [$B4:0000 + [sprite object instruction list pointer]] >= 8000h: go to BRANCH_ASM_INSTRUCTION
$B4:BCCE 10 13       BPL $13    [$BCE3]     ;/
$B4:BCD0 AE 44 18    LDX $1844  [$7E:1844]  ;\
$B4:BCD3 9F F8 EF 7E STA $7EEFF8,x[$7E:F036];} Sprite object instruction/timer = [$B4:0000 + [sprite object instruction list pointer]]

; BRANCH_NEXT
$B4:BCD7 AD 44 18    LDA $1844  [$7E:1844]  ;\
$B4:BCDA 3A          DEC A                  ;|
$B4:BCDB 3A          DEC A                  ;} Sprite object index -= 2
$B4:BCDC 8D 44 18    STA $1844  [$7E:1844]  ;/
$B4:BCDF 10 BA       BPL $BA    [$BC9B]     ; If [sprite object index] >= 0: go to LOOP
$B4:BCE1 80 08       BRA $08    [$BCEB]     ; Return

; BRANCH_ASM_INSTRUCTION
$B4:BCE3 85 12       STA $12    [$7E:0012]  ;\
$B4:BCE5 F4 D6 BC    PEA $BCD6              ;} Execute sprite object instruction, returning to BRANCH_NEXT
$B4:BCE8 6C 12 00    JMP ($0012)[$B4:BD07]  ;/

$B4:BCEB AB          PLB
$B4:BCEC 28          PLP
$B4:BCED 7A          PLY
$B4:BCEE FA          PLX
$B4:BCEF 6B          RTL
}


;;; $BCF0: Sprite object instruction - go back 4 bytes ;;;
{
$B4:BCF0 AE 44 18    LDX $1844  [$7E:1844]
$B4:BCF3 BF 78 EF 7E LDA $7EEF78,x[$7E:EFB6]
$B4:BCF7 3A          DEC A
$B4:BCF8 3A          DEC A
$B4:BCF9 3A          DEC A
$B4:BCFA 3A          DEC A
$B4:BCFB 9F 78 EF 7E STA $7EEF78,x[$7E:EFB6]
$B4:BCFF A9 FF 7F    LDA #$7FFF
$B4:BD02 9F F8 EF 7E STA $7EEFF8,x[$7E:F036]
$B4:BD06 60          RTS
}


;;; $BD07: Sprite object instruction - delete ;;;
{
$B4:BD07 AE 44 18    LDX $1844  [$7E:1844]
$B4:BD0A A9 00 00    LDA #$0000
$B4:BD0D 9F 78 EF 7E STA $7EEF78,x[$7E:EFB6]
$B4:BD11 60          RTS
}


;;; $BD12: Sprite object instruction - go to parameter ;;;
{
$B4:BD12 AE 44 18    LDX $1844  [$7E:1844]
$B4:BD15 BF 78 EF 7E LDA $7EEF78,x[$7E:EFB6]
$B4:BD19 AA          TAX
$B4:BD1A BF 02 00 B4 LDA $B40002,x[$B4:C61A]
$B4:BD1E AE 44 18    LDX $1844  [$7E:1844]
$B4:BD21 9F 78 EF 7E STA $7EEF78,x[$7E:EFB6]
$B4:BD25 AA          TAX
$B4:BD26 BF 00 00 B4 LDA $B40000,x[$B4:C608]
$B4:BD2A AE 44 18    LDX $1844  [$7E:1844]
$B4:BD2D 9F F8 EF 7E STA $7EEFF8,x[$7E:F036]
$B4:BD31 60          RTS
}


;;; $BD32: Draw sprite objects ;;;
{
$B4:BD32 DA          PHX
$B4:BD33 5A          PHY
$B4:BD34 08          PHP
$B4:BD35 8B          PHB
$B4:BD36 F4 00 B4    PEA $B400              ;\
$B4:BD39 AB          PLB                    ;} DB = $B4
$B4:BD3A AB          PLB                    ;/
$B4:BD3B C2 30       REP #$30
$B4:BD3D A2 3E 00    LDX #$003E             ; X = 3Eh (sprite object index)

; LOOP
$B4:BD40 BF 78 EF 7E LDA $7EEF78,x[$7E:EFB6];\
$B4:BD44 F0 48       BEQ $48    [$BD8E]     ;} If [sprite object instruction list pointer] = 0: go to BRANCH_NEXT
$B4:BD46 BF F8 F0 7E LDA $7EF0F8,x[$7E:F136];\
$B4:BD4A 38          SEC                    ;|
$B4:BD4B ED 11 09    SBC $0911  [$7E:0911]  ;} Sprite X position = [sprite object X position] - [layer 1 X position]
$B4:BD4E 85 14       STA $14    [$7E:0014]  ;/
$B4:BD50 18          CLC                    ;\
$B4:BD51 69 10 00    ADC #$0010             ;} If [sprite X position] < -10h: go to BRANCH_NEXT
$B4:BD54 30 38       BMI $38    [$BD8E]     ;/
$B4:BD56 C9 20 01    CMP #$0120             ;\
$B4:BD59 10 33       BPL $33    [$BD8E]     ;} If [sprite X position] >= 110h: go to BRANCH_NEXT
$B4:BD5B BF F8 F1 7E LDA $7EF1F8,x[$7E:F236];\
$B4:BD5F 38          SEC                    ;|
$B4:BD60 ED 15 09    SBC $0915  [$7E:0915]  ;} Sprite Y position = [sprite object Y position] - [layer 1 Y position]
$B4:BD63 85 12       STA $12    [$7E:0012]  ;/
$B4:BD65 30 27       BMI $27    [$BD8E]     ; If [sprite Y position] < 0: go to BRANCH_NEXT
$B4:BD67 C9 10 01    CMP #$0110             ;\
$B4:BD6A 10 22       BPL $22    [$BD8E]     ;} If [sprite Y position] >= 110h: go to BRANCH_NEXT
$B4:BD6C BF 78 F0 7E LDA $7EF078,x[$7E:F0B6];\
$B4:BD70 29 00 0E    AND #$0E00             ;} Sprite palette bits = [sprite object palette and VRAM index] & E00h
$B4:BD73 85 03       STA $03    [$7E:0003]  ;/
$B4:BD75 BF 78 F0 7E LDA $7EF078,x[$7E:F0B6];\
$B4:BD79 29 FF 01    AND #$01FF             ;} Sprite base tile number = [sprite object palette and VRAM index] & 1FFh
$B4:BD7C 85 00       STA $00    [$7E:0000]  ;/
$B4:BD7E DA          PHX                    ;\
$B4:BD7F BF 78 EF 7E LDA $7EEF78,x[$7E:EFB6];|
$B4:BD83 AA          TAX                    ;|
$B4:BD84 BF 02 00 B4 LDA $B40002,x[$B4:C5C8];} Add spritemap [$B4:0002 + [sprite object instruction list pointer]] to OAM with base tile number
$B4:BD88 A8          TAY                    ;|
$B4:BD89 22 B8 8A 81 JSL $818AB8[$81:8AB8]  ;|
$B4:BD8D FA          PLX                    ;/

; BRANCH_NEXT
$B4:BD8E CA          DEX                    ;\
$B4:BD8F CA          DEX                    ;} X -= 2
$B4:BD90 10 AE       BPL $AE    [$BD40]     ; If [X] >= 0: go to LOOP
$B4:BD92 AB          PLB
$B4:BD93 28          PLP
$B4:BD94 7A          PLY
$B4:BD95 FA          PLX
$B4:BD96 6B          RTL
}


;;; $BD97: Clear sprite objects ;;;
{
; BUG: Doesn't clear $7E:EF78 due to wrong branch instruction,
; causes a crash during door transition if 32 sprite objects are created
$B4:BD97 A2 FE 03    LDX #$03FE
$B4:BD9A A9 00 00    LDA #$0000

$B4:BD9D 9F 78 EF 7E STA $7EEF78,x[$7E:F376]
$B4:BDA1 CA          DEX
$B4:BDA2 CA          DEX
$B4:BDA3 D0 F8       BNE $F8    [$BD9D]
$B4:BDA5 6B          RTL
}


;;; $BDA6: Empty draw instruction ;;;
{
$B4:BDA6             dw 0000
}


;;; $BDA8: Sprite objects ;;;
{
$B4:BDA8             dw BE5A, BE6C, BE86, BEA4, BEBE, BED4, BEEA, BF04, BF12, BF1C, BF32, BF44, BF56, BF8E, BFA0, BFB2,
                        BFC4, BFD2, C014, C026, C040, C05E, C080, C0FE, C10C, C132, C154, C176, BF68, BF74, C198, C1AC,
                        C1C0, C1D4, C1E8, C1FC, C210, C224, C238, C258, C2A0, C2BC, C304, C30A, C33E, C35C, C37A, BE54,
                        C390, C3A2, C3BA, C436, C4B6, C536, C5B2, C5C6, C5D8, C5DE, C5E4, C608, C61C, BE24
}


;;; $BE24..C62F: Sprite object instruction lists ;;;
{
;;; $BE24: Instruction list - sprite object 3Dh (Draygon foaming at the mouth) ;;;
{
$B4:BE24             dx 0006,DD51,
                        0006,DD58,
                        0007,DD5F,
                        0007,DD66,
                        0008,DD6D,
                        0008,DD74,
                        0009,DD7B,
                        0009,DD82,
                        BD07        ; Delete
}


;;; $BE46: Unused. Instruction list ;;;
{
$B4:BE46             dx 0005,DD3C,
                        0005,DD43,
                        0005,DD4A,
                        BD07        ; Delete
}


;;; $BE54: Instruction list - sprite object 2Fh (unused) ;;;
{
$B4:BE54             dx 0001,D594,
                        BCF0        ; Go back 4 bytes
}


;;; $BE5A: Instruction list - sprite object 0 (unused. Beam charge) ;;;
{
$B4:BE5A             dx 0003,CAC9,
                        0003,CAD0,
                        0003,CAD7,
                        0003,CADE,
                        BD07        ; Delete
}


;;; $BE6C: Instruction list - sprite object 1 (unused. Mother Brain elbow charge particles) ;;;
{
$B4:BE6C             dx 0005,CAF4,
                        0004,CB05,
                        0003,CB16,
                        0003,CB27,
                        0003,CB38,
                        0003,CB49,
                        BD07        ; Delete
}


;;; $BE86: Instruction list - sprite object 2 (unused. Mother Brain elbow charge energy) ;;;
{
$B4:BE86             dx 0004,CB5A,
                        0003,CB6B,
                        0002,CB7C,
                        0002,CB8D,
                        0002,CB9E,
                        0002,CBAF,
                        000C,CBC0,
                        BD07        ; Delete
}


;;; $BEA4: Instruction list - sprite object 3 (small explosion) ;;;
{
$B4:BEA4             dx 0004,CBC0,
                        0006,CBC7,
                        0005,CBDD,
                        0005,CBF3,
                        0005,CC09,
                        0006,CC1F,
                        BD07        ; Delete
}


;;; $BEBE: Instruction list - sprite object 4 (unused. Bomb explosion) ;;;
{
$B4:BEBE             dx 0003,CC35,
                        0003,CC4B,
                        0004,CC61,
                        0004,CC77,
                        0004,CC8D,
                        BD07        ; Delete
}


;;; $BED4: Instruction list - sprite object 5 (unused. Beam trail) ;;;
{
$B4:BED4             dx 0008,CCB9,
                        0008,CCC0,
                        0008,CCC7,
                        0008,CCCE,
                        0018,CB8D,
                        BD07        ; Delete
}


;;; $BEEA: Instruction list - sprite object 6 (dud shot) ;;;
{
$B4:BEEA             dx 0004,CCF1,
                        0004,CCF8,
                        0004,CCFF,
                        0004,CD15,
                        0004,CD2B,
                        0004,CD41,
                        BD07        ; Delete
}


;;; $BF04: Instruction list - sprite object 7 (unused. Power bomb) ;;;
{
$B4:BF04             dx 0005,CCD5,
                        0005,CCDC,
                        0005,CCE3,
                        BD07        ; Delete
}


;;; $BF12: Instruction list - sprite object 8 (unused. Elevator pad) ;;;
{
$B4:BF12             dx 0001,CD57,
                        0001,CD6D,
                        BD07        ; Delete
}


;;; $BF1C: Instruction list - sprite object 9 (small dust cloud) ;;;
{
$B4:BF1C             dx 0005,CDB5,
                        0005,CD99,
                        0005,CDA0,
                        0005,CDA7,
                        0005,CDAE,
                        BD07        ; Delete
}


;;; $BF32: Instruction list - sprite object Ah (ninja space pirate landing dust cloud) ;;;
{
$B4:BF32             dx 0003,CDB5,
                        0003,CDBC,
                        0003,CDC3,
                        0003,CDCA,
                        BD07        ; Delete
}


;;; $BF44: Instruction list - sprite object Bh (unused. Eye door sweat drop) ;;;
{
$B4:BF44             dx 0005,CDD1,
                        0005,CDD8,
                        0005,CDDF,
                        0005,CDE6,
                        BD07        ; Delete
}


;;; $BF56: Instruction list - sprite object Ch (smoke) ;;;
{
$B4:BF56             dx 0008,CDED,
                        0008,CDF4,
                        0008,CDFB,
                        0008,CE02,
                        BD07        ; Delete
}


;;; $BF68: Instruction list - sprite object 1Ch (unused. Elevator pad) ;;;
{
$B4:BF68             dx 0001,CD57,
                        0001,CD6D,
                        BD12,BF68   ; Go to $BF68
}


;;; $BF74: Instruction list - sprite object 1Dh (big explosion) ;;;
{
$B4:BF74             dx 0005,CFA3,
                        0005,CFB9,
                        0005,CFCF,
                        0005,CFE5,
                        0005,D023,
                        0005,D04D,
                        BD07        ; Delete
}


;;; $BF8E: Instruction list - sprite object Dh (unused. Small health drop) ;;;
{
$B4:BF8E             dx 0008,CE1E,
                        0008,CE25,
                        0008,CE2C,
                        0008,CE33,
                        BD07        ; Delete
}


;;; $BFA0: Instruction list - sprite object Eh (unused. Big health drop) ;;;
{
$B4:BFA0             dx 0008,CE3A,
                        0008,CE50,
                        0008,CE66,
                        0008,CE7C,
                        BD07        ; Delete
}


;;; $BFB2: Instruction list - sprite object Fh (unused. Bomb) ;;;
{
$B4:BFB2             dx 0005,CE83,
                        0005,CE8A,
                        0005,CE91,
                        0005,CE98,
                        BD07        ; Delete
}


;;; $BFC4: Instruction list - sprite object 10h (unused. Weird small health drop) ;;;
{
$B4:BFC4             dx 0010,CF87,
                        0010,CF8E,
                        0010,CF95,
                        BD07        ; Delete
}


;;; $BFD2: Instruction list - sprite object 11h (unused. Rock particles) ;;;
{
$B4:BFD2             dx 0002,C6D8,
                        0002,C6EE,
                        0002,C704,
                        0002,C71A,
                        0002,C730,
                        0002,C746,
                        0002,C75C,
                        0002,C772,
                        0002,C788,
                        0002,C79E,
                        0002,C7B4,
                        0002,C7CA,
                        0002,C7E0,
                        0002,C7F6,
                        0002,C80C,
                        0002,C822,
                        BD07        ; Delete
}


;;; $C014: Instruction list - sprite object 12h (short big dust cloud) ;;;
{
$B4:C014             dx 0002,C838,
                        0002,C83F,
                        0002,C84B,
                        0002,C85C,
                        BD07        ; Delete
}


;;; $C026: Instruction list - sprite object 13h (unused. Short big dust cloud with weird short beam) ;;;
{
$B4:C026             dx 0003,C872,
                        0003,C888,
                        0003,C899,
                        0003,C8A5,
                        0003,C8AC,
                        0005,C8B3,
                        BD07        ; Delete
}


;;; $C040: Instruction list - sprite object 14h (unused. Short big dust cloud with weird medium beam) ;;;
{
$B4:C040             dx 0003,C872,
                        0003,C888,
                        0003,C899,
                        0003,C8A5,
                        0003,C8AC,
                        0003,C8B3,
                        0003,C8BA,
                        BD07        ; Delete
}


;;; $C05E: Instruction list - sprite object 15h (big dust cloud) ;;;
{
$B4:C05E             dx 0005,C838,
                        0005,C83F,
                        0005,C84B,
                        0005,C85C,
                        0005,C872,
                        0005,C888,
                        0005,C899,
                        0005,C8A5,
                        BD07        ; Delete
}


;;; $C080: Instruction list - sprite object 16h (unused. Weird long beam) ;;;
{
$B4:C080             dx 0001,C8AC,
                        0001,C8B3,
                        0001,C8BA,
                        0001,C8C6,
                        0001,C8D2,
                        0001,C8E3,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        BD07        ; Delete
}


;;; $C0FE: Instruction list - sprite object 17h (unused. Weird long flickering beam) ;;;
{
$B4:C0FE             dx 0001,C8F4,
                        0001,C90A,
                        0001,C8F4,
                        BD07        ; Delete
}


;;; $C10C: Instruction list - sprite object 18h (short Draygon breath bubbles) ;;;
{
$B4:C10C             dx 0003,C920,
                        0003,C927,
                        0003,C938,
                        0003,C949,
                        0003,C95A,
                        0003,C96B,
                        0003,C97C,
                        0003,C98D,
                        0003,C999,
                        BD07        ; Delete
}


;;; $C132: Instruction list - sprite object 19h (unused. Save station electricity) ;;;
{
$B4:C132             dx 0001,C9A0,
                        0001,C9B6,
                        0001,C9CC,
                        0001,C9E2,
                        0001,C9F8,
                        0001,CA0E,
                        0001,CA24,
                        0001,CA3A,
                        BD07        ; Delete
}


;;; $C154: Instruction list - sprite object 1Ah (unused. Expanding vertical gate) ;;;
{
$B4:C154             dx 0010,CA50,
                        0010,CA5C,
                        0010,CA63,
                        0010,CA6F,
                        0010,CA7B,
                        0010,CA8C,
                        0010,CA9D,
                        0010,CAB3,
                        BD07        ; Delete
}


;;; $C176: Instruction list - sprite object 1Bh (unused. Contracting vertical gate) ;;;
{
$B4:C176             dx 0004,CAB3,
                        0004,CA9D,
                        0004,CA8C,
                        0004,CA7B,
                        0004,CA6F,
                        0004,CA63,
                        0004,CA5C,
                        0004,CA50,
                        BD07        ; Delete
}


;;; $C198: Instruction list - sprite object 1Eh (unused) ;;;
{
$B4:C198             dx 0005,C630,
                        0005,C637,
                        0005,C630,
                        0005,C63E,
                        BD12,C198   ; Go to $C198
}


;;; $C1AC: Instruction list - sprite object 1Fh (unused) ;;;
{
$B4:C1AC             dx 0005,C645,
                        0005,C64C,
                        0005,C645,
                        0005,C653,
                        BD12,C1AC   ; Go to $C1AC
}


;;; $C1C0: Instruction list - sprite object 20h (unused) ;;;
{
$B4:C1C0             dx 0005,C65A,
                        0005,C661,
                        0005,C65A,
                        0005,C668,
                        BD12,C1C0   ; Go to $C1C0
}


;;; $C1D4: Instruction list - sprite object 21h (unused) ;;;
{
$B4:C1D4             dx 0005,C66F,
                        0005,C676,
                        0005,C66F,
                        0005,C67D,
                        BD12,C1D4   ; Go to $C1D4
}


;;; $C1E8: Instruction list - sprite object 22h (unused) ;;;
{
$B4:C1E8             dx 0005,C684,
                        0005,C68B,
                        0005,C684,
                        0005,C692,
                        BD12,C1E8   ; Go to $C1E8
}


;;; $C1FC: Instruction list - sprite object 23h (unused) ;;;
{
$B4:C1FC             dx 0005,C699,
                        0005,C6A0,
                        0005,C699,
                        0005,C6A7,
                        BD12,C1FC   ; Go to $C1FC
}


;;; $C210: Instruction list - sprite object 24h (unused) ;;;
{
$B4:C210             dx 0005,C6AE,
                        0005,C6B5,
                        0005,C6AE,
                        0005,C6BC,
                        BD12,C210   ; Go to $C210
}


;;; $C224: Instruction list - sprite object 25h (unused) ;;;
{
$B4:C224             dx 0005,C6C3,
                        0005,C6CA,
                        0005,C6C3,
                        0005,C6D1,
                        BD12,C224   ; Go to $C224
}


;;; $C238: Instruction list - sprite object 26h (unused) ;;;
{
$B4:C238             dx 000A,D08B,
                        000A,D08B,
                        000A,D0BA,
                        000A,D0E9,
                        000A,D118,
                        000A,D147,
                        000A,D176,
                        BD12,C238   ; Go to $C238
}


;;; $C258: Instruction list - sprite object 27h (unused) ;;;
{
$B4:C258             dx 000A,D1D4,
                        000A,D1EF,
                        000A,D20A,
                        000A,D225,
                        000A,D1D4,
                        000A,D1EF,
                        000A,D20A,
                        000A,D225,
                        000A,D1D4,
                        000A,D1EF,
                        000A,D20A,
                        000A,D225,
                        000A,D1D4,
                        000A,D1EF,
                        000A,D20A,
                        000A,D225,
                        0030,D245,
                        BD12,C258   ; Go to $C258
}


;;; $C2A0: Instruction list - sprite object 28h (unused) ;;;
{
$B4:C2A0             dx 000A,D2B3,
                        000A,D2E2,
                        000A,D311,
                        000A,D340,
                        000A,D36F,
                        000A,D39E,
                        BD12,C2A0   ; Go to $C2A0
}


;;; $C2BC: Instruction list - sprite object 29h (unused) ;;;
{
$B4:C2BC             dx 000A,D3FC,
                        000A,D417,
                        000A,D432,
                        000A,D44D,
                        000A,D3FC,
                        000A,D417,
                        000A,D432,
                        000A,D44D,
                        000A,D3FC,
                        000A,D417,
                        000A,D432,
                        000A,D44D,
                        000A,D3FC,
                        000A,D417,
                        000A,D432,
                        000A,D44D,
                        0030,D46D,
                        BD12,C2BC   ; Go to $C2BC
}


;;; $C304: Instruction list - sprite object 2Ah (unused) ;;;
{
$B4:C304             dx 0001,D2AC,
                        BCF0        ; Go back 4 bytes
}


;;; $C30A: Instruction list - sprite object 2Bh (fire arc body) ;;;
{
$B4:C30A             dx 0003,D4BE,
                        0003,D4C5,
                        0003,D4DA,
                        0003,D4CC,
                        0003,D4D3,
                        0003,D4E1,
                        0003,D4BE,
                        0003,D4C5,
                        0003,D4E8,
                        0003,D4CC,
                        0003,D4D3,
                        0003,D4EF,
                        BD12,C30A   ; Go to $C30A
}


;;; $C33E: Instruction list - sprite object 2Ch (fire arc right explosion) ;;;
{
$B4:C33E             dx 0002,D4F6,
                        0002,D4FD,
                        0002,D504,
                        0002,D50B,
                        0002,D512,
                        0002,D519,
                        0002,D520,
                        BD07        ; Delete
}


;;; $C35C: Instruction list - sprite object 2Dh (fire arc left explosion) ;;;
{
$B4:C35C             dx 0002,D527,
                        0002,D52E,
                        0002,D535,
                        0002,D53C,
                        0002,D543,
                        0002,D54A,
                        0002,D551,
                        BD07        ; Delete
}


;;; $C37A: Instruction list - sprite object 2Eh (fire arc splash) ;;;
{
$B4:C37A             dx 0002,D558,
                        0002,D558,
                        0002,D564,
                        0002,D570,
                        0002,D588,
                        BD07        ; Delete
}


;;; $C390: Instruction list - sprite object 30h (falling spark trail) ;;;
{
$B4:C390             dx 0003,D59B,
                        0003,D5A2,
                        0003,D5A9,
                        0003,D5B0,
                        BD07        ; Delete
}


;;; $C3A2: Instruction list - sprite object 31h (unused. Metroid insides) ;;;
{
$B4:C3A2             dx 0010,D653,
                        0010,D67D,
                        0006,D69D,
                        000A,D6C7,
                        0010,D67D,
                        BD12,C3A2   ; Go to $C3A2
}


;;; $C3BA: Instruction list - sprite object 32h (metroid electricity) ;;;
{
$B4:C3BA             dx 0002,D6F1,
                        0003,D702,
                        0002,D713,
                        0001,D6F1,
                        0003,D713,
                        0004,BDA6,
                        0004,D724,
                        0005,D73A,
                        0002,D750,
                        0001,D73A,
                        0004,BDA6,
                        0002,D7DB,
                        0003,D7E7,
                        0004,D7EE,
                        0007,BDA6,
                        0003,D799,
                        0002,D7AF,
                        0001,D7C5,
                        0002,D7AF,
                        0003,D7C5,
                        0004,BDA6,
                        0004,D7FA,
                        0002,D806,
                        0002,D812,
                        0003,D7FA,
                        0001,BDA6,
                        0004,D81E,
                        0003,D82A,
                        0003,D836,
                        0002,D82A,
                        0007,BDA6
}


;;; $C436: Instruction list - sprite object 33h (unused) ;;;
{
$B4:C436             dx 0002,D766,
                        0003,D777,
                        0004,D788,
                        0002,D766,
                        0001,D788,
                        0003,BDA6,
                        0002,D842,
                        0003,D849,
                        0004,D850,
                        0001,D842,
                        0003,BDA6,
                        0003,D766,
                        0004,D788,
                        0020,BDA6,
                        0002,D6F1,
                        0001,D702,
                        0002,D713,
                        0001,D6F1,
                        0004,BDA6,
                        0003,D7FA,
                        0004,D806,
                        0005,D812,
                        0004,BDA6,
                        0002,D799,
                        0001,D7AF,
                        0003,D7C5,
                        0001,D799,
                        0006,BDA6,
                        0003,D724,
                        0004,D73A,
                        0002,D750,
                        BD12,C436   ; Go to $C436
}


;;; $C4B6: Instruction list - sprite object 34h (metroid shell) ;;;
{
$B4:C4B6             dx 0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5EB,
                        0001,BDA6,
                        0001,D5EB,
                        0001,BDA6,
                        0001,D5EB,
                        0001,BDA6,
                        0001,D5EB,
                        0001,BDA6,
                        0001,D5EB,
                        0001,BDA6,
                        0001,D5EB,
                        0001,BDA6,
                        0001,D5EB,
                        0001,BDA6,
                        0001,D5EB,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6
}


;;; $C536: Instruction list - sprite object 35h (unused) ;;;
{
$B4:C536             dx 0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D5B7,
                        0001,BDA6,
                        0001,D61F,
                        0001,BDA6,
                        0001,D61F,
                        0001,BDA6,
                        0001,D61F,
                        0001,BDA6,
                        0001,D61F,
                        0001,BDA6,
                        0001,D61F,
                        0001,BDA6,
                        0001,D61F,
                        0001,BDA6,
                        0001,D61F,
                        0001,BDA6,
                        0001,D61F,
                        0001,BDA6,
                        0001,D61F,
                        0001,BDA6,
                        BD12,C536   ; Go to $C536
}


;;; $C5B2: Instruction list - sprite object 36h (unused) ;;;
{
$B4:C5B2             dx 0010,D5B7,
                        0010,D5EB,
                        0010,D5B7,
                        0010,D61F,
                        BD12,C5B2   ; Go to $C5B2
}


;;; $C5C6: Instruction list - sprite object 37h (enemy shot) ;;;
{
$B4:C5C6             dx 0002,D857,
                        0002,D86D,
                        0002,D883,
                        0002,D899,
                        BD07        ; Delete
}


;;; $C5D8: Instruction list - sprite object 38h (yapping maw base - facing down) ;;;
{
$B4:C5D8             dx 0001,D8AF,
                        BCF0        ; Go back 4 bytes
}


;;; $C5DE: Instruction list - sprite object 39h (yapping maw base - facing up) ;;;
{
$B4:C5DE             dx 0001,D8B6,
                        BCF0        ; Go back 4 bytes
}


;;; $C5E4: Instruction list - sprite object 3Ah (unused) ;;;
{
$B4:C5E4             dx 000A,D8BD,
                        000A,D905,
                        000A,D957,
                        000A,D9A9,
                        000A,D9FB,
                        000A,DA48,
                        000A,DA90,
                        000A,DAD8,
                        BD12,C5E4   ; Go to $C5E4
}


;;; $C608: Instruction list - sprite object 3Bh (evir facing left) ;;;
{
$B4:C608             dx 000A,DB42,
                        000A,DB80,
                        000A,DBBE,
                        000A,DBFC,
                        BD12,C608   ; Go to $C608
}


;;; $C61C: Instruction list - sprite object 3Ch (evir facing right) ;;;
{
$B4:C61C             dx 000A,DC3F,
                        000A,DC7D,
                        000A,DCBB,
                        000A,DCF9,
                        BD12,C61C   ; Go to $C61C
}
}


;;; $C630: Sprite object spritemaps ;;;
{
; Sprite object 1Eh (unused)
$B4:C630             dx 0001, 01FC,FC,0100
$B4:C637             dx 0001, 01FC,FC,0101
$B4:C63E             dx 0001, 01FC,FC,0102

; Sprite object 1Fh (unused)
$B4:C645             dx 0001, 01FC,FC,0103
$B4:C64C             dx 0001, 01FC,FC,0104
$B4:C653             dx 0001, 01FC,FC,0105

; Sprite object 20h (unused)
$B4:C65A             dx 0001, 01FC,FC,0106
$B4:C661             dx 0001, 01FC,FC,0107
$B4:C668             dx 0001, 01FC,FC,0108

; Sprite object 21h (unused)
$B4:C66F             dx 0001, 01FC,FC,8103
$B4:C676             dx 0001, 01FC,FC,8104
$B4:C67D             dx 0001, 01FC,FC,8105

; Sprite object 22h (unused)
$B4:C684             dx 0001, 01FC,FC,8100
$B4:C68B             dx 0001, 01FC,FC,8101
$B4:C692             dx 0001, 01FC,FC,8102

; Sprite object 23h (unused)
$B4:C699             dx 0001, 01FC,FC,C103
$B4:C6A0             dx 0001, 01FC,FC,C104
$B4:C6A7             dx 0001, 01FC,FC,C105

; Sprite object 24h (unused)
$B4:C6AE             dx 0001, 01FC,FC,4106
$B4:C6B5             dx 0001, 01FC,FC,4107
$B4:C6BC             dx 0001, 01FC,FC,4108

; Sprite object 25h (unused)
$B4:C6C3             dx 0001, 01FC,FC,4103
$B4:C6CA             dx 0001, 01FC,FC,4104
$B4:C6D1             dx 0001, 01FC,FC,4105

; Sprite object 11h (unused. Rock particles)
$B4:C6D8             dx 0004, 0000,F8,7A2B, 0000,00,7A2B, 01F8,00,3A2B, 01F8,F8,3A2B
$B4:C6EE             dx 0004, 0002,F3,7A2B, 0001,FF,7A2B, 01F7,FF,3A2B, 01F6,F3,3A2B
$B4:C704             dx 0004, 0005,EE,7A2B, 0003,FD,7A2B, 01F5,FD,3A2B, 01F3,EE,3A2B
$B4:C71A             dx 0004, 0007,EC,7A2B, 0005,FB,7A2B, 01F3,FB,3A2B, 01F1,EC,3A2B
$B4:C730             dx 0004, 0009,EA,7A2B, 0007,FA,7A2B, 01F1,FA,3A2B, 01EF,EA,3A2B
$B4:C746             dx 0004, 000A,EA,7A2B, 0008,F9,7A2B, 01F0,F9,3A2B, 01EE,EA,3A2B
$B4:C75C             dx 0004, 000C,EB,7A2A, 0009,FA,7A2A, 01EF,FA,3A2A, 01EC,EB,3A2A
$B4:C772             dx 0004, 000E,EC,7A2A, 000A,FC,7A2A, 01EE,FC,3A2A, 01EA,EC,3A2A
$B4:C788             dx 0004, 0010,ED,7A29, 000B,FE,7A29, 01ED,FE,3A29, 01E8,ED,3A29
$B4:C79E             dx 0004, 0012,EE,7A29, 000C,00,7A29, 01EC,00,3A29, 01E6,EE,3A29
$B4:C7B4             dx 0004, 0013,F0,7A28, 000D,02,7A28, 01E5,F0,3A28, 01EB,02,3A28
$B4:C7CA             dx 0004, 0014,F2,7A28, 000E,04,7A28, 01E4,F2,3A28, 01EA,04,3A28
$B4:C7E0             dx 0004, 0015,F5,7A28, 000F,07,7A28, 01E3,F5,3A28, 01E9,07,3A28
$B4:C7F6             dx 0004, 0016,F9,7A28, 0010,0B,7A28, 01E2,F9,3A28, 01E8,0B,3A28
$B4:C80C             dx 0004, 0017,03,7A28, 0011,11,7A28, 01E1,03,3A28, 01E7,11,3A28
$B4:C822             dx 0004, 0018,0A,7A28, 0012,18,7A28, 01E0,0A,3A28, 01E6,18,3A28

; Sprite object 12h/13h/14h/15h/16h/17h (dust cloud / weird beam)
$B4:C838             dx 0001, 01F7,F7,3A48                                           ; Sprite object 12h/        15h
$B4:C83F             dx 0002, 0001,01,3A48, 81F3,F3,3A7C                             ; Sprite object 12h/        15h
$B4:C84B             dx 0003, 81FD,FD,3A7C, 01F7,01,3A48, 81F3,F3,3A7E               ; Sprite object 12h/        15h
$B4:C85C             dx 0004, 0001,F7,3A48, 81FD,FD,3A7E, 81F3,FD,3A7C, 81F3,F3,3A9A ; Sprite object 12h/        15h
$B4:C872             dx 0004, 81FD,F3,3A7C, 81FD,FD,3A9A, 81F3,FD,3A7E, 81F3,F3,3A9C ; Sprite object     13h/14h/15h
$B4:C888             dx 0003, 81FD,F3,3A7E, 81FD,FD,3A9C, 81F3,FD,3A9A               ; Sprite object     13h/14h/15h
$B4:C899             dx 0002, 81FD,F3,3A9A, 81F3,FD,3A9C                             ; Sprite object     13h/14h/15h
$B4:C8A5             dx 0001, 81FD,F3,3A9C                                           ; Sprite object     13h/14h/15h
$B4:C8AC             dx 0001, 01FC,FC,3A6B                                           ; Sprite object     13h/14h/    16h
$B4:C8B3             dx 0001, 01FC,FC,3A6C                                           ; Sprite object     13h/14h/    16h
$B4:C8BA             dx 0002, 01F8,FC,3A6B, 0000,FC,3A6B                             ; Sprite object         14h/    16h
$B4:C8C6             dx 0002, 01F8,FC,3A6C, 0000,FC,3A6C                             ; Sprite object                 16h
$B4:C8D2             dx 0003, 01F4,FC,3A6C, 0004,FC,3A6C, 01FC,FC,3A6C               ; Sprite object                 16h
$B4:C8E3             dx 0003, 0004,FC,3A6B, 01F4,FC,3A6B, 01FC,FC,3A6B               ; Sprite object                 16h
$B4:C8F4             dx 0004, 0008,FC,3A6C, 0000,FC,3A6C, 01F8,FC,3A6C, 01F0,FC,3A6C ; Sprite object                 16h/17h
$B4:C90A             dx 0004, 0008,FC,3A6B, 0000,FC,3A6B, 01F8,FC,3A6B, 01F0,FC,3A6B ; Sprite object                 16h/17h

; Sprite object 18h (short Draygon breath bubbles)
$B4:C920             dx 0001, 01FC,FC,3A25
$B4:C927             dx 0003, 0000,F8,3A25, 01FA,F6,3A25, 01FC,FB,3A25
$B4:C938             dx 0003, 0001,F7,3A25, 01F9,F4,3A25, 01FB,FA,3A25
$B4:C949             dx 0003, 0001,F5,3A43, 01FC,F8,3A43, 01FA,F1,3A43
$B4:C95A             dx 0003, 0001,F3,3A43, 01FC,F5,3A43, 01FA,EE,3A43
$B4:C96B             dx 0003, 0000,F0,3A40, 01FC,F4,3A40, 01FA,ED,3A40
$B4:C97C             dx 0003, 0000,EE,3A40, 01FC,F2,3A40, 01FA,EC,3A40
$B4:C98D             dx 0002, 0000,EC,3A40, 01FC,F0,3A40
$B4:C999             dx 0001, 01FC,EE,3A40

; Sprite object 19h (unused. Save station electricity)
$B4:C9A0             dx 0004, 0008,E0,3A6F, 0000,E0,3A6F, 01F8,E0,3A6F, 01F0,E0,3A6F
$B4:C9B6             dx 0004, 0008,E8,3A6F, 0000,E8,3A6F, 01F8,E8,3A6F, 01F0,E8,3A6F
$B4:C9CC             dx 0004, 0008,F0,3A6F, 0000,F0,3A6F, 01F8,F0,3A6F, 01F0,F0,3A6F
$B4:C9E2             dx 0004, 0008,F8,3A6F, 0000,F8,3A6F, 01F8,F8,3A6F, 01F0,F8,3A6F
$B4:C9F8             dx 0004, 0008,00,3A6F, 0000,00,3A6F, 01F8,00,3A6F, 01F0,00,3A6F
$B4:CA0E             dx 0004, 0008,08,3A6F, 0000,08,3A6F, 01F8,08,3A6F, 01F0,08,3A6F
$B4:CA24             dx 0004, 0008,10,3A6F, 0000,10,3A6F, 01F8,10,3A6F, 01F0,10,3A6F
$B4:CA3A             dx 0004, 0008,18,3A6F, 0000,18,3A6F, 01F8,18,3A6F, 01F0,18,3A6F

; Sprite object 1Ah/1Bh (unused. Vertical gate)
$B4:CA50             dx 0002, 0000,FC,3ABF, 01F8,FC,3ABE
$B4:CA5C             dx 0001, 81F8,F8,3ABE
$B4:CA63             dx 0002, 81F8,FC,3ABE, 81F8,F4,3ABE
$B4:CA6F             dx 0002, 81F8,00,3ABE, 81F8,F0,3ABE
$B4:CA7B             dx 0003, 81F8,04,3ABE, 81F8,F8,3ABE, 81F8,EC,3ABE
$B4:CA8C             dx 0003, 81F8,08,3ABE, 81F8,F8,3ABE, 81F8,E8,3ABE
$B4:CA9D             dx 0004, 81F8,0C,3ABE, 81F8,00,3ABE, 81F8,F0,3ABE, 81F8,E4,3ABE
$B4:CAB3             dx 0004, 81F8,10,3ABE, 81F8,00,3ABE, 81F8,F0,3ABE, 81F8,E0,3ABE

; Sprite object 0 (unused. Beam charge)
$B4:CAC9             dx 0001, 01FC,FC,3C53
$B4:CAD0             dx 0001, 01FC,FC,3C52
$B4:CAD7             dx 0001, 01FC,FC,3C51
$B4:CADE             dx 0004, 01F8,00,BC50, 0000,00,FC50, 0000,F8,7C50, 01F8,F8,3C50

; Sprite object 1 (unused. Mother Brain elbow charge particles)
$B4:CAF4             dx 0003, 0000,0C,3A5B, 0008,EC,3A5B, 01F0,F4,3A5B
$B4:CB05             dx 0003, 01FD,0A,3A5C, 0006,EE,3A5C, 01F2,F6,3A5C
$B4:CB16             dx 0003, 01FC,08,3A5C, 0004,F0,3A5C, 01F4,F8,3A5C
$B4:CB27             dx 0003, 0002,F2,3A5D, 01FB,06,3A5D, 01F6,FA,3A5D
$B4:CB38             dx 0003, 01FB,04,3A5D, 01F8,FB,3A5D, 0000,F4,3A5D
$B4:CB49             dx 0003, 01FB,02,3A5D, 01FA,FA,3A5D, 0000,F6,3A5D

; Sprite object 2 (unused. Mother Brain elbow charge energy)
$B4:CB5A             dx 0003, 0000,EC,BA5B, 0008,0C,BA5B, 01F0,04,BA5B
$B4:CB6B             dx 0003, 01FE,EE,BA5C, 0006,0A,BA5C, 01F2,02,BA5C
$B4:CB7C             dx 0003, 0004,08,BA5C, 01F4,00,BA5C, 01FD,F0,BA5C
$B4:CB8D             dx 0003, 0002,06,BA5D, 01FC,F2,BA5D, 01F6,FE,BA5D ; Used by sprite object 5
$B4:CB9E             dx 0003, 01FC,F4,BA5D, 01F8,FC,BA5D, 0000,04,BA5D
$B4:CBAF             dx 0003, 01FC,F6,BA5D, 01FA,FD,BA5D, 0000,02,BA5D
$B4:CBC0             dx 0001, 01FC,FC,3A5F ; Used by sprite object 3

; Sprite object 3 (small explosion)
$B4:CBC7             dx 0004, 0000,00,FA8A, 01F8,00,BA8A, 0000,F8,7A8A, 01F8,F8,3A8A
$B4:CBDD             dx 0004, 8000,00,FA90, 81F0,00,BA90, 8000,F0,7A90, 81F0,F0,3A90
$B4:CBF3             dx 0004, 8000,00,FA92, 81F0,00,BA92, 8000,F0,7A92, 81F0,F0,3A92
$B4:CC09             dx 0004, 8000,00,FA94, 81F0,00,BA94, 8000,F0,7A94, 81F0,F0,3A94
$B4:CC1F             dx 0004, 8000,00,FA96, 81F0,00,BA96, 8000,F0,7A96, 81F0,F0,3A96

; Sprite object 4 (unused. Bomb explosion)
$B4:CC35             dx 0004, 0000,00,FA8B, 01F8,00,BA8B, 0000,F8,7A8B, 01F8,F8,3A8B
$B4:CC4B             dx 0004, 0000,00,FA7A, 01F8,00,BA7A, 0000,F8,7A7A, 01F8,F8,3A7A
$B4:CC61             dx 0004, 8000,00,FA70, 81F0,00,BA70, 8000,F0,7A70, 81F0,F0,3A70
$B4:CC77             dx 0004, 8000,00,FA72, 81F0,00,BA72, 8000,F0,7A72, 81F0,F0,3A72
$B4:CC8D             dx 0004, 8000,00,FA74, 81F0,00,BA74, 8000,F0,7A74, 81F0,F0,3A74

; Unused
$B4:CCA3             dx 0004, 01F8,00,3A5E, 0000,00,3A5E, 0000,F8,3A5E, 01F8,F8,3A5E

; Sprite object 5 (unused. Beam trail)
$B4:CCB9             dx 0001, 01FC,FC,3C38
$B4:CCC0             dx 0001, 01FC,FC,3C39
$B4:CCC7             dx 0001, 01FC,FC,3C3A
$B4:CCCE             dx 0001, 01FC,FC,3C3B

; Sprite object 7 (unused. Power bomb)
$B4:CCD5             dx 0001, 01FC,FC,3A26
$B4:CCDC             dx 0001, 01FC,FC,3A27
$B4:CCE3             dx 0001, 01FC,FC,3A7B

; Unused
$B4:CCEA             dx 0001, 01FC,FC,3A5F

; Sprite object 6 (dud shot)
$B4:CCF1             dx 0001, 01FC,FC,3A53
$B4:CCF8             dx 0001, 01FC,FC,3A51
$B4:CCFF             dx 0004, 0000,00,FA60, 0000,F8,7A60, 01F8,00,BA60, 01F8,F8,3A60
$B4:CD15             dx 0004, 0000,00,FA61, 0000,F8,7A61, 01F8,00,BA61, 01F8,F8,3A61
$B4:CD2B             dx 0004, 0000,00,FA62, 0000,F8,7A62, 01F8,00,BA62, 01F8,F8,3A62
$B4:CD41             dx 0004, 0000,00,FA63, 0000,F8,7A63, 01F8,00,BA63, 01F8,F8,3A63

; Sprite object 8/1Ch (unused. Elevator pad)
$B4:CD57             dx 0004, 01F2,FC,7A6C, 0006,FC,7A6C, 0000,FC,7A6C, 01F8,FC,3A6C
$B4:CD6D             dx 0004, 0000,FC,7A6E, 0008,FC,7A6D, 01F8,FC,3A6E, 01F0,FC,3A6D

; Unused
$B4:CD83             dx 0004, 01F0,FE,3A6F, 0008,FE,3A6F, 0000,FE,3A6F, 01F8,FE,3A6F

; Sprite object 9 (small dust cloud)
$B4:CD99             dx 0001, 81F8,F8,3A7C
$B4:CDA0             dx 0001, 81F8,F6,3A7E
$B4:CDA7             dx 0001, 81F8,F4,3A9A
$B4:CDAE             dx 0001, 81F8,F2,3A9C

; Sprite object Ah (ninja space pirate landing dust cloud)
$B4:CDB5             dx 0001, 01FC,FC,3A48 ; Used by sprite object 9
$B4:CDBC             dx 0001, 01FC,FA,3A49
$B4:CDC3             dx 0001, 01FC,F8,3A4A
$B4:CDCA             dx 0001, 01FC,F6,3A4B

; Sprite object Bh (unused. Eye door sweat drop)
$B4:CDD1             dx 0001, 01FC,FC,3A2C
$B4:CDD8             dx 0001, 01FC,FC,3A2D
$B4:CDDF             dx 0001, 01FC,FC,3A2E
$B4:CDE6             dx 0001, 01FC,FC,3A2F

; Sprite object Ch (smoke)
$B4:CDED             dx 0001, 81F8,F6,3A76
$B4:CDF4             dx 0001, 81F8,F4,3A78
$B4:CDFB             dx 0001, 81F8,F2,3A98
$B4:CE02             dx 0001, 81F8,F0,3A9E

; Unused
$B4:CE09             dx 0001, 01FC,FC,3A25
$B4:CE10             dx 0001, 01FC,FC,3A43
$B4:CE17             dx 0001, 01FC,FC,3A40

; Sprite object Dh (unused. Small health drop)
$B4:CE1E             dx 0001, 01FC,FC,3A3E
$B4:CE25             dx 0001, 01FC,FC,3A3D
$B4:CE2C             dx 0001, 01FC,FC,3A41
$B4:CE33             dx 0001, 01FC,FC,3A42

; Sprite object Eh (unused. Big health drop)
$B4:CE3A             dx 0004, 0000,00,FA44, 01F8,00,BA44, 0000,F8,7A44, 01F8,F8,3A44
$B4:CE50             dx 0004, 0000,00,FA45, 0000,F8,7A45, 01F8,00,BA45, 01F8,F8,3A45
$B4:CE66             dx 0004, 01F8,00,BA46, 0000,00,FA46, 0000,F8,7A46, 01F8,F8,3A46
$B4:CE7C             dx 0001, 01FC,FC,3A42

; Sprite object Fh (unused. Bomb)
$B4:CE83             dx 0001, 01FC,FC,3A4C
$B4:CE8A             dx 0001, 01FC,FC,3A4D
$B4:CE91             dx 0001, 01FC,FC,3A4E
$B4:CE98             dx 0001, 01FC,FC,3A4F

; Unused
$B4:CE9F             dx 0002, 01FF,FC,3A55, 01F7,FC,3A54
$B4:CEAB             dx 0003, 01FA,F5,3A56, 0002,FD,3A58, 01FA,FD,3A57
$B4:CEBC             dx 0002, 01FD,F7,3A59, 01FD,FF,3A5A
$B4:CEC8             dx 0003, 01FE,F5,7A56, 01F6,FD,7A58, 01FE,FD,7A57
$B4:CED9             dx 0002, 01F9,FC,7A55, 0001,FC,7A54
$B4:CEE5             dx 0003, 01FE,03,FA56, 01F6,FB,FA58, 01FE,FB,FA57
$B4:CEF6             dx 0002, 01FD,01,BA59, 01FD,F9,BA5A
$B4:CF02             dx 0003, 01FA,03,BA56, 0002,FB,BA58, 01FA,FB,BA57
$B4:CF13             dx 0002, 0000,FC,3A65, 01F8,FC,3A64
$B4:CF1F             dx 0003, 0002,FE,3A68, 01FA,FE,3A67, 01FA,F6,3A66
$B4:CF30             dx 0002, 01FC,F8,3A69, 01FC,00,3A6A
$B4:CF3C             dx 0003, 01F6,FE,7A68, 01FE,FE,7A67, 01FE,F6,7A66
$B4:CF4D             dx 0002, 01F8,FC,7A65, 0000,FC,7A64
$B4:CF59             dx 0003, 01F6,FA,FA68, 01FE,FA,FA67, 01FE,02,FA66
$B4:CF6A             dx 0002, 01FC,00,BA69, 01FC,F8,BA6A
$B4:CF76             dx 0003, 0002,FA,BA68, 01FA,FA,BA67, 01FA,02,BA66

; Sprite object 10h (unused. Weird small health drop)
$B4:CF87             dx 0001, 01FC,FC,3A3C
$B4:CF8E             dx 0001, 01FC,FC,3A3D
$B4:CF95             dx 0001, 01FC,FC,3A3E

; Unused
$B4:CF9C             dx 0001, 01FC,FC,3A3F

; Sprite object 1Dh (big explosion)
$B4:CFA3             dx 0004, 0000,00,FA8A, 01F8,00,BA8A, 0000,F8,7A8A, 01F8,F8,3A8A
$B4:CFB9             dx 0004, C200,00,FA90, C200,F0,7A90, C3F0,00,BA90, C3F0,F0,3A90
$B4:CFCF             dx 0004, C200,00,FA92, C3F0,00,BA92, C200,F0,7A92, C3F0,F0,3A92
$B4:CFE5             dx 000C, 0010,00,FAC2, 0010,F8,7AC2, 0000,10,FAB2, 01F8,10,BAB2, 01E8,00,BAC2, 01E8,F8,3AC2, 0000,E8,7AB2, 01F8,E8,3AB2, C200,00,FAB0, C200,F0,7AB0, C3F0,00,BAB0, C3F0,F0,3AB0
$B4:D023             dx 0008, C208,00,FAB5, C200,08,FAB3, C3E8,00,BAB5, C3F0,08,BAB3, C208,F0,7AB5, C200,E8,7AB3, C3E8,F0,3AB5, C3F0,E8,3AB3
$B4:D04D             dx 000C, 0000,10,FABB, 01F8,10,BABB, 0000,E8,7ABB, 01F8,E8,3ABB, 0010,00,FAB7, 0010,F8,7AB7, 01E8,00,BAB7, 01E8,F8,3AB7, C208,08,FAB8, C3E8,08,BAB8, C208,E8,7AB8, C3E8,E8,3AB8

; Sprite object 26h (unused)
$B4:D08B             dx 0009, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FB,20D8, 8001,01,20D8, 81FF,07,20DC, 01FE,10,20F6, 01FE,08,20F5
$B4:D0BA             dx 0009, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FC,20D8, 8001,02,20D8, 81FF,07,20DC, 01FE,10,20F6, 01FE,08,20F5
$B4:D0E9             dx 0009, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FD,20D8, 8001,03,20D8, 81FF,08,20DC, 01FE,11,20F6, 01FE,09,20F5
$B4:D118             dx 0009, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FD,20D8, 8001,04,20D8, 81FF,09,20DC, 01FE,12,20F6, 01FE,0A,20F5
$B4:D147             dx 0009, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FD,20D8, 8001,04,20D8, 81FF,0A,20DC, 01FE,11,20F6, 01FE,09,20F5
$B4:D176             dx 0009, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FC,20D8, 8001,03,20D8, 81FF,09,20DC, 01FE,10,20F6, 01FE,08,20F5

; Unused
$B4:D1A5             dx 0009, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FB,20D8, 8001,01,20D8, 81FF,07,20DC, 01FE,10,20F6, 01FE,08,20F5

; Sprite object 27h (unused)
$B4:D1D4             dx 0005, 0000,F8,20F3, 01F8,F8,20F2, 0002,FC,20F4, 01FE,F4,20F1, 01F6,F4,20F0
$B4:D1EF             dx 0005, 01FE,F4,20F3, 01F6,F4,20F2, 0000,F8,20F4, 0002,FC,20F3, 01FA,FC,20F2
$B4:D20A             dx 0005, 01FE,F4,20F4, 01F8,F8,20F2, 0000,F8,20F3, 0002,FC,20F1, 01FA,FC,20F0
$B4:D225             dx 0006, 01FE,F4,20F3, 01F6,F4,20F2, 01F8,F8,20F0, 0000,F8,20F1, 0002,FC,20F3, 01FA,FC,20F2
$B4:D245             dx 0003, 01FE,F4,20F4, 0000,F8,20F4, 0002,FC,20F4

; Unused
$B4:D256             dx 0006, 01FE,F4,20F3, 01F6,F4,20F2, 01F8,F8,20F2, 0000,F8,20F3, 0002,FC,20F3, 01FA,FC,20F2
$B4:D276             dx 0006, 01FE,F4,20F1, 01F6,F4,20F0, 0000,F8,20F1, 01F8,F8,20F0, 0002,FC,20F1, 01FA,FC,20F0
$B4:D296             dx 0004, 0000,00,A0F8, 01F8,00,A0F7, 0000,F8,20F8, 01F8,F8,20F7

; Sprite object 2Ah (unused)
$B4:D2AC             dx 0001, 81F8,F8,20DE

; Sprite object 28h (unused)
$B4:D2B3             dx 0009, 81F2,FB,60D6, 8002,FB,60D4, 81F2,EB,60D2, 8002,EB,60D0, 81EE,FB,60D8, 81EF,01,60D8, 81F1,07,60DC, 01FA,10,60F6, 01FA,08,60F5
$B4:D2E2             dx 0009, 81F2,FB,60D6, 8002,FB,60D4, 81F2,EB,60D2, 8002,EB,60D0, 81EE,FC,60D8, 81EF,02,60D8, 81F1,07,60DC, 01FA,10,60F6, 01FA,08,60F5
$B4:D311             dx 0009, 81F2,FB,60D6, 8002,FB,60D4, 81F2,EB,60D2, 8002,EB,60D0, 81EE,FD,60D8, 81EF,03,60D8, 81F1,08,60DC, 01FA,11,60F6, 01FA,09,60F5
$B4:D340             dx 0009, 81F2,FB,60D6, 8002,FB,60D4, 81F2,EB,60D2, 8002,EB,60D0, 81EE,FD,60D8, 81EF,04,60D8, 81F1,09,60DC, 01FA,12,60F6, 01FA,0A,60F5
$B4:D36F             dx 0009, 81F2,FB,60D6, 8002,FB,60D4, 81F2,EB,60D2, 8002,EB,60D0, 81EE,FD,60D8, 81EF,04,60D8, 81F1,0A,60DC, 01FA,11,60F6, 01FA,09,60F5
$B4:D39E             dx 0009, 81F2,FB,60D6, 8002,FB,60D4, 81F2,EB,60D2, 8002,EB,60D0, 81EE,FC,60D8, 81EF,03,60D8, 81F1,09,60DC, 01FA,10,60F6, 01FA,08,60F5

; Unused
$B4:D3CD             dx 0009, 81F2,FB,60D6, 8002,FB,60D4, 81F2,EB,60D2, 8002,EB,60D0, 81EE,FB,60D8, 81EF,01,60D8, 81F1,07,60DC, 01FA,10,60F6, 01FA,08,60F5

; Sprite object 29h (unused)
$B4:D3FC             dx 0005, 01F8,F8,60F3, 0000,F8,60F2, 01FA,F4,60F1, 0002,F4,60F0, 01F6,FC,60F4
$B4:D417             dx 0005, 01FA,F4,60F3, 0002,F4,60F2, 01F8,F8,60F4, 01F6,FC,60F3, 01FE,FC,60F2
$B4:D432             dx 0005, 01FA,F4,60F4, 01F8,F8,60F3, 0000,F8,60F2, 01F6,FC,60F1, 01FE,FC,60F0
$B4:D44D             dx 0006, 01FA,F4,60F3, 0002,F4,60F2, 0000,F8,60F0, 01F8,F8,60F1, 01F6,FC,60F3, 01FE,FC,60F2
$B4:D46D             dx 0003, 01F6,FC,60F4, 01F8,F8,60F4, 01FA,F4,60F4

; Unused
$B4:D47E             dx 0006, 01FA,F4,60F3, 0002,F4,60F2, 01F8,F8,60F3, 0000,F8,60F2, 01F6,FC,60F3, 01FE,FC,60F2
$B4:D49E             dx 0006, 01FA,F4,60F1, 0002,F4,60F0, 0000,F8,60F0, 01F8,F8,60F1, 01F6,FC,60F1, 01FE,FC,60F0

; Sprite object 2Bh (fire arc body)
$B4:D4BE             dx 0001, 81F9,F8,230A
$B4:D4C5             dx 0001, 81F9,F8,2308
$B4:D4CC             dx 0001, 81F8,F8,E30A
$B4:D4D3             dx 0001, 81F8,F8,E308
$B4:D4DA             dx 0001, 81F9,F8,2306
$B4:D4E1             dx 0001, 81F9,F8,2322
$B4:D4E8             dx 0001, 81F8,F8,E306
$B4:D4EF             dx 0001, 81F8,F8,E322

; Sprite object 2Ch (fire arc right explosion)
$B4:D4F6             dx 0001, 81F9,F9,230E
$B4:D4FD             dx 0001, 81FD,F5,2320
$B4:D504             dx 0001, 8003,EE,2304
$B4:D50B             dx 0001, 8005,EC,2308
$B4:D512             dx 0001, 8005,EC,230C
$B4:D519             dx 0001, 8005,EC,2326
$B4:D520             dx 0001, 8005,EC,232E

; Sprite object 2Dh (fire arc left explosion)
$B4:D527             dx 0001, 81F8,F9,630E
$B4:D52E             dx 0001, 81F4,F5,6320
$B4:D535             dx 0001, 81EE,EE,6304
$B4:D53C             dx 0001, 81EC,EC,6308
$B4:D543             dx 0001, 81EC,EC,630C
$B4:D54A             dx 0001, 81EC,EC,6326
$B4:D551             dx 0001, 81EB,EC,232E

; Sprite object 2Eh (fire arc splash)
$B4:D558             dx 0002, 01F1,F8,6334, 0008,F8,2334
$B4:D564             dx 0002, 01F1,F8,6324, 0008,F8,2324
$B4:D570             dx 0002, 81E9,F0,6328, 8008,F0,2328
$B4:D57C             dx 0002, 81E9,F0,632C, 8008,F0,232C
$B4:D588             dx 0002, 81E8,F0,632A, 8009,F0,232A

; Sprite object 2Fh (unused)
$B4:D594             dx 0001, 81F8,F8,3340

; Sprite object 30h (falling spark trail)
$B4:D59B             dx 0001, 01FC,FC,2107
$B4:D5A2             dx 0001, 01FC,FC,2108
$B4:D5A9             dx 0001, 01FC,FC,2109
$B4:D5B0             dx 0001, 01FC,FC,210A

; Sprite object 34h/35h/36h (metroid shell)
$B4:D5B7             dx 000A, 0010,04,6130, 0010,FC,6120, 0010,F4,6110, 01E8,04,2130, 01E8,FC,2120, 01E8,F4,2110, 8000,FC,6121, 8000,EC,2103, 81F0,FC,2121, 81F0,EC,2101
$B4:D5EB             dx 000A, 0010,FC,612A, 0010,04,613A, 0010,F4,211F, 01E8,04,213A, 01E8,FC,212A, 01E8,F4,211A, 8000,EC,210D, 8000,FC,612B, 81F0,FC,212B, 81F0,EC,210B ; Sprite object 34h/36h only
$B4:D61F             dx 000A, 01E8,FC,2125, 0010,04,6135, 0010,FC,6125, 0010,F4,6115, 01E8,04,2135, 01E8,F4,2115, 8000,FC,6126, 8000,EC,2108, 81F0,FC,2126, 81F0,EC,2106

; Sprite object 31h (unused. Metroid insides. See $A3:F10D)
$B4:D653             dx 0008, 0010,00,6160, 0010,F8,6150, 01E8,00,2160, 01E8,F8,2150, 8000,00,6161, 8000,F0,6141, 81F0,00,2161, 81F0,F0,2141
$B4:D67D             dx 0006, 0010,00,6163, 01E8,00,2163, 8000,00,6164, 8000,F0,6144, 81F0,00,2164, 81F0,F0,2144
$B4:D69D             dx 0008, 0010,00,6166, 0010,F8,6156, 01E8,00,2166, 01E8,F8,2156, 8000,00,6167, 8000,F0,6147, 81F0,00,2167, 81F0,F0,2147
$B4:D6C7             dx 0008, 0010,00,6169, 0010,F8,6159, 01E8,00,2169, 01E8,F8,2159, 8000,00,616A, 8000,F0,614A, 81F0,00,216A, 81F0,F0,214A

; Sprite object 32h/33h (metroid electricity)
$B4:D6F1             dx 0003, 0000,EC,217C, 01F8,FC,214D, 01F0,FC,214C
$B4:D702             dx 0003, 0000,EC,217D, 01F8,FC,215D, 01F0,FC,215C
$B4:D713             dx 0003, 0000,EC,217E, 01F8,FC,216D, 01F0,FC,216C
$B4:D724             dx 0004, 0008,FC,214F, 0000,FC,214E, 01F8,F4,213D, 01F8,EC,212D
$B4:D73A             dx 0004, 0008,FC,215F, 0000,FC,215E, 01F8,F4,213E, 01F8,EC,212E
$B4:D750             dx 0004, 0008,FC,216F, 0000,FC,216E, 01F8,F4,213F, 01F8,EC,212F
$B4:D766             dx 0003, 0008,FC,214D, 0000,FC,214C, 01F8,EC,617C
$B4:D777             dx 0003, 0008,FC,215D, 0000,FC,215C, 01F8,EC,617D
$B4:D788             dx 0003, 0008,FC,216D, 0000,FC,216C, 01F8,EC,617E
$B4:D799             dx 0004, 01F8,FC,214F, 01F0,FC,214E, 0000,F4,613D, 0000,EC,612D
$B4:D7AF             dx 0004, 01F8,FC,216F, 01F0,FC,216E, 0000,F4,613E, 0000,EC,612E
$B4:D7C5             dx 0004, 01F8,FC,215F, 01F0,FC,215E, 0000,F4,613F, 0000,EC,612F
$B4:D7DB             dx 0002, 01F8,FC,214D, 01F0,FC,214C ; Sprite object 32h only
$B4:D7E7             dx 0001, 01F0,FC,215C               ; Sprite object 32h only
$B4:D7EE             dx 0002, 01F8,FC,216D, 01F0,FC,216C ; Sprite object 32h only
$B4:D7FA             dx 0002, 01F8,F4,213D, 01F8,EC,212D
$B4:D806             dx 0002, 01F8,F4,213E, 01F8,EC,212E
$B4:D812             dx 0002, 01F8,F4,213F, 01F8,EC,212F
$B4:D81E             dx 0002, 0008,FC,214D, 0000,FC,214C ; Sprite object 32h only
$B4:D82A             dx 0002, 0008,FC,215D, 0000,FC,215C ; Sprite object 32h only
$B4:D836             dx 0002, 0008,FC,216D, 0000,FC,216C ; Sprite object 32h only
$B4:D842             dx 0001, 0000,EC,217C
$B4:D849             dx 0001, 0000,EC,217D
$B4:D850             dx 0001, 0000,EC,217E

; Sprite object 37h (enemy shot)
$B4:D857             dx 0004, 0002,02,ECBC, 01F6,02,ACBC, 0002,F6,6CBC, 01F6,F6,2CBC
$B4:D86D             dx 0004, 0004,04,ECBD, 01F4,04,ACBD, 0004,F4,6CBD, 01F4,F4,2CBD
$B4:D883             dx 0004, 0007,07,ECCB, 0007,F1,6CCB, 01F1,07,ACCB, 01F1,F1,2CCB
$B4:D899             dx 0004, 000B,0B,ECCC, 01ED,0B,ACCC, 000B,ED,6CCC, 01ED,ED,2CCC

; Sprite object 38h (yapping maw base - facing down)
$B4:D8AF             dx 0001, 81F8,F8,210A

; Sprite object 39h (yapping maw base - facing up)
$B4:D8B6             dx 0001, 81F8,F8,A10A

; Sprite object 3Ah (unused)
$B4:D8BD             dx 000E, 01FB,00,20F3, 01F3,00,20F2, 01FD,04,20F4, 01F9,FD,20F1, 01F1,FD,20F0, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FB,20D8, 8001,01,20DA, 81FF,07,20DC, 01FE,10,20F6, 01FE,08,20F5
$B4:D905             dx 0010, 01F9,FC,20F3, 01F1,FC,20F2, 01FB,00,20F4, 01FD,04,20F3, 01F5,04,20F2, 01EE,FB,20F9, 01F6,F3,20FC, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FC,20D8, 8001,02,20DA, 81FF,07,20DC, 01FE,11,20F6, 01FE,09,20F5
$B4:D957             dx 0010, 01FC,04,20F1, 01FC,00,20F3, 01F4,04,20F0, 01F4,00,20F2, 01F8,FC,20F4, 01EE,FB,20FA, 01F6,F3,20FB, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FD,20D8, 8001,03,20DA, 81FF,08,20DC, 01FE,12,20F6, 01FE,0A,20F5
$B4:D9A9             dx 0010, 01FE,04,20F3, 01F6,04,20F2, 01F4,01,20F0, 01FC,01,20F1, 01FB,FC,20F3, 01F3,FC,20F2, 01EE,FB,20F9, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FD,20D8, 8001,04,20DA, 81FF,09,20DC, 01FE,12,20F6, 01FE,0A,20F5
$B4:D9FB             dx 000F, 01FC,00,20F3, 01F4,00,20F2, 01FE,04,20F4, 01FA,FD,20F1, 01F2,FD,20F0, 01EE,FB,20F9, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FD,20D8, 8001,04,20DA, 81FF,0A,20DC, 01FE,12,20F6, 01FE,0A,20F5
$B4:DA48             dx 000E, 01FC,00,20F4, 01FE,04,20F3, 01FA,FB,20F3, 01F2,FB,20F2, 01F6,04,20F2, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FC,20D8, 8001,03,20DA, 81FF,0A,20DC, 01FE,11,20F6, 01FE,09,20F5
$B4:DA90             dx 000E, 01FE,04,20F1, 01F6,04,20F0, 01FA,FC,20F4, 01F4,00,20F2, 01FC,00,20F3, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FB,20D8, 8001,01,20DA, 81FF,08,20DC, 01FE,10,20F6, 01FE,08,20F5
$B4:DAD8             dx 000F, 01FE,04,20F3, 01F6,04,20F2, 01FC,01,20F1, 01F4,01,20F0, 01FA,FC,20F3, 01F2,FC,20F2, 81FE,FB,20D6, 81EE,FB,20D4, 81FE,EB,20D2, 81EE,EB,20D0, 8002,FB,20D8, 8001,01,20DA, 81FF,07,20DC, 01FE,0F,20F6, 01FE,07,20F5

; Unused
$B4:DB25             dx 0004, 0000,00,A0F8, 01F8,00,A0F7, 0000,F8,20F8, 01F8,F8,20F7
$B4:DB3B             dx 0001, 81F8,F8,20DE

; Sprite object 3Bh (evir facing left)
$B4:DB42             dx 000C, 0000,02,20F3, 01F8,02,20F2, 01FC,FC,20F1, 01F4,FC,20F0, 8000,FC,20D6, 81F0,FC,20D4, 8000,EC,20D2, 81F0,EC,20D0, 8004,FB,20D8, 8002,02,20DC, 0000,0F,20F6, 0000,07,20F5
$B4:DB80             dx 000C, 01F8,F4,20FC, 0000,02,20F4, 01FC,FC,20F3, 01F4,FC,20F2, 8000,FC,20D6, 81F0,FC,20D4, 8000,EC,20D2, 81F0,EC,20D0, 8004,FC,20D8, 8002,03,20DC, 0000,0E,20F6, 0000,06,20F5
$B4:DBBE             dx 000C, 01F8,F4,20FB, 0000,02,20F3, 01F8,02,20F2, 01FA,FC,20F4, 8000,FC,20D6, 81F0,FC,20D4, 8000,EC,20D2, 81F0,EC,20D0, 8004,FD,20D8, 8002,03,20DC, 0000,0D,20F6, 0000,05,20F5
$B4:DBFC             dx 000D, 01FC,FC,20F3, 01F4,FC,20F2, 01F0,FC,20F9, 0000,02,20F1, 01F8,02,20F0, 8000,FC,20D6, 81F0,FC,20D4, 8000,EC,20D2, 81F0,EC,20D0, 8004,FD,20D8, 8002,04,20DC, 0000,0E,20F6, 0000,06,20F5

; Sprite object 3Ch (evir facing right)
$B4:DC3F             dx 000C, 01F8,02,60F3, 0000,02,60F2, 01FC,FC,60F1, 0004,FC,60F0, 81F0,FC,60D6, 8000,FC,60D4, 81F0,EC,60D2, 8000,EC,60D0, 81EC,FB,60D8, 81EE,02,60DC, 01F8,0F,60F6, 01F8,07,60F5
$B4:DC7D             dx 000C, 0000,F4,60FC, 01F8,02,60F4, 01FC,FC,60F3, 0004,FC,60F2, 81F0,FC,60D6, 8000,FC,60D4, 81F0,EC,60D2, 8000,EC,60D0, 81EC,FC,60D8, 81EE,03,60DC, 01F8,0E,60F6, 01F8,06,60F5
$B4:DCBB             dx 000C, 0000,F4,60FB, 01F8,02,60F3, 0000,02,60F2, 01FE,FC,60F4, 81F0,FC,60D6, 8000,FC,60D4, 81F0,EC,60D2, 8000,EC,60D0, 81EC,FD,60D8, 81EE,03,60DC, 01F8,0D,60F6, 01F8,05,60F5
$B4:DCF9             dx 000D, 01FC,FC,60F3, 0004,FC,60F2, 0008,FC,60F9, 01F8,02,60F1, 0000,02,60F0, 81F0,FC,60D6, 8000,FC,60D4, 81F0,EC,60D2, 8000,EC,60D0, 81EC,FD,60D8, 81EE,04,60DC, 01F8,0E,60F6, 01F8,06,60F5

; Unused instruction list $BE46
$B4:DD3C             dx 0001, 81F8,F8,3BCA
$B4:DD43             dx 0001, 81F8,F8,3BCC
$B4:DD4A             dx 0001, 81F8,F8,3BCE

; Sprite object 3Dh (Draygon foaming at the mouth)
$B4:DD51             dx 0001, 81F8,F8,35E0
$B4:DD58             dx 0001, 81F8,F4,35E2
$B4:DD5F             dx 0001, 81F8,F0,35E4
$B4:DD66             dx 0001, 81F8,EC,35E6
$B4:DD6D             dx 0001, 81F8,E8,35E8
$B4:DD74             dx 0001, 81F8,E4,35EA
$B4:DD7B             dx 0001, 81F8,E0,35EC
$B4:DD82             dx 0001, 81F8,DC,35EE
}
}


;;; $DD89: Enemy names ;;;
{
;                        ________________________________________ Enemy name in ASCII
;                       |                               _________ Enemy population pointer (for debug enemy spawner)
;                       |                              |      ___ Enemy name debug spritemap index (add 30h to index $A201)
;                       |                              |     |
$B4:DD89             dx 4E,4F,44,41,54,41,20,20,20,20, E2F3, 0000 ; "NODATA    " - enemies with enemy name = 0
$B4:DD97             dx 41,54,4F,4D,49,43,20,20,20,20, E2F6, 0001 ; "ATOMIC    " - enemy $E9FF
$B4:DDA5             dx 42,41,4E,47,20,20,20,20,20,20, E309, 0002 ; "BANG      " - enemy $DB3F
$B4:DDB3             dx 42,41,54,54,41,31,20,20,20,20, E33C, 0003 ; "BATTA1    " - enemy $F353
$B4:DDC1             dx 42,41,54,54,41,32,20,20,20,20, E34F, 0004 ; "BATTA2    " - enemy $F4D3
$B4:DDCF             dx 42,41,54,54,41,33,20,20,20,20, E362, 0005 ; "BATTA3    " - enemy $F653
$B4:DDDD             dx 42,4F,54,4F,4F,4E,20,20,20,20, E375, 0006 ; "BOTOON    " - enemy $F293
$B4:DDEB             dx 42,4F,59,4F,4E,20,20,20,20,20, E388, 0007 ; "BOYON     " - enemy $CEBF
$B4:DDF9             dx 44,45,53,53,47,45,45,47,41,20, E39B, 0008 ; "DESSGEEGA " - enemy $DA3F
$B4:DE07             dx 44,4F,52,49,20,20,20,20,20,20, E3AE, 0009 ; "DORI      " - enemy $F07F
$B4:DE15             dx 44,52,41,47,4F,4E,20,20,20,20, E421, 000A ; "DRAGON    " - enemy $D4BF
$B4:DE23             dx 45,42,49,20,20,20,20,20,20,20, E444, 000B ; "EBI       " - enemy $E63F
$B4:DE31             dx 45,59,45,20,20,20,20,20,20,20, E477, 000C ; "EYE       " - enemy $E6BF
$B4:DE3F             dx 4E,41,4D,49,20,20,20,20,20,20, E49A, 000D ; "NAMI      " - enemy $E73F, debug spritemap name is "NAMIHEI"
$B4:DE4D             dx 46,49,53,48,20,20,20,20,20,20, E4AD, 000E ; "FISH      " - enemy $D6FF
$B4:DE5B             dx 47,41,49,20,20,20,20,20,20,20, E4C0, 000F ; "GAI       " - enemy $E77F
$B4:DE69             dx 47,41,4D,45,54,20,20,20,20,20, E4D3, 0010 ; "GAMET     " - enemy $F213
$B4:DE77             dx 47,45,45,47,41,20,20,20,20,20, E526, 0011 ; "GEEGA     " - enemy $F253
$B4:DE85             dx 47,45,52,55,44,41,20,20,20,20, E539, 0012 ; "GERUDA    " - enemy $D2FF
$B4:DE93             dx 47,52,41,56,59,20,20,20,20,20, E55C, 0013 ; "GRAVY     "
$B4:DEA1             dx 48,41,43,48,49,31,20,20,20,20, E55F, 0014 ; "HACHI1    " - enemy $EABF
$B4:DEAF             dx 48,41,4E,44,20,20,20,20,20,20, E582, 0015 ; "HAND      " - enemy $E7BF
$B4:DEBD             dx 48,49,42,41,53,48,49,20,20,20, E595, 0016 ; "HIBASHI   " - enemy $E07F
$B4:DECB             dx 48,49,52,55,20,20,20,20,20,20, E5B8, 0017 ; "HIRU      " - enemy $D3BF
$B4:DED9             dx 48,4F,4C,54,5A,20,20,20,20,20, E5CB, 0018 ; "HOLTZ     " - enemy $D33F
$B4:DEE7             dx 48,4F,54,41,52,59,20,20,20,20, E5EE, 0019 ; "HOTARY    " - enemy $D6BF
$B4:DEF5             dx 48,5A,4F,4F,4D,45,52,20,20,20, E601, 001A ; "HZOOMER   " - enemy $DC3F
$B4:DF03             dx 4B,41,47,4F,20,20,20,20,20,20, E614, 001B ; "KAGO      " - enemy $E7FF
$B4:DF11             dx 4B,41,4D,45,20,20,20,20,20,20, E627, 001C ; "KAME      " - enemy $CF3F
$B4:DF1F             dx 4B,41,4D,45,52,20,20,20,20,20, E67A, 001D ; "KAMER     " - enemy $D7FF/$D83F
$B4:DF2D             dx 4B,41,4E,49,20,20,20,20,20,20, E68D, 001E ; "KANI      " - enemy $D77F
$B4:DF3B             dx 4B,4F,4D,41,20,20,20,20,20,20, E6A0, 001F ; "KOMA      " - enemy $EA7F
$B4:DF49             dx 4B,5A,41,4E,20,20,20,20,20,20, E6B3, 0020 ; "KZAN      " - enemy $DFFF
$B4:DF57             dx 4C,41,56,41,4D,41,4E,20,20,20, E6D6, 0021 ; "LAVAMAN   " - enemy $E83F
$B4:DF65             dx 4D,45,4C,4C,41,20,20,20,20,20, E709, 0022 ; "MELLA     " - enemy $D13F
$B4:DF73             dx 4D,45,4D,55,20,20,20,20,20,20, E71C, 0023 ; "MEMU      " - enemy $D17F
$B4:DF81             dx 4D,45,52,4F,20,20,20,20,20,20, E72F, 0024 ; "MERO      " - enemy $D0FF
$B4:DF8F             dx 4D,45,54,41,4C,45,45,20,20,20, E742, 0025 ; "METALEE   " - enemy $D67F
$B4:DF9D             dx 4D,45,54,4D,4F,44,20,20,20,20, E755, 0026 ; "METMOD    " - enemy $D8FF
$B4:DFAB             dx 4D,45,54,52,4F,49,44,20,20,20, E768, 0027 ; "METROID   " - enemy $DD7F
$B4:DFB9             dx 4D,55,4C,54,49,20,20,20,20,20, E77B, 0028 ; "MULTI     " - enemy $D1BF
$B4:DFC7             dx 4D,5A,4F,4F,4D,45,52,20,20,20, E78E, 0029 ; "MZOOMER   " - enemy $DD3F
$B4:DFD5             dx 4E,44,52,41,20,20,20,20,20,20, E7A1, 002A ; "NDRA      " - enemy $E9BF
$B4:DFE3             dx 4E,4F,4D,49,20,20,20,20,20,20, E7B4, 002B ; "NOMI      " - enemy $E87F
$B4:DFF1             dx 4E,4F,56,41,20,20,20,20,20,20, E7C7, 002C ; "NOVA      " - enemy $DCBF
$B4:DFFF             dx 4F,55,4D,20,20,20,20,20,20,20, E7DA, 002D ; "OUM       " - enemy $D37F
$B4:E00D             dx 4F,55,4D,55,20,20,20,20,20,20, E7ED, 002E ; "OUMU      " - enemy $D7BF
$B4:E01B             dx 50,49,50,45,20,20,20,20,20,20, E800, 002F ; "PIPE      " - enemy $E97F
$B4:E029             dx 50,4F,4C,59,50,20,20,20,20,20, E813, 0030 ; "POLYP     " - enemy $D1FF
$B4:E037             dx 50,55,52,4F,4D,49,20,20,20,20, E826, 0031 ; "PUROMI    " - enemy $E0BF
$B4:E045             dx 50,55,55,20,20,20,20,20,20,20, E839, 0032 ; "PUU       " - enemy $E8BF
$B4:E053             dx 50,55,59,4F,20,20,20,20,20,20, E85C, 0033 ; "PUYO      " - enemy $CFBF
$B4:E061             dx 52,45,46,4C,45,43,20,20,20,20, E86F, 0034 ; "REFLEC    " - enemy $DBFF
$B4:E06F             dx 52,49,4E,4B,41,20,20,20,20,20, E882, 0035 ; "RINKA     " - enemy $D23F
$B4:E07D             dx 52,49,4F,20,20,20,20,20,20,20, E895, 0036 ; "RIO       " - enemy $D27F
$B4:E08B             dx 52,49,50,50,45,52,20,20,20,20, E8A8, 0037 ; "RIPPER    " - enemy $D47F, debug spritemap name is "RIPPER1"
$B4:E099             dx 52,49,50,50,45,52,32,20,20,20, E8BB, 0038 ; "RIPPER2   " - enemy $D3FF/$D43F
$B4:E0A7             dx 52,4F,42,4F,20,20,20,20,20,20, E8CE, 0039 ; "ROBO      " - enemy $E8FF
$B4:E0B5             dx 52,53,54,4F,4E,45,20,20,20,20, E8E1, 003A ; "RSTONE    " - enemy $DFBF
$B4:E0C3             dx 53,41,42,4F,54,45,4E,20,20,20, E8F4, 003B ; "SABOTEN   " - enemy $CFFF
$B4:E0D1             dx 53,42,55,47,20,20,20,20,20,20, E907, 003C ; "SBUG      " - enemy $D87F/$D8BF
$B4:E0DF             dx 53,43,4C,41,59,44,20,20,20,20, E91A, 003D ; "SCLAYD    " - enemy $E0FF
$B4:E0ED             dx 53,44,45,41,54,48,20,20,20,20, E92D, 003E ; "SDEATH    " - enemy $D97F
$B4:E0FB             dx 53,48,55,54,54,45,52,20,20,20, E940, 003F ; "SHUTTER   " - enemy $D4FF, debug spritemap name is "SHUTTER1"
$B4:E109             dx 53,48,55,54,54,45,52,32,20,20, E953, 0040 ; "SHUTTER2  " - enemy $D53F/$D57F/$D5BF/$D5FF
$B4:E117             dx 53,49,44,45,20,20,20,20,20,20, E966, 0041 ; "SIDE      " - enemy $D9BF/$D9FF
$B4:E125             dx 53,4B,52,45,45,20,20,20,20,20, E979, 0042 ; "SKREE     " - enemy $DB7F
$B4:E133             dx 53,50,41,20,20,20,20,20,20,20, E98C, 0043 ; "SPA       " - enemy $EA3F
$B4:E141             dx 53,51,55,45,45,57,50,54,20,20, E99F, 0044 ; "SQUEEWPT  " - enemy $D2BF
$B4:E14F             dx 53,53,49,44,45,20,20,20,20,20, E9C2, 0045 ; "SSIDE     " - enemy $D93F
$B4:E15D             dx 53,54,4F,4B,45,20,20,20,20,20, E9D5, 0046 ; "STOKE     " - enemy $CEFF
$B4:E16B             dx 54,4F,47,45,20,20,20,20,20,20, E9E8, 0047 ; "TOGE      " - enemy $D03F
$B4:E179             dx 56,49,4F,4C,41,20,20,20,20,20, E9FB, 0048 ; "VIOLA     " - enemy $DABF
$B4:E187             dx 57,41,56,45,52,20,20,20,20,20, EA0E, 0049 ; "WAVER     " - enemy $D63F
$B4:E195             dx 59,41,52,44,20,20,20,20,20,20, EA21, 004A ; "YARD      " - enemy $DBBF
$B4:E1A3             dx 5A,45,42,20,20,20,20,20,20,20, EA34, 004B ; "ZEB       " - enemy $F193
$B4:E1B1             dx 5A,45,42,42,4F,20,20,20,20,20, EA47, 004C ; "ZEBBO     " - enemy $F1D3
$B4:E1BF             dx 5A,45,45,4C,41,20,20,20,20,20, EA5A, 004D ; "ZEELA     " - enemy $DC7F
$B4:E1CD             dx 5A,4F,41,20,20,20,20,20,20,20, EA6D, 004E ; "ZOA       " - enemy $DA7F
$B4:E1DB             dx 5A,4F,4F,4D,45,52,20,20,20,20, EA80, 004F ; "ZOOMER    " - enemy $DCFF
$B4:E1E9             dx 42,41,54,54,41,31,42,72,20,20, EA93, 0050 ; "BATTA1Br  " - enemy $F393, debug spritemap name is "BATTA1br"
$B4:E1F7             dx 42,41,54,54,41,31,4E,6F,20,20, EAA6, 0051 ; "BATTA1No  " - enemy $F3D3, debug spritemap name is "BATTA1no"
$B4:E205             dx 42,41,54,54,41,31,4E,61,20,20, EAB9, 0052 ; "BATTA1Na  " - enemy $F413, debug spritemap name is "BATTA1np"
$B4:E213             dx 42,41,54,54,41,31,4D,61,20,20, EACC, 0053 ; "BATTA1Ma  " - enemy $F453, debug spritemap name is "BATTA1ml"
$B4:E221             dx 42,41,54,54,41,31,54,75,20,20, EADF, 0054 ; "BATTA1Tu  " - enemy $F493, debug spritemap name is "BATTA1ts"
$B4:E22F             dx 42,41,54,54,41,32,42,72,20,20, EAF2, 0055 ; "BATTA2Br  " - enemy $F513, debug spritemap name is "BATTA2br"
$B4:E23D             dx 42,41,54,54,41,32,4E,6F,20,20, EB05, 0056 ; "BATTA2No  " - enemy $F553, debug spritemap name is "BATTA2no"
$B4:E24B             dx 42,41,54,54,41,32,4E,61,20,20, EB18, 0057 ; "BATTA2Na  " - enemy $F593, debug spritemap name is "BATTA2np"
$B4:E259             dx 42,41,54,54,41,32,4D,61,20,20, EB2B, 0058 ; "BATTA2Ma  " - enemy $F5D3, debug spritemap name is "BATTA2ml"
$B4:E267             dx 42,41,54,54,41,32,54,75,20,20, EB3E, 0059 ; "BATTA2Tu  " - enemy $F613, debug spritemap name is "BATTA2ts"
$B4:E275             dx 42,41,54,54,41,33,42,72,20,20, EB51, 005A ; "BATTA3Br  " - enemy $F693, debug spritemap name is "BATTA3br"
$B4:E283             dx 42,41,54,54,41,33,4E,6F,20,20, EB64, 005B ; "BATTA3No  " - enemy $F6D3, debug spritemap name is "BATTA3no"
$B4:E291             dx 42,41,54,54,41,33,4E,61,20,20, EB77, 005C ; "BATTA3Na  " - enemy $F713, debug spritemap name is "BATTA3np"
$B4:E29F             dx 42,41,54,54,41,33,4D,61,20,20, EB8A, 005D ; "BATTA3Ma  " - enemy $F753, debug spritemap name is "BATTA3ml"
$B4:E2AD             dx 42,41,54,54,41,33,54,75,20,20, EB9D, 005E ; "BATTA3Tu  " - enemy $F793, debug spritemap name is "BATTA3ts"
$B4:E2BB             dx 46,55,4E,45,20,20,20,20,20,20, EBB0, 005F ; "FUNE      " - enemy $E6FF
$B4:E2C9             dx 48,41,43,48,49,32,20,20,20,20, EBC3, 0060 ; "HACHI2    " - enemy $EB3F
$B4:E2D7             dx 48,41,43,48,49,33,20,20,20,20, EBE6, 0061 ; "HACHI3    " - enemy $EBBF
$B4:E2E5             dx 52,4F,42,4F,32,20,20,20,20,20, EC09, 0062 ; "ROBO2     " - enemy $E93F
}


;;; $E2F3: Debug enemy population data ;;;
{
;  ____________________________________ Enemy ID
; |     _______________________________ X position
; |    |     __________________________ Y position
; |    |    |     _____________________ Initialisation parameter
; |    |    |    |     ________________ Properties
; |    |    |    |    |     ___________ Extra properties
; |    |    |    |    |    |     ______ Parameter 1
; |    |    |    |    |    |    |     _ Parameter 2
; |    |    |    |    |    |    |    |
; iiii xxxx yyyy oooo pppp gggg aaaa bbbb

;  ______ Terminator
; |     _ Number of enemy deaths needed to clear current room
; |    |
; FFFF nn

; Enemies with enemy name = 0
$B4:E2F3             dx FFFF, 00

; Enemy $E9FF (atomic)
$B4:E2F6             dx E9FF, 0100, 0100, 0000, 2000, 0000, 0001, 0001,
                        FFFF, 01

; Enemy $DB3F (bang)
$B4:E309             dx DB3F, 0100, 0100, 0000, 2800, 0000, BB2B, 0000,
                        DB3F, 0100, 0100, 0000, 2800, 0000, BB66, 0101,
                        DB3F, 0100, 0100, 0000, 2800, 0000, BB4A, 0000,
                        FFFF, 01

; Enemy $F353 (grey wall space pirate)
$B4:E33C             dx F353, 002D, 01B8, 0000, 2000, 0004, 0000, 00A0,
                        FFFF, 01

; Enemy $F4D3 (grey ninja space pirate)
$B4:E34F             dx F4D3, 0270, 00A0, 0000, 2800, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F653 (grey walking space pirate)
$B4:E362             dx F653, 00D9, 00A0, 0000, 2000, 0004, 0000, 0050,
                        FFFF, 01

; Enemy $F293 (Botwoon)
$B4:E375             dx F293, 0100, 0100, 0000, 2800, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $CEBF (boyon)
$B4:E388             dx CEBF, 00E8, 00A8, 0000, 2000, 0000, 0103, 0020,
                        FFFF, 00

; Enemy $DA3F (super-desgeega)
$B4:E39B             dx DA3F, 0100, 0100, 0000, 2000, 0000, 8000, 0000,
                        FFFF, 01

; Enemy $F07F (Shaktool)
$B4:E3AE             dx F07F, 0110, 035C, 0000, 2000, 0000, 8000, 0000,
                        F07F, 0110, 035C, 0000, 2000, 0000, 8000, 0002,
                        F07F, 0110, 035C, 0000, 2000, 0000, 8000, 0004,
                        F07F, 0110, 035C, 0000, 2000, 0000, 8000, 0006,
                        F07F, 0110, 035C, 0000, 2000, 0000, 8000, 0008,
                        F07F, 0110, 035C, 0000, 2000, 0000, 8000, 000A,
                        F07F, 0110, 035C, 0000, 2000, 0000, 8000, 000C,
                        FFFF, 01

; Enemy $D4BF (dragon)
$B4:E421             dx D4BF, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        D4BF, 0100, 0100, 0002, 2400, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $E63F (evir)
$B4:E444             dx E63F, 0100, 0100, 0000, 2000, 0000, 0000, 1010,
                        E63F, 0100, 0100, 0000, 2400, 0000, 0001, 0000,
                        E67F, 0100, 0100, 0000, 2800, 0000, 0002, 0000,
                        FFFF, 01

; Enemy $E6BF (morph ball eye)
$B4:E477             dx E6BF, 0228, 0048, 0000, 2C00, 0000, 0000, 8001,
                        E6BF, 0228, 0048, 0000, 2C00, 0000, 0000, 0000,
                        FFFF, 00

; Enemy $E73F (namihe)
$B4:E49A             dx E73F, 00F0, 04E0, 0000, A000, 0000, 0111, 0F05,
                        FFFF, 01

; Enemy $D6FF (skultera)
$B4:E4AD             dx D6FF, 0090, 00A0, 0000, 2000, 0000, 0102, 0420,
                        FFFF, 01

; Enemy $E77F (coven)
$B4:E4C0             dx E77F, 0100, 0100, 0000, 6800, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $F213 (gamet)
$B4:E4D3             dx F213, 0100, 00E0, 0000, 6800, 0000, 0000, 4030,
                        F213, 0100, 00E0, 0000, 6800, 0000, 0000, 4000,
                        F213, 0100, 00E0, 0000, 6800, 0000, 0000, 4000,
                        F213, 0100, 00E0, 0000, 6800, 0000, 0000, 4000,
                        F213, 0100, 00E0, 0000, 6800, 0000, 0000, 4000,
                        FFFF, 01

; Enemy $F253 (geega)
$B4:E526             dx F253, 0100, 0100, 0000, 6100, 0000, 0001, 0010,
                        FFFF, 01

; Enemy $D2FF (geruta)
$B4:E539             dx D2FF, 0048, 0080, 0000, 2000, 0000, 0000, 0000,
                        D2FF, 0048, 0080, 0005, 2400, 0000, 8000, 0000,
                        FFFF, 01

; Used for enemy name "GRAVY"
$B4:E55C             dx FFFF, 00

; Enemy $EABF (green ki-hunter)
$B4:E55F             dx EABF, 0100, 0100, 0000, 2800, 0000, 0001, 0000,
                        EAFF, 0100, 0100, 0000, 2C00, 0000, 0020, 0000,
                        FFFF, 01

; Enemy $E7BF (yapping maw)
$B4:E582             dx E7BF, 0100, 0100, 0000, 2000, 0000, 0010, 0001,
                        FFFF, 00

; Enemy $E07F (fire pillar)
$B4:E595             dx E07F, 0100, 0100, 0000, 2500, 0000, 0025, 0000,
                        E07F, 0100, 0100, 0000, 2100, 0000, 0000, 0001,
                        FFFF, 00

; Enemy $D3BF (choot)
$B4:E5B8             dx D3BF, 0100, 0100, 0000, 2000, 0000, 0204, 0030,
                        FFFF, 01

; Enemy $D33F (holtz)
$B4:E5CB             dx D33F, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        D33F, 0100, 0100, 0006, 2400, 0000, 8000, 0000,
                        FFFF, 01

; Enemy $D6BF (fireflea)
$B4:E5EE             dx D6BF, 0600, 0060, 0000, 2000, 0000, 0001, 0108,
                        FFFF, 01

; Enemy $DC3F (Wrecked Ship orange zoomer)
$B4:E601             dx DC3F, 0360, 0098, 0003, 2001, 0000, 0002, 0000,
                        FFFF, 01

; Enemy $E7FF (kago)
$B4:E614             dx E7FF, 0168, 0090, 0000, A000, 0000, 0020, 0000,
                        FFFF, 01

; Enemy $CF3F (tatori)
$B4:E627             dx CF3F, 0100, 0100, 0000, A800, 0000, 0000, 0000,
                        CF7F, 00D8, 0100, 0000, A800, 0000, FFFF, 0000,
                        CF7F, 0100, 0100, 0000, A800, 0000, FFFF, 0000,
                        CF7F, 0110, 0100, 0000, A800, 0000, 0001, 0000,
                        CF7F, 0140, 0100, 0000, A800, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $D7FF/$D83F (tripper / suspensor platform))
$B4:E67A             dx D7FF, 0868, 00C8, 0000, A000, 0000, 0000, 2020,
                        FFFF, 01

; Enemy $D77F (sciser)
$B4:E68D             dx D77F, 01C0, 0098, 0003, 2000, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $EA7F (blue Brinstar face block)
$B4:E6A0             dx EA7F, 0100, 0100, 0000, A000, 0000, 0025, 0000,
                        FFFF, 00

; Enemy $DFFF (spike platform)
$B4:E6B3             dx DFFF, 0480, 0400, 0000, A000, 0000, 0030, A070,
                        E03F, 0480, 0408, 0000, 0100, 0000, 0000, 0000,
                        FFFF, 00

; Enemy $E83F (magdollite)
$B4:E6D6             dx E83F, 0248, 00B0, 0000, 2800, 0000, 0000, 3A60,
                        E83F, 0248, 00B0, 0000, 2C00, 0000, 0001, 0000,
                        E83F, 0248, 00B0, 0000, 2C00, 0000, 0002, 0000,
                        FFFF, 01

; Enemy $D13F (mella)
$B4:E709             dx D13F, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 00

; Enemy $D17F (memu)
$B4:E71C             dx D17F, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 00

; Enemy $D0FF (mellow)
$B4:E72F             dx D0FF, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 00

; Enemy $D67F (metaree)
$B4:E742             dx D67F, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $D8FF (mochtroid)
$B4:E755             dx D8FF, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $DD7F (metroid)
$B4:E768             dx DD7F, 0100, 0100, 0000, 2000, 0000, 0000, 0005,
                        FFFF, 01

; Enemy $D1BF (multiviola)
$B4:E77B             dx D1BF, 0078, 0058, 0000, 2000, 0000, 0060, 0001,
                        FFFF, 00

; Enemy $DD3F (stone zoomer)
$B4:E78E             dx DD3F, 0188, 0198, 0003, 2800, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $E9BF (alcoon)
$B4:E7A1             dx E9BF, 0100, 0100, 0000, 2800, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $E87F (beetom)
$B4:E7B4             dx E87F, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $DCBF (sova)
$B4:E7C7             dx DCBF, 0880, 02A8, 0003, 2000, 0000, 0001, 0004,
                        FFFF, 01

; Enemy $D37F (oum)
$B4:E7DA             dx D37F, 0100, 0100, 0000, A000, 0004, 0000, 0000,
                        FFFF, 01

; Enemy $D7BF (zero)
$B4:E7ED             dx D7BF, 00A0, 0040, 0002, 2000, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $E97F (bull)
$B4:E800             dx E97F, 0200, 0060, 0000, 2800, 0000, 0008, 0000,
                        FFFF, 01

; Enemy $D1FF (polyp)
$B4:E813             dx D1FF, 0100, 0100, 0000, 2500, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $E0BF (fire arc)
$B4:E826             dx E0BF, 0100, 0100, 0000, 2000, 0000, 1010, 2001,
                        FFFF, 00

; Enemy $E8BF (powamp)
$B4:E839             dx E8BF, 0100, 0100, 0000, 2C00, 0000, 0001, 0000,
                        E8BF, 0100, 0100, 0000, 2800, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $CFBF (puyo)
$B4:E85C             dx CFBF, 033D, 00CC, 0000, 2000, 0000, 0003, 000A,
                        FFFF, 01

; Enemy $DBFF (reflec)
$B4:E86F             dx DBFF, 0168, 0048, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 00

; Enemy $D23F (rinka)
$B4:E882             dx D23F, 0100, 0100, 0000, 6000, 0000, 0000, 0000,
                        FFFF, 00

; Enemy $D27F (rio)
$B4:E895             dx D27F, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $D47F (ripper)
$B4:E8A8             dx D47F, 0068, 01A0, 0000, 2000, 0000, 0010, 0001,
                        FFFF, 01

; Enemy $D3FF/$D43F (gripper / ripper ii)
$B4:E8BB             dx D43F, 0040, 06A0, 0000, 2800, 0000, 0020, 0001,
                        FFFF, 01

; Enemy $E8FF (work robot)
$B4:E8CE             dx E8FF, 0050, 00B0, 0000, 2800, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $DFBF (boulder)
$B4:E8E1             dx DFBF, 0400, 01B5, 0060, 2000, 0000, 0101, 20A0,
                        FFFF, 00

; Enemy $CFFF (cacatac)
$B4:E8F4             dx CFFF, 03D0, 00B3, 0000, 2000, 0000, 0100, 0F01,
                        FFFF, 01

; Enemy $D87F/$D8BF (roach)
$B4:E907             dx D87F, 01AD, 04E8, 0000, 2400, 0000, E804, 0020,
                        FFFF, 00

; Enemy $E0FF (fake Kraid)
$B4:E91A             dx E0FF, 0100, 0100, 0000, 2800, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $D97F (desgeega)
$B4:E92D             dx D97F, 0100, 0100, 0000, 2000, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $D4FF (timed shutter)
$B4:E940             dx D4FF, 0300, 0088, 0000, A800, 0000, 004C, 0008,
                        FFFF, 00

; Enemy $D53F/$D57F/$D5BF/$D5FF (shutter / rising and falling platform)
$B4:E953             dx D53F, 0100, 0100, 0020, A800, 0A0A, 2003, 0000,
                        FFFF, 00

; Enemy $D9BF/$D9FF (super-sidehopper)
$B4:E966             dx D9BF, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $DB7F (skree)
$B4:E979             dx DB7F, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $EA3F (Wrecked Ship spark)
$B4:E98C             dx EA3F, 0100, 0100, 0000, 2000, 0000, 0000, 0000,
                        FFFF, 00

; Enemy $D2BF (squeept)
$B4:E99F             dx D2BF, 0060, 00D8, 0000, 2000, 0000, 0000, 0000,
                        D2BF, 0060, 00D8, 0002, 2400, 0000, 8000, 0000,
                        FFFF, 01

; Enemy $D93F (sidehopper)
$B4:E9C2             dx D93F, 0100, 0100, 0000, 2000, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $CEFF (mini-Crocomire)
$B4:E9D5             dx CEFF, 0C30, 01F8, 0000, 2000, 0000, 0000, 0001,
                        FFFF, 01

; Enemy $D03F (owtch)
$B4:E9E8             dx D03F, 0060, 01C8, 0000, 2000, 0000, 0301, 0002,
                        FFFF, 01

; Enemy $DABF (viola)
$B4:E9FB             dx DABF, 00D8, 008A, 0003, 2001, 0000, 0002, 0006,
                        FFFF, 01

; Enemy $D63F (waver)
$B4:EA0E             dx D63F, 00C9, 005C, 0000, 2000, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $DBBF (yard)
$B4:EA21             dx DBBF, 01D0, 0098, 0003, A004, 0000, 0001, 0000,
                        FFFF, 01

; Enemy $F193 (zeb)
$B4:EA34             dx F193, 0100, 0100, 0000, 6900, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $F1D3 (zebbo)
$B4:EA47             dx F1D3, 0100, 0100, 0000, 6900, 0000, 0002, 0000,
                        FFFF, 01

; Enemy $DC7F (zeela)
$B4:EA5A             dx DC7F, 0180, 008C, 0003, 2000, 0000, 0002, 0002,
                        FFFF, 01

; Enemy $DA7F (zoa)
$B4:EA6D             dx DA7F, 0100, 0100, 0000, 6100, 0000, 0000, 0000,
                        FFFF, 01

; Enemy $DCFF (zoomer)
$B4:EA80             dx DCFF, 00D8, 00C8, 0003, 2000, 0000, 0002, 0000,
                        FFFF, 01

; Enemy $F393 (green wall space pirate)
$B4:EA93             dx F393, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F3D3 (red wall space pirate)
$B4:EAA6             dx F3D3, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F413 (gold wall space pirate)
$B4:EAB9             dx F413, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F453 (magenta wall space pirate)
$B4:EACC             dx F453, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F493 (silver wall space pirate)
$B4:EADF             dx F493, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F513 (green ninja space pirate)
$B4:EAF2             dx F513, 0100, 0100, 0000, 2800, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F553 (red ninja space pirate)
$B4:EB05             dx F553, 0100, 0100, 0000, 2800, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F593 (gold ninja space pirate)
$B4:EB18             dx F593, 0100, 0100, 0000, 2800, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F5D3 (magenta ninja space pirate)
$B4:EB2B             dx F5D3, 0100, 0100, 0000, 2800, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F613 (silver ninja space pirate)
$B4:EB3E             dx F613, 0100, 0100, 0000, 2800, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F693 (green walking space pirate)
$B4:EB51             dx F693, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F6D3 (red walking space pirate)
$B4:EB64             dx F6D3, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F713 (gold walking space pirate)
$B4:EB77             dx F713, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F753 (magenta walking space pirate)
$B4:EB8A             dx F753, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $F793 (silver walking space pirate)
$B4:EB9D             dx F793, 0100, 0100, 0000, 2000, 0004, 0001, 0030,
                        FFFF, 01

; Enemy $E6FF (fune)
$B4:EBB0             dx E6FF, 00F0, 04E0, 0000, A000, 0000, 0110, 0F05,
                        FFFF, 01

; Enemy $EB3F (yellow ki-hunter)
$B4:EBC3             dx EB3F, 0100, 0100, 0000, 2800, 0000, 0001, 0000,
                        EB7F, 0100, 0100, 0000, 2C00, 0000, 0020, 0000,
                        FFFF, 01

; Enemy $EBBF (red ki-hunter)
$B4:EBE6             dx EBBF, 0100, 0100, 0000, 2800, 0000, 0001, 0000,
                        EBFF, 0100, 0100, 0000, 2C00, 0000, 0020, 0000,
                        FFFF, 01

; Enemy $E93F (work robot deactivated)
$B4:EC09             dx E93F, 0050, 00B0, 0000, A800, 0000, 0001, 0000,
                        FFFF, 01
}


;;; $EC1C: Enemy vulnerabilities ;;;
{
; Vulnerability format:
;     v = f000dddd
;     If v = FFh:
;         Freeze, no damage
;     Else:
;         d: Damage multiplier * 2
;         f: Does not freeze

;                        _________________________________________________________________ 0: Power
;                       |   ______________________________________________________________ 1: Wave
;                       |  |   ___________________________________________________________ 2: Ice
;                       |  |  |   ________________________________________________________ 3: Ice + wave
;                       |  |  |  |   _____________________________________________________ 4: Spazer
;                       |  |  |  |  |   __________________________________________________ 5: Spazer + wave
;                       |  |  |  |  |  |   _______________________________________________ 6: Spazer + ice
;                       |  |  |  |  |  |  |   ____________________________________________ 7: Spazer + ice + wave
;                       |  |  |  |  |  |  |  |   _________________________________________ 8: Plasma
;                       |  |  |  |  |  |  |  |  |   ______________________________________ 9: Plasma + wave / shinespark echo
;                       |  |  |  |  |  |  |  |  |  |   ___________________________________ Ah: Plasma + ice
;                       |  |  |  |  |  |  |  |  |  |  |   ________________________________ Bh: Plasma + ice + wave
;                       |  |  |  |  |  |  |  |  |  |  |  |
;                       |  |  |  |  |  |  |  |  |  |  |  |    ____________________________ Ch: Missile
;                       |  |  |  |  |  |  |  |  |  |  |  |   |   _________________________ Dh: Super missile
;                       |  |  |  |  |  |  |  |  |  |  |  |   |  |   ______________________ Eh: Bomb
;                       |  |  |  |  |  |  |  |  |  |  |  |   |  |  |   ___________________ Fh: Power bomb
;                       |  |  |  |  |  |  |  |  |  |  |  |   |  |  |  |   ________________ 10h: Speed booster
;                       |  |  |  |  |  |  |  |  |  |  |  |   |  |  |  |  |   _____________ 11h: Shinespark
;                       |  |  |  |  |  |  |  |  |  |  |  |   |  |  |  |  |  |   __________ 12h: Screw attack
;                       |  |  |  |  |  |  |  |  |  |  |  |   |  |  |  |  |  |  |   _______ 13h: Charged beam (including SBA)
;                       |  |  |  |  |  |  |  |  |  |  |  |   |  |  |  |  |  |  |  |   ____ 14h: Pseudo screw attack
;                       |  |  |  |  |  |  |  |  |  |  |  |   |  |  |  |  |  |  |  |  |   _ 15h: Unused
;                       |  |  |  |  |  |  |  |  |  |  |  |   |  |  |  |  |  |  |  |  |  |
$B4:EC1C             db 02,02,02,02,02,02,02,02,02,02,02,02, 02,02,02,02,02,02,02,02,02,02 ; Default. Enemy $CEFF/$CFBF/$CFFF/$D07F/$D0BF/$D0FF/$D17F/$D23F/$D27F/$D3BF/$D63F/$D6BF/$D6FF/$D8FF/$D93F/$D97F/$D9BF/$DA7F/$DB7F/$E77F/$E9FF/$ECBF/$ECFF/$EFFF/$F03F/$F0BF/$F193/$F1D3/$F213/$F253
$B4:EC32             db 00,00,00,00,01,01,01,01,02,02,02,02, 02,02,02,02,02,02,02,02,02,02 ; Enemy $DA3F (super-desgeega)
$B4:EC48             db 02,02,02,02,02,02,02,02,02,02,02,02, 02,02,04,04,02,02,02,02,02,02 ; Enemy $DABF/$DBBF/$DC3F/$DC7F/$DCBF/$DCFF ((orange / fire) zoomer / viola / yard / zeela)
$B4:EC5E             db 82,82,82,82,82,82,82,82,82,82,82,82, 02,02,00,02,02,02,02,02,80,00 ; Enemy $F4D3/$F513/$F553/$F5D3 (non-gold/silver ninja space pirate)
$B4:EC74             db 80,80,80,80,81,81,81,81,82,82,82,82, 02,04,00,00,00,00,00,02,80,00 ; Enemy $F593 (gold ninja space pirate)
$B4:EC8A             db 02,02,02,02,02,02,02,02,02,02,02,02, 04,04,00,02,02,02,02,02,02,02 ; Enemy $F493/$F793 (silver walking/wall space pirate)
$B4:ECA0             db 84,84,84,84,84,84,84,84,84,84,84,84, 84,84,84,84,84,84,84,04,84,84 ; Enemy $F613 (silver ninja space pirate)
$B4:ECB6             db 00,02,04,04,02,02,04,04,02,02,04,04, 04,04,02,02,02,02,02,02,02,02 ; Enemy $F3D3 (red wall space pirate)
$B4:ECCC             db 02,02,02,02,02,02,02,02,02,02,02,02, 04,04,00,02,02,02,02,02,02,02 ; Enemy $F353/$F393 (grey/green wall space pirate)
$B4:ECE2             db 02,02,02,02,02,02,02,02,02,02,02,02, 04,04,00,02,02,02,02,02,02,02 ; Enemy $F453 (magenta wall space pirate)
$B4:ECF8             db 02,02,02,02,02,02,02,02,02,02,02,02, 04,04,00,02,02,02,02,02,02,02 ; Enemy $F653 (grey walking space pirate)
$B4:ED0E             db 00,02,02,02,02,02,02,02,02,02,02,02, 04,04,04,02,02,02,02,02,02,02 ; Enemy $F693 (green walking space pirate)
$B4:ED24             db 00,02,04,04,02,02,04,04,02,02,04,04, 04,04,00,02,02,02,02,02,02,02 ; Enemy $F6D3 (red walking space pirate)
$B4:ED3A             db 00,00,00,00,00,00,00,00,02,02,02,02, 00,00,00,00,02,02,02,00,02,02 ; Enemy $F753 (magenta walking space pirate)
$B4:ED50             db 00,00,00,00,00,00,00,00,00,00,00,00, 02,02,02,02,02,02,02,02,02,02 ; Enemy $F413/$F713 (gold walking/wall space pirate)
$B4:ED66             db 01,01,01,01,01,01,01,01,01,01,01,01, 04,04,00,02,02,02,02,02,02,02 ; Enemy $EABF/$EAFF (green ki-hunter)
$B4:ED7C             db 02,02,02,02,02,02,02,02,02,02,02,02, 02,02,00,02,02,02,02,02,02,02 ; Enemy $EB3F/$EB7F (yellow ki-hunter)
$B4:ED92             db 00,00,81,81,81,82,82,82,82,82,82,82, 00,02,00,00,02,02,04,82,00,02 ; Enemy $EBBF/$EBFF (red ki-hunter)
$B4:EDA8             db 00,00,FF,FF,00,00,FF,FF,00,00,FF,FF, 00,02,02,02,00,00,00,00,02,02 ; Enemy $CEBF (boyon)
$B4:EDBE             db 00,00,FF,FF,00,00,FF,FF,00,00,FF,FF, 00,02,02,02,00,00,02,00,02,02 ; Enemy $D67F (metaree)
$B4:EDD4             db 00,00,00,00,00,00,00,00,02,02,02,02, 00,00,02,02,00,00,02,00,00,00 ; Enemy $DD3F (stone zoomer)
$B4:EDEA             db 00,00,FF,FF,00,00,FF,FF,00,00,FF,FF, 00,02,00,02,00,00,02,00,00,02 ; Enemy $D2BF/$D43F/$D47F/$D7FF (lava jumping enemy / ripper ii / ripper / tripper)
$B4:EE00             db 02,02,04,04,02,02,04,04,02,02,04,04, 02,02,02,02,02,02,02,02,02,02 ; Enemy $D13F (mella)
$B4:EE16             db 00,00,FF,FF,00,00,FF,FF,02,02,02,02, 02,02,02,02,02,02,02,02,02,02 ; Enemy $D4BF (dragon)
$B4:EE2C             db 02,02,02,02,02,02,02,02,02,02,02,02, 04,04,02,02,02,02,02,02,02,02 ; Enemy $E9BF (alcoon)
$B4:EE42             db 02,02,04,04,02,02,04,04,02,02,04,04, 02,02,00,02,02,02,02,02,02,02 ; Enemy $D2FF (geruta)
$B4:EE58             db 02,02,04,04,02,02,04,04,02,02,04,04, 00,02,00,02,02,02,02,02,02,02 ; Enemy $D33F (holtz)
$B4:EE6E             db 02,02,04,04,02,02,04,04,02,02,04,04, 02,02,02,02,02,02,02,02,02,02 ; Enemy $D1BF (multiviola)
$B4:EE84             db 00,00,00,00,00,00,00,00,02,02,02,02, 00,02,00,02,02,02,02,02,02,02 ; Enemy $D03F (spikey shells)
$B4:EE9A             db 00,00,FF,FF,00,00,FF,FF,00,00,FF,FF, 00,02,00,00,02,02,00,00,00,02 ; Enemy $E7BF (yapping maw)
$B4:EEB0             db 00,00,FF,FF,00,00,FF,FF,00,00,FF,FF, 00,02,00,02,02,02,00,00,00,02 ; Enemy $E6FF/$E83F (fune / lava creature)
$B4:EEC6             db 00,00,00,00,00,00,00,00,00,00,00,00, 00,00,00,00,00,00,00,00,00,00 ; Indestructible. Enemy $CF3F/$CF7F/$D1FF/$D37F/$D83F/$D87F/$D8BF/$DBFF/$DFFF/$E03F/$E07F/$E0BF/$E1BF/$E1FF/$E6BF/$E8FF/$E93F/$EA3F/$EA7F/$F0FF
$B4:EEDC             db 00,00,00,00,00,00,00,00,00,00,00,00, 00,02,00,00,00,00,00,00,02,02 ; Enemy $DFBF (boulder)
$B4:EEF2             db 00,00,00,00,00,00,00,00,00,00,FF,FF, 00,00,00,00,00,00,02,00,02,02 ; Enemy $E73F (fune with eyes)
$B4:EF08             db 00,00,00,00,00,00,00,00,00,00,00,00, 00,00,00,82,00,00,00,00,00,00 ; Enemy $D4FF/$D53F/$D57F/$D5FF (non-destroyable shutters)
$B4:EF1E             db 82,82,82,82,82,82,82,82,82,82,82,82, 82,82,82,00,00,00,00,00,00,00 ; Enemy $F07F (shaktool)
$B4:EF34             db 82,82,82,82,82,82,82,82,82,82,82,82, 82,82,82,82,82,82,82,02,82,82 ; Enemy $E8BF (floater)
$B4:EF4A             db 00,00,00,00,00,00,80,00,00,00,00,00, 02,02,00,02,00,02,02,00,00,02 ; Enemy $D3FF (gripper)
$B4:EF60             db 00,00,FF,FF,00,00,FF,FF,00,00,FF,FF, 02,04,00,01,02,02,02,00,02,02 ; Enemy $DD7F (metroid)
$B4:EF76             db 02,02,02,02,02,02,02,02,02,02,02,02, 02,02,04,04,02,02,02,02,02,02 ; Enemy $D77F/$D7BF (sciser / zero)
$B4:EF8C             db 00,00,FF,FF,00,00,FF,FF,00,00,FF,FF, 02,02,04,04,02,02,02,00,00,02 ; Enemy $E87F (beetom)
$B4:EFA2             db 80,80,80,80,80,80,80,80,02,02,82,82, 02,02,02,02,02,02,02,02,02,02 ; Enemy $E97F (bull)
$B4:EFB8             db 02,02,02,02,02,02,02,02,02,02,82,82, 00,00,00,00,00,00,00,02,00,00 ; Enemy $D5BF (destroyable timed shutter)
$B4:EFCE             db 02,02,FF,FF,02,02,FF,FF,02,02,82,82, 02,02,02,02,02,02,02,02,02,02 ; Enemy $E63F (evir)
$B4:EFE4             db 00,00,00,00,00,00,00,00,00,00,00,00, 00,00,00,00,00,00,00,00,00,00 ; Enemy $E67F (evir projectile)
$B4:EFFA             db 82,82,82,82,82,82,82,82,82,82,82,82, 84,84,82,82,82,82,82,02,80,80 ; Enemy $E0FF (fake Kraid)
$B4:F010             db 02,02,02,02,02,02,02,02,02,02,02,02, 00,00,00,00,00,00,00,02,00,00 ; Enemy $DB3F (bang)
$B4:F026             db 00,00,00,00,00,00,00,00,00,00,00,00, 00,00,00,02,00,00,00,00,00,00 ; Enemy $E7FF (kago)
$B4:F03C             db 00,00,00,00,00,00,00,00,00,00,00,00, 00,00,00,02,00,00,00,02,00,00
$B4:F052             db 00,00,00,00,00,00,00,00,00,00,00,00, 00,00,00,04,00,00,00,02,00,00
$B4:F068             db 80,80,80,80,80,80,80,80,80,80,80,80, 82,82,80,80,80,80,80,00,80,80 ; Enemy $E27F (zebetites)
$B4:F07E             db 00,00,00,00,00,00,00,00,00,00,00,00, 00,02,00,00,00,00,00,00,00,00 ; Enemy $D9FF (super-sidehopper)
$B4:F094             db 80,82,82,82,80,82,82,82,82,82,82,82, 82,82,80,80,80,80,80,04,80,80 ; Enemy $DF3F/$DF7F (Spore Spawn)
$B4:F0AA             db 82,82,82,82,82,82,82,82,82,82,82,82, 82,82,82,82,82,82,82,02,82,82
$B4:F0C0             db 02,02,82,82,02,02,82,82,02,02,82,82, 02,04,00,00,00,00,00,02,00,00 ; Enemy $EEFF/$EF3F (Bomb Torizo)
$B4:F0D6             db 80,80,80,80,80,80,80,80,80,80,80,80, 82,84,80,00,00,00,00,02,02,00 ; Enemy $EF7F/$EFBF (Gold Torizo)
$B4:F0EC             db 80,80,80,80,80,80,80,80,80,80,80,80, 82,84,00,00,00,00,00,02,80,80 ; Enemy $E4BF/$E4FF/$E53F/$E57F (Phantoon)
$B4:F102             db 80,80,80,80,80,80,80,80,80,80,80,80, 80,80,80,82,80,80,80,00,80,80 ; Enemy $DDBF/$DDFF (Crocomire)
$B4:F118             db 80,80,80,80,80,80,80,80,80,80,80,80, 82,82,80,80,80,80,80,02,80,80 ; Enemy $F293 (Botwoon)
$B4:F12E             db 00,00,00,00,00,00,00,00,00,00,00,00, 00,00,00,00,00,00,00,00,00,00 ; Enemy $ED3F/$ED7F/$EDBF/$EDFF/$EE3F/$EE7F/$EEBF (dead enemies / Shitroid)
$B4:F144             db 80,80,80,80,80,80,80,80,80,80,80,80, 82,82,80,80,80,81,80,82,82,80 ; Enemy $DE3F/$DE7F/$DEBF/$DEFF (Draygon)
$B4:F15A             db 82,82,82,82,82,82,82,82,82,82,82,82, 82,82,80,80,80,80,80,02,80,80 ; Enemy $E2BF (Kraid)
$B4:F170             db 80,80,80,80,80,80,80,80,80,80,80,80, 80,80,80,80,80,80,80,00,80,80 ; Enemy $E2FF/$E3FF (Kraid arm / foot)
$B4:F186             db 80,80,80,80,80,80,80,80,80,80,80,80, 80,80,80,80,80,80,80,00,80,80 ; Enemy $E33F/$E37F/$E3BF (Kraid lints)
$B4:F19C             db 82,82,82,82,82,82,82,82,82,82,82,82, 82,82,82,82,82,00,82,02,82,82 ; Enemy $E43F/$E47F (Kraid fingernails)
$B4:F1B2             db 80,80,80,80,80,80,80,80,80,80,80,80, 82,84,80,82,80,80,80,82,80,80 ; Enemy $E13F/$E17F (Ridley)
$B4:F1C8             db 80,80,80,80,80,80,80,80,80,80,80,80, 82,82,80,80,80,80,80,02,80,80 ; Enemy $EC3F (Mother Brain brain)
$B4:F1DE             db 80,80,80,80,80,80,80,80,80,80,80,80, 80,80,80,80,80,80,80,00,80,80 ; Enemy $EC7F (Mother Brain body)
}


;;; $F1F4: Enemy drop chances ;;;
{
;                        ________________ ; 0: Small health
;                       |   _____________ ; 1: Big health
;                       |  |   __________ ; 2: Missiles
;                       |  |  |   _______ ; 3: Nothing
;                       |  |  |  |   ____ ; 4: Super missiles
;                       |  |  |  |  |   _ ; 5: Power bombs
;                       |  |  |  |  |  |
$B4:F1F4             db 3C,3C,3C,05,3C,0A ;  23.5%  23.5%  23.5%   2.0%  23.5%   3.9% - enemy $D2FF (geruta)
$B4:F1FA             db 1E,50,55,28,0A,0A ;  11.8%  31.4%  33.3%  15.7%   3.9%   3.9% - enemy $D27F (rio)
$B4:F200             db 3C,3C,3C,05,3C,0A ;  23.5%  23.5%  23.5%   2.0%  23.5%   3.9% - enemy $D63F (waver)
$B4:F206             db 14,03,55,89,05,05 ;   7.8%   1.2%  33.3%  53.7%   2.0%   2.0% - enemy $DB7F (skree)
$B4:F20C             db 3C,3C,3C,05,0A,3C ;  23.5%  23.5%  23.5%   2.0%   3.9%  23.5% - enemy $CFBF (puyo)
$B4:F212             db 00,A5,50,00,05,05 ;         64.7%  31.4%          2.0%   2.0% - enemy $E9FF (atomic)
$B4:F218             db 3C,3C,3C,05,3C,0A ;  23.5%  23.5%  23.5%   2.0%  23.5%   3.9% - enemy $D8FF (mochtroid)
$B4:F21E             db 3C,3C,3C,05,3C,0A ;  23.5%  23.5%  23.5%   2.0%  23.5%   3.9% - enemy $D3BF (choot)
$B4:F224             db 37,19,AA,00,05,00 ;  21.6%   9.8%  66.7%          2.0%        - enemy $DCFF (zoomer)
$B4:F22A             db 37,19,7D,00,32,00 ;  21.6%   9.8%  49.0%         19.6%        - enemy $DC7F (zeela)
$B4:F230             db 50,46,1E,19,32,00 ;  31.4%  27.5%  11.8%   9.8%  19.6%        - enemy $DCBF (sova)
$B4:F236             db 1E,46,50,46,05,00 ;  11.8%  27.5%  31.4%  27.5%   2.0%        - enemy $D0FF (mellow)
$B4:F23C             db 46,1E,50,46,05,00 ;  27.5%  11.8%  31.4%  27.5%   2.0%        - enemy $D13F (mella)
$B4:F242             db 46,14,50,50,05,00 ;  27.5%   7.8%  31.4%  31.4%   2.0%        - enemy $D17F (memu)
$B4:F248             db 3C,3C,3C,05,3C,0A ;  23.5%  23.5%  23.5%   2.0%  23.5%   3.9% - enemy $F193 (zeb)
$B4:F24E             db 3C,3C,3C,05,3C,0A ;  23.5%  23.5%  23.5%   2.0%  23.5%   3.9% - enemy $F253 (geega)
$B4:F254             db 00,8C,0A,00,64,05 ;         54.9%   3.9%         39.2%   2.0% - enemy $F1D3 (zebbo)
$B4:F25A             db 3C,3C,3C,05,3C,0A ;  23.5%  23.5%  23.5%   2.0%  23.5%   3.9% - enemy $F213 (gamet)
$B4:F260             db 00,64,46,05,46,0A ;         39.2%  27.5%   2.0%  27.5%   3.9% - enemy $DA7F (zoa)
$B4:F266             db 32,5F,46,00,14,14 ;  19.6%  37.3%  27.5%          7.8%   7.8% - enemy $E77F (coven)
$B4:F26C             db 32,5A,46,05,14,14 ;  19.6%  35.3%  27.5%   2.0%   7.8%   7.8% - enemy $E7FF (kago)
$B4:F272             db 32,1E,50,4B,0A,0A ;  19.6%  11.8%  31.4%  29.4%   3.9%   3.9% - enemy $EABF/$EAFF (green ki-hunter)
$B4:F278             db 37,50,0A,28,3C,0A ;  21.6%  31.4%   3.9%  15.7%  23.5%   3.9% - enemy $EB3F/$EB7F (yellow ki-hunter)
$B4:F27E             db 23,78,0A,14,3C,0A ;  13.7%  47.1%   3.9%   7.8%  23.5%   3.9% - enemy $EBBF/$EBFF (red ki-hunter)
$B4:F284             db 00,96,05,00,64,00 ;         58.8%   2.0%         39.2%        - enemy $F593 (gold ninja space pirate)
$B4:F28A             db 50,14,32,5F,05,05 ;  31.4%   7.8%  19.6%  37.3%   2.0%   2.0% - enemy $DA3F (super-desgeega)
$B4:F290             db 0A,14,14,C3,05,05 ;   3.9%   7.8%   7.8%  76.5%   2.0%   2.0% - enemy $F3D3 (red wall space pirate)
$B4:F296             db 0A,14,14,C3,05,05 ;   3.9%   7.8%   7.8%  76.5%   2.0%   2.0% - enemy $F553 (red ninja space pirate)
$B4:F29C             db 0A,14,14,C3,05,05 ;   3.9%   7.8%   7.8%  76.5%   2.0%   2.0% - enemy $F6D3 (red walking space pirate)
$B4:F2A2             db 0A,14,14,C3,05,05 ;   3.9%   7.8%   7.8%  76.5%   2.0%   2.0% - enemy $F413 (gold wall space pirate)
$B4:F2A8             db 0A,2D,C5,01,01,01 ;   3.9%  17.6%  77.3%   0.4%   0.4%   0.4% - enemy $F353 (grey wall space pirate)
$B4:F2AE             db 05,1E,78,00,64,00 ;   2.0%  11.8%  47.1%         39.2%        - enemy $F393 (green wall space pirate)
$B4:F2B4             db 01,00,00,00,FE,00 ;   0.4%                       99.6%        - enemy $E8BF (powamp)
$B4:F2BA             db 00,01,00,00,FE,00 ;          0.4%                99.6%        - enemy $CFFF (cacatac)
$B4:F2C0             db 00,01,00,00,FE,00 ;          0.4%                99.6%        - enemy $E0FF (fake Kraid)
$B4:F2C6             db 00,01,00,00,FE,00 ;          0.4%                99.6%        - enemy $D3FF/$D43F (gripper / ripper ii)
$B4:F2CC             db 01,00,00,00,00,FE ;   0.4%                              99.6% - enemy $DABF (viola)
$B4:F2D2             db 00,05,00,00,00,FA ;          2.0%                       98.0% - enemy $E97F (bull)
$B4:F2D8             db 01,64,00,00,00,9A ;   0.4%  39.2%                       60.4% - enemy $D77F (sciser)
$B4:F2DE             db 01,00,00,00,00,FE ;   0.4%                              99.6% - enemy $D97F (desgeega)
$B4:F2E4             db 00,01,00,00,00,FE ;          0.4%                       99.6% - enemy $D6BF (fireflea)
$B4:F2EA             db 01,00,00,00,00,FE ;   0.4%                              99.6% - enemy $E9BF (alcoon)
$B4:F2F0             db 01,00,00,00,00,FE ;   0.4%                              99.6% - enemy $D7BF (zero)
$B4:F2F6             db 01,00,00,00,00,FE ;   0.4%                              99.6% - enemy $E87F (beetom)
$B4:F2FC             db 82,14,00,64,00,05 ;  51.0%   7.8%         39.2%          2.0% - enemy $DC3F (Wrecked Ship orange zoomer)
$B4:F302             db 82,14,00,64,00,05 ;  51.0%   7.8%         39.2%          2.0% - enemy $DD3F (stone zoomer)
$B4:F308             db 50,14,50,41,05,05 ;  31.4%   7.8%  31.4%  25.5%   2.0%   2.0% - enemy $D47F (ripper)
$B4:F30E             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $D7FF/$D83F (tripper / suspensor platform)
$B4:F314             db 50,19,50,3C,05,05 ;  31.4%   9.8%  31.4%  23.5%   2.0%   2.0% - enemy $D67F (metaree)
$B4:F31A             db 3C,3C,3C,3C,0F,00 ;  23.5%  23.5%  23.5%  23.5%   5.9%        - enemy $DBFF (reflec)
$B4:F320             db 14,0A,55,82,05,05 ;   7.8%   3.9%  33.3%  51.0%   2.0%   2.0% - enemy $CEBF (boyon)
$B4:F326             db 14,28,55,64,05,05 ;   7.8%  15.7%  33.3%  39.2%   2.0%   2.0% - enemy $D93F (sidehopper)
$B4:F32C             db 14,14,37,64,37,05 ;   7.8%   7.8%  21.6%  39.2%  21.6%   2.0% - enemy $D9BF/$D9FF (super-sidehopper)
$B4:F332             db 50,1E,46,46,05,00 ;  31.4%  11.8%  27.5%  27.5%   2.0%        - enemy $D6FF (skultera)
$B4:F338             db 46,1E,46,4B,05,05 ;  27.5%  11.8%  27.5%  29.4%   2.0%   2.0% - enemy $D37F (oum)
$B4:F33E             db 55,50,00,50,00,0A ;  33.3%  31.4%         31.4%          3.9% - enemy $DBBF (yard)
$B4:F344             db 00,82,3C,05,1E,1E ;         51.0%  23.5%   2.0%  11.8%  11.8% - enemy $F293 (Botwoon)
$B4:F34A             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $D03F (owtch)
$B4:F350             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $E63F/$E67F (evir)
$B4:F356             db 00,78,32,00,32,23 ;         47.1%  19.6%         19.6%  13.7% - enemy $D33F (holtz)
$B4:F35C             db 32,32,32,05,32,32 ;  19.6%  19.6%  19.6%   2.0%  19.6%  19.6% - enemy $D2BF (squeept)
$B4:F362             db 46,1E,4B,46,05,05 ;  27.5%  11.8%  29.4%  27.5%   2.0%   2.0% - enemy $D1BF (multiviola)
$B4:F368             db 32,32,46,4B,05,05 ;  19.6%  19.6%  27.5%  29.4%   2.0%   2.0% - enemy $D4BF (dragon)
$B4:F36E             db 19,32,5A,0A,32,1E ;   9.8%  19.6%  35.3%   3.9%  19.6%  11.8% - enemy $DD7F (metroid)
$B4:F374             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $D23F (rinka)
$B4:F37A             db 00,82,3C,05,1E,1E ;         51.0%  23.5%   2.0%  11.8%  11.8%
$B4:F380             db 2D,50,50,1E,0A,0A ;  17.6%  31.4%  31.4%  11.8%   3.9%   3.9% - enemy $DB3F (bang)
$B4:F386             db 32,78,50,00,05,00 ;  19.6%  47.1%  31.4%          2.0%        - enemy $F4D3 (grey ninja space pirate)
$B4:F38C             db 32,78,50,00,05,00 ;  19.6%  47.1%  31.4%          2.0%        - enemy $F653 (grey walking space pirate)
$B4:F392             db 32,19,00,19,9B,00 ;  19.6%   9.8%          9.8%  60.8%        - enemy $F513 (green ninja space pirate)
$B4:F398             db 32,1E,64,2D,14,0A ;  19.6%  11.8%  39.2%  17.6%   7.8%   3.9% - enemy $F693 (green walking space pirate)
$B4:F39E             db 32,78,50,00,05,00 ;  19.6%  47.1%  31.4%          2.0%        - enemy $F713 (gold walking space pirate)
$B4:F3A4             db 1E,46,50,46,05,00 ;  11.8%  27.5%  31.4%  27.5%   2.0%        - enemy $F453 (magenta wall space pirate)
$B4:F3AA             db 32,78,50,00,05,00 ;  19.6%  47.1%  31.4%          2.0%        - enemy $F5D3 (magenta ninja space pirate)
$B4:F3B0             db 32,78,50,00,05,00 ;  19.6%  47.1%  31.4%          2.0%        - enemy $F753 (magenta walking space pirate)
$B4:F3B6             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $CEFF (mini-Crocomire)
$B4:F3BC             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $CF3F/$CF7F (tatori / mini-tatori))
$B4:F3C2             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $D07F/$D0BF (gunship))
$B4:F3C8             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $F07F (Shaktool)
$B4:F3CE             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $E6BF (morph ball eye)
$B4:F3D4             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $E6FF (fune)
$B4:F3DA             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $E73F (namihe)
$B4:F3E0             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $E7BF (yapping maw)
$B4:F3E6             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $E83F (magdollite)
$B4:F3EC             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $E8FF (work robot)
$B4:F3F2             db 50,50,50,05,05,05 ;  31.4%  31.4%  31.4%   2.0%   2.0%   2.0% - enemy $E93F (work robot deactivated)
$B4:F3F8             db 32,32,32,00,32,37 ;  19.6%  19.6%  19.6%         19.6%  21.6% - enemy $EC7F/$EEFF (Mother Brain body / Bomb Torizo))
$B4:F3FE             db 74,14,41,36,00,00 ;  45.5%   7.8%  25.5%  21.2%               - enemy $EF3F (Bomb Torizo orb)
$B4:F404             db 32,32,32,00,32,37 ;  19.6%  19.6%  19.6%         19.6%  21.6% - enemy $EF7F (Golden Torizo)
$B4:F40A             db 1E,1E,32,3C,55,00 ;  11.8%  11.8%  19.6%  23.5%  33.3%        - enemy $EFBF (Golden Torizo orb)
$B4:F410             db 32,32,32,00,32,37 ;  19.6%  19.6%  19.6%         19.6%  21.6% - enemy $DF3F (Spore Spawn)
$B4:F416             db 0A,14,C8,19,00,00 ;   3.9%   7.8%  78.4%   9.8%               - enemy $DF7F (Spore Spawn)
$B4:F41C             db 32,32,32,00,32,37 ;  19.6%  19.6%  19.6%         19.6%  21.6% - enemy $E2BF (Kraid)
$B4:F422             db 0A,23,C8,00,0A,00 ;   3.9%  13.7%  78.4%          3.9%        - enemy $E3FF/$E43F (Kraid foot / good fingernail)
$B4:F428             db 00,0A,DC,05,14,00 ;          3.9%  86.3%   2.0%   7.8%        - enemy $DDFF (Crocomire tongue)
$B4:F42E             db 00,78,64,05,14,0A ;         47.1%  39.2%   2.0%   7.8%   3.9% - enemy $DDBF (Crocomire)
$B4:F434             db 32,32,32,00,32,37 ;  19.6%  19.6%  19.6%         19.6%  21.6% - enemy $E4BF/$E53F/$E57F (Phantoon body / tentacles / mouth))
$B4:F43A             db 14,14,64,69,0A,00 ;   7.8%   7.8%  39.2%  41.2%   3.9%        - enemy $E4FF (Phantoon eye)
$B4:F440             db 32,32,32,00,32,37 ;  19.6%  19.6%  19.6%         19.6%  21.6% - enemy $DE3F/$DEBF/$DEFF (Draygon body / tail / arms))
$B4:F446             db 05,1E,6E,64,05,05 ;   2.0%  11.8%  43.1%  39.2%   2.0%   2.0% - enemy $DE7F (Draygon eye)
$B4:F44C             db 32,32,32,00,32,37 ;  19.6%  19.6%  19.6%         19.6%  21.6% - enemy $E13F/$E17F (Ridley)
$B4:F452             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $F0BF/$F0FF (n00b tube cracks / chozo statue)
$B4:F458             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $EA3F (Wrecked Ship spark)
$B4:F45E             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $EA7F (blue Brinstar face block)
$B4:F464             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $E0BF (fire arc)
$B4:F46A             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $DFBF (boulder)
$B4:F470             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $DFFF/$E03F (spike platform)
$B4:F476             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $E07F (fire pillar)
$B4:F47C             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $D87F/$D8BF (roach)
$B4:F482             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $E5BF/$F2D3 (etecoon)
$B4:F488             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $E1FF/$E5FF/$F313 (Ceres steam / dachora))
$B4:F48E             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $D1FF (polyp)
$B4:F494             db 00,00,00,FF,00,00 ;                      100.0%
$B4:F49A             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $EC3F (Mother Brain brain)
$B4:F4A0             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $D4FF/$D53F/$D57F/$D5BF/$D5FF/$ECBF/$ED3F (shutter / rising and falling platform / Shitroid in cutscene / torizo corpse)
$B4:F4A6             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $F493 (silver wall space pirate)
$B4:F4AC             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $F613 (silver ninja space pirate)
$B4:F4B2             db 00,00,00,FF,00,00 ;                      100.0%               - enemy $F793 (silver walking space pirate)
}


;;; $F4B8: Free space ;;;
{
$B4:F4B8             fillto $B58000, $FF
}
