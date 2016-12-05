DEFINE TEMP-TABLE ttGrid NO-UNDO
    FIELD gX  AS INTEGER
    FIELD gY  AS INTEGER
    FIELD lit AS LOGICAL
    INDEX id1 gX gY
    INDEX lit lit.

DEFINE VARIABLE cData AS CHARACTER   NO-UNDO.
DEFINE TEMP-TABLE ttData NO-UNDO
    FIELD instr AS CHARACTER
    FIELD frX   AS INTEGER
    FIELD frY   AS INTEGER
    FIELD toX   AS INTEGER
    FIELD toY   AS INTEGER.

DEFINE VARIABLE iX AS INTEGER     NO-UNDO.
DEFINE VARIABLE iY AS INTEGER     NO-UNDO.
DEFINE VARIABLE iOffset AS INTEGER     NO-UNDO.
DEFINE VARIABLE iLit AS INTEGER     NO-UNDO.


INPUT FROM VALUE("C:\temp\advent_of_code_2015\advent_of_code_2015\jensdahlin-progressabl\input6.txt").
REPEAT :
    IMPORT UNFORMATTED cData.

    CREATE ttData.

    ttData.instr = ENTRY(1, cData, " ").

    IF ttData.instr BEGINS "turn" THEN DO:
        ttData.instr = ttData.instr + " " + ENTRY(2, cData, " ").
        iOffset = 1.
    END.
    ELSE 
        iOffset = 0.

    ASSIGN 
        ttData.frX = INTEGER(ENTRY(1, ENTRY(2 + iOffset, cData, " ")))
        ttData.frY = INTEGER(ENTRY(2, ENTRY(2 + iOffset, cData, " ")))
        ttdata.toX = INTEGER(ENTRY(1, ENTRY(4 + iOffset, cData, " ")))
        ttdata.toY = INTEGER(ENTRY(2, ENTRY(4 + iOffset, cData, " "))).

    RUN setUp( ttData.instr, ttData.frX, ttData.frY, ttData.toX, ttData.toY).

END.


FOR EACH ttGrid WHERE lit:
    iLit = iLit + 1.
END.


/* Incredibly slow setup! */
PROCEDURE setUp:
    DEFINE INPUT  PARAMETER pcInstr AS CHARACTER   NO-UNDO.
    DEFINE INPUT  PARAMETER piFrX   AS INTEGER     NO-UNDO.
    DEFINE INPUT  PARAMETER piFrY   AS INTEGER     NO-UNDO.
    DEFINE INPUT  PARAMETER piToX   AS INTEGER     NO-UNDO.
    DEFINE INPUT  PARAMETER piToY   AS INTEGER     NO-UNDO.

    DEFINE VARIABLE iX AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iY AS INTEGER     NO-UNDO.

    DO iX = piFrX TO piToX:
        DO iY = piFrY TO piToY:
            FIND FIRST ttGrid WHERE ttGrid.gX = iX 
                                AND ttGrid.gY = iY  NO-ERROR.
            IF NOT AVAILABLE ttGrid THEN DO:
                CREATE ttGrid.
                ASSIGN 
                    ttGrid.gX = iX
                    ttGrid.gY = iY.
            END.

            CASE pcInstr:
                WHEN "turn on" THEN DO:
                    ttGrid.lit = TRUE.
                END.
                WHEN "turn off" THEN DO:
                    ttGrid.lit = FALSE.
                END.
                WHEN "toggle"  THEN DO:
                    ttGrid.lit = NOT ttGrid.lit.
                END.
                OTHERWISE DO:
                    DISP pcInstr.
                END.
            END CASE.

        END.
    END.

END.




MESSAGE "Num lit lights: " iLit VIEW-AS ALERT-BOX.
