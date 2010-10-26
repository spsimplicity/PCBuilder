DELIMITER $$

DROP FUNCTION IF EXISTS caseSizeMatch$$

CREATE FUNCTION caseSizeMatch(caseId INT, sizeToMatch VARCHAR(15))
    RETURNS INT DETERMINISTIC
BEGIN
    /*Holds the size of the Motherboard*/
    DECLARE caseMoboSize VARCHAR(15);
    /*Flag to determine if the sizes match*/
    DECLARE caseSizeMatch INT DEFAULT 0;
    DECLARE loopDone INT DEFAULT 0;
    /*Gets all the sizes for the specific Case*/
    DECLARE caseSizeCur CURSOR FOR 
        SELECT size
        FROM case_motherboards
        WHERE caseId = id;
    /*Handler to set variable to signify there are no sizes left*/
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET loopDone = 1;
    /*For each Case Motherboard size*/
    open caseSizeCur;
    sizeLoop:LOOP
        FETCH caseSizeCur INTO caseMoboSize;
        IF loopDone = 1 THEN
            LEAVE sizeLoop;
        END IF;
        /*If the sizes match set the flag to 1*/
        IF caseMoboSize = sizeToMatch THEN
            SET caseSizeMatch = 1;
        END IF;
    END LOOP sizeLoop;
    
    RETURN caseSizeMatch;
END$$

DELIMITER ;