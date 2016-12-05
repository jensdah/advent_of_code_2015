DEFINE VARIABLE cFile AS CHARACTER   NO-UNDO INIT "C:\temp\advent_of_code_2015\advent_of_code_2015\jensdahlin-progressabl\input3.txt".
DEFINE VARIABLE cData AS LONGCHAR    NO-UNDO.
DEFINE VARIABLE giNr  AS INTEGER     NO-UNDO.
DEFINE VARIABLE iWalk AS INTEGER     NO-UNDO.
DEFINE VARIABLE cChr  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iSum  AS INTEGER     NO-UNDO.
DEFINE TEMP-TABLE ttPath NO-UNDO 
    FIELD nr       AS INTEGER
    FIELD posX     AS INTEGER
    FIELD posY     AS INTEGER
    INDEX nr nr.

DEFINE BUFFER bPath FOR ttPath.

COPY-LOB FROM FILE cFile TO cData.

/* Give the first present... */
giNr = 1.
CREATE ttPath.
ASSIGN 
    ttPath.nr   = giNr
    ttPath.posX = 0
    ttPath.posY = 0
    .

DO iWalk = 1 TO LENGTH(cData):

    FIND FIRST bPath NO-LOCK WHERE bPath.nr = giNr.

    giNr = giNr + 1.

    cChr = SUBSTRING(cData, iWalk, 1).

    CREATE ttPath.
    ASSIGN ttPath.nr = giNr.

    CASE cChr:
        WHEN "^" THEN DO:
            ASSIGN
                ttPath.posY = bPath.posY + 1
                ttPath.posX = bPath.posX.
        END.
        WHEN "v" THEN DO:
            ASSIGN
                ttPath.posY = bPath.posY - 1
                ttPath.posX = bPath.posX.
        END.
        WHEN ">" THEN DO:
            ASSIGN 
                ttPath.posX = bPath.posX + 1
                ttPath.posY = bPath.posY.
        END.
        WHEN "<" THEN DO:
            ASSIGN 
                ttPath.posX = bPath.posX - 1
                ttPath.posY = bPath.posY.
        END.
    END CASE.
 
END.

FOR EACH ttPath BREAK BY ttPath.posX BY ttPath.posY.
    IF FIRST-OF(ttPath.posY) THEN DO:
        iSum = iSum + 1.
    END.
END.

MESSAGE "Houses: " iSum VIEW-AS ALERT-BOX.

/* v><^ */

