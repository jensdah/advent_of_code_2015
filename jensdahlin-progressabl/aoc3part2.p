DEFINE VARIABLE cFile   AS CHARACTER   NO-UNDO INIT "C:\temp\advent_of_code_2015\advent_of_code_2015\jensdahlin-progressabl\input3.txt".
DEFINE VARIABLE cData   AS LONGCHAR    NO-UNDO.
DEFINE VARIABLE giNr    AS INTEGER     NO-UNDO.
DEFINE VARIABLE iWalk   AS INTEGER     NO-UNDO.
DEFINE VARIABLE cChr    AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iSum    AS INTEGER     NO-UNDO.
DEFINE VARIABLE cWalker AS CHARACTER   NO-UNDO.
DEFINE TEMP-TABLE ttPath NO-UNDO 
    FIELD nr       AS INTEGER
    FIELD walker   AS CHARACTER
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
    ttPath.walker = "santa"
    ttPath.posX = 0
    ttPath.posY = 0.

CREATE ttPath.
ASSIGN 
    ttPath.nr   = giNr
    ttPath.walker = "Robo-Santa"
    ttPath.posX = 0
    ttPath.posY = 0.

DO iWalk = 1 TO LENGTH(cData):

    IF iWalk MOD 2 = 1 THEN DO:
        cWalker = "Santa".
        giNr = giNr + 1.
    END.
    ELSE DO:
        cWalker = "Robo-Santa".
    END.

    FIND FIRST bPath NO-LOCK WHERE bPath.nr     = giNr - 1
                               AND bPath.walker = cWalker NO-ERROR.

    

    cChr = SUBSTRING(cData, iWalk, 1).

    CREATE ttPath.
    ASSIGN 
        ttPath.nr     = giNr
        ttPath.walker = cWalker.

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

