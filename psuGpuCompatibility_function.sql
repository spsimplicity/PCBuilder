DELIMITER $$
DROP FUNCTION IF EXISTS gpuPsuCompatibility$$
CREATE DEFINER=CURRENT_USER FUNCTION gpuPsuCompatibility(gpuMin INT, psuPower INT, gpu8 INT, gpu6 INT, 
	psu8 INT, psu6 INT, psu62 INT)
	RETURNS INT DETERMINISTIC
BEGIN
	DECLARE supported INT DEFAULT 1;
	/*Incompatible if power supply does not have enough power connectors for
	  the graphics card*/
	/*If the gpu need both 6pin and 8pin power make sure if has enough of both*/
	IF gpuMin > psuPower THEN
		SET supported = 0;
	ELSEIF gpu8 > 0 AND gpu6 > 0 THEN
		/*If there is enough gpu8pin power then use the 6+2 pin for 6pin power*/
		IF psu8 >= gpu8 THEN
			IF (psu6 + psu62) < gpu6 THEN
				SET supported = 0;
			END IF;
		/*If not enough gpu8pin power then sue the 6+2pin power to balance out*/
		ELSEIF (psu8 + psu62) >= gpu8 THEN
			/*Need to subtract because you need to see how many 6+2 power connectors are
			left after using them up for any 8 power slots if needed*/
			IF (psu6 + ((psu8 - gpu8) + psu62)) < gpu6 THEN
				SET supported = 0;
			END IF;
		/*not enough 8pin power for the graphics card*/
		ELSE
			SET supported = 0;
		END IF;
	/*If it needs just 8pin power check if there is enough*/
	ELSEIF gpu8 > 0 THEN
		IF (psu8 + psu62) < gpu8 THEN
			SET supported = 0;
		END IF;
	/*If it needs just 6pin power check if there is enough*/
	ELSEIF gpu6 > 0 THEN
		IF (psu6 + psu62) < gpu6 THEN
			SET supported = 0;
		END IF;
	END IF;				
	RETURN supported;
END$$
DELIMITER ;