DELIMITER$$
DROP FUNCTION IF EXISTS hddMoboCompatibility$$
CREATE FUNCTION hddMoboCompatibility(hddInter VARCHAR(10), moboS6 INT, 
    moboS3 INT, moboIde INT)
    RETURN INT DETERMINISTIC
BEING
    DECLARE supported INT DEFAULT 1;
	
    IF STRCMP(hddInter, 'SATA 6') = 0 AND moboS6 = 0 THEN
		SET supported = 0;
	ELSEIF STRCMP(hddInter, 'SATA 3') = 0 AND moboSa6 = 0 AND moboS3 = 0 THEN
		SET supported = 0;
	ELSEIF STRCMP(hddInter, 'IDE/PATA') = 0 AND moboIde = 0 THEN
		SET supported = 0;
	END IF;
	
	RETURN supported;
END$$
DELIMITER;