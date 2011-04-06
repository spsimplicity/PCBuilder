DELIMITER $$
DROP FUNCTION IF EXISTS displayCompatibility$$
CREATE DEFINER=CURRENT_USER FUNCTION displayCompatibility(monVga INT, monHdmi INT,
	monSvideo INT, monDvi INT, monDp INT, gpuVga INT, gpuHdmi INT,
	gpuSvideo INT, gpuDvi INT, gpuDp INT)
	RETURNS INT DETERMINISTIC
BEGIN
	DECLARE portMatch INT DEFAULT 0;
	
	IF monVga > 0 AND gpuVga > 0 THEN
		SET portMatch = 1;
	ELSEIF monHdmi > 0 AND gpuHdmi > 0 THEN
		SET portMatch = 1;
	ELSEIF monSvideo > 0 AND gpuSvideo > 0 THEN
		SET portMatch = 1;
	ELSEIF monDvi > 0 AND gpuDvi > 0 THEN
		SET portMatch = 1;
	ELSEIF monDp > 0 AND gpuDp > 0 THEN
		SET portMatch = 1;
	END IF;				
	RETURN portMatch;
END$$
DELIMITER ;