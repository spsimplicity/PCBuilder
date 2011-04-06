DELIMITER $$
DROP FUNCTION IF EXISTS coolerSocketMatch$$
CREATE DEFINER=CURRENT_USER FUNCTION coolerSocketMatch(coolerId INT, socketToMatch VARCHAR(10))
	RETURNS INT DETERMINISTIC
BEGIN
	/*Flag to hold value for wether the sockets match or not*/
	DECLARE socketsMatch INT DEFAULT 0;
	/*The socket of the CPU Cooler*/
	DECLARE cpuCoolerSocket VARCHAR(10);
	DECLARE loopDone INT DEFAULT 0;
	/*Cursor to get each socket for the specific CPU Cooler*/
	DECLARE coolerSocketsCur CURSOR FOR 
		SELECT sockettype
		FROM cpu_cooler_sockets
		WHERE coolerId = cpu_cooler_id;
	/*Handler to set varaible to leave loop when no sets left*/
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET loopDone = 1;
	/*For each CPU Cooler socket*/
	OPEN coolerSocketsCur;
	socketsLoop:LOOP
		FETCH coolerSocketsCur INTO cpuCoolerSocket;
		IF loopDone = 1 THEN
			LEAVE socketsLoop;
		END IF;
		/*If the sizes match set the flag to 1*/
		IF STRCMP(cpuCoolerSocket, socketToMatch) = 0 THEN
			SET socketsMatch = 1;
			SET loopDone = 1;
		END IF;
	END LOOP socketsLoop;				
	RETURN socketsMatch;
END$$
DELIMITER ;