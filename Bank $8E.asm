;;; $8000: Menu BG1/2 tiles ;;;
{
; $8000..BFFF used for anti-piracy screen

; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |  EEEE  |   EE   |  EEEE  |  EEEE  |    EE  | EEEEEE |  EEEE  | EEEEEE |  EEEE  |        |   EE   | EEEEE  |  EEEE  | EEEEE  | EEEEEE |        |
; | EEDDEE |   EED  | EEDDEE | EEDDEE |    EED | EEDDDDD| EEDDEE | EEDDEED| EEDDEE |        |  EEEE  | EEDDEE | EEDDEE | EEDDEE | EEDDDDD|        |
; | EED EED|  EEED  | EED EED| EED EED|   EEED | EED    | EED EED| EED EED| EED EED|        | EEDDEE | EED EED| EED EED| EED EED| EED    |        |
; | EED EED|   EED  | EED EED|  DD EED|   EEED | EED    | EED  DD|  DD EED| EED EED|        | EED EED| EED EED| EED EED| EED EED| EED    |        |
; | EED EED|   EED  |  DD EED|     EED|  EDEED | EEEEE  | EED    |    EEDD| EED EED|        | EED EED| EED EED| EED  DD| EED EED| EED    |        |
; | EED EED|   EED  |    EEDD|  EEEEDD|  EDEED | EEDDEE | EEEEE  |    EED |  EEEEDD|        | EED EED| EEEEEDD| EED    | EED EED| EEEEEE |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | EED EED|   EED  |   EEDD |   DDEE |  EDEED | EED EED| EED EE |   EEDD | EEDDEE |  EEEEED| EED EED| EEDDEE | EED    | EED EED| EEDDDDD| EEDDDDD|
; | EED EED|   EED  |  EEDD  |     EED| EEDEED |  DD EED| EED EED|   EED  | EED EED|   DDEED| EEEEEED| EED EED| EED    | EED EED| EED    | EED    |
; | EED EED|   EED  | EEDD   |     EED| EEDEED |     EED| EED EED|   EED  | EED EED|     EED| EEDDEED| EED EED| EED EE | EED EED| EED    | EED    |
; | EED EED|   EED  | EED    | EE  EED| EEEEEE | EE  EED| EED EED|   EED  | EED EED| EED EED| EED EED| EED EED| EED EED| EED EED| EED    | EED    |
; | EED EED|   EED  | EED    | EED EED|  DDEEDD| EED EED| EED EED|   EED  | EED EED| EED EED| EED EED| EED EED| EED EED| EED EED| EED    | EED    |
; |  EEEEDD|   EED  | EEEEEE |  EEEEDD|    EED |  EEEEDD|  EEEEDD|   EED  |  EEEEDD|  EEEEDD| EED EED| EEEEEDD|  EEEEDD| EEEEEDD| EEEEEE | EED    |
; |  DDDDD |   DDD  |  DDDDDD|   DDDD |     DD |   DDDD |   DDDD |    DD  |   DDDD |   DDDD |  DD  DD|  DDDDD |   DDDD |  DDDDD |  DDDDDD|  DD    |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        | EE  EE |   EE   |     EE | EE  EE | EE     |E     E |EE   EE |        |        |        |  EEEE  | EEEEEE | EE  EE |        |EE   EE |
; |        | EED EED|   EED  |     EED| EED EED| EED    |EE   EED|EED  EED|        |        |        | EEDDEE |  DEEDDD| EED EED|        |EED  EED|
; |        | EED EED|   EED  |     EED| EED EED| EED    |EED  EED|EEE  EED|        |        |        | EED EED|   EED  | EED EED|        |EED  EED|
; |        | EED EED|   EED  |     EED| EEDEEDD| EED    |EEEDEEED|EEED EED|        |        |        | EED EED|   EED  | EED EED|        |EED  EED|
; |        | EED EED|   EED  |     EED| EEDEED | EED    |EEEEEEED|EEEE EED|        |        |        | EED  DD|   EED  | EED EED|        |EEDE EED|
; |        | EEEEEED|   EED  |     EED| EEEEDD | EED    |EEDEDEED|EEDEDEED|        |        |        |  EEE   |   EED  | EED EED|        |EEDE EED|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | EEDEEE | EEDDEED|        |     EED| EEEED  | EED    |EEDEDEED|EEDEEEED| EEEEEDD| EED EED| EEEEEDD|   DEE  |        |        | EED EED|EEDEDEED|
; | EED EED| EED EED|        | EE  EED| EEEEE  | EED    |EEDEDEED|EED EEED| EEDDDD | EED EED| EEDDEE |     EE |        |        | EED EED|EEDEDEED|
; | EED EED| EED EED|        | EED EED| EEDEED | EED    |EED DEED|EED EEED| EED    | EDEEDED| EED EED| EE  EED|        |        |  ED EDD|EEEEEEED|
; | EED EED| EED EED|        | EED EED| EEDEEE | EED    |EED  EED|EED  EED| EED    | EEDEDED| EED EED| EED EED|        |        |  EEEED | EEDEEDD|
; | EED EED| EED EED|        | EED EED| EED EED| EED    |EED  EED|EED  EED| EED    | EEDEEDD| EED EED| EED EED|        |        |   EEDD | EDD ED |
; |  EEEEED| EED EED|        |  EEEEDD| EED EED| EEEEEE |EED  EED|EED  EED| EED    |  EEDEE | EED EED|  EEEEDD|        |        |   EED  | ED  ED |
; |   DDDDD|  DD  DD|        |   DDDD |  DD  DD|  DDDDDD| DD   DD|  D   DD|  DD    |   DD DD|  DD  DD|   DDDD |        |        |    DD  |  D   D |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |EE  DEDD|        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        | DDEEEE |        |        |        |        |        |        |        |        |   E    |        |        |    EEE |
; | EE  EE | EE  EE | EEEEEE |EEE DEDD|  EEEE  |        |        |    E   |  E     | EEEEEE |   E    | E EEEE |   ED   |  E E   |        |    E ED|
; | EED EED| EED EED|  DDDEED|E ED ED | EEDDEE |        |        |   EDD  |   E    | EDDDDED|   ED   | ED EDDD|EEEEEEE |EEEEEEE |        |    EEED|
; | EED EED| EED EED|     EED|E ED ED | EED EED|        |        |   ED   |   ED   | ED   ED|EEEEEEE | EDEEEE |EDDDDDED| DEDEDDD|EEEEEE  | E   DDD|
; | EED EED| EED EED|    EEDD|EEED ED | EED EED|   EED  |        |  EDD   |    E   | ED   ED| DEEEDDD|EEE EDED|ED    ED| EEEEE  | DDDDED | ED E   |
; |  EE EDD|  ED EDD|    EED | DDD  D |  DD EED|   EED  |        |  ED    |    ED  | ED   ED|  EEED  | DDDEDED| EEEEE D| EDDDED |    EDD | ED DE  |
; |   EEDD |  EEEED |   EEDD |        |    EEDD|   EED  |        |  ED    |    ED  | EEEEEED| EDEDE  |EE EEEED|  DDEDD |  EEEDD |    ED  | ED  ED |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |   EED  |        |   EED  |   EED  |   EEDD | EEEEEE | EEEEE  |  ED    |    ED  | EDDDDED| EDEDED | DD DDDD|  EEDD  |EEEEEEE |   EDD  | ED  ED |
; |  EDEE  |        |  EEDD  |   EED  |   EED  |  DEEDDD|  DDDDD |  ED    |    ED  | ED   ED| EDEDED |EE EEEE |   DED  | DEDEDDD|   EE   |EDD   E |
; | EED EE | E E  E |  EED   |   EED  |   EED  |   EED  |        |  ED    |    ED  | ED   ED|EDDED E | DDEDDED|EEEEEEE | EDEDE  |  EDDE  |ED    ED|
; | EED EED| EDED ED| EEDD   |    DD  |    DD  |   EED  |        |   E    |   EDD  | ED   ED|EDEEE ED|EE ED ED| DDDEDDD|EEEEEEE | EDD DE |ED    ED|
; | EED EED|EEE DEDD| EED    |   EE   |   EE   |   EED  |        |   ED   |   ED   | EEEEEED| D EDD D|EDDED ED|    ED  | EDEDEDD|EDD   ED|ED    ED|
; | EED EED| DDEEEE | EEEEEE |   EED  |   EED  |    DD  |        |    E   |  EDD   | EDDDDED|   ED   |EE EEEED|  EEDD  | EDEDED | D     D| D     D|
; |  DD  DD|EE  DEDD|  DDDDDD|    DD  |    DD  |        |        |     D  |   D    |  D    D|    D   | DD DDDD|   DD   |  DED D |        |        |
; |        | DDEEEE |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |  EEEE  |   EE   | EEEEE  | EEEEE  |   EEE  |EEEEEE  | EEEEE  |EEEEEEE | EEEEE  | EEEEE  |  EEE   |EEEEEE  | EEEEE  |EEEEEE  |EEEEEEE |EEEEEEE |
; | EDDDEE |  EEED  |EEDDDEE |EEDDDEE |  EEEED |EEDDDDD |EEDDDEE |EEDDDEED|EEDDDEE |EEDDDEE | EEEEE  |EEDDDEE |EEDDDEE |EEDDDEE |EEDDDDDD|EEDDDDDD|
; |EED  EED|   EED  |EED  EED| DD  EED| EEDEED |EEEEEE  |EED   DD| DD EEDD|EED  EED|EED  EED|EEDDDEE |EED  EED|EED  EED|EED  EED|EED     |EED     |
; |EED  EED|   EED  | DDEEEDD|  EEEEDD|EEDDEED |EEDDDEE |EEEEEE  |   EEDD | EEEEEDD| EEEEEED|EED  EED|EEEEEEDD|EED   DD|EED  EED|EEEEEE  |EEEEEE  |
; |EED  EED|   EED  | EEEDDD |   DDEE |EED EED | DD  EED|EEDDDEE |  EEDD  |EEDDDEE |  DDDEED|EEEEEEED|EEDDDEE |EED  EE |EED  EED|EEDDDDD |EEDDDDD |
; |EED  EDD|   EED  |EEDDD   |EE   EED|EEEEEEE |EE   EED|EED  EED|  EED   |EED  EED|EE   EED|EEDDDEED|EED  EED|EED  EED|EED  EED|EED     |EED     |
; | EEEEDD |   EED  |EEEEEEE | EEEEEDD| DDDEEDD| EEEEEDD| EEEEEDD|  EED   | EEEEEDD| EEEEEDD|EED  EED|EEEEEEDD| EEEEEDD|EEEEEEDD|EEEEEEE |EED     |
; |  DDDD  |    DD  | DDDDDDD|  DDDDD |     DD |  DDDDD |  DDDDD |   DD   |  DDDDD |  DDDDD | DD   DD|  DDDDD |  DDDDD | DDDDDD | DDDDDDD| DD     |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | EEEEE  |EE   EE |   EE   |     EE |EE   EE |EE      |EE   EE |EE   EE | EEEEE  |EEEEEE  | EEEEE  |EEEEEE  | EEEEE  |EEEEEE  |EE   EE |EE   EE |
; |EEDDDEE |EED  EED|   EED  |     EED|EED EEDD|EED     |EED  EED|EEE  EED|EEDDDEE |EEDDDEE |EEDDDEE |EEDDDEE |EEDDDEE | DEEDDD |EED  EED|EED  EED|
; |EED  EED|EED  EED|   EED  |     EED|EEDEED  |EED     |EEEDEEED|EEEE EED|EED  EED|EED  EED|EED  EED|EED  EED|EED   DD|  EED   |EED  EED|EED  EED|
; |EED   DD|EEEEEEED|   EED  |     EED|EEEED   |EED     |EEDEDEED|EEDEEEED|EED  EED|EED  EED|EED  EED|EEEEEEDD| EEEEE  |  EED   |EED  EED|EEEDEEED|
; |EED EEE |EEDDDEED|   EED  |EE   EED|EEEEE   |EED     |EED DEED|EED EEED|EED  EED|EEEEEEDD|EEDEEEED|EEDEEDD |  DDDEE |  EED   |EED  EED| EEEEEDD|
; |EED  EED|EED  EED|   EED  |EED  EED|EEDEEEE |EED     |EED  EED|EED  EED|EED  EED|EEDDDDD |EED EEDD|EED EE  |EE   EED|  EED   |EED  EED|  EEEDD |
; | EEEEEED|EED  EED|   EED  | EEEEEDD|EED DEED|EEEEEEE |EED  EED|EED  EED| EEEEEDD|EED     | EEEDEE |EED  EE | EEEEEDD|  EED   | EEEEEDD|   EDD  |
; |  DDDDDD| DD   DD|    DD  |  DDDDD | DD   DD| DDDDDDD| DD   DD| DD   DD|  DDDDD | DD     |  DDD DD| DD   DD|  DDDDD |   DD   |  DDDDD |    D   |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |EE   EE |EE   EE | EE  EE |EEEEEEE |   EE   | EEEEE  |        |        |        |        |   E    |  E     |        |        |        | ED     |
; |EED  EED|EEE EEED| EED EED| DDDEEED|   EED  |EEDDDEE |   E    |        |        |        |  EDD   |   E    |        |    EEE |    E E | ED     |
; |EEDE EED| EEEEEDD| EED EED|   EEEDD|   EED  |EED  EED|   ED   |        |        |        |  ED    |   ED   |   ED   |    E ED|    EDED| ED     |
; |EEDEDEED|  EEEDD |  EEEEDD|  EEEDD |   EED  | DDEEEDD| EEEEE  | EEEEE  |        |  EE    |  ED    |   ED   |        | E  EEED| E   D D| ED     |
; | EEEEEDD| EEEEE  |   EEDD | EEEDD  |   EED  |  EEDDD |  DEDDD |  DDDDD |  EE    |  EED   |  ED    |   ED   |        | ED  DDD| ED     |  EEEEE |
; | EEDEED |EEEDEEE |   EED  |EEEDD   |    DD  |   DD   |   ED   |        |  EED   |   ED   |  ED    |   ED   |   ED   | ED  EE | ED  EE |   DDDDD|
; | EDD ED |EEDD EED|   EED  |EEEEEEE |   EE   |  EE    |    D   |        |   DD   |  E D   |   E    |  EDD   |        | EEEEDDD| EEEEDDD|        |
; |  D   D | DD   DD|    DD  | DDDDDDD|    DD  |   DD   |        |        |        |   D    |    D   |   D    |        | EDDDD  | EDDDD  |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |       E|E       |        |        |        |        |        |        |        |        |
; |     DEE|     DEE|EED     |     DEE|     DEE|        |     EEF|FE      | EEEEEC | 999997 |        |        |        |    EEE |E  E EEE| EEE EEE|
; |    EEFF|    EEFF|FFEE    |    EEFF|    EEFF|        |   EEFFF|FE      | EBBBBC | 9AAAA7 |   EEEEE|EEEEEEEE|EEEEEEEE|    EDD |EE E EDD| EDE EDD|
; |   EFFFF|   EFFFF|FFFFE   |   EFFFF|   EFFFF|        | EEFFFFE|E       | EBBBBC | 9AAAA7 |  EDFFFF|FFFFFFFF|FFFFFFFF|    EEE |EDEE EEE| E E E  |
; |  EFFFFE|  EFFEEE|EEFFFE  |  EFFEEF|  EFFEEF|       E|EFFFFEE |        | EBBBBC | 9AAAA7 | EFFFFFF|FEEFFFFF|FEEEEEFF|    EDD |E EE EDD| EED E E|
; | DEFFFEE| DEFFEEF|FEEFFED | DEFFEEF| DEFFEEF|      EF|FFFEE   |        | EBBBBC | 9AAAA7 |DEFFFFFF|FEEFFFFF|FEEFFEEF|    E   |E DE E  | EDE E E|
; | EFFFEEF| EFFFEEF|FEEFFFE | EFFFFEE| EFFFEEF|      EF|FEE     |        | CCCCCC | 777777 |EFFFFFFF|FEEFFFFF|FEEFFEEF|    EEE |E  E EEE| E E EEE|
; | EFFFEEF| EFFFEEE|EEFFFFE | EFFFFFE| EFFFFEF|       E|E       |        |        |        |EFFFFFFF|FEEFFFFF|FEEFFEEF|    DDD |D  D DDD| D D DDD|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | EFFFEEF| EFFFEEF|FEEFFFE | EFFFFFE| EFFFFEE|        |        |        |        |        |        |FEEFFFFF|FEEEEEFF|        |        |        |
; | EFFFEEE| EFFFEEF|FEEFFFE | EFFFFEF| EFFFFFE|EEE EEE |E   EEE |EEE EEE |  EEE EE|E EEE EE|E EEE   |FEEFFFFF|FEEFFEEF|   EEE  |E  E   E|  EEE   |
; | DEFFEEF| DEFFEEF|FEEFFED | DEFFEEF| DEFFFFE|EDDDEDDD|ED  EDDD|EDDD EDD|  EDDD E|DDEDEDED|ED EDD  |FEEFFFFF|FEEFFEEF|   DED  |E  EE EE|  EDD   |
; |  EFFEEF|  EFFEEE|EEFFFE  |  EFFEEF|  EFFFFE|EEE EEE |ED  EEE |ED   ED |  EEE  E|D EDEDED|ED ED   |FEEEEEEF|FEEFFEEF|    E   |E  EDEDE|  EEE   |
; |   EFFFF|   EFFFF|FFFFE   |   EFFFF|   EFFFF| DEDEDDD|ED  EDDD|ED   ED |   DED E|D EEEDEE|DD ED   |FFFFFFFF|FFFFFFFF|    E   |E  E E E|  EDD   |
; |    EEFF|    EEFF|FFEE    |    EEFF|    EEFF|  EDED  |ED  ED  |ED   ED |    ED E|D EDEDED|E  ED   |EEEEEEEE|EEEEEEEE|    E   |E  E D E|  E     |
; |     DEE|     DEE|EED     |     DEE|     DEE|EEEDEEE |EEE EEE |EEE  ED |  EEED E|D EDEDED|ED ED   |        |        |    E   |E  E   E|  EEE   |
; |        |        |        |        |        | DDD DDD| DDD DDD| DDD  D |   DDD  |D  D D D| D  D   |        |        |    D   |D  D   D|  DDD   |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |    DEEE|EED     |    DEEE|EED     |    DEEE|EED     |    DEEE|EED     |    5678|765     |        |        |    5678|765     |        |        |
; |    EFFD|FFE     |    EFFD|FFE     |    EFFD|FFE     |    EFFD|FFE     |    4567|654     |        | 1      |    4567|654     |        |        |
; |    EFDD|DFE     |    EFDE|DFE     |    EFDD|DFE     |    EFDE|DFE     |    3456|543     |        | 21     |    3456|543     |        |        |
; |    EDDD|DDE     |    EDEE|EDE     |    EDDD|DDE     |    EDEE|EDE     |    2345|432     |        | 321    |    2345|432     |        |        |
; |DEEEEFFF|FFEEEED |DEEEEFFF|FFEEEED |DEEEEFFF|FFEEEED |DEEEEFFF|FFEEEED |    1234|32181876|54321876|54321   |    1234|321     |   12345|6781234 |
; |EFFDFFFF|FFFDFFE |EFFDFFFF|FFFDFFE |EFFDFFFF|FFFDFFE |EFFDFFFF|FFFDFFE |     123|21832187|65432187|654321  |    8123|218     |  123456|781234  |
; |EFDDFFFF|FFFDDFE |EFDDFFFF|FFFDDFE |EFDEFFFF|FFFEDFE |EFDEFFFF|FFFEDFE |      12|18543218|76543218|7654321 |    7812|187     | 1234567|81234   |
; |EDDDFFFE|FFFDDDE |EDDDFFFE|FFFDDDE |EDEEFFFE|FFFEEDE |EDEEFFFE|FFFEEDE |       1|87654321|87654321|87654321|    6781|876     |12345678|1234    |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |EFDDFFFF|FFFDDFE |EFDDFFFF|FFFDDFE |EFDEFFFF|FFFEDFE |EFDEFFFF|FFFEDFE |        | 6543218|76543218|7654321 |        |       8|71234567|81234   |
; |EFFDFFFF|FFFDFFE |EFFDFFFF|FFFDFFE |EFFDFFFF|FFFDFFE |EFFDFFFF|FFFDFFE |    E E |  332187|65432187|654321  | E E    |      67|65123456|781234  |
; |DEEEEFFF|FFEEEED |DEEEEFFF|FFEEEED |DEEEEFFF|FFEEEED |DEEEEFFF|FFEEEED |    EDED|   21876|54321876|54321   | E E    |     456|54312345|6781234 |
; |    EDDD|DDE     |    EDEE|EDE     |    EDDD|DDE     |    EDEE|EDE     | EEEEE D|    8   |        | 321    | E E    |    2345|432     |        |
; |    EFDD|DFE     |    EFDE|DFE     |    EFDD|DFE     |    EFDE|DFE     |  DDDDD |        |        | 21     | DED    |    1234|321     |        |
; |    EFFD|FFE     |    EFFD|FFE     |    EFFD|FFE     |    EFFD|FFE     |        |        |        | 1      |  E     |    8123|218     |        |
; |    DEEE|EED     |    DEEE|EED     |    DEEE|EED     |    DEEE|EED     |EEEEEEE |        |        |        |  E     |    7812|187     |        |
; |        |        |        |        |        |        |        |        | DDEDDDD|        |        |        |  D     |    6781|876     |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |    E E |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |    EDED|        |        |        |        |        |        |        |        |        | E   E  |        |    E   |
; | E   E  |   E    |        | E   D D| EEEEE  |        |    E   |        |     E  | EEEEE  |        |  E     | E  E   | ED  ED |   E    |E  EEEE |
; | ED  ED |   ED   |EE      | ED     |  DDDDD | E      |    ED  | EEEEE  |     ED |  DDDDD | E  E   |  ED    | ED ED  |EEED ED |   ED   |DE  EDDD|
; |EEEEEEE |EEEEEEE | DE     | ED     |        | ED     |EEEEEEE |  EDDDD |     ED |        | ED ED  |EEEEEEE | EEEED  |EDEEEEE |EEEEEEE | DDEEEE |
; | EDDDEDD|EDDDDDED|  DD  E | ED     |EEEEEEE | ED     | DDDEDDD|  ED    |     ED |EEEEEEE | ED ED  | DEDDDDD| EDDEED |EEEDDEDD| DEDDDDD|   EEDED|
; | ED  ED |ED    ED|      ED| EEE    | DDEDDDD| ED     |   EED  |EEEEEEE |    EDD | DDDDDED| ED ED  |  EDEEE |EED EDE |EDED ED |  EDEE  |EE EEEED|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | ED  ED | D    ED|     EDD|        |   ED   | ED   E |   EED  | DEDDDDD|    ED  |      ED| ED EDE | EDD DDD|EEDEDDED|EEED ED | EEEDDE | EDEEDED|
; |  D  ED |     EDD|     ED |    E E |   ED   | ED   ED|  EDED  |  ED    |   EDD  |     EDD| ED EDED| ED E   |EDEED ED|EDEE ED | EDDD ED| EDEEEED|
; |    EDD |     ED |    EDD |    EDED|  EDD   | ED  EDD| EDDED  |  ED    |   ED   |     ED | ED EDED| EDEDD  |EDEDD ED|EEEDEED |  D   ED| ED EDDD|
; |    ED  |    EDD |   EDD  |  E  D D|  ED    | EDEEDD |EDD ED  |  ED    |  EDD   |    EDD |EDD EDED|EDDED   |EDED  ED| EEDDED |      ED| EDEEEE |
; |   EDD  |  EEDD  | EEDD   |  ED    | EDD    | EEDDD  | D  ED  |   EEEE | EDD    |  EEDD  |ED  EEDD|ED  EEE | EDD EDD|EDED ED |  EEEEDD|EDE EDDD|
; |    D   |   DD   |  DD    |EEEEEEE |  D     |  DD    |     D  |    DDDD|  D     |   DD   | D   DD | D   DDD|  D   D |EDEDEED |   DDDD |EDDEEEE |
; |        |        |        | DEDDDDD|        |        |        |        |        |        |        |        |        | D D DD |        | D  DDDD|
; |        |        |        |  EDEEE |        |        |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |        |    E E |    EEE |        |        |        |        |        |    EEE |        |    E E |
; |        |        |        |        |        |        |    EDED|    E ED|        |        |        |        |        |    E ED| E  ED  |    DDED|
; |        | E      |        | E      |        |        | E   D D|    EEED|        |        |        |  E     |      E |    DEED| EDEDDE |    ED D|
; | EEEEEE | ED     |EEEEEEE | ED     |        |        | EEEEE  |  E  DDD|EE      |        |        |  EEEEE |      ED|EEEEEDDD| ED EEDD|EEEEEEE |
; |  DDDDED| ED     |EDDDDDED|EEEEEEE |        |        | EDDDED | EDE    | DED    |        |        |  EDDDED|     EDD| DDDDED |EDD EDD | DDDEDDD|
; |      ED| ED     |ED    ED| EDDDDED| E E E  |      E | ED  ED | EDDE   |   D  E | E      |        |  ED  ED|    EDD |     ED | D EDDE |    ED  |
; |      ED| EEE    |ED    ED| ED  EDD| EDEDED |     EDD|EDD  ED |EDD  E  |EE    ED|EEEEEEE | EEEEE  | EDED ED|  EEED  |     ED | E EEEED|  EEED  |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |      ED| EDDEE  |ED    ED| ED EDD | EDEDED |   EEDD |        |ED   ED | DED EDD| DEDDDED|  DDDED |  D EDED|EEDDED  |     ED | ED DDDD| D  ED  |
; |      ED| ED  DD |ED    ED| ED  D  |  D DED |EEEDED  |    E E | D    E |   D ED |  ED EDD| EEEEED |     EDD| DD ED  |    EDD |EED EEE |    ED  |
; |      ED| ED     |ED    ED| ED     |    EDD | DD ED  |    EDED|      ED|    EDD |   E  D |  DDDED |     ED |    ED  |    ED  | EDEDDED|   EDD  |
; |      ED| ED     |ED    ED| ED     |  EEDD  |    ED  | E   D D|      ED|  EEDD  |   ED   | EEEEED |    EDD |    ED  |   EDD  | ED DEDD|   ED   |
; | EEEEEED| ED     |EEEEEEED|  EEEEE |   DD   |     D  | ED     |       D|EEDDD   |    D   |  DDDDD |  EEDD  |    ED  | EEDD   | ED EED |  EDD   |
; |  DDDDDD|  D     | DDDDDDD|   DDDDD|        |        | EEEEEE |        | DD     |        |        |   DD   |     D  |  DD    | EDEDDE |   D    |
; |        |        |        |        |        |        |EDDDEDDD|        |        |        |        |        |        |        |  D D  D|        |
; |        |        |        |        |        |        |ED  ED  |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |    E E |    E E |        |        |        |        |        |        |        |        |        |
; |        |        |   E E  |   E    |   E    |    EDED|    EDED|        |        |        |        |        |        |        |   E    |EEEEEEE |
; |   E    |  E   E |E  EDED |   ED   |  ED    |     D D|  E  D D|        |EEEEEEE |    E   | E      |  E     |  E     | E  E   |   ED   | DDEDDDD|
; |   ED   | EDD  ED|ED EDED |EEEEEEE |EEEEEEE |EE      |  EEEEE |        | DDDDDED|    ED  | EEEEE  |  ED    |  ED ED | ED ED  |   ED   |   EE   |
; | EEEEEE | ED   ED| DEEEEE | DEDDDDD|EDDDDDED| DE     |  EDDDED|        |   E  ED|   EDD  | EDDDED |EEEEEEE |EEEE  ED| EEEED  |   ED   |   EDE  |
; |  DDEDDD| ED   ED|   DEDDD|  ED    |EDEEE ED|  DD  E |  ED  ED|        |   ED ED|   ED   | ED  ED | DDEDDDD| EDDD  D| EDDEED |   EEE  |   EDDE |
; |    ED  | ED   ED|E E EDE |  EEEEE |EDEDEDED|EE    ED| EDED ED| EEEE   |   EDEDD|  EDD   |EDD  ED |   ED   | ED     |EED EDE |   EDDD |   ED DD|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |    DED | EED  ED| EEDEDED|  EDDDED|EDEDEDED| DE  EDD|        |  DDED  |   EEDD |  ED    | D   ED |EEEEEEE |EDD  E  |EEDEDDED|   ED   |   ED   |
; |  E  DD |  DD  ED| EEEEEED|  ED  ED|EDEDEDED|  DD ED |    E E |    ED  |   EDD  | EDD E  |    EDD | DDDEDDD|ED   ED |EDEED ED|   ED   |   ED   |
; | EDD    |     EDD| EDDEDDD| EDD  ED|EDEDEDED|    EDD |    EDED|    ED  |   ED   | ED  ED |    ED  |    ED  | DEEEED |EDEDD ED|   ED   |   ED   |
; | ED     |     ED | ED E   |EDD   ED|EDEEEDED|  EEDD  |     D D|EEEEEEE |  EDD   |EDDEEDE |   EDD  |    DE  |  EDDEE |EDED  ED|   ED   |   ED   |
; |  EEEE  |    EDD |EDEE    | D   EDD|ED DDDED|EEDDD   |EEEEEEE | DDDDDDD| EDD    |EEEDDDED| EEDD   |     ED |   EEDDD| EDD EDD|   ED   |   ED   |
; |   DDDD |     D  |ED EEEE |    EDD |ED   EED| DD     | DDDEDDD|        |  D     | DDD   D|  DD    |      D |    DD  |  D   D |EEEEEEE |   ED   |
; |        |        | D  DDDD|     D  | D    DD|        |   EDD  |        |        |        |        |        |        |        | DDDDDDD|    D   |
; |        |        |        |        |        |        |  EDD   |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        | DD     |     FF | DD     |     FF | DD     |     FF |        |
; |        | DDDDDD |        |        |DDDDDDD |        |        | CCCDCCC|        | D3D    |    FDF | D3D    |    FDF | D3D    |    FDF |  666666|
; |       D|CCCCCCFC|        |      DD|DCCCCCCD|D       |       C|BBBCDCBC|CC      | D32D   |   DDDF | D32D   |   DDDF | D32D   |   3DDF |  444454|
; |     DCC|CCCCCCCF|CD      |     DBD|BBBCCCCC|DD      |     CBB|ABBCDBAB|CCC     |  321EE1|3233DD  |  32111E|E133DD  |  3211E2|1EE1DD  |  777EE6|
; |    DBBC|CCCCCCCC|DCD     |    BACD|9ABBBCCC|CCD     |    CB9A|AABCDBBB|CCCD    |  321EE1|2333DD  |  32111E|E133DD  |  321122|1EE1DD  |  766446|
; |   D9ABB|BCCCCCCC|FDCD    |   BABDB|AAABCBCC|CCDD    |    B9E9|AABCDBBB|BCCC    |   31EE1|3233D   |   3211E|E133D   |   32112|1EE2D   |  555575|
; |   89ABB|CBCCCCCD|FDDDD   |   9ABDD|BAAABBBC|CCDD    |   CB999|AABDDBBB|BCCCD   |     1E1|233     |     21E|E13     |     322|1E1     |  777766|
; |  B9AAAB|BCCCCDDA|BCDDD   |  C9ACAB|DBAABBCC|CCDDD   |   BBA9A|ABDCCDBB|BCCCD   |      11|33      |      31|12      |      73|21      |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | BDAAAAB|CBCCDAA9|ABCDD   |  9ACABB|BDBBBBBB|CDDACD  | CBCBBAA|BD9ABCDB|BCCCDDC | DD     |     3F | DD     |     FF |  5457  |        |        |
; | 9BDADAB|BCCDAA9A|CCCDDC  | BAA89BB|BCDBFBBC|CDAACCD |C8ACBDBB|C999ABCD|CCFCDCCC| D3D  E |    22F | D3D    |    FDF |  5457  |  666666|6767    |
; |C8ABDDAB|BC4579AB|BCCDCF  | BDC99BB|BCFFFBBC|57ABCCD |B99BBDDB|CA9AABCD|CFFCDCDC| D32D E |   2E2F | D32D E |   DDDF |  5457  |  444444|46458   |
; |9ABD3DAB|CE579ABB|CCCDCDB | BFFAABC|CFF3FBCE|45ABBCD |BAABBD3D|CBBABCCD|FDFCCDDC|  321EEE|321EE2  |  32EEEE|E233DD  |  5457  |  EEEEEE|E5E5E8  |
; |AAD33DAB|B4779ABB|BCCDCFD | BFEFFFF|F323FBB4|57BBBCD |CA4ABD3E|DDCCDDDF|DDFCC6DC|  3211E2|231EE3  |  3211E2|2333DD  |  5457  |  444444|4645E8  |
; | 22339AA|DDDDCCAB|CCCDCDB | BFEE121|2233FBB7|7ABBBDD | B56BB3E|E1123233|DDCC56DC|   321E2|321E2   |   32112|3233D   |  5457  |  EEEE65|57568   |
; |E12339AD|C47DDCCA|CCDCDFDC| BAFE112|232FBBC4|5CBBCDD | C57BB3E|E1222333|DDBC76C |     322|232     |     322|233     |  5457  |  777447|6767    |
; |11239ADC|457DDDCC|CDCDDCBD| CAAE121|223ABBD4|CDCCDD  |  C4CBA3|E1123233|DBCD6C  |      73|33      |      73|33      |  5457  |  55557 |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |1239ADC4|5DDDD   |      DC|  CAF112|23ABBD54|DDDDDD  |   45BBA|A322233C|BCD56   |        |        |        |  5457  |  5457  |  55554 |        |
; |5D9ADCE5|DD      |        |  4CAF33|3AABD54D|   DD   |    45CB|AA7333CB|BD657   |        |        |        |  5E56  |  5E57  |  666666|6767    |
; |D9ADCE5D|        |        |  4DA644|CABD5E  |        |    745C|5A654DBB|D65     |    5555|55555555|5556    |  5E4555|556E57  |  444444|4645B   |
; |5AD477  |        |        |   5A757|AA54E   |        |      45|4BA76BB6|75      |   5EE44|44444444|4EE56   |  65EE44|4EE567  |  EEEEEE|E5E5AB  |
; |DAD55   |        |        |     A64|AD45    |        |        |6CA54BC7|        |  5E4555|55555555|554E57  |   65555|55567   |  444444|4645AB  |
; |ADC     |        |        |     A7A|ADD     |        |        | DA77BCD|        |  5E5677|77777777|776E57  |    7777|7777    |  555555|5756B   |
; |BD      |        |        |      AA|DD      |        |        |  DAACD |        |  5457  |        |  5457  |        |        |  666666|6767    |
; | D      |        |        |        |        |        |        |        |        |  5457  |        |  5457  |        |        |  55556 |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |  55557 |        |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |  777446|6767    |
; |        |        |        |        |        |        | E   E  |        |E E  E  |   E    |E   E   |    E   | E   E  |        |  EEEE54|4645D   |
; | EEEEE  |ED   E  |  E     |        |   EEEE |  E   E |EEE EEE |  E     |EEEE EEE| E ED   |DE  ED  | E EEEE |EEE EEE | E      |  6666EE|E5E5CD  |
; |  DDDED |ED  DED |  ED    |E     E | E  EDED| EDD  ED| EDD EDD|  DEE   |EDEDED E| EDED   | DEEEEE | EDDEDED| EDD EDD| ED     |  444444|4645CD  |
; |     ED |EDEEEEE |EEEEEEE | E    ED| ED EDED| ED   ED|EEE EEE |    DD  |EEEEDEDE| EEEEE  |E  DEDDD|EDDEEEEE|EEE EEE | ED     |  555555|5756D   |
; | E   ED |ED   EDD| DEDDDED| ED   ED|EEE EDED| ED   ED| EDD EDD| EEEEE  |DEDED ED|EEDEDDD |DE  ED  | D DEDED|DEDD EDD| ED     |  666666|6767    |
; | ED  ED |ED   ED |  ED  ED|  D  EDD| EDDEDED| ED   ED|EDEDEDE |  DDEDD |EEDEDEDE| DDED   | DEEEEE | E  EDED|  EEE D | ED     |   777  |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |  EDEDD |ED   ED |  ED  ED|     ED | ED EDED| EED  ED| D D D D|   EDD  | EEEEEED|EEEEEEE |   DEDDD| EDEEEED|   DDD  | ED     |        |        |
; |  EDED  |ED   ED | EDD  ED|    EDD | ED EDED|  DD  ED| EEEEE  |  EEE   |  EEEDDD| DDDDDDD| E  ED  |EED EDDD| EEEEE  | ED   E |    E E |        |
; |   EDD  |ED EEEE | ED   ED|    ED  | EE EDED|     EDD| EDDDED | EDDED  |  DEEE  | EEEEE  | EDEDDE |DEDEEEE |   EDDD | ED   ED|    EDED|        |
; |   ED   |EDEDDEDD| ED   ED|   EDD  | EDDEDED|     ED | EEE ED |EDD ED  | EEEEEE | EDDDED |EDDED ED| ED EDDD| E EDE  | ED  EDD| E   D D|  EEE   |
; |  EDED  |ED EEDD |EDD EEDD|  EDD   |  DEDDED|    EDD | EDDDED |ED   EE | ED   ED| ED  ED |ED EEEED| EDEEEE | EDEDED |  EEEDD | ED     |  E ED  |
; | EDD EE | D  DD  | D   DD |   D    |  EDDEED|     D  | EEEEED | D    DD| EEEEEED| EEEEED |EDEEDDED| ED EDDD|EDDED E |   DDD  | ED     |  EEED  |
; |  D   DD|        |        |        |   D  DD|        |  DDDDD |        |  DDDDDD|  DDDDD | D DD  D|  D  D  | D  D  D|        | ED     |   DDD  |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        | ED     |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |        |        |        |        |        |        |   E    |        |        |        |        |
; |        |        |        |        |        |    E   |        |EEEEE   | E EEEE | E  E E |    EEE | EEEEE  |        |   ED   |        |        |
; |  EE    | E      |        |        |    E   |    ED  |     E  | EDEDD  | ED EDED| E  EDED|    EDED|  DEDED |  E     |  ED ED |   EEEE |        |
; |   DEE  | ED EE  |EEEEEEE |E       | EEEEEE |EEEEEEE |    EDD | EDEEEE | ED EDED|EEEEEEE |EEE EDED|EEEEEEE |  ED    | EEEEEED|EEE EDED|  EEE   |
; |    DDD |EEDEDDE | DDDEDDD|ED   E  |  DDEDDD| DDDEDDD|   EDD  | EEEDDED|EEE EDED| DDEDDED|EDEDEEED| DDEDEDD|EEEEEE  |  DEDDDD|EDEDEDED| EDEDE  |
; | E      | EEDD ED|   EDD  |ED   DE |    ED  |    ED  |  EDD   | EDED ED| EDDEEDD|EE ED ED|EDEDEDED| EEEEED | DEDDDD |EEEEEEE |EDEDEDED|EDDEDDE |
; | EDEEE  | EED  ED|  EDD   |ED    ED| EEEEEE |  EEED  | EDD    | EEEE ED| ED EEE | DDED ED|EEEDEDED|  DEDDD | EEE EE | DEDEDDD|EEED D D|ED ED ED|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | EEDDDE |EEDD EDD|  ED    |ED    ED|  DDEDDD| EDDED  | ED     | EDEEDED| ED EDED|EE EEEED|EDEDEDED| EEEEED |EDDEEDDD| ED  ED |EDEDEEE |ED ED ED|
; | EDD  ED|EED  ED |  ED    |ED    ED|    ED  | ED ED  |  E     | EEEEDED| EE EDED| DD DEDD|EDEDEEED|EEEEEEE | DEEDD  |EDEED ED|EDEDEDED|EDEDD ED|
; |  D   ED| ED  ED |  ED    |EDE   ED| EEEEED |  EEED  |  DE    |EEDE EDD|EEDDEDED|EE E ED |EEEDEDED| EDDDEDD| EDED   |D   ED D|EEEDEEED|EDED  ED|
; |     EDD| ED  ED |   E    | EDD   D|EDDDEDED|   DED  |   DE   | DDEDED | EDEDEED|DEDEDED | DDED ED| EEEEED | ED D   |  EEDD  | DDD DDD| EDD EDD|
; |   EEDD | ED   ED|    EE  | ED     | EEEDD D|  EEDD  |    DE  |   EEDE | EDEDEDD|DEDEDED |   ED ED| EDDDED |  EEEEE |   DDE  |E E E E |  D EDD |
; |    DD  |  D    D|     DD |  D     |  DDD   |   DD   |     DD |   EDD D| EEDEDED|EEEDDEE |  EDDEED| EEEEED |   DDDDD|  EEEDD |EDEDEDED|     D  |
; |        |        |        |        |        |        |        |    D   |   D D D| DDD  DD|   D  DD|  DDDDD |        |   DDD  | D D D D|        |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |       2|       2|11111111|44444445|44444442|23222222|11111112|       7|66666666|9999999A|99999997|78777777|66666667|       C|BBBBBBBB|21111111|
; |      21|      21|11111111|44444452|44444421|12322222|11111121|      76|66666666|999999A7|19999976|67877777|66666676|      CB|BBBBBBBB|22111111|
; |     211|     211|11111111|44444522|44444211|11232222|11111211|     766|66666666|99999A77|11999766|66787777|66666766|     CBB|BBBBBBBB|22211111|
; |    2111|    2111|11111111|44445222|44442111|11123222|11112111|    7666|66666666|9999A777|11197666|66678777|66667666|    CBBB|BBBBBBBB|22221111|
; |   21111|   21111|11111111|44452222|44421111|11112322|11121111|   76666|66666666|999A7777|11976666|66667877|66676666|   CBBBB|BBBBBBBB|22222111|
; |  211111|  211111|11111111|44522222|44211111|11111232|11211111|  766666|66666666|99A77777|19766666|66666787|66766666|  CBBBBB|BBBBBBBB|22222211|
; | 2111111| 2111111|11111111|45222222|42111111|11111123|12111111| 7666666|66666666|9A777777|97666666|66666678|67666666| CBBBBBB|BBBBBBBB|22222221|
; |21111111|21111111|11111111|52222222|21111111|11111112|21111111|76666666|66666666|A7777777|76666666|66666667|76666666|CBBBBBBB|BBBBBBBB|22222222|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |11111111|32222222|32222222|44444445|EEEEEEEF|76666666|66666666|66666667|87777777|87777777|9999999A|CBBBBBBB|BBBBBBBB|32222222|33333333|44444445|
; |11111111|43222222|1322222 |44444451|EEEEEEF1|77666666|66666666|66666679|98777777|68777777|999999A6|CCBBBBBB|BBBBBBBB| 3222222|33333333|4444445 |
; |11111111|44322222|113222  |44444511|EEEEEF11|77766666|66666666|66666799|99877777|66877777|99999A66|CCCBBBBB|BBBBBBBB|  322222|33333333|444445  |
; |11111111|44432222|11132   |44445111|EEEEF111|77776666|66666666|66667999|99987777|66687777|9999A666|CCCCBBBB|BBBBBBBB|   32222|33333333|44445   |
; |11111111|44443222|11113   |44451111|EEEF1111|77777666|66666666|66679999|99998777|66668777|999A6666|CCCCCBBB|BBBBBBBB|    3222|33333333|4445    |
; |11111111|44444322|111113  |44511111|EEF11111|77777766|66666666|66799999|99999877|66666877|99A66666|CCCCCCBB|BBBBBBBB|     322|33333333|445     |
; |11111111|44444432|1111113 |45111111|EF111111|77777776|66666666|67999999|99999987|66666687|9A666666|CCCCCCCB|BBBBBBBB|      32|33333333|45      |
; |22222222|44444443|11111113|51111111|F1111111|77777777|77777777|79999999|99999998|66666668|A6666666|CCCCCCCC|CCCCCCCC|       3|33333333|5       |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |22222222|44444444|87777777|88888888|9999999A|77777777|99999999|DCCCCCCC|DDDDDDDD|EEEEEEEF|6EEEEEEC|CDCCCCD6|BBBBBBBC|99999992|27777777|EEEEEEE7|
; |22222222|44444444| 8777777|88888888|999999A |77777777|99999999| DCCCCCC|DDDDDDDD|EEEEEEFC|66EEEECB|BCDCCD66|BBBBBBCB|99999921|12777777|EEEEEE76|
; |22222222|44444444|  877777|88888888|99999A  |77777777|99999999|  DCCCCC|DDDDDDDD|EEEEEFCC|666EECBB|BBCDD666|BBBBBCBB|99999211|11277777|EEEEE766|
; |22222222|44444444|   87777|88888888|9999A   |77777777|99999999|   DCCCC|DDDDDDDD|EEEEFCCC|666ECBBB|BBBCD666|BBBBCBBB|99992111|11127777|EEEE7666|
; |22222222|44444444|    8777|88888888|999A    |77777777|99999999|    DCCC|DDDDDDDD|EEEFCCCC|66ECBBBB|BBBBCD66|BBBCBBBB|99921111|11112777|EEE76666|
; |22222222|44444444|     877|88888888|99A     |77777777|99999999|     DCC|DDDDDDDD|EEFCCCCC|6ECBBBBB|BBBBBCD6|BBCBBBBB|99211111|11111277|EE766666|
; |22222222|44444444|      87|88888888|9A      |77777777|99999999|      DC|DDDDDDDD|EFCCCCCC|ECBBBBBB|BBBBBBCD|BCBBBBBB|92111111|11111127|E7666666|
; |22222222|44444444|       8|88888888|A       |77777777|99999999|       D|DDDDDDDD|FCCCCCCC|CBBBBBBB|BBBBBBBC|CBBBBBBB|21111111|11111112|76666666|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |7CCCCCCC|9999999C|C7777777|8666666C|1111111C|BBBBBBBC|DCCCCCCC|DCCCCCC | EEEEEEF|6666666C|C      7|EEEEEEEF|CCCCCCCC|EEEEEEEE|32222222|44444445|
; |67CCCCCC|999999CB|BC777777|686666CB|111111CB|BBBBBBCE|EDCCCCCC|BDCCCC  |  EEEEFB|666666CB|BC    76|EEEEEEF |CCCCCCCC|EEEEEEEE|63222222|44444456|
; |667CCCCC|99999CBB|BBC77777|66866CBB|11111CBB|BBBBBCEE|EEDCCCCC|BBDCC   |   EEFBB|66666CBB|BBC  766|EEEEEF  |CCCCCCCC|EEEEEEEE|66322222|44444566|
; |6667CCCC|9999CBBB|BBBC7777|6668CBBB|1111CBBB|BBBBCEEE|EEEDCCCC|BBBD    |    FBBB|6666CBBB|BBBC7666|EEEEF   |CCCCCCCC|EEEEEEEE|66632222|44445666|
; |66667CCC|999CBBBB|BBBBC777|666CBBBB|111CBBBB|BBBCEEEE|EEEEDCCC|BBBBD   |   FBBBB|666CBBBB|BBBBC666|EEEF    |CCCCCCCC|EEEEEEEE|66663222|44456666|
; |666667CC|99CBBBBB|BBBBBC77|66CBBBBB|11CBBBBB|BBCEEEEE|EEEEEDCC|BBBBBD  |  FBBBBB|66CBBBBB|BBBBBC66|EEF     |CCCCCCCC|EEEEEEEE|66666322|44566666|
; |6666667C|9CBBBBBB|BBBBBBC7|6CBBBBBB|1CBBBBBB|BCEEEEEE|EEEEEEDC|BBBBBBD | FBBBBBB|6CBBBBBB|BBBBBBC6|EF      |CCCCCCCC|EEEEEEEE|66666632|45666666|
; |66666667|CBBBBBBB|BBBBBBBC|CBBBBBBB|CBBBBBBB|CEEEEEEE|EEEEEEED|BBBBBBBD|FBBBBBBB|CBBBBBBB|BBBBBBBC|F       |CCCCCCCC|EEEEEEEE|66666663|56666666|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |87777777|9999999A|DCCCCCCC|EEEEEEEF|DCCCCCCC|EEEEEEEF|DCCCCCCC|        |        |        |        |        |        |        |        |        |
; |B8777777|999999AB|6DCCCCCC|EEEEEEF6|7DCCCCCC|EEEEEEF9|1DCCCCCC|        |        |        |        |        |        |        |        |        |
; |BB877777|99999ABB|66DCCCCC|EEEEEF66|77DCCCCC|EEEEEF99|11DCCCCC|        |        |        |        |        |        |        |        |        |
; |BBB87777|9999ABBB|666DCCCC|EEEEF666|777DCCCC|EEEEF999|111DCCCC|        |        |        |        |        |        |        |        |        |
; |BBBB8777|999ABBBB|6666DCCC|EEEF6666|7777DCCC|EEEF9999|1111DCCC|        |        |        |        |        |        |        |        |        |
; |BBBBB877|99ABBBBB|66666DCC|EEF66666|77777DCC|EEF99999|11111DCC|        |        |        |        |        |        |        |        |        |
; |BBBBBB87|9ABBBBBB|666666DC|EF666666|777777DC|EF999999|111111DC|        |        |        |        |        |        |        |        |        |
; |BBBBBBB8|ABBBBBBB|6666666D|F6666666|7777777D|F9999999|1111111D|        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | FBCCF  |F FFFF F|   D    |  FFFF  |  FFFF  |  F   F |  1111  |        |        |        |        |        |        |        |        |        |
; |FBACBCF |4F4456F5|  D9D   | FA99AF | 5EEEE5 | F1F F1F| 1BBBB1 |        |        |        |        |        |        |        |        |        |
; |BA9CBBCF|F444456F| D9ABD  |FA9889AF| BEBBEB | F11F11F| 1B111  |        |        |        |        |        |        |        |        |        |
; |A1CAC3CF|FF4456FF| DBCCD  |F98E889F| BEBEEB | F11111F| 1BBB1  |        |        |        |        |        |        |        |        |        |
; |A1E123CF|F8FFFD8F| D9ABD  |FA9889AF| BEEBEB | F1F1F1F| 1B111  |        |        |        |        |        |        |        |        |        |
; |4A112B4F| F6456F |D9A9BAD | FA99AF | BEBBEB | F1FFF1F| 1BBBB1 |        |        |        |        |        |        |        |        |        |
; |F4A4B4F |  F45F  |D9D9DAD |  FFFF  | 5EEEE5 |  F   F |  1111  |        |        |        |        |        |        |        |        |        |
; | FBACF  |   FF   |DD D DD |        |FFFFFFFF|        |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
;                            |        |        |        |   88777|77777777|7888    |        |        |        |        |
;                            |        |        |        |77766665|55555666|6677788 |        |        |        |        |
;                            |        |        |    7776|55554444|44444555|55555667|88      |        |        |        |
;                            |        |        | 7776655|44444333|33444444|44455555|5568    |        |        |        |
;                            |   9    |       7|76555554|33333433|33333344|55545444|445557  |        |   A    |   B    |
;                            |        |     776|65444444|43333334|33334344|44543222|23445566|        |        |        |
;                            |        |    7655|44233444|44332232|22333344|44432223|44445555|68      |        |        |
;                            |        |  766544|33442324|44422211|12222333|32323223|33333455|566     |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
;                            |        |76545545|53322112|11111111|11111224|55431123|
;                            |       7|65666654|54432111|21111111|11111123|33331113|
;                            |       6|66766654|54332111|12211111|11111112|33321111|
;                            |      76|77776664|45432211|11222211|21111112|12211111|
;                            |     767|77766564|35433221|11122112|22111111|11111111|
;                            |    8667|75766554|14543222|22222111|22111111|11111111|
;                            |   87776|67565543|22444321|11122212|12221211|11111111|
;                            |   77776|E7655543|22334422|22213333|31113321|11111211|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
;                   |        | 7655442|22323112|22224111|11112333|34433322|22334444|55568   |        |
;                   |       7|76542433|32334221|21244222|11222223|44444333|32223344|4555578 |        |
;                   |      77|65542223|12223433|33322444|22233333|33344433|33222344|44454578|        |
;                   |     766|65433322|11111244|34443222|44444334|44544443|33332244|44444445|8       |
;                   |    7666|55332312|21121124|44554321|11333443|44554454|34334444|43333444|57      |
;                   |   76555|53332211|12111113|44554433|24333344|55443345|44444442|33332333|447     |
;                   |  765554|44333111|11111112|33422344|33322225|54433244|44443222|33444233|3447    |
;                   | 7654455|43221111|11111111|11111224|45411124|54432124|54433323|33443323|33347   |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |  87776E|E6554432|31223442|11222134|32111331|11111121|43431124|54443334|44344322|223347  |        |
; |        |  77676E|76555432|32123333|21112223|43321111|21221112|32444235|44444444|33434432|2223348 |        |
; |        | 77657E7|65545432|32112332|21121212|44132222|11231112|23344442|33334333|33333443|21123348|        |
; |        |87767776|65444433|32212233|22121221|23134422|21112113|11224223|22322333|22333444|21121245|8       |
; |        |77657766|55444333|22211223|32211131|13144433|32212113|11123111|11121122|22233333|22332124|5       |
; |       8|76567765|54444333|22111123|33332131|13314444|33213112|11113311|11112122|22233444|23433334|46      |
; |       7|76567665|54543343|22111122|23333332|12332455|33322221|11111312|22111111|21223444|34434444|558     |
; |       7|67677655|44533343|22111111|22344432|22433455|44332322|11111131|12211111|11123233|33334445|5568    |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |      77|67666665|45433443|22221111|11234443|33444566|55333332|23433222|12223322|11112211|12322233|
; |      76|76566655|55444443|32222111|11233334|24445556|65444443|22343332|21222232|22111221|11222224|
; |     876|76555555|55544433|33322211|11122322|33444455|66543344|44344332|22333223|22222211|11334433|
; |     776|66545554|44554333|44322221|11112332|33334454|55544433|44444444|43333333|33322232|12233344|
; |    8776|66545543|33433444|44333221|11112231|12333344|44555542|33444445|44444444|33333443|33244333|
; |    8777|67554554|33344555|44444322|22221231|12223333|33334554|22334444|45554444|44444444|33344444|
; |    7777|67554554|44445555|54444433|22111131|11132333|33233335|55444434|44455555|54444554|44443455|
; |    7767|66554455|45545555|55554443|32221132|11111233|33222334|44333333|34444555|55555455|44555444|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
;                                     |11111131|11122111|11113333|33334445|55568   |
;                                     |11111113|11111221|11111233|33334555|55568   |
;                                     |12112213|11111121|11111122|24445444|455668  |
;                                     |22121113|31111112|11111113|34334455|555667  |
;                                     |32121221|13221111|21111112|22344554|4455668 |
;                                     |33112112|21322111|12111112|22344455|55556678|
;                                     |33212112|22232211|12211112|23224444|45555668|
;                                     |14322221|12213221|11222111|21113334|44455568|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |   87877|76665445|54346666|56555444|43332233|21111111|11111223|33333333|33344445|56555655|55445555|        |44555666|8       |
; |   7877E|E7656444|33455677|66665544|44433223|22211111|22323332|22333323|33334544|56666665|55555655|        |35545566|8       |
; |   787EE|E7756544|43445656|66666655|44444322|23312332|32232444|42223333|43445533|34556666|65655666|   DD   |44455566|68      |
; |   877E7|E7776554|55554555|56666665|55544433|22323443|44334454|42322434|43454345|55666555|66666555|  DBBD  |44445556|68      |
; |   E7EE7|EE776665|64454456|66666666|65554444|42233443|44444564|44455544|33545455|66654556|55566665|  DBBD  |34444566|68      |
; |  877E87|EE776665|65466555|66667677|66655444|43244443|55554564|44553332|33454556|65444455|66666677|   DD   |44445566|668     |
; |  877E76|EE776666|65656566|67767777|67665554|54344445|54554456|45544444|44445556|54566545|56666666|        |45455566|668     |
; |  87EE76|8E777666|56757656|77766777|77776666|64444444|55555566|66455542|45244455|45655765|57767777|        |55555665|668     |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |  87EE87|8EE77667|67776657|66766777|77767776|65445555|55555567|76644444|44244555|45555556|65776766|77776666|66678   |   DD   |55555667|6688    |
; |  87EE87|8EEE7777|67755675|66766776|77776777|66555666|66556667|76555444|44524555|55555565|76677777|66667776|66678   | DDCCDD |55556676|6688    |
; |  87EEFE|8EEE6776|76657676|67766776|66777777|76556777|77666777|76655455|54545555|55455566|675677E7|77777777|76778   | DCBBCD |56666656|6678    |
; |  87EEFE|FEEEEE67|77756776|77767766|56677777|77666777|77777777|65555545|54554455|54455565|576577EE|EE777767|77778   |DCB99BCD|66666566|6668    |
; |  87EEFE|FEEE7667|77567777|77667565|55666677|77777777|77677667|66556555|55455444|44555666|57767E77|7EEEE777|677E8   |DCB99BCD|55555565|6668    |
; |  8EEEFF|FEEE77E7|76677777|76676654|43455556|67777777|77777767|E7665555|66545555|55556666|67767EE7|777EEE77|77778   | DCBBCD |77776656|6668    |
; |  8EEEFF|FEEEE7E7|66E77777|77776665|44333455|56766666|655677E7|77776656|55655556|55567677|677777EE|7777EEEE|7E7E8   | DDCCDD |66667777|66688   |
; |  88EEEF|FEEEE776|67EE77E7|77767665|55455433|35565677|EEEE656E|EE777776|66655665|66667776|E77677EE|7777EEEE|EEE88   |   DD   |66666656|77778   |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |  878EEF|FEEEEE76|6EEE7EE7|77677666|56566443|34455657|67EEE76E|EEEEE777|77666666|66677667|E767E7EE|E7767EEE|EEE8    |
; |  878EEF|FE8EEE7E|E7E7EEEE|77777676|66666654|34456667|777EEE77|EE77EEEE|77776666|66677677|E767E7EE|E776777E|EEE8    |
; |   8888F|FE8EE7E7|7E7EEEEE|77776777|66656655|45565656|67EEE767|777667EE|EE777777|77777777|E777E7EE|E777777E|EEE8    |
; |   788FF|FEFEEEEE|EEEE7EEE|77777776|76766655|65656566|67EEEEEE|EE77777E|7E777777|7777777E|E7EEE7EE|EE777E77|EEE8    |
; |   878FF|FFE8EEE7|EEE7EEEE|77E77776|77676656|65566665|6677EEE6|7777777E|76677777|7777777E|E7EE7EEE|EE7E7EE7|EEE8    |
; |   878FF|FFFFEEEE|E7EEEEE7|EE7E77E7|76776666|66666675|567666EE|EEE77777|77777EEE|E8777EEE|7EEEE8EE|7E7EEEE7|7EE8    |
; |   888FF|FFFFEEEE|E7EEEE7E|E7E7EE77|777E6656|57776776|7666766E|EE8EEE7E|EE7E8888|EEEEEEE7|EEEEE8EE|E7EEEEE7|EEE8    |
; |    78FF|FFFFEEEE|EEEEE7EE|E77EEEE7|E77E7EE7|777777E7|77E77766|6EE77777|E8E88888|88EEE87E|E8EE8EE8|EEE7EEEE|EE8     |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |    88EF|FFFFFEEE|EEEEEEEE|EEEE7E7E|7EEEEEEE|77EE7777|777EE76E|66EE77EE|77777777|78EEEEE8|88EE8EE8|EEEEEEEE|EE8     |  888888|88888888|888888EE|
; |    888F|FFFFF8EE|EEEEEEEE|EEE7EEEE|7EEEEEEE|EE7E777E|77EEE878|EEE87766|77777766|67888EEE|8EE8EE88|EEEEEEEE|EE8     |   88888|88888888|88888888|
; |     EEF|FFFFF8EE|EEEEEEEE|EE7EEEEE|EEE7EEEE|EEEEEEE7|77EE8E7E|8866E777|6666E7EE|766EE88E|888EEE88|EEEEEEEE|EE      |   88888|88888888|88888888|
; |     E88|8FFFF8EE|FEEEEEEE|EEEEEE7E|EEEEEEEE|EEEEEEEE|E7EE88E8|777EEEE7|76767EE7|77777EE7|7888E888|EEEEEEEE|E8      |    888F|FFF88888|88888888|
; |     888|8FFFF8FE|EFEEEFEE|EEEEEEEE|EEEEEEEE|EEEEEEEE|EEEE8888|EEEEEEEE|E7777777|EEEE7EE7|7888888E|EEEEEEEE|E8      |     888|8FF88888|88888888|
; |      8F|888FFFFF|EFEEEFEE|FEEFEEEE|EEEEEEEE|88888888|8EEE8888|88EEEEEE|EE77E777|EEEEE777|7878888E|EEEEE8EE|88      |     888|88F88888|8888FFF8|
; |      88|888F8FEF|8FFFEFEF|EFEEE8EE|EEEEEEEE|88888888|888E8888|F8EEEEEE|7777777E|EEEEEE77|8887888E|EEF8EFEE|8       |      88|888F8888|88888888|
; |      88|8888FF8F|EFE8EFFE|FFFF8EE8|EEEEEEEE|88F8E888|88888888|88FEEEEE|EE77777E|EFFF7E77|88878888|8F888FE8|8       |       8|88888888|F8888888|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |       8|8888F8FF|8FEF8FEF|FFEFEEF8|EEEEEEEE|E8F888F8|E8E88888|888E8EEE|EEEE7EEE|88F87E7E|88788888|8F88EFE8|        |        |8888888F|8F8F8888|
; |       8|88888F8F|88FEFF88|F8EE88FE|EEEEEEEE|E8F8FFFF|E8E88888|8F8EEEEE|EEEEEEE8|88FF7EE8|87778888|8F88FE88|        |        | 88888FF|8F88F888|
; |       8|888888FF|888F8FF8|F8FEEEF8|8EEEEEEE|E88888FF|88888888|888E88EE|E8EEEE88|88FFE8E8|87788888|FFFFE888|        |        |  888888|8FFF8FF8|
; |        |88888888|888F8F8F|8FFEEEF8|888EE8EE|EEE8E8F8|888EE888|888888F8|E8EE8888|8FF87E88|8EE8888F|8FF8888 |        |        |   88888|F88888FF|
; |        |88888888|8888F8F8|88FE88EF|888EEEE8|E8EEE8E8|E88EE888|888888F8|EEE88888|E8787E88|887888F8|FF8888  |        |        |    8888|FF8888FF|
; |        | 8888888|88888FF8|88EFE88E|88E8EEEE|8EEE888E|88E88888|88888888|EE88888E|7787E888|88888FFF|FF888   |        |        |     888|8FFF8888|
; |        | 8888888|8888888F|FEEE8E88|8888E8E8|EE88F888|88E88888|8F888888|EE8888EE|E8EEE888|87888FFF|F8888   |        |        |      88|8888FFF8|
; |        |  888888|88888888|88888EEE|888EE888|E88E888E|8EE88888|88888888|888888EE|EE888888|8888FFFF|F888    |        |        |       8|8F88FFF8|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |88E88E88|88888888|8E888888|88888888|8888888E|8E888888|888FFFFF|8888    | 88888F8|F8FFFFFF|8F888888|88888888|88888888|88888888|888     |3333333 |
; |E888EEE8|88888E88|88888888|88888888|88888888|88888888|88FFFFFF|888     |   88888|8FFFFFFF|FFFF8888|88888FF8|88888888|88888888|8       |31111133|
; |8EEE8888|88E8E88E|888E8888|88888888|88888888|88888888|88FFFFF8|88      |     888|8FFFFFFF|FFFFF888|88888888|8FFF8888|88888888|        |31133113|
; |88888888|8E888888|88888888|88888888|88888888|88888888|FFFFFF88|8       |        |888FFFFF|F8FFFFFF|88888888|FFFF8888|888888  |        |31111133|
; |88888888|88888888|88888888|88888888|88888888|88888888|FFFFF888|8       |        |  8888FF|F88FF8FF|F8FFF88F|FFFF8888|8888    |        |3113333 |
; |88888888|88888888|88888888|88888888|88888888|88888888|FFF8888 |        |        |     888|8FFF888F|F8888888|FF888888|88      |        |3113    |
; |88888888|88888888|88888888|88888888|88888888|8888888F|FFF8888 |        |        |        |F8888888|88888888|888888  |        |        |3113    |
; |88888888|88888888|88888888|88888888|88888888|8888888F|F88888  |        |        |        |     888|8888888F|88      |        |        |3333    |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |88888888|88888888|88888888|88888888|88888888|8888888F|88888   |3333    | 333333 |333 3333|33333333|33333333|33333333| 333333 | 333333 |
; |88888888|88888888|88888888|88888888|88888888|88888FF8|8888    |3113    |33111133|31333113|31111113|31111113|31111113|31111133|33111113|
; |88888888|88888888|88888888|88888888|88888888|8888F888|888     |3113    |31133113|31133113|31133333|33311333|33333113|31133113|31133333|
; |FF888888|88888888|88888888|88888888|88888888|8888F888|88      |3113    |31133113|31113113|3111113 |  3113  |  31133 |31111133|3311133 |
; |8F888888|88888888|88888888|88888888|88888888|888F8888|8       |3113    |31111113|31131113|3113333 |  3113  | 31133  |31133113| 3311133|
; |88FFFF88|88F88888|88888888|88888888|88888888|8888888 |        |3113333 |31133113|31133113|31133333|  3113  |31133333|31133113|33333113|
; |888FFFFF|8F88FF8F|F8888888|88888888|88888888|888888  |        |31111113|31133113|311 3313|31111113|  3113  |31111113|31111133|31111133|
; |88FFFFFF|FF888F8F|8F88888F|88888888|88888888|88888   |        |3333333 |33333333|333  333|33333333|  3333  |33333333|3333333 | 333333 |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |   333  |        |        |        |        |        |
; |   3131 |        |   33333|        |   33333|        |
; |33331333|33333333|   31313|        |   31313|        |
; |11111113|31111113|33331313|        |   31313|        |
; |33331333|31333313|31333333|        | 3333333|3333333 |
; |1111313 |31111113|31333333|        |33133   |1111113 |
; |1331313 |31333313|11111113|        |313133  |3333313 |
; |11113313|31111113|31333133|33333333|3133133 |   3133 |
; |--------|--------|--------|--------|--------|--------|--------|
; |33333333|31331333|31333133|31111113|1333313 |  3313  |   D    |
; |11131313|11111113|3133133 |33333333|13  3133|  3133  |  DCD   |
; |33331313|13331333|313333  |        |33  3313| 331133 | DCBCD  |
; |13133333|33111113|313     |        |     313|33133133|DCB9BCD |
; |13133313|33331333|31333333|        |     313|31333313| DCBCD  |
; |13111113|11111111|33111113|        |     333|133  313|  DCD   |
; |33333333|33333333| 3333333|        |        |33   333|   D    |
; |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|

$8E:8000             db 00,00,00,00,00,3C,18,66,11,66,11,66,11,66,11,66,00,00,00,00,3C,3C,7E,7E,77,77,77,77,77,77,77,77,
                        00,00,00,00,00,18,04,18,04,38,04,18,04,18,04,18,00,00,00,00,18,18,1C,1C,3C,3C,1C,1C,1C,1C,1C,1C,
                        00,00,00,00,00,3C,18,66,11,66,11,66,31,06,03,0C,00,00,00,00,3C,3C,7E,7E,77,77,77,77,37,37,0F,0F,
                        00,00,00,00,00,3C,18,66,11,66,31,06,01,06,03,3C,00,00,00,00,3C,3C,7E,7E,77,77,37,37,07,07,3F,3F,
                        00,00,00,00,00,0C,02,0C,02,1C,02,1C,12,2C,12,2C,00,00,00,00,0C,0C,0E,0E,1E,1E,1E,1E,3E,3E,3E,3E,
                        00,00,00,00,00,7E,1F,60,10,60,10,60,00,7C,18,66,00,00,00,00,7E,7E,7F,7F,70,70,70,70,7C,7C,7E,7E,
                        00,00,00,00,00,3C,18,66,11,66,13,60,10,60,00,7C,00,00,00,00,3C,3C,7E,7E,77,77,73,73,70,70,7C,7C,
                        00,00,00,00,00,7E,19,66,11,66,31,06,03,0C,02,0C,00,00,00,00,7E,7E,7F,7F,77,77,37,37,0F,0F,0E,0E,
                        00,00,00,00,00,3C,18,66,11,66,11,66,11,66,03,3C,00,00,00,00,3C,3C,7E,7E,77,77,77,77,77,77,3F,3F,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,18,00,3C,18,66,11,66,11,66,11,66,00,00,00,00,18,18,3C,3C,7E,7E,77,77,77,77,77,77,
                        00,00,00,00,00,7C,18,66,11,66,11,66,11,66,03,7C,00,00,00,00,7C,7C,7E,7E,77,77,77,77,77,77,7F,7F,
                        00,00,00,00,00,3C,18,66,11,66,11,66,13,60,10,60,00,00,00,00,3C,3C,7E,7E,77,77,77,77,73,73,70,70,
                        00,00,00,00,00,7C,18,66,11,66,11,66,11,66,11,66,00,00,00,00,7C,7C,7E,7E,77,77,77,77,77,77,77,77,
                        00,00,00,00,00,7E,1F,60,10,60,10,60,10,60,00,7E,00,00,00,00,7E,7E,7F,7F,70,70,70,70,70,70,7E,7E,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        11,66,11,66,11,66,11,66,11,66,03,3C,3E,00,00,00,77,77,77,77,77,77,77,77,77,77,3F,3F,3E,3E,00,00,
                        04,18,04,18,04,18,04,18,04,18,04,18,1C,00,00,00,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,00,00,
                        06,18,0C,30,18,60,10,60,10,60,00,7E,3F,00,00,00,1E,1E,3C,3C,78,78,70,70,70,70,7E,7E,3F,3F,00,00,
                        18,06,01,06,01,06,01,66,11,66,03,3C,1E,00,00,00,1E,1E,07,07,07,07,67,67,77,77,3F,3F,1E,1E,00,00,
                        12,2C,12,6C,12,6C,00,7E,33,0C,02,0C,06,00,00,00,3E,3E,7E,7E,7E,7E,7E,7E,3F,3F,0E,0E,06,06,00,00,
                        11,66,31,06,01,06,01,66,11,66,03,3C,1E,00,00,00,77,77,37,37,07,07,67,67,77,77,3F,3F,1E,1E,00,00,
                        10,66,11,66,11,66,11,66,11,66,03,3C,1E,00,00,00,76,76,77,77,77,77,77,77,77,77,3F,3F,1E,1E,00,00,
                        06,18,04,18,04,18,04,18,04,18,04,18,0C,00,00,00,1E,1E,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,0C,0C,00,00,
                        18,66,11,66,11,66,11,66,11,66,03,3C,1E,00,00,00,7E,7E,77,77,77,77,77,77,77,77,3F,3F,1E,1E,00,00,
                        01,3E,19,06,01,06,11,66,11,66,03,3C,1E,00,00,00,3F,3F,1F,1F,07,07,77,77,77,77,3F,3F,1E,1E,00,00,
                        11,66,01,7E,19,66,11,66,11,66,11,66,33,00,00,00,77,77,7F,7F,7F,7F,77,77,77,77,77,77,33,33,00,00,
                        18,66,11,66,11,66,11,66,11,66,03,7C,3E,00,00,00,7E,7E,77,77,77,77,77,77,77,77,7F,7F,3E,3E,00,00,
                        10,60,10,60,10,66,11,66,11,66,03,3C,1E,00,00,00,70,70,70,70,76,76,77,77,77,77,3F,3F,1E,1E,00,00,
                        11,66,11,66,11,66,11,66,11,66,03,7C,3E,00,00,00,77,77,77,77,77,77,77,77,77,77,7F,7F,3E,3E,00,00,
                        1F,60,10,60,10,60,10,60,10,60,00,7E,3F,00,00,00,7F,7F,70,70,70,70,70,70,70,70,7E,7E,3F,3F,00,00,
                        1F,60,10,60,10,60,10,60,10,60,10,60,30,00,00,00,7F,7F,70,70,70,70,70,70,70,70,70,70,30,30,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,66,11,66,11,66,11,66,11,66,01,7E,00,00,00,00,66,66,77,77,77,77,77,77,77,77,7F,7F,
                        00,00,00,00,00,18,04,18,04,18,04,18,04,18,04,18,00,00,00,00,18,18,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,
                        00,00,00,00,00,06,01,06,01,06,01,06,01,06,01,06,00,00,00,00,06,06,07,07,07,07,07,07,07,07,07,07,
                        00,00,00,00,00,66,11,66,11,66,13,6C,12,6C,06,78,00,00,00,00,66,66,77,77,77,77,7F,7F,7E,7E,7E,7E,
                        00,00,00,00,00,60,10,60,10,60,10,60,10,60,10,60,00,00,00,00,60,60,70,70,70,70,70,70,70,70,70,70,
                        00,00,00,00,00,82,01,C6,21,C6,11,EE,01,FE,29,D6,00,00,00,00,82,82,C7,C7,E7,E7,FF,FF,FF,FF,FF,FF,
                        00,00,00,00,00,C6,21,C6,01,E6,11,E6,01,F6,29,D6,00,00,00,00,C6,C6,E7,E7,E7,E7,F7,F7,F7,F7,FF,FF,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,3C,18,66,11,66,11,66,13,60,00,38,00,00,00,00,3C,3C,7E,7E,77,77,77,77,73,73,38,38,
                        00,00,00,00,00,7E,27,18,04,18,04,18,04,18,04,18,00,00,00,00,7E,7E,3F,3F,1C,1C,1C,1C,1C,1C,1C,1C,
                        00,00,00,00,00,66,11,66,11,66,11,66,11,66,11,66,00,00,00,00,66,66,77,77,77,77,77,77,77,77,77,77,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,C6,21,C6,21,C6,21,C6,21,D6,21,D6,00,00,00,00,C6,C6,E7,E7,E7,E7,E7,E7,F7,F7,F7,F7,
                        10,6E,11,66,11,66,11,66,11,66,01,3E,1F,00,00,00,7E,7E,77,77,77,77,77,77,77,77,3F,3F,1F,1F,00,00,
                        19,66,11,66,11,66,11,66,11,66,11,66,33,00,00,00,7F,7F,77,77,77,77,77,77,77,77,77,77,33,33,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        01,06,01,66,11,66,11,66,11,66,03,3C,1E,00,00,00,07,07,67,67,77,77,77,77,77,77,3F,3F,1E,1E,00,00,
                        04,78,00,7C,12,6C,10,6E,11,66,11,66,33,00,00,00,7C,7C,7C,7C,7E,7E,7E,7E,77,77,77,77,33,33,00,00,
                        10,60,10,60,10,60,10,60,10,60,00,7E,3F,00,00,00,70,70,70,70,70,70,70,70,70,70,7E,7E,3F,3F,00,00,
                        29,D6,29,D6,29,C6,21,C6,21,C6,21,C6,63,00,00,00,FF,FF,FF,FF,EF,EF,E7,E7,E7,E7,E7,E7,63,63,00,00,
                        21,DE,21,CE,21,CE,21,C6,21,C6,21,C6,23,00,00,00,FF,FF,EF,EF,EF,EF,E7,E7,E7,E7,E7,E7,23,23,00,00,
                        03,7C,1E,60,10,60,10,60,10,60,10,60,30,00,00,00,7F,7F,7E,7E,70,70,70,70,70,70,70,70,30,30,00,00,
                        11,66,11,66,25,5A,15,6A,13,6C,08,36,1B,00,00,00,77,77,77,77,7F,7F,7F,7F,7F,7F,3E,3E,1B,1B,00,00,
                        03,7C,18,66,11,66,11,66,11,66,11,66,33,00,00,00,7F,7F,7E,7E,77,77,77,77,77,77,77,77,33,33,00,00,
                        10,0C,00,06,01,66,11,66,11,66,03,3C,1E,00,00,00,1C,1C,06,06,67,67,77,77,77,77,3F,3F,1E,1E,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        11,66,11,66,13,24,02,3C,06,18,04,18,0C,00,00,00,77,77,77,77,37,37,3E,3E,1E,1E,1C,1C,0C,0C,00,00,
                        29,D6,29,D6,01,FE,13,6C,32,44,22,44,22,00,00,00,FF,FF,FF,FF,FF,FF,7F,7F,76,76,66,66,22,22,00,00,
                        00,00,00,00,00,66,11,66,11,66,11,66,03,34,06,18,00,00,00,00,66,66,77,77,77,77,77,77,37,37,1E,1E,
                        00,00,00,00,00,66,11,66,11,66,11,66,13,24,02,3C,00,00,00,00,66,66,77,77,77,77,77,77,37,37,3E,3E,
                        00,00,00,00,00,7E,39,06,01,06,03,0C,02,0C,06,18,00,00,00,00,7E,7E,3F,3F,07,07,0F,0F,0E,0E,1E,1E,
                        0B,C4,60,1E,0B,E4,12,A4,12,A4,12,E4,72,00,00,00,CF,CF,7E,7E,EF,EF,B6,B6,B6,B6,F6,F6,72,72,00,00,
                        00,00,00,00,00,3C,18,66,11,66,11,66,31,06,03,0C,00,00,00,00,3C,3C,7E,7E,77,77,77,77,37,37,0F,0F,
                        00,00,00,00,00,00,00,00,00,00,04,18,04,18,04,18,00,00,00,00,00,00,00,00,00,00,1C,1C,1C,1C,1C,1C,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,08,0C,10,08,10,18,20,10,20,10,20,00,00,00,00,08,08,1C,1C,18,18,38,38,30,30,30,30,
                        00,00,00,00,00,20,00,10,08,10,00,08,04,08,04,08,00,00,00,00,20,20,10,10,18,18,08,08,0C,0C,0C,0C,
                        00,00,00,00,00,7E,3D,42,21,42,21,42,21,42,01,7E,00,00,00,00,7E,7E,7F,7F,63,63,63,63,63,63,7F,7F,
                        00,00,00,00,00,10,08,10,00,FE,47,38,04,38,28,54,00,00,00,00,10,10,18,18,FE,FE,7F,7F,3C,3C,7C,7C,
                        00,00,00,00,00,5E,27,48,20,5E,05,EA,75,0A,01,DE,00,00,00,00,5E,5E,6F,6F,7E,7E,EF,EF,7F,7F,DF,DF,
                        00,00,00,10,08,10,00,FE,7D,82,41,82,01,7C,36,08,00,00,10,10,18,18,FE,FE,FF,FF,C3,C3,7D,7D,3E,3E,
                        00,00,00,00,00,28,00,FE,57,28,00,7C,3A,44,06,38,00,00,00,00,28,28,FE,FE,7F,7F,7C,7C,7E,7E,3E,3E,
                        00,00,00,00,00,00,00,00,00,FC,7A,04,06,08,04,08,00,00,00,00,00,00,00,00,FC,FC,7E,7E,0E,0E,0C,0C,
                        00,00,00,0E,01,0A,01,0E,07,40,20,48,28,44,22,44,00,00,0E,0E,0B,0B,0F,0F,47,47,68,68,6C,6C,66,66,
                        04,18,10,2C,10,66,11,66,11,66,11,66,33,00,00,00,1C,1C,3C,3C,76,76,77,77,77,77,77,77,33,33,00,00,
                        00,00,00,00,00,52,29,52,0B,E4,60,1E,0B,C4,60,1E,00,00,00,00,52,52,7B,7B,EF,EF,7E,7E,CF,CF,7E,7E,
                        04,18,0C,30,08,30,18,60,10,60,00,7E,3F,00,00,00,1C,1C,3C,3C,38,38,78,78,70,70,7E,7E,3F,3F,00,00,
                        04,18,04,18,04,18,0C,00,00,18,04,18,0C,00,00,00,1C,1C,1C,1C,1C,1C,0C,0C,18,18,1C,1C,0C,0C,00,00,
                        06,18,04,18,04,18,0C,00,00,18,04,18,0C,00,00,00,1E,1E,1C,1C,1C,1C,0C,0C,18,18,1C,1C,0C,0C,00,00,
                        00,7E,27,18,04,18,04,18,04,18,0C,00,00,00,00,00,7E,7E,3F,3F,1C,1C,1C,1C,1C,1C,0C,0C,00,00,00,00,
                        00,7C,3E,00,00,00,00,00,00,00,00,00,00,00,00,00,7C,7C,3E,3E,00,00,00,00,00,00,00,00,00,00,00,00,
                        10,20,10,20,10,20,00,10,08,10,00,08,04,00,00,00,30,30,30,30,30,30,10,10,18,18,08,08,04,04,00,00,
                        04,08,04,08,04,08,0C,10,08,10,18,20,10,00,00,00,0C,0C,0C,0C,0C,0C,1C,1C,18,18,38,38,10,10,00,00,
                        3D,42,21,42,21,42,21,42,01,7E,3D,42,21,00,00,00,7F,7F,63,63,63,63,63,63,7F,7F,7F,7F,21,21,00,00,
                        2A,54,2A,54,68,92,41,BA,4D,10,08,10,08,00,00,00,7E,7E,7E,7E,FA,FA,FB,FB,5D,5D,18,18,08,08,00,00,
                        6F,00,00,DE,6D,12,09,D2,69,92,01,DE,6F,00,00,00,6F,6F,DE,DE,7F,7F,DB,DB,FB,FB,DF,DF,6F,6F,00,00,
                        0C,30,14,08,00,FE,77,08,04,08,0C,30,18,00,00,00,3C,3C,1C,1C,FE,FE,7F,7F,0C,0C,3C,3C,18,18,00,00,
                        00,FE,57,28,28,54,00,FE,2B,54,2A,54,2A,10,00,00,FE,FE,7F,7F,7C,7C,FE,FE,7F,7F,7E,7E,3A,3A,00,00,
                        0C,10,00,18,18,24,34,42,61,82,41,00,00,00,00,00,1C,1C,18,18,3C,3C,76,76,E3,E3,41,41,00,00,00,00,
                        22,44,60,82,41,82,41,82,41,82,41,00,00,00,00,00,66,66,E2,E2,C3,C3,C3,C3,C3,C3,41,41,00,00,00,00,
                        00,3C,38,46,21,C6,21,C6,21,C6,23,C4,06,78,3C,00,3C,3C,7E,7E,E7,E7,E7,E7,E7,E7,E7,E7,7E,7E,3C,3C,
                        00,18,04,38,04,18,04,18,04,18,04,18,04,18,0C,00,18,18,3C,3C,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,0C,0C,
                        00,7C,38,C6,21,C6,63,1C,0E,70,38,C0,00,FE,7F,00,7C,7C,FE,FE,E7,E7,7F,7F,7E,7E,F8,F8,FE,FE,7F,7F,
                        00,7C,38,C6,61,06,03,3C,18,06,01,C6,03,7C,3E,00,7C,7C,FE,FE,67,67,3F,3F,1E,1E,C7,C7,7F,7F,3E,3E,
                        00,1C,02,3C,12,6C,32,CC,22,CC,00,FE,73,0C,06,00,1C,1C,3E,3E,7E,7E,FE,FE,EE,EE,FE,FE,7F,7F,06,06,
                        00,FC,3E,C0,00,FC,38,C6,61,06,01,C6,03,7C,3E,00,FC,FC,FE,FE,FC,FC,FE,FE,67,67,C7,C7,7F,7F,3E,3E,
                        00,7C,38,C6,23,C0,00,FC,38,C6,21,C6,03,7C,3E,00,7C,7C,FE,FE,E3,E3,FC,FC,FE,FE,E7,E7,7F,7F,3E,3E,
                        00,FE,39,C6,63,0C,06,18,0C,30,08,30,08,30,18,00,FE,FE,FF,FF,6F,6F,1E,1E,3C,3C,38,38,38,38,18,18,
                        00,7C,38,C6,21,C6,03,7C,38,C6,21,C6,03,7C,3E,00,7C,7C,FE,FE,E7,E7,7F,7F,FE,FE,E7,E7,7F,7F,3E,3E,
                        00,7C,38,C6,21,C6,01,7E,39,06,01,C6,03,7C,3E,00,7C,7C,FE,FE,E7,E7,7F,7F,3F,3F,C7,C7,7F,7F,3E,3E,
                        00,38,00,7C,38,C6,21,C6,01,FE,39,C6,21,C6,63,00,38,38,7C,7C,FE,FE,E7,E7,FF,FF,FF,FF,E7,E7,63,63,
                        00,FC,38,C6,21,C6,03,FC,38,C6,21,C6,03,FC,3E,00,FC,FC,FE,FE,E7,E7,FF,FF,FE,FE,E7,E7,FF,FF,3E,3E,
                        00,7C,38,C6,21,C6,23,C0,20,C6,21,C6,03,7C,3E,00,7C,7C,FE,FE,E7,E7,E3,E3,E6,E6,E7,E7,7F,7F,3E,3E,
                        00,FC,38,C6,21,C6,21,C6,21,C6,21,C6,03,FC,7E,00,FC,FC,FE,FE,E7,E7,E7,E7,E7,E7,E7,E7,FF,FF,7E,7E,
                        00,FE,3F,C0,20,C0,00,FC,3E,C0,20,C0,00,FE,7F,00,FE,FE,FF,FF,E0,E0,FC,FC,FE,FE,E0,E0,FE,FE,7F,7F,
                        00,FE,3F,C0,20,C0,00,FC,3E,C0,20,C0,20,C0,60,00,FE,FE,FF,FF,E0,E0,FC,FC,FE,FE,E0,E0,E0,E0,60,60,
                        00,7C,38,C6,21,C6,23,C0,20,CE,21,C6,01,7E,3F,00,7C,7C,FE,FE,E7,E7,E3,E3,EE,EE,E7,E7,7F,7F,3F,3F,
                        00,C6,21,C6,21,C6,01,FE,39,C6,21,C6,21,C6,63,00,C6,C6,E7,E7,E7,E7,FF,FF,FF,FF,E7,E7,E7,E7,63,63,
                        00,18,04,18,04,18,04,18,04,18,04,18,04,18,0C,00,18,18,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,1C,0C,0C,
                        00,06,01,06,01,06,01,06,01,C6,21,C6,03,7C,3E,00,06,06,07,07,07,07,07,07,C7,C7,E7,E7,7F,7F,3E,3E,
                        00,C6,23,CC,24,D8,08,F0,00,F8,20,DE,29,C6,63,00,C6,C6,EF,EF,FC,FC,F8,F8,F8,F8,FE,FE,EF,EF,63,63,
                        00,C0,20,C0,20,C0,20,C0,20,C0,20,C0,00,FE,7F,00,C0,C0,E0,E0,E0,E0,E0,E0,E0,E0,E0,E0,FE,FE,7F,7F,
                        00,C6,21,C6,11,EE,29,D6,29,C6,21,C6,21,C6,63,00,C6,C6,E7,E7,FF,FF,FF,FF,EF,EF,E7,E7,E7,E7,63,63,
                        00,C6,01,E6,01,F6,21,DE,21,CE,21,C6,21,C6,63,00,C6,C6,E7,E7,F7,F7,FF,FF,EF,EF,E7,E7,E7,E7,63,63,
                        00,7C,38,C6,21,C6,21,C6,21,C6,21,C6,03,7C,3E,00,7C,7C,FE,FE,E7,E7,E7,E7,E7,E7,E7,E7,7F,7F,3E,3E,
                        00,FC,38,C6,21,C6,21,C6,03,FC,3E,C0,20,C0,60,00,FC,FC,FE,FE,E7,E7,E7,E7,FF,FF,FE,FE,E0,E0,60,60,
                        00,7C,38,C6,21,C6,21,C6,21,DE,23,CC,08,76,3B,00,7C,7C,FE,FE,E7,E7,E7,E7,FF,FF,EF,EF,7E,7E,3B,3B,
                        00,FC,38,C6,21,C6,03,FC,26,D8,20,CC,20,C6,63,00,FC,FC,FE,FE,E7,E7,FF,FF,FE,FE,EC,EC,E6,E6,63,63,
                        00,7C,38,C6,23,C0,00,7C,38,06,01,C6,03,7C,3E,00,7C,7C,FE,FE,E3,E3,7C,7C,3E,3E,C7,C7,7F,7F,3E,3E,
                        00,FC,4E,30,08,30,08,30,08,30,08,30,08,30,18,00,FC,FC,7E,7E,38,38,38,38,38,38,38,38,38,38,18,18,
                        00,C6,21,C6,21,C6,21,C6,21,C6,21,C6,03,7C,3E,00,C6,C6,E7,E7,E7,E7,E7,E7,E7,E7,E7,E7,7F,7F,3E,3E,
                        00,C6,21,C6,21,C6,11,EE,03,7C,06,38,0C,10,08,00,C6,C6,E7,E7,E7,E7,FF,FF,7F,7F,3E,3E,1C,1C,08,08,
                        00,C6,21,C6,21,D6,29,D6,03,7C,12,6C,32,44,22,00,C6,C6,E7,E7,F7,F7,FF,FF,7F,7F,7E,7E,76,76,22,22,
                        00,C6,01,EE,03,7C,06,38,00,7C,10,EE,31,C6,63,00,C6,C6,EF,EF,7F,7F,3E,3E,7C,7C,FE,FE,F7,F7,63,63,
                        00,66,11,66,11,66,03,3C,06,18,04,18,04,18,0C,00,66,66,77,77,77,77,3F,3F,1E,1E,1C,1C,1C,1C,0C,0C,
                        00,FE,71,0E,03,1C,06,38,0C,70,18,E0,00,FE,7F,00,FE,FE,7F,7F,1F,1F,3E,3E,7C,7C,F8,F8,FE,FE,7F,7F,
                        00,18,04,18,04,18,04,18,04,18,0C,00,00,18,0C,00,18,18,1C,1C,1C,1C,1C,1C,1C,1C,0C,0C,18,18,0C,0C,
                        00,7C,38,C6,21,C6,63,1C,0E,30,18,00,00,30,18,00,7C,7C,FE,FE,E7,E7,7F,7F,3E,3E,18,18,30,30,18,18,
                        00,00,00,10,08,10,00,7C,2E,10,08,10,08,00,00,00,00,00,10,10,18,18,7C,7C,3E,3E,18,18,08,08,00,00,
                        00,00,00,00,00,00,00,7C,3E,00,00,00,00,00,00,00,00,00,00,00,00,00,7C,7C,3E,3E,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,30,08,30,18,00,00,00,00,00,00,00,00,00,00,00,30,30,38,38,18,18,00,00,
                        00,00,00,00,00,00,00,30,08,30,08,10,08,20,10,00,00,00,00,00,00,00,30,30,38,38,18,18,28,28,10,10,
                        00,10,18,20,10,20,10,20,10,20,10,20,00,10,08,00,10,10,38,38,30,30,30,30,30,30,30,30,10,10,08,08,
                        00,20,00,10,08,10,08,10,08,10,08,10,18,20,10,00,20,20,10,10,18,18,18,18,18,18,18,18,38,38,10,10,
                        00,00,00,00,08,10,00,00,00,00,08,10,00,00,00,00,00,00,00,00,18,18,00,00,00,00,18,18,00,00,00,00,
                        00,00,00,0E,01,0A,01,4E,27,40,20,46,07,78,3C,40,00,00,0E,0E,0B,0B,4F,4F,67,67,66,66,7F,7F,7C,7C,
                        00,00,00,0A,05,0A,05,40,20,40,20,46,07,78,3C,40,00,00,0A,0A,0F,0F,45,45,60,60,66,66,7F,7F,7C,7C,
                        20,40,20,40,20,40,20,40,00,3E,1F,00,00,00,00,00,60,60,60,60,60,60,60,60,3E,3E,1F,1F,00,00,00,00,
                        00,00,04,03,03,0F,0F,1F,1E,3F,5C,3F,39,7F,39,7F,00,00,07,07,0F,0F,1F,1F,3F,3F,7F,7F,7F,7F,7F,7F,
                        00,00,04,03,03,0F,0F,1F,18,3F,59,3F,39,7F,38,7F,00,00,07,07,0F,0F,1F,1F,3F,3F,7F,7F,7F,7F,7F,7F,
                        00,00,20,C0,C0,F0,F0,F8,38,FC,9A,FC,9C,FE,3C,FE,00,00,E0,E0,F0,F0,F8,F8,FC,FC,FE,FE,FE,FE,FE,FE,
                        00,00,04,03,03,0F,0F,1F,19,3F,59,3F,3C,7F,3E,7F,00,00,07,07,0F,0F,1F,1F,3F,3F,7F,7F,7F,7F,7F,7F,
                        00,00,04,03,03,0F,0F,1F,19,3F,59,3F,39,7F,3D,7F,00,00,07,07,0F,0F,1F,1F,3F,3F,7F,7F,7F,7F,7F,7F,
                        00,00,00,00,00,00,00,00,00,01,01,03,01,03,00,01,00,00,00,00,00,00,00,00,01,01,03,03,03,03,01,01,
                        00,01,01,07,07,1F,1E,7F,78,FE,E0,F8,80,E0,00,80,01,01,07,07,1F,1F,7F,7F,FE,FE,F8,F8,E0,E0,80,80,
                        00,80,80,C0,80,C0,00,80,00,00,00,00,00,00,00,00,80,80,C0,C0,C0,C0,80,80,00,00,00,00,00,00,00,00,
                        00,00,00,7C,3C,7C,3C,7C,3C,7C,3C,7C,00,00,00,00,00,00,7E,7E,42,7E,42,7E,42,7E,42,7E,7E,7E,00,00,
                        00,00,7E,02,42,3E,42,3E,42,3E,42,3E,7E,7E,00,00,00,00,02,7C,02,7C,02,7C,02,7C,02,7C,7E,00,00,00,
                        00,00,00,00,00,1F,1F,2F,3F,7F,BF,7F,7F,FF,7F,FF,00,00,00,00,1F,1F,3F,3F,7F,7F,FF,FF,FF,FF,FF,FF,
                        00,00,00,00,00,FF,FF,FF,9F,FF,9F,FF,9F,FF,9F,FF,00,00,00,00,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        00,00,00,00,00,FF,FF,FF,83,FF,99,FF,99,FF,99,FF,00,00,00,00,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        00,00,00,0E,06,08,00,0E,06,08,00,08,00,0E,0E,00,00,00,0E,0E,0E,0E,0E,0E,0E,0E,08,08,0E,0E,0E,0E,
                        00,00,00,97,03,D4,40,B7,03,B4,20,94,00,97,97,00,00,00,97,97,D7,D7,F7,F7,B7,B7,B4,B4,97,97,97,97,
                        00,00,00,77,23,54,00,54,10,65,20,55,00,57,57,00,00,00,77,77,77,77,54,54,75,75,75,75,57,57,57,57,
                        39,7F,38,7F,59,3F,19,3F,0F,1F,03,0F,04,03,00,00,7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,0F,0F,07,07,00,00,
                        39,7F,39,7F,59,3F,18,3F,0F,1F,03,0F,04,03,00,00,7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,0F,0F,07,07,00,00,
                        9C,FE,9C,FE,9A,FC,38,FC,F0,F8,C0,F0,20,C0,00,00,FE,FE,FE,FE,FE,FE,FC,FC,F8,F8,F0,F0,E0,E0,00,00,
                        3E,7F,3D,7F,59,3F,19,3F,0F,1F,03,0F,04,03,00,00,7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,0F,0F,07,07,00,00,
                        3C,7F,3E,7F,5E,3F,1E,3F,0F,1F,03,0F,04,03,00,00,7F,7F,7F,7F,7F,7F,3F,3F,1F,1F,0F,0F,07,07,00,00,
                        00,00,00,EE,77,88,00,EE,57,28,14,28,10,EE,77,00,00,00,EE,EE,FF,FF,EE,EE,7F,7F,3C,3C,FE,FE,77,77,
                        00,00,00,8E,47,88,40,8E,47,88,44,88,00,EE,77,00,00,00,8E,8E,CF,CF,CE,CE,CF,CF,CC,CC,EE,EE,77,77,
                        00,00,00,EE,73,84,42,84,42,84,42,84,02,E4,72,00,00,00,EE,EE,F7,F7,C6,C6,C6,C6,C6,C6,E6,E6,72,72,
                        00,00,00,3B,1C,21,00,39,14,09,04,09,04,39,1C,00,00,00,3B,3B,3D,3D,39,39,1D,1D,0D,0D,3D,3D,1C,1C,
                        00,00,00,BB,D5,2A,95,2A,84,3B,95,2A,95,2A,95,00,00,00,BB,BB,FF,FF,BF,BF,BF,BF,BF,BF,BF,BF,95,95,
                        00,00,00,B8,4C,90,48,90,C8,10,08,90,48,90,48,00,00,00,B8,B8,DC,DC,D8,D8,D8,D8,98,98,D8,D8,48,48,
                        9F,FF,9F,FF,9F,FF,81,FF,FF,FF,00,FF,00,00,00,00,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,00,00,00,00,
                        83,FF,99,FF,99,FF,99,FF,FF,FF,00,FF,00,00,00,00,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,00,00,00,00,
                        00,00,00,1C,14,08,00,08,00,08,00,08,00,08,08,00,00,00,1C,1C,1C,1C,08,08,08,08,08,08,08,08,08,08,
                        00,00,00,91,00,9B,0A,95,00,95,04,91,00,91,91,00,00,00,91,91,9B,9B,9F,9F,95,95,95,95,91,91,91,91,
                        00,00,00,38,18,20,00,38,18,20,00,20,00,38,38,00,00,00,38,38,38,38,38,38,38,38,20,20,38,38,38,38,
                        08,07,07,0E,07,0C,07,08,87,7F,7F,EF,7F,CF,7E,8F,0F,0F,0F,0F,0F,0F,0F,0F,FF,FF,FF,FF,FF,FF,FF,FF,
                        20,C0,C0,E0,C0,60,C0,20,C2,FC,FC,EE,FC,E6,FC,E2,E0,E0,E0,E0,E0,E0,E0,E0,FE,FE,FE,FE,FE,FE,FE,FE,
                        08,07,07,0E,06,0D,04,0B,87,7F,7F,EF,7F,CF,7E,8F,0F,0F,0F,0F,0F,0F,0F,0F,FF,FF,FF,FF,FF,FF,FF,FF,
                        20,C0,C0,E0,C0,60,40,A0,C2,FC,FC,EE,FC,E6,FC,E2,E0,E0,E0,E0,E0,E0,E0,E0,FE,FE,FE,FE,FE,FE,FE,FE,
                        08,07,07,0E,07,0C,07,08,87,7F,7F,EF,6F,DF,4E,BF,0F,0F,0F,0F,0F,0F,0F,0F,FF,FF,FF,FF,FF,FF,FF,FF,
                        20,C0,C0,E0,C0,60,C0,20,C2,FC,FC,EE,EC,F6,E4,FA,E0,E0,E0,E0,E0,E0,E0,E0,FE,FE,FE,FE,FE,FE,FE,FE,
                        08,07,07,0E,06,0D,04,0B,87,7F,7F,EF,6F,DF,4E,BF,0F,0F,0F,0F,0F,0F,0F,0F,FF,FF,FF,FF,FF,FF,FF,FF,
                        20,C0,C0,E0,C0,60,40,A0,C2,FC,FC,EE,EC,F6,E4,FA,E0,E0,E0,E0,E0,E0,E0,E0,FE,FE,FE,FE,FE,FE,FE,FE,
                        0A,06,05,03,0A,09,05,0C,0A,06,05,03,02,01,01,00,0E,01,0F,00,07,00,03,00,01,00,00,00,00,00,00,00,
                        A0,C0,40,80,A0,20,40,60,AA,C3,55,99,AA,0C,55,66,E0,00,E0,00,C0,00,80,00,03,14,01,22,30,41,78,80,
                        00,00,00,00,00,00,00,00,AA,33,55,99,AA,CC,55,66,00,00,00,00,00,00,00,00,C3,04,E1,02,F0,01,78,80,
                        00,00,40,00,20,40,50,60,A8,30,54,98,AA,CC,55,66,00,00,00,00,00,00,00,00,C0,00,E0,00,F0,00,78,80,
                        0A,06,05,03,0A,09,05,0C,0A,06,05,03,0A,09,05,0C,0E,01,0F,00,07,00,03,00,01,00,00,08,08,04,0C,02,
                        A0,C0,40,80,A0,20,40,60,A0,C0,40,80,A0,20,40,60,E0,00,E0,00,C0,00,80,00,00,00,00,20,20,40,60,80,
                        00,00,00,00,00,00,00,00,15,0C,2A,19,55,33,AA,66,00,00,00,00,00,00,00,00,03,00,07,00,0F,00,1E,01,
                        00,00,00,00,00,00,00,00,54,CC,A8,98,50,30,A0,60,00,00,00,00,00,00,00,00,C2,20,84,40,08,80,10,00,
                        7F,CF,7F,EF,87,7F,07,08,07,0C,07,0E,08,07,00,00,FF,FF,FF,FF,FF,FF,0F,0F,0F,0F,0F,0F,0F,0F,00,00,
                        FC,E6,FC,EE,C2,FC,C0,20,C0,60,C0,E0,20,C0,00,00,FE,FE,FE,FE,FE,FE,E0,E0,E0,E0,E0,E0,E0,E0,00,00,
                        7F,CF,7F,EF,87,7F,04,0B,06,0D,07,0E,08,07,00,00,FF,FF,FF,FF,FF,FF,0F,0F,0F,0F,0F,0F,0F,0F,00,00,
                        FC,E6,FC,EE,C2,FC,40,A0,C0,60,C0,E0,20,C0,00,00,FE,FE,FE,FE,FE,FE,E0,E0,E0,E0,E0,E0,E0,E0,00,00,
                        6F,DF,7F,EF,87,7F,07,08,07,0C,07,0E,08,07,00,00,FF,FF,FF,FF,FF,FF,0F,0F,0F,0F,0F,0F,0F,0F,00,00,
                        EC,F6,FC,EE,C2,FC,C0,20,C0,60,C0,E0,20,C0,00,00,FE,FE,FE,FE,FE,FE,E0,E0,E0,E0,E0,E0,E0,E0,00,00,
                        6F,DF,7F,EF,87,7F,04,0B,06,0D,07,0E,08,07,00,00,FF,FF,FF,FF,FF,FF,0F,0F,0F,0F,0F,0F,0F,0F,00,00,
                        EC,F6,FC,EE,C2,FC,40,A0,C0,60,C0,E0,20,C0,00,00,FE,FE,FE,FE,FE,FE,E0,E0,E0,E0,E0,E0,E0,E0,00,00,
                        00,00,00,0A,05,0A,01,7C,3E,00,00,00,00,FE,6F,10,00,00,0A,0A,0F,0F,7D,7D,3E,3E,00,00,FE,FE,7F,7F,
                        2A,4C,35,39,0A,13,00,00,00,00,00,00,00,00,00,00,70,01,01,02,03,04,00,08,00,00,00,00,00,00,00,00,
                        AA,CC,55,99,AA,33,00,00,00,00,00,00,00,00,00,00,F0,01,E1,02,C3,04,00,00,00,00,00,00,00,00,00,00,
                        AA,CC,54,98,A8,30,50,60,20,40,40,00,00,00,00,00,F0,00,E0,00,C0,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,50,00,50,00,50,50,20,00,20,00,20,20,00,00,00,50,50,50,50,50,50,70,70,20,20,20,20,20,20,
                        00,00,01,03,02,01,05,0C,0A,06,05,03,0A,09,05,0C,00,01,03,00,07,00,03,00,01,00,00,08,08,04,0C,02,
                        D5,B3,6A,99,B5,2C,40,60,A0,C0,40,80,A0,20,40,60,8F,00,C7,00,C3,00,80,00,00,00,00,20,20,40,60,80,
                        50,30,A8,98,54,CC,00,00,00,00,00,00,00,00,00,00,08,80,84,40,C2,20,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,44,22,44,00,FE,3B,44,22,44,00,00,00,00,00,00,44,44,66,66,FE,FE,7F,7F,66,66,
                        00,00,00,00,00,00,00,10,08,10,00,FE,7D,82,41,82,00,00,00,00,00,00,10,10,18,18,FE,FE,FF,FF,C3,C3,
                        00,00,00,00,00,00,00,00,00,C0,40,20,30,02,01,02,00,00,00,00,00,00,00,00,C0,C0,60,60,32,32,03,03,
                        00,00,00,0A,05,0A,05,40,20,40,20,40,20,40,00,70,00,00,0A,0A,0F,0F,45,45,60,60,60,60,60,60,70,70,
                        00,00,00,00,00,00,00,7C,3E,00,00,00,00,FE,6F,10,00,00,00,00,00,00,7C,7C,3E,3E,00,00,FE,FE,7F,7F,
                        00,00,00,00,00,00,00,00,00,40,20,40,20,40,20,40,00,00,00,00,00,00,00,00,40,40,60,60,60,60,60,60,
                        00,00,00,00,00,00,00,08,04,08,00,FE,77,08,04,18,00,00,00,00,00,00,08,08,0C,0C,FE,FE,7F,7F,1C,1C,
                        00,00,00,00,00,00,00,00,00,7C,1E,20,10,20,00,FE,00,00,00,00,00,00,00,00,7C,7C,3E,3E,30,30,FE,FE,
                        00,00,00,00,00,00,00,04,02,04,02,04,02,04,06,08,00,00,00,00,00,00,04,04,06,06,06,06,06,06,0E,0E,
                        00,00,00,00,00,00,00,7C,3E,00,00,00,00,FE,7D,02,00,00,00,00,00,00,7C,7C,3E,3E,00,00,FE,FE,7F,7F,
                        00,00,00,00,00,00,00,00,00,48,24,48,24,48,24,48,00,00,00,00,00,00,00,00,48,48,6C,6C,6C,6C,6C,6C,
                        00,00,00,00,00,00,00,20,10,20,00,FE,5F,20,10,2E,00,00,00,00,00,00,20,20,30,30,FE,FE,7F,7F,3E,3E,
                        00,00,00,00,00,00,00,48,24,48,04,78,32,4C,24,CA,00,00,00,00,00,00,48,48,6C,6C,7C,7C,7E,7E,EE,EE,
                        00,00,00,00,00,44,22,44,12,E4,40,BE,1B,E4,52,A4,00,00,00,00,44,44,66,66,F6,F6,FE,FE,FF,FF,F6,F6,
                        00,00,00,00,00,00,00,10,08,10,00,FE,5F,20,10,2C,00,00,00,00,00,00,10,10,18,18,FE,FE,7F,7F,3C,3C,
                        00,00,00,00,00,08,00,9E,87,48,60,1E,05,1A,01,DE,00,00,00,00,08,08,9E,9E,CF,CF,7E,7E,1F,1F,DF,DF,
                        22,44,22,04,06,08,04,08,0C,10,08,00,00,00,00,00,66,66,26,26,0E,0E,0C,0C,1C,1C,08,08,00,00,00,00,
                        41,02,03,04,02,04,06,08,0C,30,18,00,00,00,00,00,43,43,07,07,06,06,0E,0E,3C,3C,18,18,00,00,00,00,
                        03,04,02,04,06,08,0C,10,18,60,30,00,00,00,00,00,07,07,06,06,0E,0E,1C,1C,78,78,30,30,00,00,00,00,
                        00,00,00,0A,05,0A,05,20,10,20,00,FE,5F,20,10,2E,00,00,0A,0A,0F,0F,25,25,30,30,FE,FE,7F,7F,3E,3E,
                        08,10,08,10,18,20,10,20,30,40,20,00,00,00,00,00,18,18,18,18,38,38,30,30,70,70,20,20,00,00,00,00,
                        20,42,21,42,23,44,26,58,1C,60,30,00,00,00,00,00,62,62,63,63,67,67,7E,7E,7C,7C,30,30,00,00,00,00,
                        04,18,14,28,34,48,64,88,44,08,04,00,00,00,00,00,1C,1C,3C,3C,7C,7C,EC,EC,4C,4C,04,04,00,00,00,00,
                        5F,20,10,20,10,20,10,20,00,1E,0F,00,00,00,00,00,7F,7F,30,30,30,30,30,30,1E,1E,0F,0F,00,00,00,00,
                        04,08,0C,10,08,10,18,20,30,40,20,00,00,00,00,00,0C,0C,1C,1C,18,18,38,38,70,70,20,20,00,00,00,00,
                        01,02,03,04,02,04,06,08,0C,30,18,00,00,00,00,00,03,03,07,07,06,06,0E,0E,3C,3C,18,18,00,00,00,00,
                        24,4A,25,4A,25,4A,65,8A,43,8C,46,00,00,00,00,00,6E,6E,6F,6F,6F,6F,EF,EF,CF,CF,46,46,00,00,00,00,
                        37,40,20,48,2C,50,68,90,40,8E,47,00,00,00,00,00,77,77,68,68,7C,7C,F8,F8,CE,CE,47,47,00,00,00,00,
                        2D,D2,49,B2,59,A2,51,A2,33,44,22,00,00,00,00,00,FF,FF,FB,FB,FB,FB,F3,F3,77,77,22,22,00,00,00,00,
                        12,E4,42,B4,12,EC,1A,64,52,A4,52,AC,56,00,00,00,F6,F6,F6,F6,FE,FE,7E,7E,F6,F6,FE,FE,56,56,00,00,
                        0C,72,39,42,21,02,01,02,03,3C,1E,00,00,00,00,00,7E,7E,7B,7B,23,23,03,03,3F,3F,1E,1E,00,00,00,00,
                        25,5A,21,5E,27,48,20,5E,47,A8,60,9E,4F,00,00,00,7F,7F,7F,7F,6F,6F,7E,7E,EF,EF,FE,FE,4F,4F,00,00,
                        00,00,00,00,00,00,00,00,00,7E,3D,02,01,02,01,02,00,00,00,00,00,00,00,00,7E,7E,3F,3F,03,03,03,03,
                        00,00,00,00,00,00,00,40,20,40,20,40,20,40,00,70,00,00,00,00,00,00,40,40,60,60,60,60,60,60,70,70,
                        00,00,00,00,00,00,00,00,00,FE,7D,82,41,82,41,82,00,00,00,00,00,00,00,00,FE,FE,FF,FF,C3,C3,C3,C3,
                        00,00,00,00,00,00,00,40,20,40,00,FE,3D,42,23,44,00,00,00,00,00,00,40,40,60,60,FE,FE,7F,7F,67,67,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,54,2A,54,00,00,00,00,00,00,00,00,00,00,00,00,54,54,7E,7E,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,02,03,04,00,00,00,00,00,00,00,00,00,00,00,00,02,02,07,07,
                        00,00,00,0A,05,0A,05,40,00,7C,3A,44,22,44,62,84,00,00,0A,0A,0F,0F,45,45,7C,7C,7E,7E,66,66,E6,E6,
                        00,00,00,0E,01,0A,01,0E,07,20,20,50,30,48,60,84,00,00,0E,0E,0B,0B,0F,0F,27,27,70,70,78,78,E4,E4,
                        00,00,00,00,00,00,00,00,00,C0,50,20,10,02,01,C2,00,00,00,00,00,00,00,00,C0,C0,70,70,12,12,C3,C3,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,40,00,FE,00,00,00,00,00,00,00,00,00,00,00,00,40,40,FE,FE,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,7C,00,00,00,00,00,00,00,00,00,00,00,00,00,00,7C,7C,
                        00,00,00,00,00,00,00,20,00,3E,1D,22,11,22,29,52,00,00,00,00,00,00,20,20,3E,3E,3F,3F,33,33,7B,7B,
                        00,00,00,00,00,00,00,02,01,02,03,04,06,08,04,38,00,00,00,00,00,00,02,02,03,03,07,07,0E,0E,3C,3C,
                        00,00,00,0E,01,0A,09,06,07,F8,7A,04,02,04,02,04,00,00,0E,0E,0B,0B,0F,0F,FF,FF,7E,7E,06,06,06,06,
                        00,00,00,00,04,48,2C,52,23,4C,66,88,4C,12,01,5E,00,00,00,00,4C,4C,7E,7E,6F,6F,EE,EE,5E,5E,5F,5F,
                        00,00,00,0A,0D,02,05,08,00,FE,77,08,04,08,04,38,00,00,0A,0A,0F,0F,0D,0D,FE,FE,7F,7F,0C,0C,3C,3C,
                        01,02,01,02,01,02,01,02,01,7E,3F,00,00,00,00,00,03,03,03,03,03,03,03,03,7F,7F,3F,3F,00,00,00,00,
                        30,4C,26,40,20,40,20,40,20,40,20,00,00,00,00,00,7C,7C,66,66,60,60,60,60,60,60,20,20,00,00,00,00,
                        41,82,41,82,41,82,41,82,01,FE,7F,00,00,00,00,00,C3,C3,C3,C3,C3,C3,C3,C3,FF,FF,7F,7F,00,00,00,00,
                        26,48,24,40,20,40,20,40,00,3E,1F,00,00,00,00,00,6E,6E,64,64,60,60,60,60,3E,3E,1F,1F,00,00,00,00,
                        2A,54,2A,04,06,08,0C,30,18,00,00,00,00,00,00,00,7E,7E,2E,2E,0E,0E,3C,3C,18,18,00,00,00,00,00,00,
                        06,18,14,E8,64,08,04,08,04,00,00,00,00,00,00,00,1E,1E,FC,FC,6C,6C,0C,0C,04,04,00,00,00,00,00,00,
                        00,00,00,0A,05,0A,05,40,20,40,00,7E,77,88,44,88,00,00,0A,0A,0F,0F,45,45,60,60,7E,7E,FF,FF,CC,CC,
                        42,84,40,02,01,02,01,02,01,00,00,00,00,00,00,00,C6,C6,42,42,03,03,03,03,01,01,00,00,00,00,00,00,
                        53,24,12,04,06,08,0C,30,38,C0,60,00,00,00,00,00,77,77,16,16,0E,0E,3C,3C,F8,F8,60,60,00,00,00,00,
                        5D,22,13,24,02,10,08,10,08,00,00,00,00,00,00,00,7F,7F,37,37,12,12,18,18,08,08,00,00,00,00,00,00,
                        3A,04,02,7C,3A,04,02,7C,3E,00,00,00,00,00,00,00,3E,3E,7E,7E,3E,3E,7E,7E,3E,3E,00,00,00,00,00,00,
                        25,0A,03,04,02,04,06,08,0C,30,18,00,00,00,00,00,2F,2F,07,07,06,06,0E,0E,3C,3C,18,18,00,00,00,00,
                        34,C8,64,08,04,08,04,08,04,08,04,00,00,00,00,00,FC,FC,6C,6C,0C,0C,0C,0C,0C,0C,04,04,00,00,00,00,
                        02,04,06,08,04,08,0C,10,18,60,30,00,00,00,00,00,06,06,0E,0E,0C,0C,1C,1C,78,78,30,30,00,00,00,00,
                        2F,40,20,CE,2D,52,2B,44,22,4C,2C,52,29,00,00,00,6F,6F,EE,EE,7F,7F,6F,6F,6E,6E,7E,7E,29,29,00,00,
                        44,08,04,08,0C,10,08,10,18,20,10,00,00,00,00,00,4C,4C,0C,0C,1C,1C,18,18,38,38,10,10,00,00,00,00,
                        00,00,00,00,00,00,00,10,08,10,00,7E,37,08,04,08,00,00,00,00,00,00,10,10,18,18,7E,7E,3F,3F,0C,0C,
                        00,00,00,00,00,00,00,22,31,42,21,42,21,42,21,42,00,00,00,00,00,00,22,22,73,73,63,63,63,63,63,63,
                        00,00,00,00,00,14,0A,94,4A,94,40,3E,17,08,04,AA,00,00,00,00,14,14,9E,9E,DE,DE,7E,7E,1F,1F,AE,AE,
                        00,00,00,00,00,10,08,10,00,FE,5F,20,10,20,00,3E,00,00,00,00,10,10,18,18,FE,FE,7F,7F,30,30,3E,3E,
                        00,00,00,00,00,10,10,20,00,FE,7D,82,41,BA,55,AA,00,00,00,00,10,10,30,30,FE,FE,FF,FF,FB,FB,FF,FF,
                        00,00,00,0A,05,0A,05,00,00,C0,40,20,30,02,01,C2,00,00,0A,0A,0F,0F,05,05,C0,C0,60,60,32,32,C3,C3,
                        00,00,00,0A,05,0A,05,20,00,3E,1D,22,11,22,29,52,00,00,0A,0A,0F,0F,25,25,3E,3E,3F,3F,33,33,7B,7B,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,78,00,00,00,00,00,00,00,00,00,00,00,00,00,00,78,78,
                        00,00,00,00,00,00,00,FE,7D,02,01,12,09,12,0B,14,00,00,00,00,00,00,FE,FE,7F,7F,13,13,1B,1B,1F,1F,
                        00,00,00,00,00,00,00,08,04,08,0C,10,08,10,18,20,00,00,00,00,00,00,08,08,0C,0C,1C,1C,18,18,38,38,
                        00,00,00,00,00,00,00,40,00,7C,3A,44,22,44,62,84,00,00,00,00,00,00,40,40,7C,7C,7E,7E,66,66,E6,E6,
                        00,00,00,00,00,00,00,20,10,20,00,FE,6F,10,08,10,00,00,00,00,00,00,20,20,30,30,FE,FE,7F,7F,18,18,
                        00,00,00,00,00,00,00,20,12,24,01,F2,39,40,20,40,00,00,00,00,00,00,20,20,36,36,F3,F3,79,79,60,60,
                        00,00,00,00,00,00,00,48,24,48,04,78,32,4C,24,CA,00,00,00,00,00,00,48,48,6C,6C,7C,7C,7E,7E,EE,EE,
                        00,00,00,00,00,10,08,10,08,10,08,10,00,1C,0E,10,00,00,00,00,10,10,18,18,18,18,18,18,1C,1C,1E,1E,
                        00,00,00,00,00,FE,6F,10,00,18,08,14,0C,12,0B,10,00,00,00,00,FE,FE,7F,7F,18,18,1C,1C,1E,1E,1B,1B,
                        0A,04,06,20,30,40,20,40,00,3C,1E,00,00,00,00,00,0E,0E,26,26,70,70,60,60,3C,3C,1E,1E,00,00,00,00,
                        11,62,31,02,03,04,02,04,06,08,04,00,00,00,00,00,73,73,33,33,07,07,06,06,0E,0E,04,04,00,00,00,00,
                        15,6A,01,7E,37,48,20,48,40,B0,40,9E,4F,00,00,00,7F,7F,7F,7F,7F,7F,68,68,F0,F0,DE,DE,4F,4F,00,00,
                        1D,22,11,22,31,42,61,82,43,04,06,08,04,00,00,00,3F,3F,33,33,73,73,E3,E3,47,47,0E,0E,04,04,00,00,
                        55,AA,55,AA,55,AA,45,BA,5D,82,41,86,43,00,00,00,FF,FF,FF,FF,FF,FF,FF,FF,DF,DF,C7,C7,43,43,00,00,
                        43,24,32,04,06,08,0C,30,38,C0,60,00,00,00,00,00,67,67,36,36,0E,0E,3C,3C,F8,F8,60,60,00,00,00,00,
                        00,00,00,0A,05,0A,05,00,00,FE,77,08,0C,10,18,20,00,00,0A,0A,0F,0F,05,05,FE,FE,7F,7F,1C,1C,38,38,
                        34,08,04,08,04,08,00,FE,7F,00,00,00,00,00,00,00,3C,3C,0C,0C,0C,0C,FE,FE,7F,7F,00,00,00,00,00,00,
                        06,18,0C,10,08,10,18,20,30,40,20,00,00,00,00,00,1E,1E,1C,1C,18,18,38,38,70,70,20,20,00,00,00,00,
                        10,20,30,44,22,44,64,9A,1D,E2,71,00,00,00,00,00,30,30,74,74,66,66,FE,FE,FF,FF,71,71,00,00,00,00,
                        42,04,06,08,04,08,0C,10,18,60,30,00,00,00,00,00,46,46,0E,0E,0C,0C,1C,1C,78,78,30,30,00,00,00,00,
                        00,FE,77,08,04,08,08,04,02,04,02,00,00,00,00,00,FE,FE,7F,7F,0C,0C,0C,0C,06,06,02,02,00,00,00,00,
                        60,84,42,84,42,3C,18,26,07,18,0C,00,00,00,00,00,E4,E4,C6,C6,7E,7E,3E,3E,1F,1F,0C,0C,00,00,00,00,
                        2D,D2,49,B2,59,A2,51,A2,33,44,22,00,00,00,00,00,FF,FF,FB,FB,FB,FB,F3,F3,77,77,22,22,00,00,00,00,
                        08,10,08,10,08,10,08,10,08,10,00,FE,7F,00,00,00,18,18,18,18,18,18,18,18,18,18,FE,FE,7F,7F,00,00,
                        08,10,08,10,08,10,08,10,08,10,08,10,08,00,00,00,18,18,18,18,18,18,18,18,18,18,18,18,08,08,00,00,
                        00,00,00,00,01,00,04,00,0E,06,1B,07,0B,07,31,2F,00,00,00,00,01,01,07,07,09,0F,10,1F,00,1F,00,3F,
                        00,00,7E,00,02,02,01,01,00,00,80,80,41,40,86,81,00,00,7E,7E,FF,FF,FF,FF,FF,FF,7F,FF,BF,FF,7E,FF,
                        00,00,00,00,00,00,40,00,A0,00,D0,80,F8,80,B8,80,00,00,00,00,00,00,C0,C0,E0,E0,F0,F0,F8,F8,78,F8,
                        00,00,00,00,03,00,07,02,09,0C,17,1D,17,0C,11,0B,00,00,00,00,03,03,05,07,03,0F,02,1F,03,1F,24,3F,
                        00,00,FE,00,81,00,E0,E0,B8,78,14,F4,8E,FE,CC,7C,00,00,FE,FE,FF,FF,1F,FF,07,FF,0B,FF,01,FF,83,FF,
                        00,00,00,00,80,00,C0,00,20,00,30,00,30,00,38,00,00,00,00,00,80,80,C0,C0,E0,E0,F0,F0,F0,F0,F8,F8,
                        00,00,00,00,00,00,03,03,06,05,0D,0A,0F,08,1A,1D,00,00,00,00,01,01,04,07,08,0F,02,0F,10,1F,00,1F,
                        00,00,08,00,EA,E2,6D,E7,2F,E7,2F,E7,3F,E7,67,C3,00,00,7F,7F,1D,FF,18,FF,18,FF,18,FF,18,FF,3C,FF,
                        00,00,00,00,00,00,00,00,10,00,80,80,88,80,88,80,00,00,00,00,C0,C0,E0,E0,F0,F0,70,F0,78,F8,78,F8,
                        60,00,70,20,68,30,29,36,29,36,19,16,05,02,03,00,60,60,50,50,48,48,06,06,06,06,06,06,02,02,00,00,
                        06,06,0E,0A,1E,02,BC,F0,7C,F0,B8,F0,60,E0,C0,C0,06,06,0E,0E,1E,1E,0C,0C,0C,0C,08,08,00,00,00,00,
                        60,00,70,20,68,30,2E,31,2E,31,16,19,02,05,03,02,60,60,50,50,48,48,01,01,01,01,01,01,01,01,00,00,
                        06,06,0E,0A,1E,02,7C,B0,7C,B0,78,B0,60,A0,80,40,06,06,0E,0E,1E,1E,8C,8C,8C,8C,88,88,80,80,00,00,
                        60,00,70,20,68,30,2C,33,2C,33,16,19,04,07,03,03,60,60,50,50,48,48,02,02,00,00,00,00,00,00,02,00,
                        06,06,0E,0A,1E,12,9C,60,9C,60,88,70,A0,40,40,80,06,06,0E,0E,0E,0E,6C,6C,6C,6C,68,68,40,40,00,00,
                        00,00,00,3F,02,00,38,3F,20,39,3F,02,3C,3F,00,00,00,00,3F,00,3F,00,3F,06,3F,00,3F,00,3F,00,00,00,
                        61,5F,75,2B,1D,33,BD,6B,3D,DB,1C,7B,5D,BA,DA,34,20,7F,14,7F,8C,FF,14,F7,24,E7,00,07,81,87,03,0F,
                        49,46,92,8D,9D,8B,3B,57,BB,B7,F1,03,38,21,7C,20,B8,FF,70,FF,78,C7,F0,CF,70,8F,FC,FF,FE,9F,FF,1F,
                        58,C0,18,00,94,84,16,02,96,84,16,02,2E,04,5B,02,38,F8,FC,FC,7C,FC,FC,FE,7E,FE,FC,FE,FF,FF,FD,FF,
                        23,17,47,73,6F,43,72,7E,6F,7F,65,7A,56,79,05,3A,08,3F,00,7F,30,7F,31,7F,3F,7F,38,78,18,78,48,78,
                        FF,BF,BE,9E,BE,BE,7C,7D,DE,FE,3F,FF,5C,FC,2E,FC,40,FF,69,FF,79,FF,EB,EF,89,8E,09,0E,13,1E,03,1E,
                        64,10,42,30,D2,70,5A,38,FA,78,BE,F8,B6,30,4C,00,EC,FC,CE,FE,CE,3E,C6,3E,C6,3E,86,7E,CE,7E,FC,FC,
                        2C,2F,0F,2B,FF,99,9F,FA,0E,5B,6E,5F,3E,1F,05,07,50,7F,94,FF,06,FF,05,FD,A5,DD,31,4D,71,4D,38,2E,
                        EB,99,75,0C,25,5C,69,78,CF,01,6B,9F,47,BF,6B,9F,46,FF,83,FF,83,FF,87,FF,FF,FF,80,80,80,80,80,80,
                        8C,80,28,20,6A,60,E6,A0,E2,24,CA,04,E8,2C,D0,48,7E,FE,FF,FF,FF,FF,FF,FF,FF,FB,FF,F3,DE,F2,BC,F4,
                        60,00,70,22,68,32,28,37,2C,33,14,1B,04,07,03,03,60,60,52,52,4A,4A,07,07,02,02,02,02,00,00,02,00,
                        06,06,02,0E,02,1E,A0,DC,64,DC,A0,D8,40,E0,C0,C0,02,02,02,02,0A,0A,18,18,18,18,10,10,00,00,00,00,
                        60,00,70,20,68,32,20,3F,2C,33,16,19,04,07,03,03,60,60,50,50,4A,4A,0F,0F,02,02,00,00,00,00,02,00,
                        06,06,0E,0A,1E,02,3C,F0,7C,F0,B8,F0,60,E0,C0,C0,06,06,0E,0E,1E,1E,8C,8C,0C,0C,08,08,00,00,00,00,
                        2C,04,2C,04,2C,04,2C,04,2C,04,2C,04,2C,04,2C,04,3C,00,3C,00,3C,00,3C,00,3C,00,3C,00,3C,00,3C,00,
                        00,00,00,3F,00,00,00,3F,00,00,01,3E,39,39,3E,02,00,00,3F,00,3F,00,3F,3F,3F,00,3F,3C,3F,00,3E,00,
                        00,00,50,F0,10,40,50,A8,10,48,E0,50,50,F0,00,00,00,00,F0,00,F0,08,F8,AC,F8,0C,F0,08,F0,00,00,00,
                        B4,68,E9,12,D3,24,AC,4C,B8,40,40,80,C0,80,40,00,07,1E,CF,7E,9F,FD,BC,60,B8,E0,60,E0,40,C0,40,40,
                        F8,00,C0,00,00,00,00,00,00,00,00,00,00,00,00,00,F8,78,C0,C0,00,00,00,00,00,00,00,00,00,00,00,00,
                        02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        0E,19,07,0F,10,0C,17,0D,00,06,02,07,00,03,00,00,28,38,34,1C,37,18,17,08,03,04,02,05,00,03,00,00,
                        5E,F8,9D,F0,38,64,20,C8,50,80,60,80,C0,00,00,00,07,3C,0F,79,9C,F4,38,C8,70,C0,60,E0,C0,C0,00,00,
                        FC,00,18,00,00,00,00,00,00,00,00,00,00,00,00,00,FC,FC,18,18,00,00,00,00,00,00,00,00,00,00,00,00,
                        0E,07,05,01,0A,08,01,00,00,00,00,00,00,00,00,00,18,07,0E,03,0F,01,03,00,00,00,00,00,00,00,00,00,
                        46,FE,3D,FD,97,63,56,7F,15,A5,5D,3C,22,18,00,00,01,81,22,C3,BC,47,99,66,DB,66,5B,67,26,3E,00,00,
                        B0,88,D8,A8,A0,40,C0,80,00,00,00,00,00,00,00,00,78,E0,78,C0,E0,80,C0,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,0F,00,10,0C,27,10,2B,17,2C,04,2C,04,00,00,00,00,0F,00,1F,0C,3F,10,3F,10,3C,00,3C,00,
                        00,00,00,00,FF,00,00,00,FF,00,FF,FF,00,00,00,00,00,00,00,00,FF,00,FF,00,FF,00,FF,00,00,00,00,00,
                        00,00,00,00,E0,10,10,68,CC,14,CC,F4,2C,04,2C,04,00,00,00,00,F0,00,F8,60,FC,10,FC,10,3C,00,3C,00,
                        2C,04,28,14,27,10,10,2C,0F,10,0F,0F,00,00,00,00,3C,00,3C,10,3F,10,3F,0C,1F,00,0F,00,00,00,00,00,
                        2C,04,2C,14,CC,34,14,6C,E8,18,F0,F0,00,00,00,00,3C,00,3C,10,FC,10,FC,60,F8,00,F0,00,00,00,00,00,
                        3C,00,00,3F,00,00,00,3F,00,00,3F,00,00,3F,3C,02,3E,00,3F,00,3F,00,3F,3F,3F,00,3F,00,3F,00,3E,00,
                        00,00,50,F0,18,48,54,AC,14,4C,E8,58,50,F0,00,00,00,00,F0,00,F0,08,F0,AC,F0,0C,F0,08,F0,00,00,00,
                        00,00,00,00,00,00,00,7C,3A,04,02,04,02,44,22,44,00,00,00,00,00,00,7C,7C,3E,3E,06,06,46,46,66,66,
                        00,00,00,00,00,00,40,84,4A,84,40,BE,43,84,42,84,00,00,00,00,00,00,C4,C4,CE,CE,FE,FE,C7,C7,C6,C6,
                        00,00,00,00,00,00,00,20,10,20,00,FE,5D,22,11,22,00,00,00,00,00,00,20,20,30,30,FE,FE,7F,7F,33,33,
                        00,00,00,00,00,00,00,00,00,82,01,42,21,42,23,04,00,00,00,00,00,00,00,00,82,82,43,43,63,63,27,27,
                        00,00,00,00,00,00,00,1E,05,4A,25,4A,05,EA,35,4A,00,00,00,00,00,00,1E,1E,4F,4F,6F,6F,EF,EF,7F,7F,
                        00,00,00,00,00,00,00,22,31,42,21,42,21,42,21,42,00,00,00,00,00,00,22,22,73,73,63,63,63,63,63,63,
                        00,00,00,00,00,44,00,EE,33,44,00,EE,33,44,54,AA,00,00,00,00,44,44,EE,EE,77,77,EE,EE,77,77,FE,FE,
                        00,00,00,00,00,00,00,20,20,18,0C,00,00,7C,36,08,00,00,00,00,00,00,20,20,38,38,0C,0C,7C,7C,3E,3E,
                        00,00,00,00,00,A4,00,F7,54,A9,0A,F5,A9,52,2A,D5,00,00,00,00,A4,A4,F7,F7,FD,FD,FF,FF,FB,FB,FF,FF,
                        00,00,00,00,00,10,08,50,28,50,00,7C,2E,D0,68,10,00,00,00,00,10,10,58,58,78,78,7C,7C,FE,FE,78,78,
                        00,00,00,00,00,88,84,48,40,3E,17,88,84,48,40,3E,00,00,00,00,88,88,CC,CC,7E,7E,9F,9F,CC,CC,7E,7E,
                        00,00,00,00,00,08,00,5E,35,4A,60,9F,55,0A,05,4A,00,00,00,00,08,08,5E,5E,7F,7F,FF,FF,5F,5F,4F,4F,
                        00,00,00,00,00,44,00,EE,33,44,00,EE,B3,44,02,38,00,00,00,00,44,44,EE,EE,77,77,EE,EE,F7,F7,3A,3A,
                        00,00,00,00,00,00,00,40,20,40,20,40,20,40,20,40,00,00,00,00,00,00,40,40,60,60,60,60,60,60,60,60,
                        3E,02,38,39,02,3C,00,3F,00,00,3F,00,00,3F,1C,1C,3E,00,3F,00,3F,3C,3F,03,3F,00,3F,00,3F,00,1C,00,
                        00,00,50,F0,18,40,54,A0,14,40,E8,50,50,F0,00,00,00,00,F0,00,F8,08,FC,AC,FC,0C,F8,08,F0,00,00,00,
                        16,28,14,28,0C,10,08,10,14,28,30,46,23,00,00,00,3E,3E,3C,3C,1C,1C,18,18,3C,3C,76,76,23,23,00,00,
                        42,84,42,84,40,9E,5B,A4,46,98,4C,00,00,00,00,00,C6,C6,C6,C6,DE,DE,FF,FF,DE,DE,4C,4C,00,00,00,00,
                        11,22,31,42,21,42,21,42,63,8C,46,00,00,00,00,00,33,33,73,73,63,63,63,63,EF,EF,46,46,00,00,00,00,
                        02,04,06,08,04,08,0C,10,18,20,10,00,00,00,00,00,06,06,0E,0E,0C,0C,1C,1C,38,38,10,10,00,00,00,00,
                        25,4A,25,4A,05,6A,35,4A,2D,12,19,26,13,00,00,00,6F,6F,6F,6F,6F,6F,7F,7F,3F,3F,3F,3F,13,13,00,00,
                        11,62,31,02,03,04,02,04,06,08,04,00,00,00,00,00,73,73,33,33,07,07,06,06,0E,0E,04,04,00,00,00,00,
                        55,00,00,7C,3A,44,02,74,3A,44,02,7C,3E,00,00,00,55,55,7C,7C,7E,7E,76,76,7E,7E,7E,7E,3E,3E,00,00,
                        0C,10,00,38,34,48,64,88,40,86,43,00,00,00,00,00,1C,1C,38,38,7C,7C,EC,EC,C6,C6,43,43,00,00,00,00,
                        01,7E,07,38,20,1C,00,7E,21,42,01,7E,3F,00,00,00,7F,7F,3F,3F,3C,3C,7E,7E,63,63,7F,7F,3F,3F,00,00,
                        00,FE,7F,00,00,7C,3A,44,22,44,02,7C,3E,00,00,00,FE,FE,7F,7F,7C,7C,7E,7E,66,66,7E,7E,3E,3E,00,00,
                        17,08,04,48,2C,52,69,92,41,9E,4D,B2,59,00,00,00,1F,1F,4C,4C,7E,7E,FB,FB,DF,DF,FF,FF,59,59,00,00,
                        21,5E,27,C8,A0,5E,27,48,20,5E,27,48,24,00,00,00,7F,7F,EF,EF,FE,FE,6F,6F,7E,7E,6F,6F,24,24,00,00,
                        1C,00,00,7C,0E,10,08,54,2A,54,68,92,49,00,00,00,1C,1C,7C,7C,1E,1E,5C,5C,7E,7E,FA,FA,49,49,00,00,
                        20,40,20,42,21,42,23,44,06,38,1C,00,00,00,00,00,60,60,62,62,63,63,67,67,3E,3E,1C,1C,00,00,00,00,
                        00,00,00,0A,05,0A,05,40,20,40,20,40,20,40,20,40,00,00,0A,0A,0F,0F,45,45,60,60,60,60,60,60,60,60,
                        00,00,00,00,00,00,00,38,04,28,04,38,1C,00,00,00,00,00,00,00,00,00,38,38,2C,2C,3C,3C,1C,1C,00,00,
                        00,00,00,00,00,00,00,30,10,0C,0E,00,00,40,20,5C,00,00,00,00,00,00,30,30,1C,1C,0E,0E,40,40,7C,7C,
                        00,00,00,00,00,00,00,40,20,4C,2C,D2,19,62,11,62,00,00,00,00,00,00,40,40,6C,6C,FE,FE,7B,7B,73,73,
                        00,00,00,00,00,00,00,00,00,FE,77,08,0C,10,18,20,00,00,00,00,00,00,00,00,FE,FE,7F,7F,1C,1C,38,38,
                        00,00,00,00,00,00,00,00,00,80,40,84,44,82,41,82,00,00,00,00,00,00,00,00,80,80,C4,C4,C6,C6,C3,C3,
                        00,00,00,00,00,00,00,08,00,7E,37,08,04,08,00,7E,00,00,00,00,00,00,08,08,7E,7E,3F,3F,0C,0C,7E,7E,
                        00,00,00,00,00,08,04,08,00,FE,77,08,04,08,04,38,00,00,00,00,08,08,0C,0C,FE,FE,7F,7F,0C,0C,3C,3C,
                        00,00,00,00,00,00,00,04,06,08,0C,10,18,20,30,40,00,00,00,00,00,00,04,04,0E,0E,1C,1C,38,38,70,70,
                        00,00,00,00,00,F8,2C,50,20,5E,0D,72,29,52,01,7A,00,00,00,00,F8,F8,7C,7C,7E,7E,7F,7F,7B,7B,7B,7B,
                        00,00,00,00,00,5E,25,4A,25,4A,05,EA,33,4C,20,4E,00,00,00,00,5E,5E,6F,6F,6F,6F,EF,EF,7F,7F,6E,6E,
                        00,00,00,00,00,4A,05,4A,00,FE,6D,12,09,D2,69,12,00,00,00,00,4A,4A,4F,4F,FE,FE,7F,7F,DB,DB,7B,7B,
                        00,00,00,00,00,0E,05,0A,05,EA,51,AE,55,AA,15,EA,00,00,00,00,0E,0E,0F,0F,EF,EF,FF,FF,FF,FF,FF,FF,
                        00,00,00,10,00,7C,2A,14,00,FE,6B,14,02,7C,2E,10,00,00,10,10,7C,7C,3E,3E,FE,FE,7F,7F,7E,7E,3E,3E,
                        00,00,00,00,00,00,00,20,10,20,00,FC,5E,20,00,76,00,00,00,00,00,00,20,20,30,30,FC,FC,7E,7E,76,76,
                        00,00,00,00,08,10,12,24,01,7E,2F,10,00,FE,57,28,00,00,00,00,18,18,36,36,7F,7F,3F,3F,FE,FE,7F,7F,
                        00,00,00,00,00,00,00,1E,05,EA,55,AA,55,AA,15,E0,00,00,00,00,00,00,1E,1E,EF,EF,FF,FF,FF,FF,F5,F5,
                        00,00,00,00,00,00,00,00,00,38,28,54,6C,92,49,92,00,00,00,00,00,00,00,00,38,38,7C,7C,FE,FE,DB,DB,
                        1C,62,31,42,21,02,03,04,06,18,0C,00,00,00,00,00,7E,7E,73,73,23,23,07,07,1E,1E,0C,0C,00,00,00,00,
                        33,C4,22,C4,22,44,22,44,21,42,21,00,00,00,00,00,F7,F7,E6,E6,66,66,66,66,63,63,21,21,00,00,00,00,
                        10,20,10,20,10,20,00,10,00,0C,06,00,00,00,00,00,30,30,30,30,30,30,10,10,0C,0C,06,06,00,00,00,00,
                        41,82,41,82,41,A2,31,40,20,40,20,00,00,00,00,00,C3,C3,C3,C3,E3,E3,71,71,60,60,20,20,00,00,00,00,
                        37,08,04,08,02,7C,75,8A,0D,70,38,00,00,00,00,00,3F,3F,0C,0C,7E,7E,FF,FF,7D,7D,38,38,00,00,00,00,
                        34,48,24,48,04,38,14,08,0C,30,18,00,00,00,00,00,7C,7C,6C,6C,3C,3C,1C,1C,3C,3C,18,18,00,00,00,00,
                        20,40,00,20,20,10,10,08,08,04,06,00,00,00,00,00,60,60,20,20,30,30,18,18,0C,0C,06,06,00,00,00,00,
                        25,5A,05,7A,23,D4,6A,14,04,1A,0D,10,08,00,00,00,7F,7F,7F,7F,F7,F7,7E,7E,1E,1E,1D,1D,08,08,00,00,
                        25,4A,05,6A,35,CA,29,56,2B,54,15,6A,15,00,00,00,6F,6F,6F,6F,FF,FF,7F,7F,7F,7F,7F,7F,15,15,00,00,
                        01,DE,6B,04,02,D4,AA,54,AA,54,18,E6,73,00,00,00,DF,DF,6F,6F,D6,D6,FE,FE,FE,FE,FE,FE,73,73,00,00,
                        55,AA,51,AE,15,EA,69,12,09,12,19,26,13,00,00,00,FF,FF,FF,FF,FF,FF,7B,7B,1B,1B,3F,3F,13,13,00,00,
                        02,7C,00,FE,3B,44,02,7C,3A,44,02,7C,3E,00,00,00,7E,7E,FE,FE,7F,7F,7E,7E,7E,7E,7E,7E,3E,3E,00,00,
                        67,98,4C,30,28,50,28,40,00,3E,1F,00,00,00,00,00,FF,FF,7C,7C,78,78,68,68,3E,3E,1F,1F,00,00,00,00,
                        22,44,49,B2,85,08,0C,30,18,04,06,38,1C,00,00,00,66,66,FB,FB,8D,8D,3C,3C,1C,1C,3E,3E,1C,1C,00,00,
                        50,AE,55,AA,11,EE,77,00,00,AA,55,AA,55,00,00,00,FE,FE,FF,FF,FF,FF,77,77,AA,AA,FF,FF,55,55,00,00,
                        49,92,59,A2,51,A2,33,44,26,08,04,00,00,00,00,00,DB,DB,FB,FB,F3,F3,77,77,2E,2E,04,04,00,00,00,00,
                        00,01,01,02,03,04,07,08,0F,10,1F,20,3F,40,7F,80,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,01,01,02,03,04,07,08,0F,10,1F,20,3F,40,7F,80,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        01,00,02,01,04,03,08,07,10,0F,20,1F,40,3F,80,7F,FF,00,FE,00,FC,00,F8,00,F0,00,E0,00,C0,00,80,00,
                        00,01,01,02,03,04,07,08,0F,10,1F,20,3F,40,7F,80,FE,00,FC,00,F8,00,F0,00,E0,00,C0,00,80,00,00,00,
                        40,FF,A0,7F,D0,3F,E8,1F,F4,0F,FA,07,FD,03,FE,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FE,01,FD,02,FB,04,F7,08,EF,10,DF,20,BF,40,7F,80,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        01,01,02,03,04,07,08,0F,10,1F,20,3F,40,7F,80,FF,01,00,03,00,07,00,0F,00,1F,00,3F,00,7F,00,FF,00,
                        00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FE,01,FD,03,FB,07,F7,0F,EF,1F,DF,3F,BF,7F,7F,FF,00,FF,01,FE,03,FC,07,F8,0F,F0,1F,E0,3F,C0,7F,80,
                        FF,01,FE,03,FC,07,F8,0F,F0,1F,E0,3F,C0,7F,80,FF,01,FE,03,7C,07,38,0F,10,1F,20,3F,40,7F,80,FF,00,
                        BF,BF,5F,DF,2F,EF,17,F7,0B,FB,05,FD,02,FE,01,FF,BF,40,DF,20,EF,10,F7,08,FB,04,FD,02,FE,01,FF,00,
                        01,FF,02,FF,04,FF,08,FF,10,FF,20,FF,40,FF,80,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,00,01,01,03,03,07,07,0F,0F,1F,1F,3F,3F,7F,7F,01,01,02,03,04,07,08,0F,10,1F,20,3F,40,7F,80,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        7F,80,3F,C0,1F,E0,0F,F0,07,F8,03,FC,01,FE,00,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,00,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        80,FF,40,7F,20,3F,10,1F,08,0F,04,07,02,03,01,01,00,00,80,00,C0,00,E0,00,F0,00,F8,00,FC,00,FE,00,
                        80,FF,C0,7E,E0,3C,F0,18,F8,08,FC,04,FE,02,FF,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        01,00,03,00,07,00,0F,00,1F,00,3F,00,7F,00,FF,00,FF,00,FE,00,FC,00,F8,00,F0,00,E0,00,C0,00,80,00,
                        01,FF,03,FE,07,FC,0F,F8,1F,F0,3F,E0,7F,C0,FF,80,FF,FF,FE,FE,FC,FC,F8,F8,F0,F0,E0,E0,C0,C0,80,80,
                        80,FF,C0,FF,E0,FF,F0,FF,F8,FF,FC,FF,FE,FF,FF,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,FF,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        01,FF,03,FE,07,FC,0F,F8,1F,F0,3F,E0,7F,C0,FF,80,FF,00,FE,01,FC,03,F8,07,F0,0F,E0,1F,C0,3F,80,7F,
                        7F,7F,BF,3F,DF,1F,EF,0F,F7,07,FB,03,FD,01,FE,00,7F,80,3F,C0,1F,E0,0F,F0,07,F8,03,FC,01,FE,00,FF,
                        7F,7F,3F,BF,1F,DF,0F,EF,07,F7,03,FB,01,FD,00,FE,7F,80,BF,40,DF,20,EF,10,F7,08,FB,04,FD,02,FE,01,
                        FE,01,FC,03,F8,07,F0,0F,E0,1F,C0,3F,80,7F,00,FF,00,FF,01,FE,03,FC,07,F8,0F,F0,1F,E0,3F,C0,7F,80,
                        7F,7F,3F,3F,1F,1F,0F,0F,07,07,03,03,01,01,00,00,80,FF,C0,FF,E0,FF,F0,FF,F8,FF,FC,FF,FE,FF,FF,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,FF,FF,
                        80,FF,40,7F,20,3F,10,1F,08,0F,04,07,02,03,01,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        01,00,02,00,04,00,08,00,10,00,20,00,40,00,80,00,FF,00,FE,00,FC,00,F8,00,F0,00,E0,00,C0,00,80,00,
                        00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        7F,7F,3F,3F,1F,1F,0F,0F,07,07,03,03,01,01,00,00,7F,80,3F,40,1F,20,0F,10,07,08,03,04,01,02,00,01,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        FE,01,FC,02,F8,04,F0,08,E0,10,C0,20,80,40,00,80,00,FF,00,FE,00,FC,00,F8,00,F0,00,E0,00,C0,00,80,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        80,00,40,00,20,00,10,00,08,00,04,00,02,00,01,00,FF,FF,7F,7F,3F,3F,1F,1F,0F,0F,07,07,03,03,01,01,
                        FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        01,FF,02,FE,04,FC,08,F8,10,F0,20,E0,40,C0,80,80,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        00,FE,01,FD,03,FB,07,F7,0F,EF,1F,DF,3F,BF,7F,7F,FF,7F,FE,3F,FC,1F,F8,1F,F0,3F,E0,7F,C0,FF,80,FF,
                        42,01,A4,83,D8,C7,E8,E7,F4,F3,FA,F9,FD,FC,FE,FE,FF,FE,7F,FC,3F,F8,1F,F8,0F,FC,07,FE,03,FF,01,FF,
                        FE,FE,FD,FD,FB,FB,F7,F7,EF,EF,DF,DF,BF,BF,7F,7F,01,FF,02,FF,04,FF,08,FF,10,FF,20,FF,40,FF,80,FF,
                        FE,01,FD,02,FB,04,F7,08,EF,10,DF,20,BF,40,7F,80,00,FE,00,FC,00,F8,00,F0,00,E0,00,C0,00,80,00,00,
                        7F,FF,BF,7F,DF,3F,EF,1F,F7,0F,FB,07,FD,03,FE,01,7F,00,3F,00,1F,00,0F,00,07,00,03,00,01,00,00,00,
                        01,FF,02,FF,04,FF,08,FF,10,FF,20,FF,40,FF,80,FF,FF,FE,FF,FC,FF,F8,FF,F0,FF,E0,FF,C0,FF,80,FF,00,
                        80,80,40,C0,20,E0,10,F0,08,F8,04,FC,02,FE,01,FF,FF,7F,FF,3F,FF,1F,FF,0F,FF,07,FF,03,FF,01,FF,00,
                        FE,00,FD,01,FB,03,F7,07,EF,0F,DF,1F,BF,3F,7F,7F,01,FF,02,FF,04,FF,08,FF,10,FF,20,FF,40,FF,80,FF,
                        7F,7F,BF,BF,DF,DF,EF,EF,F7,F7,FB,FB,FD,FD,FE,FE,FF,80,7F,C0,3F,E0,1F,F0,0F,F8,07,FC,03,FE,01,FF,
                        00,7E,01,BD,03,DB,07,E7,0F,EF,1F,DF,3F,BF,7F,7F,7F,81,BE,43,DC,27,E8,1F,F0,1F,E0,3F,C0,7F,80,FF,
                        FE,00,FD,01,FB,03,F7,07,EF,0F,DF,1F,BF,3F,7F,7F,01,01,02,03,04,07,08,0F,10,1F,20,3F,40,7F,80,FF,
                        FE,FE,FC,FD,F8,FB,F0,F7,E0,EF,C0,DF,80,BF,00,7F,01,FF,03,FF,07,FF,0F,FF,1F,FF,3F,FF,7F,FF,FF,FF,
                        80,00,40,80,20,C0,10,E0,08,F0,04,F8,02,FC,01,FE,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        80,00,C0,80,E0,C0,F0,E0,F8,F0,FC,F8,FE,FC,FF,FE,FE,FE,7C,FC,38,F8,10,F0,08,F8,04,FC,02,FE,01,FF,
                        01,7F,03,3F,07,1F,0F,0F,1F,1F,3F,3F,7F,7F,FF,FF,7F,7F,3E,3F,1C,1F,08,0F,10,1F,20,3F,40,7F,80,FF,
                        00,FE,01,FD,03,FB,07,F7,0F,EF,1F,DF,3F,BF,7F,7F,FF,01,FE,03,FC,07,F8,0F,F0,1F,E0,3F,C0,7F,80,FF,
                        01,01,82,83,C4,C7,E8,EF,F0,F7,F8,FB,FC,FD,FE,FE,81,80,43,C0,27,E0,1F,F0,0F,F8,07,FC,03,FE,01,FF,
                        01,FF,02,FE,04,FC,08,F8,10,F0,20,E0,40,C0,80,80,FF,FF,FE,FE,FC,FC,F8,F8,F0,F0,E0,E0,C0,C0,80,80,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        80,FF,40,FF,20,FF,10,FF,08,FF,04,FF,02,FF,01,FF,00,00,80,00,C0,00,E0,00,F0,00,F8,00,FC,00,FE,00,
                        01,00,02,01,04,03,08,07,10,0F,20,1F,40,3F,80,7F,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        7F,7F,BF,BF,DF,DF,EF,EF,F7,F7,FB,FB,FD,FD,FE,FE,7F,80,3F,C0,1F,E0,0F,F0,07,F8,03,FC,01,FE,00,FF,
                        FE,01,FD,03,FB,07,F7,0F,EF,1F,DF,3F,BF,7F,7F,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        80,00,40,80,20,C0,10,E0,08,F0,04,F8,02,FC,01,FE,FF,FF,FF,7F,FF,3F,FF,1F,FF,0F,FF,07,FF,03,FF,01,
                        01,FF,02,FF,04,FF,08,FF,10,FF,20,FF,40,FF,80,FF,FF,FF,FF,FE,FF,FC,FF,F8,FF,F0,FF,E0,FF,C0,FF,80,
                        80,00,C0,80,E0,C0,F0,E0,F8,F0,FC,F8,FE,FC,FF,FE,FF,FF,FF,7F,FF,3F,FF,1F,FF,0F,FF,07,FF,03,FF,01,
                        01,FF,03,FE,07,FC,0F,F8,1F,F0,3F,E0,7F,C0,FF,80,FF,FF,FE,FF,FC,FF,F8,FF,F0,FF,E0,FF,C0,FF,80,FF,
                        80,00,C0,00,E0,00,F0,00,F8,00,FC,00,FE,00,FF,00,FF,FF,7F,7F,3F,3F,1F,1F,0F,0F,07,07,03,03,01,01,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        64,64,CA,EA,AD,CD,45,95,55,AD,35,4D,8A,AA,64,74,5C,7C,96,FE,13,FF,2B,BB,23,A3,83,45,D6,AA,4C,7C,
                        BD,BD,4B,46,85,83,CB,C7,BD,B9,4A,66,2C,24,18,18,BD,BD,FF,42,FF,81,FF,C3,BD,FF,7E,42,3C,24,18,18,
                        10,00,38,00,6C,18,64,20,6C,18,DA,2C,FA,04,D6,00,10,10,28,38,44,7C,5C,7C,44,7C,82,FE,AA,FE,D6,D6,
                        3C,3C,5A,66,A5,C3,C3,91,A5,C3,5A,66,3C,3C,00,00,3C,3C,42,7E,81,FF,91,FF,81,FF,42,7E,3C,3C,00,00,
                        3C,3C,42,3C,5A,7E,52,7E,4A,7E,5A,7E,42,3C,FF,FF,3C,3C,7E,3C,24,7E,2C,7E,34,7E,24,7E,7E,3C,FF,FF,
                        22,22,77,55,7F,49,7F,41,7F,55,7F,5D,22,22,00,00,22,22,55,55,49,49,41,41,55,55,5D,5D,22,22,00,00,
                        3C,00,7E,3C,7C,20,7C,38,7C,20,7E,3C,3C,00,00,00,00,00,00,3C,00,20,00,38,00,20,00,3C,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,01,01,06,07,0B,0C,24,38,00,00,00,00,00,00,00,00,01,00,07,00,0F,00,3F,00,
                        00,00,00,00,0E,0F,73,7C,BE,C0,40,80,18,38,C4,CE,00,00,00,00,0F,00,7F,00,FF,00,FF,00,C7,00,31,00,
                        07,07,E1,FE,F0,00,07,07,FB,FB,7E,7E,32,3F,03,1C,07,18,FF,00,FF,00,F8,00,04,00,81,00,C0,00,E0,00,
                        FF,FF,F8,07,07,00,C0,C0,FC,FC,F4,F4,3C,FC,87,7F,FF,00,FF,00,FF,00,3F,00,03,00,0B,00,03,00,00,00,
                        80,80,38,F8,F9,07,1F,00,E8,00,28,0F,11,1F,A9,FF,80,70,F8,06,FF,00,FF,00,FF,00,F0,00,E0,00,00,00,
                        00,00,00,00,00,00,C0,20,3C,04,4C,C3,0F,00,FB,F8,00,00,00,00,00,C0,E0,10,FC,00,3F,00,FF,00,07,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,80,80,60,00,00,00,00,00,00,00,00,00,00,00,00,80,40,E0,00,
                        00,00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,10,10,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,
                        00,00,01,01,00,01,02,03,05,07,01,07,0E,0F,1E,1F,00,00,01,00,01,00,03,00,07,00,07,08,0F,10,1F,00,
                        AD,C0,42,BC,22,FC,F0,FE,E4,FA,E6,B8,6D,D1,5D,E1,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FE,00,FE,80,
                        E6,79,97,18,B7,38,53,1C,D9,9E,A8,0F,05,C6,30,F3,80,00,E0,00,C0,00,E0,00,60,00,70,00,38,00,0C,00,
                        FF,00,7F,80,9F,60,C3,3C,E6,19,07,F8,E2,1D,1F,EF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        F8,06,FD,03,FE,01,7E,81,3F,C0,3F,C0,8B,74,FD,8E,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        DD,13,FF,F1,EF,F0,9F,60,FF,00,FF,00,FF,00,FB,04,E0,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,01,01,03,03,04,07,08,0F,17,18,2E,30,53,60,00,00,01,00,03,00,07,00,0F,00,1F,00,3F,00,7F,00,
                        58,61,A3,CB,61,8F,5C,9F,F6,3D,F3,7C,3F,38,4F,70,7E,00,F4,00,F0,00,E0,00,C0,00,80,00,C0,00,80,00,
                        2E,F9,B1,F6,8B,7B,F8,04,6C,92,BF,41,FE,01,FF,00,00,00,08,00,04,00,03,00,01,00,00,00,00,00,00,00,
                        07,F0,40,A7,E0,F8,88,8F,35,06,33,03,C4,DC,F8,06,08,00,18,00,07,00,70,00,F8,00,FC,00,23,00,01,00,
                        F7,0F,C1,3F,1F,FF,06,06,F9,39,3C,BC,E1,FE,5C,02,00,00,00,00,00,00,F9,00,06,00,43,00,01,00,E1,00,
                        9C,9F,07,07,E3,E3,21,01,32,00,CD,0C,98,1C,94,1A,60,00,F8,00,1C,00,FE,00,FF,00,F3,00,E3,00,E1,00,
                        30,F0,8C,FC,C4,FC,F0,FC,B0,B0,00,01,08,0F,9D,1F,0F,00,03,00,03,00,03,00,4F,00,FE,00,F0,00,E0,00,
                        E0,10,7C,04,16,02,01,00,78,78,F7,FF,C3,C7,CD,CF,F0,08,FC,02,FE,01,FF,00,87,00,00,00,38,00,30,00,
                        00,00,00,00,00,00,00,00,C0,40,20,20,90,90,E8,E8,00,00,00,00,00,00,00,80,C0,00,E0,00,70,00,18,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,01,01,01,01,00,00,00,00,00,00,00,00,00,00,00,01,01,00,01,00,
                        1C,1F,34,3F,6D,77,6E,7F,DC,EF,AD,DE,A9,DE,5B,FC,1F,21,3F,01,7F,02,7F,80,FF,00,FF,00,FF,00,FF,00,
                        32,C3,BA,C3,6A,83,43,83,C7,07,87,07,AD,0D,3D,1D,FC,80,FC,00,FC,00,FC,00,F8,00,F8,00,F2,00,E2,00,
                        C8,B9,AF,DF,B6,CF,93,EF,19,E7,3D,C3,3C,C3,3F,C0,06,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        C6,3A,71,8F,6A,95,29,D6,9F,E2,F7,FA,7E,FF,22,E3,01,00,00,00,00,00,00,00,00,00,00,00,00,00,1C,00,
                        BF,C6,6F,70,30,1F,70,D3,E3,43,F0,60,B3,78,1B,D8,00,00,80,00,C0,00,0C,00,1C,00,0F,00,07,00,27,00,
                        FD,02,4E,B1,DE,31,77,89,97,E9,DE,E9,E1,FE,34,3F,00,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,
                        5C,52,83,C6,60,E1,C1,37,EF,18,FF,0C,FE,05,FF,02,A1,00,39,00,1E,00,08,00,00,00,00,00,00,00,00,00,
                        8E,0E,00,00,F7,F7,27,FF,EC,13,F4,0B,3F,C0,9F,60,F1,00,FF,00,08,00,00,00,00,00,00,00,00,00,00,00,
                        24,27,D2,D3,F9,F9,38,F8,1F,FF,18,F8,48,B8,EB,1F,D8,00,2C,00,06,00,07,00,00,00,07,00,07,00,00,00,
                        34,F4,18,F8,6C,9C,69,94,34,FA,5E,DE,90,90,F1,F0,0C,00,04,02,02,01,03,00,01,00,21,00,6F,00,0F,00,
                        00,00,00,00,00,00,00,00,80,00,00,40,C0,00,C0,20,00,00,00,00,00,00,00,80,80,00,C0,00,C0,20,E0,10,
                        03,03,02,03,02,03,06,07,06,07,07,07,0F,0F,0D,0F,03,00,03,00,03,04,07,00,07,08,07,08,0F,00,0F,00,
                        41,FE,A3,DC,BF,C0,2E,C0,2D,C1,76,C0,76,C0,33,C0,FF,00,FF,00,FF,00,FF,00,FE,00,FF,00,FF,00,FF,00,
                        59,19,C1,01,E3,03,37,07,D8,D8,E7,E0,0F,00,6F,00,E6,00,FE,00,FC,00,F8,00,27,00,1F,00,FF,00,FF,00,
                        0F,F0,87,F8,E3,FC,21,3E,39,3E,04,07,83,03,F1,01,00,00,00,00,00,00,C0,00,C0,00,F8,00,FC,00,FE,00,
                        D1,31,DE,3E,E4,1F,F6,0F,F3,0E,0B,F6,3F,C2,8E,F3,0E,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        C4,C3,0E,81,C3,C0,F2,F0,BC,7C,8F,7F,F7,1F,FB,07,3F,00,7F,00,3F,00,0F,00,03,00,00,00,00,00,00,00,
                        FE,3F,41,81,2C,CC,E3,03,3C,01,F6,F0,DF,FE,C6,FE,C0,00,FE,00,F3,00,FC,00,FE,00,0F,00,01,00,01,00,
                        58,DF,2E,EF,26,27,00,00,C1,C0,30,F0,C2,02,3F,3F,20,00,10,00,D8,00,FF,00,3F,00,0F,00,FD,00,C0,00,
                        8C,7F,42,BF,39,FF,7F,7F,00,00,70,00,1F,00,87,80,00,00,00,00,00,00,80,00,FF,00,FF,00,FF,00,7F,00,
                        F3,0C,39,C6,03,FC,E2,FF,F9,F9,00,00,86,00,FB,00,00,00,00,00,00,00,00,00,06,00,FF,00,FF,00,FF,00,
                        A3,7F,C0,3E,F3,33,9C,7C,C7,E7,E0,E0,0B,08,38,00,00,00,01,00,0C,00,03,00,18,00,1F,00,F7,00,FF,00,
                        FF,02,FF,01,B3,4D,2F,D1,A9,D6,F6,C9,D6,E9,A1,3E,00,00,00,00,00,00,00,00,00,00,00,00,00,00,40,00,
                        E7,18,F9,06,FD,02,FE,81,CF,70,67,B8,13,FC,99,6E,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,0F,FB,07,FC,03,FF,01,7E,81,BE,41,9E,61,C7,38,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        F1,F0,F7,F0,08,80,B3,B0,26,E0,23,E0,40,F0,7E,8E,0F,00,0F,00,7F,00,4F,00,1F,00,1F,00,0F,00,01,00,
                        E0,10,E0,10,60,18,E4,1C,30,0C,F2,0E,78,06,1C,02,F0,08,F0,08,F8,04,FC,00,FC,02,FE,01,FE,01,FE,01,
                        0B,0B,16,17,14,17,0D,0F,09,1F,19,1D,1A,1F,12,1F,0B,14,17,09,17,0B,0F,12,1F,16,1D,26,1F,24,1F,2C,
                        89,F0,50,E8,74,E8,76,F8,31,FE,31,FE,30,FF,38,7F,FF,00,FF,80,FF,80,FF,80,FF,C0,FF,C0,FF,C0,7F,C0,
                        A0,2F,DB,C7,4A,45,F7,00,12,81,47,98,54,AB,BA,6D,DF,00,3F,00,BF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        B8,40,0C,F0,03,FC,81,7E,00,FF,0B,FF,6F,FF,E7,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        73,7F,19,1F,04,07,E3,03,70,80,18,E0,4E,F0,F0,FF,80,00,E0,00,F8,00,FC,00,FF,00,FF,00,FF,00,FF,00,
                        7F,80,1F,E0,76,EF,29,F9,19,79,41,61,A1,20,00,80,00,00,00,00,00,00,06,00,86,00,9E,00,DF,00,FF,00,
                        F9,07,2E,FF,90,F8,32,30,04,02,F4,02,B2,01,FC,03,00,00,00,00,07,00,CF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,3D,FF,0F,7F,22,7A,1C,00,3E,0F,60,00,1C,C1,00,00,00,00,80,00,85,00,FF,00,F0,00,FF,00,FE,00,
                        E1,E0,F4,F0,4F,43,55,44,EB,C0,D6,C1,0E,01,43,20,1F,00,0F,00,BC,00,BB,00,3F,00,3F,00,FF,00,DF,00,
                        BB,44,81,7E,B0,8F,C7,38,16,E1,43,80,A5,18,5D,26,FF,00,FF,00,7F,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        CF,00,FB,04,58,A7,07,F8,E1,1E,03,FF,80,7F,EF,7F,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,00,00,00,18,00,3C,18,3C,18,18,00,00,00,00,00,00,00,00,00,18,18,24,3C,24,3C,18,18,00,00,00,00,
                        38,07,EC,83,1C,03,0E,01,84,83,0C,03,5C,03,F9,06,FF,00,7F,00,FF,00,FF,00,7F,00,FF,00,FF,00,FF,00,
                        00,00,00,00,00,80,00,80,00,80,00,C0,00,C0,00,C0,00,80,00,80,80,40,80,40,80,40,C0,20,C0,20,C0,20,
                        11,1D,11,1D,12,1F,12,1F,12,1F,03,1F,03,1F,01,0F,1D,2E,1D,2E,1F,2F,1F,2F,1F,2F,1F,3F,1F,3F,0F,3F,
                        19,7F,0F,7F,06,7F,81,FF,89,FF,8D,FF,85,FF,86,FF,7F,E0,7F,F0,7F,F0,FF,FC,FF,F0,FF,F2,FF,FA,FF,F8,
                        73,FD,7B,E6,9A,EF,F6,EF,EF,DF,9F,FF,1F,FF,4D,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,20,FF,32,
                        27,FF,26,FF,66,FF,EC,FF,CD,FA,92,FC,F1,FE,E9,FE,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        EE,FF,F7,FF,3F,FF,9F,7F,C3,3F,5E,41,3B,38,DB,03,FF,00,FF,00,FF,00,FF,00,FF,00,BF,00,C7,00,FC,00,
                        4F,80,38,C7,B7,CF,C7,FF,FF,FF,7F,FF,A0,7F,EB,97,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,7F,00,
                        FD,03,31,CF,C7,FF,FF,FF,D9,FF,FD,FF,6D,9F,04,FB,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,02,FF,F1,
                        80,E0,B8,C0,9B,E0,7D,80,37,C8,4F,F0,F2,FD,3E,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,80,FF,00,FF,C0,
                        07,20,27,10,AF,00,B3,00,D8,00,2F,C0,DE,21,19,E6,DF,00,EF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        7E,01,FD,02,DC,03,9D,02,38,07,F0,0F,EB,1F,0E,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        74,BF,9F,FF,6D,DF,DC,6F,EB,7F,69,FF,7C,FF,6C,FF,FF,00,FF,00,FF,02,FF,03,FF,04,FF,06,FF,03,FF,83,
                        F0,FF,0E,FF,FF,FF,3D,FF,87,FF,E3,FF,F0,FF,F0,FF,FF,00,FF,00,FF,00,FF,C0,FF,78,FF,1C,FF,0F,FF,0F,
                        10,F0,10,F0,B0,F0,F0,F0,60,F0,F0,F0,A0,F0,00,E0,F0,08,F0,08,F0,08,F0,08,F0,18,F0,08,F0,58,E0,F8,
                        18,00,66,00,5A,18,BD,24,BD,24,5A,18,66,00,18,00,18,18,7E,7E,66,7E,C3,FF,C3,FF,66,7E,7E,7E,18,18,
                        F9,07,F2,0F,82,7D,04,FB,FD,02,F2,FD,0F,FF,02,FD,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,C0,00,C0,20,E0,00,E0,00,E0,00,E0,00,E0,F0,F0,C0,30,C0,30,E0,10,E0,10,E0,10,E0,10,E0,18,F0,08,
                        11,17,11,17,01,01,13,13,0B,0B,0B,0B,03,03,0B,0B,17,2F,17,2F,01,1F,13,0F,0B,17,0B,17,03,1F,0B,07,
                        82,FF,82,DF,85,DF,A0,FF,C1,EF,F0,FF,F0,FF,F0,FF,FF,FC,DF,FD,DF,FA,FF,FF,EF,FE,FF,FF,FF,FF,FF,FF,
                        09,FF,50,FF,A0,FF,08,FF,10,FF,41,FF,42,FF,04,FF,FF,76,FF,AF,FF,5F,FF,F7,FF,EF,FF,BE,FF,BD,FF,FB,
                        D8,FF,FA,FF,F7,FF,FE,FF,DE,FF,2D,FF,53,FF,61,FF,FF,00,FF,00,FF,00,FF,00,FF,20,FF,D2,FF,AC,FF,9E,
                        A1,59,02,FC,13,EC,A3,FC,D2,FD,B0,FF,E2,FD,69,FF,FE,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,10,FF,96,
                        9B,85,91,8F,6A,15,54,AB,61,9E,03,FE,F6,7F,FD,FF,7F,00,7F,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,02,
                        44,FF,E3,FF,45,FF,40,FF,30,FF,A0,7F,88,FF,DC,FF,FF,39,FF,1C,FF,38,FF,3F,FF,0E,FF,03,FF,01,FF,20,
                        07,FF,30,FF,E4,FF,3E,FF,FE,FF,1F,FF,02,DF,1F,FF,FF,F8,FF,CF,FF,03,FF,C1,FF,01,FF,E0,DF,FD,FF,60,
                        C0,FF,F0,FF,3F,FF,BF,FF,9F,FF,F8,FF,20,F0,00,A0,FF,00,FF,00,FF,C0,FF,40,FF,00,FF,07,F0,DF,A0,FF,
                        19,FF,1B,FF,FF,FF,FE,FF,FE,FF,38,BF,01,FF,02,3B,FF,00,FF,00,FF,00,FF,01,FF,01,BF,C7,FF,FE,3B,FD,
                        54,FF,54,FF,74,FF,44,FF,48,FF,80,FB,00,FB,00,B6,FF,8B,FF,8B,FF,8B,FF,BB,FF,B7,FB,7F,FB,FF,B6,FF,
                        68,FF,6E,FF,7E,FF,3B,FF,29,FF,A1,FF,41,FF,10,FF,FF,87,FF,81,FF,81,FF,C4,FF,D6,FF,5E,FF,BE,FF,EF,
                        00,E0,00,E0,00,E0,00,E0,00,E0,80,E0,00,E0,00,C0,E0,F0,E0,F0,E0,F0,E0,F0,E0,F0,E0,70,E0,F0,C0,E0,
                        01,03,01,01,01,07,00,04,00,00,01,01,00,00,00,00,03,0F,01,0F,07,07,04,07,00,07,01,03,00,03,00,03,
                        F8,FF,F8,FB,F8,FB,78,7B,7A,7B,1F,1F,15,17,0D,0D,FF,FF,FB,FF,FB,FF,7B,FF,7B,FF,1F,FF,17,FF,0D,FF,
                        00,FF,00,FF,00,FF,80,FF,44,FF,44,FF,75,7F,46,EF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,7F,FF,EF,FF,
                        0A,FF,10,FF,20,FF,02,FF,00,FF,90,FF,40,FB,F0,F6,FF,F5,FF,EF,FF,DF,FF,FD,FF,FF,FF,FF,FB,FF,F6,FF,
                        80,FF,80,FF,10,FF,00,FF,00,FF,00,FF,00,FF,00,FF,FF,7F,FF,7F,FF,EF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,
                        CF,FF,2E,FF,01,FF,00,FF,00,FF,00,00,00,00,20,28,FF,30,FF,D1,FF,FE,FF,FF,FF,FF,00,FF,00,FF,28,FF,
                        E4,FF,C2,FA,C2,F7,40,F2,00,F0,00,70,00,10,00,00,FF,19,FA,3D,F7,3D,F2,BF,F0,FF,70,FF,10,FF,00,FF,
                        0C,FF,0C,EF,07,3F,E1,FF,00,FF,00,3F,80,BF,20,3F,FF,33,EF,F0,3F,C8,FF,1E,FF,FF,3F,FF,BF,FF,3F,FF,
                        FF,FF,FC,FF,04,FF,A9,FF,7F,FF,37,FF,FE,FF,3E,FF,FF,00,FF,00,FF,0B,FF,06,FF,80,FF,C8,FF,01,FF,C1,
                        80,BE,40,C7,80,F9,F9,FF,09,FF,07,FF,03,FF,7B,FF,BE,7F,C7,3F,F9,1F,FF,06,FF,F6,FF,F8,FF,FC,FF,F4,
                        00,36,00,6C,00,1C,80,88,80,81,A0,A1,10,11,10,10,36,FF,6C,FF,1C,FF,88,7F,81,7F,A1,5F,11,EF,10,EF,
                        00,FF,00,FF,00,FF,00,FF,00,FF,00,FB,24,EF,44,46,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FB,FF,EF,FF,46,FF,
                        00,C0,00,C0,00,C0,00,80,00,80,00,00,00,00,00,00,C0,E0,C0,E0,C0,C0,80,C0,80,C0,00,C0,00,80,00,80,
                        00,00,00,00,00,00,01,01,00,00,00,00,00,00,00,00,00,3F,00,1F,00,1F,01,0F,00,07,00,07,00,03,00,01,
                        00,00,00,00,00,00,E0,E0,60,60,20,20,10,10,00,00,00,FF,00,FF,00,FF,E0,FF,60,FF,20,FF,10,FF,00,FF,
                        00,03,00,00,00,00,00,00,00,00,0E,0E,00,00,80,80,03,FF,00,FF,00,FF,00,FF,00,FF,0E,FF,00,FF,80,FF,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,01,00,01,00,00,00,00,00,00,00,00,00,00,
                        0B,0B,05,05,03,03,00,00,00,00,00,00,00,00,00,00,0B,FF,05,FF,03,FF,00,FF,00,FF,00,7F,00,7F,00,3F,
                        55,77,2C,3C,16,16,15,15,0A,0A,06,06,01,01,00,00,77,FF,3C,FF,16,FF,15,FF,0A,FF,06,FF,01,FF,00,FF,
                        D2,FE,82,B3,A2,BE,62,7E,21,33,10,39,80,F4,00,07,FE,FF,B3,FF,BE,FF,7E,FF,33,FF,39,FF,F4,FF,07,FF,
                        00,FF,00,FF,00,7F,00,1B,00,1E,00,2F,00,0A,00,18,FF,FF,FF,FF,7F,FF,1B,FF,1E,FF,2F,FF,0A,FF,18,FF,
                        22,A2,2F,AF,03,83,02,EA,00,BA,00,71,08,C8,00,91,A2,FF,AF,FF,83,FF,EA,FF,BA,FF,71,FF,C8,FF,91,FF,
                        00,A0,00,A0,00,00,00,18,00,98,00,20,00,20,00,60,A0,FF,A0,FF,00,FF,18,FF,98,FF,20,FF,20,FF,60,FF,
                        00,17,40,5F,00,13,02,02,02,02,00,00,40,40,00,00,17,FF,5F,FF,13,FF,02,FF,02,FF,00,FF,40,FF,00,FF,
                        08,FF,00,FE,00,BC,00,B0,00,E0,00,C1,00,C3,00,03,FF,F7,FE,FF,BC,FF,B0,FF,E0,FF,C1,FF,C3,FF,03,FF,
                        2A,2F,38,3E,30,3A,68,6C,28,AC,D0,D8,00,B8,00,C0,2F,F5,3E,F7,3A,FF,6C,F7,AC,D7,D8,2F,B8,FF,C0,FF,
                        20,20,70,70,60,60,01,61,22,22,07,07,47,47,0F,0F,20,DF,70,8F,60,9F,61,FF,22,DF,07,FF,47,BF,0F,FF,
                        44,4E,48,4C,F0,F8,60,60,C0,C0,C0,C0,80,80,80,80,4E,FF,4C,FF,F8,FF,60,FE,C0,FC,C0,F8,80,F8,80,F0,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        01,01,03,03,00,00,00,00,00,00,00,00,00,00,00,00,01,FF,03,7F,00,3F,00,1F,00,0F,00,07,00,03,00,01,
                        50,50,48,48,76,76,83,83,C3,C3,70,70,0E,0E,4E,4E,50,FF,48,FF,76,FF,83,FF,C3,FF,70,FF,0E,FF,4E,FF,
                        00,24,00,8E,00,70,00,00,00,00,00,00,00,00,00,00,24,FF,8E,FF,70,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        00,00,00,04,00,29,00,40,00,00,00,00,00,00,00,00,00,FF,04,FF,29,FF,40,FF,00,FF,00,FF,00,FF,00,FF,
                        00,40,00,00,00,10,00,00,00,00,00,00,00,00,00,00,40,FF,00,FF,10,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        00,40,00,00,00,00,00,00,00,00,00,00,01,01,01,01,40,FF,00,FF,00,FF,00,FF,00,FF,00,FF,01,FF,01,FF,
                        1F,1F,3F,3F,3E,3E,FC,FC,F8,F8,E0,E0,E0,E0,80,80,1F,FF,3F,FF,3E,FF,FC,FF,F8,FF,E0,FE,E0,FE,80,FC,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,F0,00,E0,00,C0,00,80,00,80,00,00,00,00,00,00,
                        02,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,7F,00,1F,00,07,00,00,00,00,00,00,00,00,00,00,
                        BF,BF,7F,7F,7F,7F,1F,1F,03,03,00,00,00,00,00,00,BF,FF,7F,FF,7F,FF,1F,FF,03,3F,00,07,00,00,00,00,
                        40,40,F0,F0,F8,F8,BF,BF,9B,9B,71,71,80,80,00,00,40,FF,F0,FF,F8,FF,BF,FF,9B,FF,71,FF,80,FF,00,07,
                        00,00,06,06,00,00,00,00,B9,B9,80,80,00,00,01,01,00,FF,06,FF,00,FF,00,FF,B9,FF,80,FF,00,FF,01,FF,
                        00,00,00,00,70,70,F0,F0,F0,F0,C0,C0,00,00,00,00,00,FF,00,FF,70,FF,F0,FF,F0,FF,C0,FF,00,FC,00,C0,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,FF,00,FF,00,FF,00,FC,00,F0,00,C0,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,E0,00,80,00,00,00,00,00,00,00,00,00,00,00,00,
                        FE,FE,FF,83,FF,99,FF,83,FE,9E,F0,90,F0,90,F0,F0,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,C0,C0,40,40,3C,3C,1F,1F,3F,3F,00,FF,00,FF,00,FF,C0,FF,40,FF,3C,FF,1F,FF,3F,FF,
                        00,00,00,00,00,00,00,00,00,00,20,20,4D,4D,C5,C5,00,FF,00,FF,00,FF,00,FF,00,FF,20,FF,4D,FF,C5,FF,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,41,41,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,80,FF,41,FF,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,
                        01,01,06,06,08,08,08,08,10,10,00,00,00,00,00,00,01,FF,06,FF,08,FF,08,FF,10,FF,00,FE,00,FC,00,F8,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,F8,00,F0,00,E0,00,C0,00,80,00,00,00,00,00,00,
                        F0,F0,F0,90,F0,90,F0,90,F0,90,FE,9E,FF,81,FE,FE,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        7E,7E,FF,C3,FF,99,FF,99,FF,81,FF,99,FF,99,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        EF,EF,FF,B9,FF,99,FF,89,FF,91,FF,99,EF,8D,E7,E7,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,FF,FF,81,FF,9F,FE,82,FE,9E,FF,9F,FF,81,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,FF,FF,81,FF,E7,3C,24,3C,24,3C,24,3C,24,3C,3C,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,FF,FF,81,FF,F9,3E,26,7C,4C,FF,9F,FF,81,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        7E,7E,FF,83,FF,99,FF,83,FF,99,FF,99,FF,83,FE,FE,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        7E,7E,FF,C1,FF,9F,FE,C6,7F,63,FF,F9,FF,83,7E,7E,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1C,1C,1E,14,FF,F7,FF,01,FF,F7,FE,0A,FE,6A,FF,0D,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,FF,FF,FF,81,FF,BD,FF,81,FF,BD,FF,81,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,1F,1F,1F,15,FF,F5,FF,BF,FF,BF,FF,01,FF,BB,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,1F,1F,1F,15,1F,15,7F,7F,F8,D8,FC,AC,FE,B6,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,FE,FE,FE,02,FE,FA,1E,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,FF,FF,15,FF,F5,FF,5F,FF,5D,FF,41,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,B7,FF,01,FF,77,FF,C1,FF,F7,FF,00,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,BB,FE,B6,FC,BC,E0,A0,FF,BF,FF,C1,7F,7F,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FF,81,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        FE,7A,CF,4B,CF,CD,07,05,07,05,07,07,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        3C,34,3C,2C,7E,66,FF,DB,FF,BD,E7,65,C7,C7,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        10,00,28,00,54,10,BA,28,54,10,28,00,10,00,00,00,10,10,38,38,6C,7C,C6,FE,6C,7C,38,38,10,10,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
}


;;; $D600: Beta minimap tiles / area select map BG3 tiles ;;;
{
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |33332221|33222221|33222221|33332221|33222221|33312221|32222222|33222221|33222221|33322213|31221311|22212132|12221221|33221212|33333333|        |
; |33331221|32211122|32211122|33321221|32211111|33221111|31111122|32211122|32221122|33221121|31221121|21132212|12113212|12133212|33333333|        |
; |33332213|33333222|33112211|33213221|12222213|32222213|33333221|31222211|32213322|32213322|33111211|22212122|12221212|12121212|33333333|        |
; |33332213|33222211|33333221|32132211|31111221|22111221|33322113|22111221|31222221|32213322|33122113|21132122|12113221|32121321|33333333|        |
; |33322133|32221133|22332221|22222221|22332221|22132221|33221333|22132221|33112213|31213221|31213221|22212132|12221212|31221321|33333333|        |
; |33322133|22222221|12222213|11112213|12222213|12222211|33221333|12222213|32221133|33122213|12111221|11131331|31113131|33113313|33333333|        |
; |33311133|11111113|31111133|33331133|31111133|31111113|33113333|31111133|31113333|33311133|11133111|22222222|22222222|22222222|33333333|        |
; |33333333|33333333|33333333|33333333|33333333|33333333|33333333|33333333|33333333|33333333|33333333|11111111|11111111|11111111|33333333|        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |21111112|33333333|23333333|22333333|33333333|22111111|11111111|33333333|21111111|22333333|21111122|11111111|33333333|33333333|33333333|33333333|
; |21111112|33322333|33333333|11223333|23333333|23221111|11111111|23333333|21111111|11223333|21112233|11111111|33333333|33333333|23333333|23333333|
; |21111112|33322333|23333333|11112233|33333333|33332211|11111111|33333333|21111111|11112233|21223333|11111111|33333333|33333333|33333333|33333333|
; |21111112|33322333|33333333|11111122|23333333|23333322|11111111|23333333|21111111|11111122|22333333|11111111|33333333|33333333|23333333|23333333|
; |21111112|33322333|23333333|11111111|22333333|33333333|22111111|22333333|22111111|11111112|33333333|11111111|33333333|33333333|33333333|33333333|
; |21111112|32222223|33333333|11111111|11223333|23333333|23221111|21223333|33221111|11111112|23333333|11111111|33333333|33333333|23333333|23333333|
; |21222212|33222233|23333333|11111111|11112233|33333333|33332211|21112233|33332211|11111112|33333333|11111111|33333333|33333333|33333333|33333333|
; |22111122|33322333|33232323|11111111|11111122|23232323|23333322|21111122|23232322|11111112|23232323|11111111|23333333|23232323|23333333|23232323|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |22222222|22222222|22222222|21111112|22222222|22222222|22222222|11111112|11111111|33333333|11111122|33333322|33333333|11111112|33333322|21111122|
; |21111112|21111111|11111111|21111112|21111112|21111111|11111111|11111112|11111111|23333333|11112233|33332211|23333333|11111112|23332211|21112233|
; |21111112|21111111|11111111|21111112|21111112|21111111|11111111|11111112|11111111|33333333|11223333|33221111|33333333|11111112|33221111|21223333|
; |21111112|21111111|11111111|21111112|21111112|21111111|11111111|11111112|11111111|23333333|22333333|22111111|23333333|11111112|22111111|22333333|
; |21111112|21111111|11111111|21111112|21111112|21111111|11111111|11111112|11111122|33333322|23333333|11111111|33333322|11111122|21111111|23333333|
; |21111112|21111111|11111111|21111112|21111112|21111111|11111111|11111112|11112233|23332211|23333333|11111111|23332212|11112233|21111111|23333333|
; |21111112|21111111|11111111|21111112|21111112|21111111|11111111|11111112|11223333|33221111|33333333|11111111|33221112|11223333|21111111|33333333|
; |22222222|22222222|22222222|21111112|21111112|21111111|11111111|11111112|22232323|22111111|23232323|11111111|22111112|22232323|21111111|23232323|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |33333333|33333333|33333333|33333333|31111111|12323221|31111111|12321133|31111111|13133331|31111111|12232211|33111133|11111113|11111113|33111113|
; |31111113|32222223|33333333|33313333|12222233|12233333|12222222|12333231|12223332|13323333|12222222|12233333|31122133|12222211|12222211|31122213|
; |31222223|32111113|33333333|33111111|12222321|12222321|12222233|12321333|12231132|12223211|12222223|12323133|31222133|31111221|11111221|11212213|
; |31222223|32111113|33332222|31111111|12223333|12222333|12223332|12333132|12311322|12223333|12222231|12313131|31122133|11222211|31222211|12112211|
; |31222223|32111113|33321111|33111111|12223221|12222321|12232233|12232233|13113223|12223211|12222312|13231333|33122133|12211111|11111221|12222221|
; |31222223|32111113|33213333|33313333|12233333|12222232|12321131|12223332|13113231|12222331|12222313|13211321|33122133|12222221|12222211|11112211|
; |33333333|33333333|22133333|33333333|12313221|12222223|12311133|12222233|13111331|12222233|12223123|13333333|33111133|11111111|11111113|33311113|
; |33333333|33333333|11333333|33333333|12313221|31111111|12311131|31111111|13111123|31111111|12223333|31111111|33333333|33333333|33333333|33333333|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |11111111|31111113|11111111|31111113|31111113|31111113|33333333|33333333|33333333|11111111|23333332|31111111|12222222|1111111 |        |32322323|
; |12222211|11222213|12222221|11222211|11222211|11222211|33333333|33113333|11131333|22222222|23112232|11222222|12222222|111111 1|11111111|32333323|
; |12211113|12211113|11111221|12211221|12211221|12211221|11333333|31313131|31313133|22333322|33112233|12222222|12222223|11111 11|11111111|32133123|
; |12222211|12222211|33112211|11222211|11222221|12211221|11133333|31313131|31313133|23312332|13113231|12222222|12222223|1111 111|11111111|32333323|
; |11111221|12211221|33122113|12211221|31111221|12211221|11133333|31313131|31313133|23112232|12113221|12222222|12222223|111 1111|11111111|32133123|
; |12222211|11222211|33122133|11222211|31222211|11222211|11133333|31113131|31313133|23112232|13113231|12222222|12222223|11 11111|11111111|32333323|
; |11111113|31111113|33111133|31111113|31111113|31111113|11133333|31313131|31313133|23333332|33333333|12222222|11222223|1 111111|11111111|32133123|
; |33333333|33333333|33333333|33333333|33333333|3  33333|33333333|31313111|31331333|23112232|11111111|12222222|31111111| 1111111|11111111|32333323|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | 111111 |        |        |11111111| 111111 |        |       1|       1|1111111 |
; |  1111 1|       1|       1|11111111|  1111  |  111111|      11|      11| 11111 1|
; |   11 11|      11|      11|11111111|   11   |   11111|     111|     111|  111 11|
; |     111|     111|     111|11111111|        |    1111|    1111|    1111|   1 111|
; |     111|    1111|     111|11111111|        |     111|   11111|     111|    1111|
; |      11|   11111|      11|11111111|        |      11|  111111|      11|     111|
; |       1|  111111|       1|11111111|        |       1| 1111111|       1|      11|
; |        | 1111111|        |11111111|        |        |11111111|        |       1|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|

$8E:D600             db F1,FE,F9,F6,F3,FD,F3,FD,E7,FB,E7,FB,FF,E3,FF,FF,C1,FE,9C,E3,F8,FF,C3,FC,8F,F3,01,FE,FF,01,FF,FF,
                        C1,FE,9C,E3,F3,CC,F9,FE,31,FE,83,7D,FF,83,FF,FF,F1,FE,E9,F6,D9,EE,B3,DC,01,FE,F3,0D,FF,F3,FF,FF,
                        C1,FE,9F,E0,83,7D,F9,86,31,FE,83,7D,FF,83,FF,FF,F1,EE,CF,F0,83,FD,39,C6,31,DE,83,7C,FF,81,FF,FF,
                        80,FF,FC,83,F9,FE,E7,F9,CF,F7,CF,F7,FF,CF,FF,FF,C1,FE,9C,E3,C3,BC,39,C6,31,DE,83,7D,FF,83,FF,FF,
                        C1,FE,8C,F3,9C,EF,C1,BE,F3,CD,8F,F3,FF,8F,FF,FF,E3,FD,CD,F2,9C,EF,9C,EF,D9,AE,E3,DD,FF,E3,FF,FF,
                        CF,B4,CD,B2,FB,C4,E7,D9,D9,AE,B9,46,FF,18,FF,FF,16,EB,72,9D,14,EB,74,9B,16,EB,FF,16,00,FF,FF,00,
                        89,76,BA,4D,8A,75,B9,4E,8A,75,FF,8A,00,FF,FF,00,CA,F5,BA,5D,AA,55,AD,D6,CD,B6,FF,CD,00,FF,FF,00,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        7E,81,7E,81,7E,81,7E,81,7E,81,7E,81,42,BD,3C,C3,FF,FF,E7,FF,E7,FF,E7,FF,E7,FF,81,FF,C3,FF,E7,FF,
                        7F,FF,FF,FF,7F,FF,FF,FF,7F,FF,FF,FF,7F,FF,D5,FF,3F,FF,CF,3F,F3,0F,FC,03,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,7F,FF,FF,FF,7F,FF,3F,FF,CF,3F,F3,0F,FC,03,3F,C0,4F,F0,F3,FC,7C,FF,FF,FF,7F,FF,FF,FF,55,FF,
                        FF,00,FF,00,FF,00,FF,00,3F,C0,4F,F0,F3,FC,7C,FF,FF,FF,7F,FF,FF,FF,7F,FF,3F,FF,4F,BF,73,8F,7C,83,
                        7F,80,7F,80,7F,80,7F,80,3F,C0,CF,F0,F3,FC,54,FF,3F,FF,CF,3F,F3,0F,FC,03,FE,01,FE,01,FE,01,FE,01,
                        7C,83,73,8F,4F,BF,3F,FF,FF,FF,7F,FF,FF,FF,55,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,7F,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,55,FF,
                        FF,FF,7F,FF,FF,FF,7F,FF,FF,FF,7F,FF,FF,FF,7F,FF,FF,FF,7F,FF,FF,FF,7F,FF,FF,FF,7F,FF,FF,FF,55,FF,
                        00,FF,7E,81,7E,81,7E,81,7E,81,7E,81,7E,81,00,FF,00,FF,7F,80,7F,80,7F,80,7F,80,7F,80,7F,80,00,FF,
                        00,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,00,FF,7E,81,7E,81,7E,81,7E,81,7E,81,7E,81,7E,81,7E,81,
                        00,FF,7E,81,7E,81,7E,81,7E,81,7E,81,7E,81,7E,81,00,FF,7F,80,7F,80,7F,80,7F,80,7F,80,7F,80,7F,80,
                        00,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FE,01,FE,01,FE,01,FE,01,FE,01,FE,01,FE,01,FE,01,
                        FF,00,FF,00,FF,00,FF,00,FC,03,F3,0F,CF,3F,15,FF,FF,FF,7F,FF,FF,FF,7F,FF,FC,FF,73,FC,CF,F0,3F,C0,
                        FC,03,F3,0F,CF,3F,3F,FF,7F,FF,7F,FF,FF,FF,55,FF,FC,FF,F3,FC,CF,F0,3F,C0,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,7F,FF,FF,FF,7F,FF,FC,FF,72,FD,CE,F1,3E,C1,FE,01,FE,01,FE,01,FE,01,FC,03,F3,0F,CF,3F,15,FF,
                        FC,FF,73,FC,CF,F0,3F,C0,7F,80,7F,80,7F,80,7F,80,7C,83,73,8F,4F,BF,3F,FF,7F,FF,7F,FF,FF,FF,55,FF,
                        FF,FF,FF,81,C1,BF,C1,BF,C1,BF,C1,BF,FF,FF,FF,FF,FF,FF,81,FF,BF,C1,BF,C1,BF,C1,BF,C1,FF,FF,FF,FF,
                        FF,FF,FF,FF,FF,FF,F0,FF,EF,F0,DF,EF,3F,DF,FF,3F,FF,FF,FF,EF,FF,C0,FF,80,FF,C0,FF,EF,FF,FF,FF,FF,
                        FF,80,83,7F,85,7E,8F,7F,89,7E,9F,7F,B9,6E,B9,6E,A9,7E,9F,7F,85,7E,87,7F,85,7E,82,7F,81,7F,FF,80,
                        FF,80,80,7F,83,7F,8E,7F,93,7F,AF,72,BF,63,BF,62,AF,73,BB,7E,AF,77,BE,7B,93,7F,8E,7F,83,7F,FF,80,
                        FF,80,8E,7F,9E,73,BC,67,F9,4F,FB,4E,FF,46,FD,43,FF,5E,EF,7F,8B,7C,8F,7F,8B,7C,87,7E,83,7F,FF,80,
                        FF,80,80,7F,81,7F,83,7E,86,7D,87,7D,8D,7B,8F,7F,93,7C,9F,7F,AF,7B,BF,6A,DF,77,DD,66,FF,7F,FF,80,
                        FF,C3,E7,9B,C7,BB,E7,9B,E7,DB,E7,DB,FF,C3,FF,FF,FF,01,83,7C,F9,86,C3,3C,9F,60,81,7E,FF,00,FF,FF,
                        FF,01,83,7C,F9,06,C3,BC,F9,06,83,7C,FF,01,FF,FF,FF,C1,E3,9D,D3,2D,B3,4C,81,7E,F3,0C,FF,E1,FF,FF,
                        FF,00,83,7C,9F,61,83,7C,F9,06,83,7C,FF,01,FF,FF,FF,81,C3,3D,9F,61,83,7C,99,66,C3,3C,FF,81,FF,FF,
                        FF,00,81,7E,F9,06,F3,CC,E7,D9,E7,DB,FF,C3,FF,FF,FF,81,C3,3C,99,66,C3,3C,99,66,C3,3C,FF,81,FF,FF,
                        FF,81,C3,3C,99,66,C1,3E,F9,86,C3,BC,FF,81,FF,FF,FF,81,C3,3C,99,66,99,66,99,66,C3,3C,FF,81,9F,9F,
                        FF,FF,FF,FF,FF,3F,FF,1F,FF,1F,FF,1F,FF,1F,FF,FF,FF,FF,FF,CF,FF,AA,FF,AA,FF,AA,FF,8A,FF,AA,FF,A8,
                        FF,FF,FF,17,FF,AB,FF,AB,FF,AB,FF,AB,FF,AB,FF,B7,FF,00,00,FF,3C,FF,76,EF,72,CF,72,CF,7E,FF,72,CF,
                        7E,FF,72,CF,F3,CF,FB,4E,B9,4E,FB,4E,FF,FF,FF,00,FF,80,C0,3F,80,7F,80,7F,80,7F,80,7F,80,7F,80,7F,
                        80,7F,80,7F,81,7F,81,7F,81,7F,81,7F,C1,3F,FF,80,FE,00,FD,00,FB,00,F7,00,EF,00,DF,00,BF,00,7F,00,
                        00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,A5,FF,BD,FF,BD,DB,BD,FF,BD,DB,BD,FF,BD,DB,BD,FF,
                        7E,00,3D,00,1B,00,07,00,07,00,03,00,01,00,00,00,00,00,01,00,03,00,07,00,0F,00,1F,00,3F,00,7F,00,
                        00,00,01,00,03,00,07,00,07,00,03,00,01,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        7E,00,3C,00,18,00,00,00,00,00,00,00,00,00,00,00,00,00,3F,00,1F,00,0F,00,07,00,03,00,01,00,00,00,
                        01,00,03,00,07,00,0F,00,1F,00,3F,00,7F,00,FF,00,01,00,03,00,07,00,0F,00,07,00,03,00,01,00,00,00,
                        FE,00,7D,00,3B,00,17,00,0F,00,07,00,03,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
}


;;; $DC00: Zebes and stars tilemap ;;;
{
$8E:DC00             dw 000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,1200,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1240,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1200,000F,000F,000F,000F,1209,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,1209,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1209,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,1200,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,1240,000F,000F,000F,000F,000F,000F,000F,1209,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1250,000F,000F,000F,
                        000F,1209,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1201,1202,1203,1204,1205,1206,1207,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,12AB,000F,000F,000F,000F,1210,1211,1212,1213,1214,1215,1216,1217,1218,000F,000F,000F,1208,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,120A,120B,120C,120D,120E,120F,1220,1221,1222,1223,1224,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,1219,121A,121B,121C,121D,121E,121F,1230,1231,1232,1233,1234,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,1225,1226,1227,1228,1229,122A,122B,122C,122D,122E,122F,1241,1242,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,1240,000F,000F,000F,000F,1208,000F,000F,1235,1236,1237,1238,1239,123A,123B,123C,123D,123E,123F,1251,1252,000F,000F,000F,000F,000F,000F,000F,12AB,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,1243,1244,1245,1246,1247,1248,1249,124A,124B,124C,124D,124E,124F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,1209,000F,000F,000F,000F,000F,1253,1254,1255,1256,1257,1258,1259,125A,125B,125C,125D,125E,125F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,1260,1261,1262,1263,1264,1265,1266,1267,1268,1269,126A,126B,126C,000F,000F,000F,000F,1240,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,1270,1271,1272,1273,1274,1275,1276,1277,1278,1279,127A,127B,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,126D,126E,126F,1280,1281,1282,1294,1284,1285,1286,1287,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,127E,127F,1290,1291,1292,1294,1294,1295,1296,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,1200,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1288,1289,128A,128B,128C,128D,128E,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1208,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,1240,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1208,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1200,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1250,000F,000F,000F,000F,000F,000F,
                        000F,000F,1209,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1209,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1208,000F,000F,000F,000F,000F,1209,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,1209,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,
                        000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F,000F
}


;;; $E400: Menu palettes ;;;
{
$8E:E400             dw 0000,7FFF,4BFF,13FF,129F,111F,0CB5,046A,0000,3DB3,292E,48FB,1849,44E5,7FFF,0000,
                        0000,7FFF,4BFF,13FF,129F,111F,0CB5,046A,0000,1085,0C64,1447,0823,1442,2108,0000,
                        0000,48FB,7FF4,001F,0000,7FFF,0156,001F,2413,559D,0000,02DF,4408,7FFF,5EF7,318C,
                        0000,44E5,7FF4,001F,0000,4A52,318C,5EF7,1CE7,2870,1CE7,4A52,4408,7FFF,5EF7,318C,
                        0000,373F,2E9E,2E3B,25D8,1D33,14AE,144A,0803,7DFF,6819,5413,340A,2004,1403,0000,
                        0000,7FE0,7EA0,7D40,7C00,4000,01DB,0196,0150,00EB,00A5,033B,0296,01F0,014B,00A5,
                        0400,6400,4C00,3400,1C00,0400,0013,000F,000A,0006,0001,0BB1,0B0D,0669,05A4,0100,
                        0000,7FE0,7EA0,7D40,7C00,4000,6417,4C12,380D,2007,0802,5280,4620,39C0,2940,14A5,
                        7FFF,7FFF,4BFF,13FF,129F,111F,0CB5,046A,0000,3DB3,292E,48FB,1849,44E5,7FFF,0000,
                        3800,7FFF,4BFF,13FF,129F,111F,0CB5,046A,0000,1085,0C64,1447,0823,1442,2108,0000,
                        3800,200D,000A,2C02,4E73,7FFF,039F,001F,0000,559D,001D,039F,7FFF,0000,0000,023F,
                        0000,200D,000A,2C02,4E73,7FFF,039F,001F,0000,559D,001D,039F,7FFF,0000,0000,023F,
                        3800,6BF5,06E1,0641,05A1,5E5F,183F,1014,080A,0404,4F9F,3ED8,2E12,6F70,7FFF,5EE0,
                        3800,7E20,6560,2060,1000,7940,5D00,4CA0,3CA0,43FF,0113,000F,175C,0299,01D6,57E0,
                        3800,0CE0,08A0,0040,18C5,1062,0C41,0421,0CE7,0887,0027,0025,0023,0001,1CE7,0000,
                        3800,2FE0,1A80,0120,6B37,4588,2D05,1062,37FF,1E3F,047F,0456,004C,0023,7FFF,0000

}


;;; $E600: Free space ;;;
{
$8E:E600             fillto $8F8000, $FF
}
