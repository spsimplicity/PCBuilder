DELIMITER $$
DROP FUNCTION IF EXISTS discdPsuCompatibility$$
CREATE DEFINER=CURRENT_USER FUNCTION discdPsuCompatibility(ddInter VARCHAR(10), psuPeripheral INT, 
	psuSata INT)
	RETURNS INT DETERMINISTIC
BEGIN
	DECLARE supported INT DEFAULT 1;

	/*Incompatible if the power supply does not have sata power for sata dsic drive*/
	IF psuSataPower = 0 AND STRCMP(ddInterface, 'SATA') = 0 THEN
		SET supported = 0;
	/* or if the power supply does not have molex power for ide disc drive*/
	ELSEIF psuPeripheral = 0 AND STRCMP(ddInterface, 'IDE/PATA') = 0 THEN
		SET supported = 0;
	END IF;				
	RETURN supported;
END$$
DELIMITER ;