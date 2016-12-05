
DEFINE VARIABLE cFile  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iNice  AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttString NO-UNDO
    FIELD str    AS CHARACTER.

cFile = "C:\temp\advent_of_code_2015\advent_of_code_2015\jensdahlin-progressabl\input5.txt".

INPUT FROM VALUE(cFile).
REPEAT:
    CREATE ttString.
    IMPORT str.
END.
INPUT CLOSE.


FUNCTION isNice RETURNS LOGICAL (INPUT cString AS CHARACTER):

    DEFINE VARIABLE iVowels    AS INTEGER     NO-UNDO.
    DEFINE VARIABLE cVowels    AS CHARACTER   NO-UNDO INIT "aeiou".
    DEFINE VARIABLE iDoubles   AS INTEGER     NO-UNDO.
    DEFINE VARIABLE cNotWanted AS CHARACTER   NO-UNDO INIT "ab,cd,pq,xy".
    DEFINE VARIABLE iLength    AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iEntry     AS INTEGER     NO-UNDO.

    DO iEntry = 1 TO NUM-ENTRIES(cNotWanted).
        IF cString MATCHES "*" + ENTRY(iEntry, cNotWanted) + "*" THEN
            RETURN FALSE.
        
    END.

    chrLoop:
    DO iLength = 1 TO LENGTH(cString):
        IF INDEX(cVowels, SUBSTRING(cString, iLength, 1)) > 0 THEN
            iVowels = iVowels + 1.

        IF iLength > 1 THEN DO:
            IF SUBSTRING(cString, iLength, 1) = SUBSTRING(cString,iLength - 1, 1) THEN
                iDoubles = iDoubles + 1.
        END.
    END.

    IF iVowels < 3 THEN
        RETURN FALSE.
    
    IF iDoubles < 1 THEN
        RETURN FALSE.

    RETURN TRUE.

END FUNCTION.

FOR EACH ttString:
    IF isNice(ttString.str) THEN iNice = iNice + 1.
END.

MESSAGE "Nice strings: " iNice VIEW-AS ALERT-BOX.
