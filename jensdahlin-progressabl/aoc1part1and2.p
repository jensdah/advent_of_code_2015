DEFINE VARIABLE cFile     AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cData     AS LONGCHAR    NO-UNDO.
DEFINE VARIABLE iCount    AS INTEGER     NO-UNDO.
DEFINE VARIABLE iAnswer   AS INTEGER     NO-UNDO.
DEFINE VARIABLE iBasement AS INTEGER     NO-UNDO.

cFile = "input1.txt".

COPY-LOB FROM FILE cFile TO cData.

MESSAGE LENGTH(cData).

DO iCount = 1 TO LENGTH(cData).
    IF SUBSTRING(cData, iCount, 1) = "(" THEN
        iAnswer = iAnswer + 1.
    ELSE IF SUBSTRING(cData, iCount, 1) = ")" THEN
        iAnswer = iAnswer - 1.

    IF iBasement = 0 AND iAnswer < 0 THEN
        iBasement = iCount.
END.


MESSAGE 
    "Floors: " iAnswer skip
    "Basement: " iBasement VIEW-AS ALERT-BOX.
