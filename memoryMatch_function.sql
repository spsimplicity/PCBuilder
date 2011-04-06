DELIMITER $$
DROP FUNCTION IF EXISTS memoryMatch$$
CREATE DEFINER=CURRENT_USER FUNCTION memoryMatch(memMultichannelType INT, memType VARCHAR(5), 
	mem2MultichannelType INT, mem2Type VARCHAR(5))
	RETURNS INT DETERMINISTIC
BEGIN
	DECLARE memMatch INT DEFAULT 1;
	
	IF STRCMP(memType, mem2Type) != 0 THEN
		SET memMatch = 0;
	ELSEIF memMultichannelType != mem2MultichannelType THEN
		SET memMatch = 0;
	END IF;
	
	RETURN memMatch;
END$$
DELIMITER ;