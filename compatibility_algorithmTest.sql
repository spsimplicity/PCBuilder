DELIMITER $$

DROP PROCEDURE IF EXISTS compatibilityAlgorithmTest$$

CREATE PROCEDURE compatibilityAlgorithmTest(part1Id INT, part1_type VARCHAR(20))
BEGIN
    /*Variables for each part*/
    DECLARE primId INT;
    DECLARE part2Id INT;
    DECLARE part2_type VARCHAR(20);
    DECLARE maxMemory INT;
    DECLARE cpuPower INT;
    DECLARE fsb INT;
    DECLARE Crossfire INT DEFAULT 0;
    DECLARE cpuSocketType VARCHAR(10);
    DECLARE watts INT;
    DECLARE memChannelType INT;
    DECLARE maxMemHeight INT;
    DECLARE coolerHeight INT;
    DECLARE height INT;
    DECLARE leng INT;
    DECLARE width INT;
	DECLARE done INT DEFAULT 0;
	DECLARE nullTest INT;
	DECLARE temp INT;
    
    /*Cursors for each part*/        
    DECLARE cpuCur CURSOR FOR
        SELECT part_id, parttype, sockettype, fsb, watts, cpupower,maxmemory, memchanneltype
        FROM cpus;
        
    DECLARE cpuCoolerCur CURSOR FOR
        SELECT id, part_id, parttype, maxmemheight, height, width, leng
        FROM cpu_coolers;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	
    /*Start of Part Incompatibility algorithm*/
    CASE part1_type
	
	  WHEN 'CPU' THEN
        /*Get the data for the cpu being checked*/
        SELECT sockettype, fsb, watts, cpupower, maxmemory, memchanneltype
        INTO cpuSocketType, fsb, watts, cpuPower, maxMemory,
            memChannelType
        FROM cpus
        WHERE part1Id = cpus.part_id;
		/*For each CPU Cooler*/
        OPEN cpuCoolerCur;
        coolerLoop:LOOP
            FETCH cpuCoolerCur INTO primId, part2Id, part2_type, maxMemHeight, coolerHeight,
                width, leng;
            IF done = 1 THEN
                LEAVE coolerLoop;
            END IF;
            /*Its incompatible if no sockets match*/
            IF coolerSocketMatch(primId, cpuSocketType) = 0 THEN
			    SET nullTest = 0;
			    BEGIN
				    DECLARE EXIT HANDLER FOR NOT FOUND SET nullTest = 1;
			        SELECT id INTO temp FROM incompatibles WHERE part1_id = part1Id and part2_id = part2Id;
				END;
				IF nullTest = 1 THEN
				    INSERT INTO incompatibles(part1_id, part1type, part2_id, part2type, created_at, updated_at)
					VALUES (part1Id, part1_type, part2Id, part2_type, cast(now() as DATETIME), cast(now() as DATETIME));
				END IF;
            END IF;
        END LOOP coolerLoop;
        
      ELSE  
      /*WHEN 'CPU Cooler' THEN*/
      
        /*Get the data for the CPU Cooler being checked*/
        SELECT id, maxmemheight, height, width, leng
        INTO primId, maxMemHeight, coolerHeight, width, leng
        FROM cpu_coolers
        WHERE part1Id = cpu_coolers.part_id;
		
		OPEN cpuCur;
        cpuLoop:LOOP
            FETCH cpuCur INTO part2Id, part2_type, cpuSocketType, fsb, watts, cpuPower, maxMemory,
                memChannelType;
            IF done = 1 THEN
                LEAVE cpuLoop;
            END IF;
            /*Incompatible if sockets do not match*/
            IF coolerSocketMatch(primId, cpuSocketType) = 0 THEN
                SET nullTest = 0;
			    BEGIN
				    DECLARE EXIT HANDLER FOR NOT FOUND SET nullTest = 1;
			        SELECT id INTO temp FROM incompatibles WHERE part1_id = part1Id and part2_id = part2Id;
				END;
				IF nullTest = 1 THEN
				    INSERT INTO incompatibles(part1_id, part1type, part2_id, part2type, created_at, updated_at)
					VALUES (part1Id, part1_type, part2Id, part2_type, cast(now() as DATETIME), cast(now() as DATETIME));
				END IF;
            END IF;
        END LOOP cpuLoop;
    END CASE;
END$$

DELIMITER ;