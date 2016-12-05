
DEFINE VARIABLE cFile  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iNice  AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttString NO-UNDO
    FIELD str    AS CHARACTER.

cFile = "input5.txt".

INPUT FROM VALUE(cFile).
REPEAT:
    CREATE ttString.
    IMPORT str.
END.
INPUT CLOSE.


FUNCTION isNice RETURNS LOGICAL (INPUT cString AS CHARACTER):
    
    DEFINE VARIABLE iLength    AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iEntry     AS INTEGER     NO-UNDO.
    DEFINE VARIABLE lPair      AS LOGICAL     NO-UNDO.
    DEFINE VARIABLE cPair      AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE lTriple    AS LOGICAL     NO-UNDO.

    chrLoop:
    DO iLength = 1 TO LENGTH(cString):
        
        IF iLength > 1 THEN DO:
            cPair = SUBSTRING(cString, iLength - 1, 2).
            
            IF INDEX(cString, cPair, iLength + 1) > 0 THEN
                lPair = TRUE.
            
        END.

        IF iLength > 2 THEN DO:
            IF SUBSTRING(cString, iLength , 1) = SUBSTRING(cString, iLength - 2 , 1) THEN 
                lTriple = TRUE.
        END.
    END.

    RETURN (lPair AND lTriple).

END FUNCTION.

FOR EACH ttString:
    IF isNice(ttString.str) THEN iNice = iNice + 1.
END.

MESSAGE "Nice strings: " iNice VIEW-AS ALERT-BOX.
