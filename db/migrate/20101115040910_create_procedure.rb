class CreateProcedure < ActiveRecord::Migration
    def self.up
        execute <<-SQL
			CREATE FUNCTION duplicateTest(part1id INT, part2id INT, part1_type VARCHAR(20), part2_type VARCHAR(20))
				RETURNS INT DETERMINISTIC
			BEGIN
				DECLARE nullTest INT DEFAULT 0;
				DECLARE temp INT;
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET nullTest = 1;

				SELECT id INTO temp FROM incompatibles WHERE part1_id = part1Id and part2_id = part2Id;
				IF nullTest = 1 THEN
					INSERT INTO incompatibles(part1_id, part1type, part2_id, part2type, created_at, updated_at)
					VALUES (part1Id, part1_type, part2Id, part2_type, cast(now() as DATETIME), cast(now() as DATETIME));
				END IF;
				RETURN nullTest;
			END;
	    SQL

		execute <<-SQL
			CREATE FUNCTION coolerSocketMatch(coolerId INT, socketToMatch VARCHAR(10))
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
			END;
		SQL
	  
		execute <<-SQL
		    CREATE FUNCTION caseSizeMatch(caseId INT, sizeToMatch VARCHAR(15))
				RETURNS INT DETERMINISTIC
			BEGIN
				/*Holds the size of the Motherboard*/
				DECLARE caseMoboSize VARCHAR(15);
				/*Flag to determine if the sizes match*/
				DECLARE caseSizeMatch INT DEFAULT 0;
				DECLARE loopDone INT DEFAULT 0;
				/*Gets all the sizes for the specific Case*/
				DECLARE caseSizeCur CURSOR FOR 
					SELECT size
					FROM case_motherboards
					WHERE caseId = case_id;
				/*Handler to set variable to signify there are no sizes left*/
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET loopDone = 1;
				/*For each Case Motherboard size*/
				open caseSizeCur;
				sizeLoop:LOOP
					FETCH caseSizeCur INTO caseMoboSize;
					IF loopDone = 1 THEN
						LEAVE sizeLoop;
					END IF;
					/*If the sizes match set the flag to 1*/
					IF STRCMP(caseMoboSize,sizeToMatch) = 0 THEN
						SET caseSizeMatch = 1;
						SET loopDone = 1;
					END IF;
				END LOOP sizeLoop;				
				RETURN caseSizeMatch;
			END;
		SQL

		execute <<-SQL
			CREATE FUNCTION memSpeedMatch(motherboardId INT, memorySpeed INT)
				RETURNS INT DETERMINISTIC
			BEGIN
				/*Flag to hold wether a speed match is found*/
				DECLARE speedMatch INT DEFAULT 0;
				DECLARE moboSpeed INT;
				DECLARE loopDone INT DEFAULT 0;	
				/*Cursor to get each socket for the specific CPU Cooler*/
				DECLARE moboSpeedsCur CURSOR FOR 
					SELECT speed
					FROM memory_speeds
					WHERE motherboardId = motherboard_id;
				/*Handler to set varaible to leave loop when no sets left*/
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET loopDone = 1;
				/*For each memory speed*/
				OPEN moboSpeedsCur;
				speedsLoop:LOOP
					FETCH moboSpeedsCur INTO moboSpeed;
					IF loopDone = 1 THEN
						LEAVE speedsLoop;
					END IF;
					IF moboSpeed > memorySpeed THEN
						SET speedMatch = 1;
					ELSEIF moboSpeed = memorySpeed THEN
						SET speedMatch = 2;
						SET loopDone = 1;
					END IF;
				END LOOP speedsLoop;
				RETURN speedMatch;
			END;
		SQL

		execute <<-SQL
		    CREATE FUNCTION discdMoboCompatibility(ddInter VARCHAR(10), moboS3 INT, 
				moboS6 INT, moboIde INT)
				RETURNS INT DETERMINISTIC
			BEGIN
				DEClARE supported INT DEFAULT 1;
				
				IF STRCMP(ddInterface, 'SATA') = 0 AND moboS3 = 0 AND moboS6 = 0 THEN
					SET supported = 0;
				/*or transfer type is ide and no ide ports on motherboard*/
				ELSEIF STRCMP(ddInterface, 'IDE/PATA') = 0 AND moboIde = 0 THEN
					SET supported = 0;
				END IF;				
				RETURN supported;
			END;
		SQL
		
		execute <<-SQL
		    CREATE FUNCTION discdPsuCompatibility(ddInter VARCHAR(10), psuPeripheral INT, 
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
			END;
		SQL
		
		execute <<-SQL
		    CREATE FUNCTION displayCompatibility(monVga INT, monHdmi INT,
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
			END;
		SQL
  
		execute <<-SQL
		    CREATE FUNCTION hddMoboCompatibility(hddInter VARCHAR(10), moboS6 INT, 
				moboS3 INT, moboIde INT)
				RETURNS INT DETERMINISTIC
			BEGIN
				DECLARE supported INT DEFAULT 1;
				
				IF STRCMP(hddInter, 'SATA 6') = 0 AND moboS6 = 0 THEN
					SET supported = 0;
				ELSEIF STRCMP(hddInter, 'SATA 3') = 0 AND moboSa6 = 0 AND moboS3 = 0 THEN
					SET supported = 0;
				ELSEIF STRCMP(hddInter, 'IDE/PATA') = 0 AND moboIde = 0 THEN
					SET supported = 0;
				END IF;				
				RETURN supported;
			END;
		SQL
		
		execute <<-SQL
		    CREATE FUNCTION hddPsuCompatibility(hddInter VARCHAR(10), psuPeripheral INT,
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
			END;
		SQL
		
		execute <<-SQL
		    CREATE FUNCTION memoryMoboCompatibility(moboMemChannel INT, memMultiChannelType INT,
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
			END;
		SQL

		execute <<-SQL
		    CREATE FUNCTION gpuPsuCompatibility(gpuMin INT, psuPower INT, gpu8 INT, gpu6 INT, 
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
			END;
		SQL
		execute <<-SQL
		    CREATE PROCEDURE compatibilityAlgorithmTest(part1Id INT, part1_type VARCHAR(20))
			BEGIN
				/*Variables for each part*/
				DECLARE part2Id INT;
				DECLARE part2_type VARCHAR(20);
				DECLARE done INT DEFAULT 0;
				DECLARE nullTest INT;
				DECLARE temp INT;
				/*Monitor decs*/
				DECLARE monVga INT;
				DECLARE monHdmi INT;
				DECLARE monSvideo INT;
				DECLARE monDvi INT;
				DECLARE monDisplayport INT;
				DECLARE portMatch INT;
				/*Case decs*/
				DECLARE caseId INT;
				DECLARE caseTotalBays INT;
				DECLARE caseHddBays INT;
				DECLARE caseConversionBays INT;
				DECLARE caseSsdBays INT;
				DECLARE caseExpansionSlots INT;
				DECLARE caseDiscBays INT;
				DECLARE caseLength INT;
				DECLARE caseWidth INT;
				DECLARE caseHeight INT;
				DECLARE caseMaxCoolerHeight INT;
				DECLARE caseMaxGpuLength INT;
				/*Hard drive decs*/
				DECLARE hddInterface VARCHAR(10);
				/*Disc Drive decs*/
				DECLARE ddInterface VARCHAR(10);
				/*Memory decs*/
				DECLARE memSpeed INT;
				DECLARE memMultiChannelType INT;
				DECLARE memType VARCHAR(5);
				DECLARE memDimms INT;
				DECLARE memTotalCapacity INT;
				/*Power supply decs*/
				DECLARE psuMainPower INT;
				DECLARE psuSataPower INT;
				DECLARE psuMultiGpuReady INT;
				DECLARE psuPeripheral INT;
				DECLARE psuPowerOut INT;
				DECLARE psuCpu4_4pin INT;
				DECLARE psuCpu4pin INT;
				DECLARE psuCpu8pin INT;
				DECLARE psuGpu8pin INT;
				DECLARE psuGpu6pin INT;
				DECLARE psuGpu6_2pin INT;
				DECLARE psuLength INT;	
				/*Graphics card decs*/
				DECLARE gpuChipMan VARCHAR(10);
				DECLARE gpuWidth VARCHAR(10);
				DECLARE gpuLength INT;
				DECLARE gpuInterface VARCHAR(15);
				DECLARE graphicsProcessor VARCHAR(10);
				DECLARE multiGpuReady INT;
				DECLARE gpuHdmi INT;
				DECLARE gpuDvi INT;
				DECLARE gpuDisplayport INT;
				DECLARE gpuVga INT;
				DECLARE gpuSvideo INT;
				DECLARE gpuMinPower INT;
				DECLARE gpuMultiGpuPower INT;
				DECLARE gpu6PinPower INT;
				DECLARE gpu8PinPower INT;
				DECLARE gpu2ChipMan VARCHAR(10);
				DECLARE gpu2Width VARCHAR(10);
				DECLARE gpu2Length INT;
				DECLARE gpu2Interface VARCHAR(15);
				DECLARE graphics2Processor VARCHAR(10);
				DECLARE multiGpu2Ready INT;
				DECLARE gpu2Hdmi INT;
				DECLARE gpu2Dvi INT;
				DECLARE gpu2Displayport INT;
				DECLARE gpu2Vga INT;
				DECLARE gpu2Svideo INT;
				DECLARE gpu2MinPower INT;
				DECLARE gpu2MultiGpuPower INT;
				DECLARE gpu26PinPower INT;
				DECLARE gpu28PinPower INT;
				/*Motherboard decs*/
				DECLARE moboMaxMemory INT;
				DECLARE moboMemType VARCHAR(5);
				DECLARE moboMemSlots INT;
				DECLARE moboMemChannel INT;
				DECLARE moboPcie16 INT;
				DECLARE moboSize VARCHAR(15);
				DECLARE moboCpuPower INT;
				DECLARE moboFsb INT;
				DECLARE moboMainPower INT;
				DECLARE moboXFire INT;
				DECLARE moboSli INT;
				DECLARE moboSocketType VARCHAR(10);
				DECLARE moboSata3 INT;
				DECLARE moboSata6 INT;
				DECLARE moboIde INT;
				DECLARE moboId INT;
				/*Cpu decs*/
				DECLARE maxMemory INT;
				DECLARE cpuPower INT;
				DECLARE cpuFsb INT;
				DECLARE cpuSocketType VARCHAR(10);
				DECLARE cpuWatts INT;
				DECLARE memChannelType INT;
				/*Cpu cooler decs*/
				DECLARE coolerId INT;
				DECLARE maxMemHeight INT;
				DECLARE coolerHeight INT;
				DECLARE leng INT;
				DECLARE width INT;
				
				/*Cursors for each part*/
				DECLARE monitorCur CURSOR FOR
					SELECT part_id, parttype, vga, hdmi, svideo, dvi, displayport
					FROM displays;
				
				DECLARE caseCur CURSOR FOR
					SELECT id, part_id, parttype, totalbays, hddbays, conversionbays, ssdbays, 
						expansionslots, discbays, length, width, height, maxcoolerheight, maxgpulength
					FROM cases;
				
				DECLARE hardDriveCur cursor FOR
					SELECT part_id, parttype, interface
					FROM hard_drives;
				
				DECLARE discDriveCur CURSOR FOR
					SELECT part_id, parttype, interface
					FROM disc_drives;
					
				DECLARE memoryCur CURSOR FOR
					SELECT part_id, parttype, speed, multichanneltype, memorytype, dimms,
						totalcapacity
					FROM memories;
				
				DECLARE powerSupplyCur CURSOR FOR
					SELECT part_id, parttype, mainpower, satapower, multi_gpu, peripheral, poweroutput, 
						cpu4_4pin, cpu4pin, cpu8pin, gpu8pin, gpu6pin, gpu6_2pin, length
					FROM power_supplies;
				
				DECLARE graphicsCardCur CURSOR FOR
					SELECT part_id, parttype, chipmanufacturer, width, length, interface, gpu, multigpusupport, 
						hdmi, dvi, displayport, vga, svideo, minpower, multigpupower, power6pin, power8pin
					FROM graphics_cards;
						
				DECLARE motherboardCur CURSOR FOR
					SELECT id, part_id, parttype, maxmemory, memorytype, memoryslots, memchannel,
						pci_ex16, size, cpupowerpin, fsb, mainpower, crossfire, sli, 
						sockettype, sata3, sata6, ide
					FROM motherboards;
				
				DECLARE cpuCur CURSOR FOR
					SELECT part_id, parttype, sockettype, fsb, watts, cpupower, maxmemory, memchanneltype
					FROM cpus;
				
				DECLARE cpuCoolerCur CURSOR FOR
					SELECT id, part_id, parttype, maxmemheight, height, width, leng
					FROM cpu_coolers;
					
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
				
				/*Start of Part Incompatibility algorithm*/
				CASE part1_type
				  
				  WHEN 'Motherboard' THEN
					/*Get the data for the Motherboard being checked*/
					SELECT id, maxmemory, memorytype, memchannel, pci_ex16, memoryslots, 
						size, cpupowerpin, fsb, mainpower, crossfire, sli, sockettype, sata3, 
						sata6, ide
					INTO moboId, moboMaxMemory, moboMemType, moboMemChannel, moboPcie16, moboMemSlots,
						moboSize, moboCpuPower, moboFsb, moboMainPower, moboXFire, moboSli, moboSocketType,
						moboSata3, moboSata6, moboIde
					FROM motherboards
					WHERE part1Id = motherboards.part_id;
					
					/*For each Memory*/
					OPEN memoryCur;
					memLoop:LOOP
						FETCH memoryCur INTO part2Id, part2_type, memSpeed, memMultichannelType, 
							memType, memDimms, memTotalCapacity;
						IF done = 1 THEN
							LEAVE memLoop;
						END IF;
						IF memoryMoboCompatibility(moboMemChannel, memMultiChannelType, moboMemType, 
							memType, moboMemSlots, memDimms, moboId, memSpeed, moboMaxMemory, 
							memTotalCapacity) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP memLoop;
					SET done = 0;
					/*For each CPU*/
					OPEN cpuCur;
					cpuLoop:LOOP
						FETCH cpuCur INTO part2Id, part2_type, cpuSocketType, cpuFsb, cpuWatts, cpuPower, maxMemory,
						memChannelType;
						IF done = 1 THEN
							LEAVE cpuLoop;
						END IF;
						/*Incompatible if the sockets dont match*/
						IF !(STRCMP(cpuSocketType, moboSocketType) = 0) THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP cpuLoop;
					SET done = 0;
					/*For each CPU Cooler*/
					OPEN cpuCoolerCur;
					coolerLoop:LOOP
						FETCH cpuCoolerCur INTO coolerId, part2Id, part2_type, maxMemHeight, coolerHeight, 
							width, leng;
						IF done = 1 THEN
							LEAVE coolerLoop;
						END IF;
						/*Its incompatible if no sockets match*/
						IF coolerSocketMatch(coolerId, moboSocketType) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP coolerLoop;
					SET done = 0;
					/*For each Graphics Card*/
					OPEN graphicsCardCur;
					graphicsLoop:LOOP
						FETCH graphicsCardCur INTO part2Id, part2_type, gpuChipMan, gpuWidth, gpuLength,
							gpuInterface, graphicsProcessor, multiGpuReady, gpuHdmi, gpuDvi, gpuDisplayport, 
							gpuVga, gpuSvideo, gpuMinpower, gpuMultiGpuPower, gpu6PinPower, gpu8PinPower;
						IF done = 1 THEN
							LEAVE graphicsLoop;
						END IF;
						/*Incompatible if not pci_ex16 slots on the motherboard*/
						IF moboPcie16 = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP graphicsLoop;
					SET done = 0;
					/*For each Hard Drive*/
					OPEN hardDriveCur;
					hddLoop:LOOP
						FETCH hardDriveCur INTO part2Id, part2_type, hddInterface;
						IF done = 1 THEN
							LEAVE hddLoop;
						END IF;
						IF hddMoboCompatibility(hddInterface, moboSata6, moboSata3, moboIde) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP hddLoop;
					SET done = 0;
					/*For each Disc Drive*/
					OPEN discDriveCur;
					discLoop:LOOP
						FETCH discDriveCur INTO part2Id, part2_type, ddInterface;
						IF done = 1 THEN
							LEAVE discLoop;
						END IF;
						/*Incompatible if transfer type is sata and no sata ports on motherboard*/
						IF discdMoboCompatibility(ddInterface, moboSata3, moboSata6, moboIde) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP discLoop; 
					SET done = 0;
					/*For each Power Supply*/
					OPEN powerSupplyCur;
					powerLoop:LOOP
						FETCH powerSupplyCur INTO part2Id, part2_Type, psuMainPower, psuSataPower, 
							psuMultiGpuReady, psuPeripheral, psuPowerOut, psuCpu4_4pin, psuCpu4pin, 
							psuCpu8pin, psuGpu8pin, psuGpu6pin, psuGpu6_2pin, psuLength;
						IF done = 1 THEN
							LEAVE powerLoop;
						END IF;
						/*Its incompatible if the psu cant provide enough power to the mobo*/
						IF psuMainPower < moboMainPower THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP powerLoop;
					SET done = 0;
					/*For each Case*/
					OPEN caseCur;
					caseLoop:LOOP
						FETCH caseCur INTO caseId, part2Id, part2_Type, caseTotalBays, caseHddBays, 
							caseConversionBays, caseSsdBays, caseExpansionSlots, caseDiscBays, 
							caseLength, caseWidth, caseHeight, caseMaxCoolerHeight, caseMaxGpuLength;
						IF done = 1 THEN
							LEAVE caseLoop;
						END IF;
						/*If not sizes match its incompatible*/
						IF caseSizeMatch(caseId, moboSize) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP caseLoop;
				  
				  WHEN 'Graphics Card' THEN
					/*Get the data for the Motherboard being checked*/
					SELECT chipmanufacturer, width, length, interface, gpu, multigpusupport, hdmi, dvi, 
						displayport, vga, svideo, minpower, multigpupower, power6pin, power8pin
					INTO gpuChipMan, gpuWidth, gpuLength, gpuInterface, graphicsProcessor, multiGpuReady,
						gpuHdmi, gpuDvi, gpuDisplayPort, gpuVga, gpuSvideo, gpuMinPower, gpuMultiGpuPower,
						gpu6PinPower, gpu8PinPower
					FROM graphics_cards
					WHERE part1Id = graphics_cards.part_id;
					/*For each Motherboard*/
					OPEN motherboardCur;
					motherboardLoop:LOOP
						FETCH motherboardCur INTO moboId, part2Id, part2_type, moboMaxMemory, moboMemType, 
							moboMemSlots, moboMemChannel, moboPcie16, moboSize, moboCpuPower, moboFsb, 
							moboMainPower, moboXFire, moboSli, moboSocketType, moboSata3, moboSata6, moboIde;
						IF done = 1 THEN
							LEAVE motherboardLoop;
						END IF;
						/*Incompatible if no pciex16 slots on motherboard*/
						IF moboPcie16 = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP motherboardLoop;
					SET done = 0;
					/*For each Power Supply*/
					OPEN powerSupplyCur;
					powerLoop:LOOP
						FETCH powerSupplyCur INTO part2Id, part2_Type, psuMainPower, psuSataPower, 
							psuMultiGpuReady, psuPeripheral, psuPowerOut, psuCpu4_4pin, psuCpu4pin, 
							psuCpu8pin, psuGpu8pin, psuGpu6pin, psuGpu6_2pin, psuLength;
						IF done = 1 THEN
							LEAVE powerLoop;
						END IF;
						IF psuGpuCompatibility(gpuMinPower, psuPowerOut, gpu8PinPower, gpu6PinPower, 
							psuGpu8pin, psuGpu6pin, psuGpu6_2pin) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP powerLoop;
					SET done = 0;
					/*For each Case*/
					OPEN caseCur;
					caseLoop:LOOP
						FETCH caseCur INTO caseId, part2Id, part2_Type, caseTotalBays, caseHddBays, 
							caseConversionBays, caseSsdBays, caseExpansionSlots, caseDiscBays, 
							caseLength, caseWidth, caseHeight, caseMaxCoolerHeight, caseMaxGpuLength;
						IF done = 1 THEN
							LEAVE caseLoop;
						END IF;
						IF gpuLength > caseMaxGpuLength THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP caseLoop;
					SET done = 0;
					/*For each display*/
					OPEN monitorCur;
					monitorLoop:LOOP
						FETCH monitorCur INTO part2Id, part2_Type, monVga, monHdmi, monSvideo, monDvi, 
							monDisplayPort;
						IF done = 1 THEN
							LEAVE monitorLoop;
						END IF;
						/*Incompatible if not a port on the monitor matches a port on the graphics card*/
						IF (displayCompatibility(monVga, monHdmi, monSvideo, monDvi, monDisplayport,
							gpuVga, gpuHdmi, gpuSvideo, gpuDvi, gpuDisplayport)) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP monitorLoop;
					SET done = 0;
					/*For each Graphics Card*/
					OPEN graphicsCardCur;
					graphicsLoop:LOOP
						FETCH graphicsCardCur INTO part2Id, part2_type, gpu2ChipMan, gpu2Width, gpu2Length, 
							gpu2Interface, graphics2Processor, multiGpu2Ready, gpu2Hdmi, gpu2Dvi, 
							gpu2DisplayPort, gpu2Vga, gpu2Svideo, gpu2MinPower, gpu2MultiGpuPower, 
							gpu26PinPower, gpu28PinPower;
						IF done = 1 THEN
							LEAVE graphicsLoop;
						END IF;
						/*need to test graphics cards with one another*/
					END LOOP graphicsLoop;
					
				  WHEN 'Power Supply' THEN      
					/*Get data for Power Supply being checked*/
					SELECT mainpower, satapower, multi_gpu, peripheral, poweroutput,
						cpu4_4pin, cpu4pin, cpu8pin, gpu8pin, gpu6pin, gpu6_2pin, length
					INTO psuMainPower, psuSataPower, psuMultiGpuReady, psuPeripheral, 
						psuPowerOut, psuCpu4_4pin, psuCpu4pin, psuCpu8pin, psuGpu8pin, 
						psuGpu6pin, psuGpu6_2pin, psuLength
					FROM power_supplies
					WHERE part1Id = power_supplies.part_id;
					
					/*For each Hard Drive*/
					OPEN hardDriveCur;
					hddLoop:LOOP
						FETCH hardDriveCur INTO part2Id, part2_type, hddInterface;
						IF done = 1 THEN
							LEAVE hddLoop;
						END IF;
						/*Incompatible if the power supply does not have sata power for sata hdd*/
						IF hddPsuCompatibility(hddInterface, psuPeripheral, psuSataPower) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP hddLoop;
					SET done = 0;
					/*For each Disc Drive*/
					OPEN discDriveCur;
					discLoop:LOOP
						FETCH discDriveCur INTO part2Id, part2_type, ddInterface;
						IF done = 1 THEN
							LEAVE discLoop;
						END IF;
						/*Incompatible if the power supply does not have sata power for sata dsic drive*/
						IF discdPsuCompatibility(ddInterface, psuPeripheral, psuSataPower) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP discLoop;
					SET done = 0;
					/*For each Motherboard*/
					OPEN motherboardCur;
					motherboardLoop:LOOP
						FETCH motherboardCur INTO moboId, part2Id, part2_type, moboMaxMemory, moboMemType, 
							moboMemSlots, moboMemChannel, moboPcie16, moboSize, moboCpuPower, moboFsb, 
							moboMainPower, moboXFire, moboSli, moboSocketType, moboSata3, moboSata6, moboIde;
						IF done = 1 THEN
							LEAVE motherboardLoop;
						END IF;
						/*Incompatible if Power Supply cant provide enough power*/
						IF psuMainPower != moboMainPower THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP motherboardLoop;
					SET done = 0;
					/*For each Graphics Card*/
					OPEN graphicsCardCur;
					graphicsLoop:LOOP
						FETCH graphicsCardCur INTO part2Id, part2_type, gpuChipMan, gpuWidth, gpuLength,
							gpuInterface, graphicsProcessor, multiGpuReady, gpuHdmi, gpuDvi, gpuDisplayport, 
							gpuVga, gpuSvideo, gpuMinpower, gpuMultiGpuPower, gpu6PinPower, gpu8PinPower;
						IF done = 1 THEN
							LEAVE graphicsLoop;
						END IF;
						IF psuGpuCompatibility(gpuMinPower, psuPowerOut, gpu8PinPower, gpu6PinPower, 
							psuGpu8pin, psuGpu6pin, psuGpu6_2pin) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP graphicsLoop;
					SET done = 0;
					/*For each CPU*/
					OPEN cpuCur;
					cpuLoop:LOOP
						FETCH cpuCur INTO part2Id, part2_type, cpuSocketType, cpuFsb, cpuWatts, cpuPower, maxMemory,
							memChannelType;
						IF done = 1 THEN
							LEAVE cpuLoop;
						END IF;
						/*Incompatible if CPU requires more power then Power Supply can give*/
						IF cpuWatts >= 125 AND psuCpu8pin = 0 AND psuCpu4_4pin = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP cpuLoop;
					
				  WHEN 'Memory' THEN        
					/*Get data for memory being checked*/
					SELECT speed, multichanneltype, memorytype, dimms, totalcapacity
					INTO memSpeed, memMultichannelType, memType, memDimms, memTotalCapacity
					FROM memories
					WHERE part1Id = memories.part_id;
					
					/*For each Motherboard*/
					OPEN motherboardCur;
					motherboardLoop:LOOP
						FETCH motherboardCur INTO moboId, part2Id, part2_type, moboMaxMemory, moboMemType, 
							moboMemSlots, moboMemChannel, moboPcie16, moboSize, moboCpuPower, moboFsb, 
							moboMainPower, moboXFire, moboSli, moboSocketType, moboSata3, moboSata6, moboIde;							
						IF done = 1 THEN
							LEAVE motherboardLoop;
						END IF;
						IF memoryMoboCompatibility(moboMemChannel, memMultiChannelType, moboMemType, 
							memType, moboMemSlots, memDimms, moboId, memSpeed, moboMaxMemory, 
							memTotalCapacity) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP motherboardLoop;
				  
				  WHEN 'Disc Drive' THEN        
					/*Get data for disc drive being checked*/
					SELECT interface
					INTO ddInterface
					FROM disc_drives
					WHERE part1Id = disc_drives.part_id;
					
					/*For each Power Supply*/
					OPEN powerSupplyCur;
					powerLoop:LOOP
						FETCH powerSupplyCur INTO part2Id, part2_type, psuMainPower, psuSataPower, 
							psuMultiGpuReady, psuPeripheral, psuPowerOut, psuCpu4_4pin, psuCpu4pin, 
							psuCpu8pin, psuGpu8pin, psuGpu6pin, psuGpu6_2pin, psuLength;
						IF done = 1 THEN
							LEAVE powerLoop;
						END IF;
						/*Incompatible if the power supply does not have sata power for sata dsic drive*/
						IF discdPsuCompatibility(ddInterface, psuPeripheral, psuSataPower) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP powerLoop;
					SET done = 0;
					/*For each Motherboard*/
					OPEN motherboardCur;
					motherboardLoop:LOOP
						FETCH motherboardCur INTO moboId, part2Id, part2_type, moboMaxMemory, moboMemType, 
							moboMemSlots, moboMemChannel, moboPcie16, moboSize, moboCpuPower, moboFsb, 
							moboMainPower, moboXFire, moboSli, moboSocketType, moboSata3, moboSata6, moboIde;
						IF done = 1 THEN
							LEAVE motherboardLoop;
						END IF;
						/*Incompatible if transfer type is sata and no sata ports on motherboard*/
						IF discdMoboCompatibility(ddInterface, moboSata3, moboSata6, moboIde) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP motherboardLoop;
					
				  WHEN 'Hard Drive' THEN        
					/*Get data for hard drive being checked*/
					SELECT interface
					INTO hddInterface
					FROM hard_drives
					WHERE part1Id = hard_drives.part_id;
					
					/*For each Power Supply*/
					OPEN powerSupplyCur;
					powerLoop:LOOP
						FETCH powerSupplyCur INTO part2Id, part2_type, psuMainPower, psuSataPower, 
							psuMultiGpuReady, psuPeripheral, psuPowerOut, psuCpu4_4pin, psuCpu4pin, 
							psuCpu8pin, psuGpu8pin, psuGpu6pin, psuGpu6_2pin, psuLength;
						IF done = 1 THEN
							LEAVE powerLoop;
						END IF;
						IF hddPsuCompatibility(hddInterface, psuPeripheral, psuSataPower) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP powerLoop;
					SET done = 0;
					/*For each Motherboard*/
					OPEN motherboardCur;
					motherboardLoop:LOOP
						FETCH motherboardCur INTO moboId, part2Id, part2_type, moboMaxMemory, moboMemType, 
							moboMemSlots, moboMemChannel, moboPcie16, moboSize, moboCpuPower, moboFsb, 
							moboMainPower, moboXFire, moboSli, moboSocketType, moboSata3, moboSata6, moboIde;
						IF done = 1 THEN
							LEAVE motherboardLoop;
						END IF;
						IF hddMoboCompatibility(hddInterface, moboSata6, moboSata3, moboIde) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP motherboardLoop;
				  
				  WHEN 'Case' THEN      
					/*Get data for Case being checked*/
					SELECT id, totalbays, hddbays, conversionbays, ssdbays, 
						expansionslots, discbays, length, width, height, maxcoolerheight,
						maxgpulength
					INTO caseId, caseTotalBays, caseHddBays, caseConversionBays, caseSsdBays, 
						caseExpansionSlots, caseDiscBays, caseLength, caseWidth, caseHeight, 
						caseMaxCoolerHeight, caseMaxGpuLength
					FROM cases
					WHERE part1Id = cases.part_id;
				  
					/*For each Motherboard*/
					OPEN motherboardCur;
					motherboardLoop:LOOP
						FETCH motherboardCur INTO moboId, part2Id, part2_type, moboMaxMemory, moboMemType, 
							moboMemSlots, moboMemChannel, moboPcie16, moboSize, moboCpuPower, moboFsb, 
							moboMainPower, moboXFire, moboSli, moboSocketType, moboSata3, moboSata6, moboIde;
						IF done = 1 THEN
							LEAVE motherboardLoop;
						END IF;
						/*If not sizes match its incompatible*/
						IF caseSizeMatch(caseId, moboSize) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP motherboardLoop;
					SET done = 0;
					/*For each Graphics Card*/
					OPEN graphicsCardCur;
					graphicsLoop:LOOP
						FETCH graphicsCardCur INTO part2Id, part2_type, gpuChipMan, gpuWidth, gpuLength,
							gpuInterface, graphicsProcessor, multiGpuReady, gpuHdmi, gpuDvi, gpuDisplayport, 
							gpuVga, gpuSvideo, gpuMinpower, gpuMultiGpuPower, gpu6PinPower, gpu8PinPower;
						IF done = 1 THEN
							LEAVE graphicsLoop;
						END IF;
						IF gpuLength > caseMaxGpuLength THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP graphicsLoop;
					SET done = 0;
					/*For each CPU Cooler*/
					OPEN cpuCoolerCur;
					coolerLoop:LOOP
						FETCH cpuCoolerCur INTO coolerId, part2Id, part2_type, maxMemHeight, coolerHeight,
							width, leng;
						IF done = 1 THEN
							LEAVE coolerLoop;
						END IF;
						/*Incompatible if cooler is to tall for the case*/
						IF coolerHeight > caseMaxCoolerHeight THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP coolerLoop;
					
				  WHEN 'CPU' THEN
					/*Get the data for the cpu being checked*/
					SELECT sockettype, fsb, watts, cpupower, maxmemory, memchanneltype
					INTO cpuSocketType, cpuFsb, cpuWatts, cpuPower, maxMemory,
						memChannelType
					FROM cpus
					WHERE part1Id = cpus.part_id;
					
					/*For each Motherboard*/
					OPEN motherboardCur;
					motherboardLoop:LOOP
						FETCH motherboardCur INTO moboId, part2Id, part2_type, moboMaxMemory, moboMemType, 
							moboMemSlots, moboMemChannel, moboPcie16, moboSize, moboCpuPower, moboFsb, 
							moboMainPower, moboXFire, moboSli, moboSocketType, moboSata3, moboSata6, moboIde;
						IF done = 1 THEN
							LEAVE motherboardLoop;
						END IF;
						/*Incompatible if the sockets dont match*/
						IF !(STRCMP(cpuSocketType, moboSocketType) = 0) THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP motherboardLoop;
					SET done = 0;
					/*For each Power Supply*/
					OPEN powerSupplyCur;
					powerLoop:LOOP
						FETCH powerSupplyCur INTO part2Id, part2_type, psuMainPower, psuSataPower, 
							psuMultiGpuReady, psuPeripheral, psuPowerOut, psuCpu4_4pin, psuCpu4pin, 
							psuCpu8pin, psuGpu8pin, psuGpu6pin, psuGpu6_2pin, psuLength;
						IF done = 1 THEN
							LEAVE powerLoop;
						END IF;
						/*Incompatible if CPU requires more power then Power Supply can give*/
						IF cpuWatts >= 125 AND psuCpu8pin = 0 AND psuCpu4_4pin = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP powerLoop;
					SET done = 0;
					/*For each CPU Cooler*/
					OPEN cpuCoolerCur;
					coolerLoop:LOOP
						FETCH cpuCoolerCur INTO coolerId, part2Id, part2_type, maxMemHeight, coolerHeight,
							width, leng;
						IF done = 1 THEN
							LEAVE coolerLoop;
						END IF;
						/*Its incompatible if no sockets match*/
						IF coolerSocketMatch(coolerId, cpuSocketType) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP coolerLoop;
					
				  WHEN 'CPU Cooler' THEN      
					/*Get the data for the CPU Cooler being checked*/
					SELECT id, maxmemheight, height, width, leng
					INTO coolerId, maxMemHeight, coolerHeight, width, leng
					FROM cpu_coolers
					WHERE part1Id = cpu_coolers.part_id;
					
					/*For each Motherboard*/
					OPEN motherboardCur;
					motherboardLoop:LOOP
						FETCH motherboardCur INTO moboId, part2Id, part2_type, moboMaxMemory, moboMemType, 
							moboMemSlots, moboMemChannel, moboPcie16, moboSize, moboCpuPower, moboFsb, 
							moboMainPower, moboXFire, moboSli, moboSocketType, moboSata3, moboSata6, moboIde;
						IF done = 1 THEN
							LEAVE motherboardLoop;
						END IF;
						/*Its incompatible if no sockets match*/
						IF coolerSocketMatch(coolerId, moboSocketType) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP motherboardLoop;
					SET done = 0;
					/*For each Case*/
					OPEN caseCur;
					caseLoop:LOOP
						FETCH caseCur INTO caseId, part2Id, part2_type, caseTotalBays, caseHddBays, 
							caseConversionBays, caseSsdBays, caseExpansionSlots, caseDiscBays, caseLength, 
							caseWidth, caseHeight, caseMaxCoolerHeight, caseMaxGpuLength;
						IF done = 1 THEN
							LEAVE caseLoop;
						END IF;
						/*Incompatible if cooler is to tall for the case*/
						IF coolerHeight > caseMaxCoolerHeight THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP caseLoop;
					SET done = 0;
					/*For each Cpu*/
					OPEN cpuCur;
					cpuLoop:LOOP
						FETCH cpuCur INTO part2Id, part2_type, cpuSocketType, cpuFsb, cpuWatts, cpuPower, maxMemory,
							memChannelType;
						IF done = 1 THEN
							LEAVE cpuLoop;
						END IF;
						/*Incompatible if sockets do not match*/
						IF coolerSocketMatch(coolerId, cpuSocketType) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP cpuLoop;
					
				  ELSE 
					/*parttype is monitor*/        
					/*Get data for display being checked*/
					SELECT vga, hdmi, svideo, dvi, displayport
					INTO monVga, monHdmi, monSvideo, monDvi, monDisplayPort
					FROM displays
					WHERE part1Id = displays.part_id;
					
					/*For each Graphics Card*/
					OPEN graphicsCardCur;
					graphicsLoop:LOOP
						FETCH graphicsCardCur INTO part2Id, part2_type, gpuChipMan, gpuWidth, gpuLength,
							gpuInterface, graphicsProcessor, multiGpuReady, gpuHdmi, gpuDvi, gpuDisplayport, 
							gpuVga, gpuSvideo, gpuMinpower, gpuMultiGpuPower, gpu6PinPower, gpu8PinPower;
						IF done = 1 THEN
							LEAVE graphicsLoop;
						END IF;
						/*Incompatible if not a port on the monitor matches a port on the graphics card*/
						IF (displayCompatibility(monVga, monHdmi, monSvideo, monDvi, monDisplayport,
							gpuVga, gpuHdmi, gpuSvideo, gpuDvi, gpuDisplayport)) = 0 THEN
							SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
						END IF;
					END LOOP graphicsLoop;
				END CASE;
			END;
		SQL
    end

    def self.down
	    execute "DROP PROCEDURE IF EXISTS compatibilityAlgorithmTest"
		execute "DROP FUNCTION IF EXISTS caseSizeMatch"
		execute "DROP FUNCTION IF EXISTS coolerSocketMatch"
		execute "DROP FUNCTION IF EXISTS duplicateTest"
		execute "DROP FUNCTION IF EXISTS memSpeedMatch"
		execute "DROP FUNCTION IF EXISTS discdMoboCompatibility"
		execute "DROP FUNCTION IF EXISTS discdPsuCompatibility"
		execute "DROP FUNCTION IF EXISTS displayCompatibility"
		execute "DROP FUNCTION IF EXISTS hddMoboCompatibility"
		execute "DROP FUNCTION IF EXISTS hddPsuCompatibility"
		execute "DROP FUNCTION IF EXISTS memoryMoboCompatibility"
		execute "DROP FUNCTION IF EXISTS gpuPsuCompatibility"
    end
end
