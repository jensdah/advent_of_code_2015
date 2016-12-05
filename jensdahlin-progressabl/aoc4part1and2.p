DEFINE VARIABLE iCounter  AS INTEGER     NO-UNDO.
DEFINE VARIABLE iFive     AS INTEGER     NO-UNDO.
DEFINE VARIABLE cInput    AS CHARACTER   NO-UNDO INIT "yzbqklnj".
DEFINE VARIABLE cString   AS LONGCHAR NO-UNDO.
DEFINE VARIABLE rVar      AS RAW NO-UNDO.

hashLoop:
REPEAT:
    iCounter = iCounter + 1.
    
    cString = cInput + STRING(iCounter).

    rVar = MD5-DIGEST(cString).
    
    IF STRING(HEX-ENCODE(rVar)) BEGINS "00000" THEN  DO:
        IF iFive = 0 THEN
            iFive = iCounter.

        IF STRING(HEX-ENCODE(rVar)) BEGINS "000000" THEN  DO:
            LEAVE hashLoop.
        END.
    END.

END.

MESSAGE "Done, solution for six 0s is: " iCounter SKIP 
        "solution for five 0s is " iFive
        VIEW-AS ALERT-BOX.

