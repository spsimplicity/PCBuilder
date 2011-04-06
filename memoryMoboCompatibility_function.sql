DELIMITER $$
DROP FUNCTION IF EXISTS memoryMoboCompatibility$$
CREATE DEFINER=CURRENT_USER FUNCTION memoryMoboCompatibility(moboMemChannel INT, memMultiChannelType INT,
	moboMemType VARCHAR(5), memType VARCHAR(5), moboMemSlots INT, memDimms INT,
	moboId INT, memSpeed INT, moboMaxMemory INT, memTotalCapacity INT)
	RETURNS INT DETERMINISTIC
BEGIN
	DECLARE supported INT DEFAULT 1;

	/*Its incompatible if memMultichannelType does not match*/
	IF moboMemChannel != memMultiChannelType THEN
		SET supported = 0;
	/*or memType does not match*/
	ELSEIF !(STRCMP(moboMemType, memType) = 0) THEN
		SET supported = 0;
	/*or memDimms is greater than number of dimm slots*/
	ELSEIF moboMemSlots < memDimms THEN
		SET supported = 0;
	/*or the speed is one of the accepted speeds*/
	ELSEIF memSpeedMatch(moboId, memSpeed) = 0 THEN
		SET supported = 0;
	/*or total capacity is greater than mobo total mem capacity*/
	ELSEIF moboMaxMemory < memTotalCapacity THEN
		SET supported = 0;
	END IF;				
	RETURN supported;
END$$
DELIMITER ;