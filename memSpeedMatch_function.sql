DELIMITER $$

DROP FUNCTION IF EXISTS memSpeedMatch$$

CREATE FUNCTION memSpeedMatch(motherboardId INT, memorySpeed INT)
    RETURNS INT DETERMINISTIC
BEGIN
    /*Flag to hold wether a speed match is found*/
    DECLARE speedMatch INT DEFAULT 0;
END$$

DELIMITER ;