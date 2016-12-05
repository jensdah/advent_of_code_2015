DEFINE TEMP-TABLE ttPresent NO-UNDO
    FIELD l AS INTEGER
    FIELD w AS INTEGER 
    FIELD h AS INTEGER
    FIELD area AS INTEGER
    FIELD ribbon AS INTEGER.

DEFINE VARIABLE iArea   AS INTEGER     NO-UNDO.
DEFINE VARIABLE iRibbon AS INTEGER     NO-UNDO.

FUNCTION area RETURNS INTEGER ( INPUT piL AS INTEGER
                              , INPUT piW AS INTEGER
                              , INPUT piH AS INTEGER ):

    DEFINE VARIABLE iSlack AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iArea  AS INTEGER     NO-UNDO EXTENT 3.

    iArea[1] = 2 * piL * piW.
    iArea[2] = 2 * piW * piH.
    iArea[3] = 2 * piH * piL.

    
    iSlack = MIN(iArea[1], iArea[2], iArea[3]) / 2.

    RETURN iArea[1] + iArea[2] + iArea[3] + iSlack.

END FUNCTION.

FUNCTION ribbon RETURNS INTEGER ( INPUT piL AS INTEGER
                                , INPUT piW AS INTEGER
                                , INPUT piH AS INTEGER ):
    
    DEFINE VARIABLE iBow AS INTEGER     NO-UNDO.

    iBow = piL * piW * piH.

    RETURN 2 * piL + 2 * piW + 2 * piH - 2 * MAX(piL, piW, piH) + iBow.

END FUNCTION.

INPUT FROM VALUE("input2.txt").
REPEAT:
    CREATE ttPresent.
    IMPORT DELIMITER "x" ttPresent. 

    ASSIGN 
        ttPresent.area = area(ttPresent.l, ttPresent.w, ttPresent.h)
        ttPresent.ribbon = ribbon(ttPresent.l, ttPresent.w, ttPresent.h)
        .
    ASSIGN 
        iArea = iArea + ttPresent.area
        iRibbon = iRibbon + ttPresent.ribbon.

END.
INPUT CLOSE.



MESSAGE "Area:" iArea SKIP
        "Ribbon:" iRibbon VIEW-AS ALERT-BOX.
