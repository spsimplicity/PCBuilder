DELIMITER $$
DROP FUNCTION IF EXISTS memSpeedMatch$$
CREATE FUNCTION memSpeedMatch(motherboardId INT, memorySpeed INT)
    RETURNS INT DETERMINISTIC
BEGIN
    /*Flag to hold wether a speed match is found*/
    DECLARE speedMatch INT DEFAULT 0;
	DECLARE moboSpeed INT;
    DECLARE loopDone INT DEFAULT 0;	
    /*Cursor to get each socket for the specific CPU Cooler*/
    DECLARE moboSpeedsCur CURSOR FOR 
        SELECT speed
        FROM memory_speeds
        WHERE motherboardId = motherboard_id;
    /*Handler to set varaible to leave loop when no sets left*/
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET loopDone = 1;
	/*For each memory speed*/
	OPEN moboSpeedsCur;
	speedsLoop:LOOP
	    FETCH moboSpeedsCur INTO moboSpeed;
		IF loopDone = 1 THEN
		    LEAVE speedsLoop;
		END IF;
		IF moboSpeed > memorySpeed THEN
		    SET speedMatch = 1;
		ELSEIF moboSpeed = memorySpeed THEN
		    SET speedMatch = 2;
			SET loopDone = 1;
		END IF;
	END LOOP speedsLoop;
	RETURN speedMatch;
END$$
DELIMITER ;