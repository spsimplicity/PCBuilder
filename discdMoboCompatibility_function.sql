DELIMITER$$
DROP FUNCTION IF EXISTS discdMoboCompatibility$$
CREATE FUNCTION discdMoboCompatibility(ddInter VARCHAR(10), moboS3 INT, 
    moboS6 INT, moboIde INT)
    RETURN INT DETERMINISTIC
BEGIN
    DEClARE supported INT DEFAULT 1;
	
    IF STRCMP(ddInterface, 'SATA') = 0 AND moboS3 = 0 AND moboS6 = 0 THEN
		SET supported = 0;
	/*or transfer type is ide and no ide ports on motherboard*/
	ELSEIF STRCMP(ddInterface, 'IDE/PATA') = 0 AND moboIde = 0 THEN
		SET supported = 0;
	END IF;
	
	RETURN supported;
END$$
DELIMITER;