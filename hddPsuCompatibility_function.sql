DELIMITER $$
DROP FUNCTION IF EXISTS hddPsuCompatibility$$
CREATE DEFINER=CURRENT_USER FUNCTION hddPsuCompatibility(hddInter VARCHAR(10), psuPeripheral INT,
	psuSata INT)
	RETURNS INT DETERMINISTIC
BEGIN
	DECLARE supported INT DEFAULT 1;

	IF psuPeripheral = 0 AND STRCMP(hddInter, 'IDE/PATA') = 0 THEN
		SET supported = 0;
	ELSEIF psuSata = 0 AND 
		((STRCMP(hddInter, 'SATA 3') = 0) OR (STRCMP(hddInter, 'SATA 6') = 0)) THEN
		SET supported = 0;
	END IF;				
	RETURN supported;
END$$
DELIMITER ;