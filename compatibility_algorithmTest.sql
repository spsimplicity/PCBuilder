DELIMITER $$
DROP PROCEDURE IF EXISTS compatibilityAlgorithmTest$$
CREATE DEFINER=CURRENT_USER PROCEDURE compatibilityAlgorithmTest(part1Id INT, part1_type VARCHAR(20))
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
	DECLARE mem2Speed INT;
	DECLARE mem2MultichannelType INT; 
	DECLARE mem2Type VARCHAR(5);
	DECLARE mem2Dimms INT;
	DECLARE mem2TotalCapacity INT;
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
	DECLARE gpuMemorysize INT;
	DECLARE gpu2Memorysize INT;
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
			hdmi, dvi, displayport, vga, svideo, minpower, multigpupower, power6pin, power8pin, memorysize
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
				gpuVga, gpuSvideo, gpuMinpower, gpuMultiGpuPower, gpu6PinPower, gpu8PinPower, gpuMemorysize;
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
			displayport, vga, svideo, minpower, multigpupower, power6pin, power8pin, memorysize
		INTO gpuChipMan, gpuWidth, gpuLength, gpuInterface, graphicsProcessor, multiGpuReady,
			gpuHdmi, gpuDvi, gpuDisplayPort, gpuVga, gpuSvideo, gpuMinPower, gpuMultiGpuPower,
			gpu6PinPower, gpu8PinPower, gpuMemorysize
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
			IF gpuPsuCompatibility(gpuMinPower, psuPowerOut, gpu8PinPower, gpu6PinPower, 
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
				gpu26PinPower, gpu28PinPower, gpu2Memorysize;
			IF done = 1 THEN
				LEAVE graphicsLoop;
			END IF;
			/*need to test graphics cards with one another*/
			IF (graphicsCardMatch(gpuChipMan, graphicsProcessor, multiGpuReady, gpuMemorysize, gpu2ChipMan, 
				graphics2Processor, multiGpu2Ready, gpu2Memorysize)) = 0 THEN
				SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
			END IF;
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
				gpuVga, gpuSvideo, gpuMinpower, gpuMultiGpuPower, gpu6PinPower, gpu8PinPower, gpuMemorysize;
			IF done = 1 THEN
				LEAVE graphicsLoop;
			END IF;
			IF gpuPsuCompatibility(gpuMinPower, psuPowerOut, gpu8PinPower, gpu6PinPower, 
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
		SET done = 0;
		/*For each Memory*/
		OPEN memoryCur;
		memLoop:LOOP
			FETCH memoryCur INTO part2Id, part2_type, mem2Speed, mem2MultichannelType, 
				mem2Type, mem2Dimms, mem2TotalCapacity;
			IF done = 1 THEN
				LEAVE memLoop;
			END IF;
			IF memoryMatch(memMultichannelType, memType, mem2MultichannelType, mem2Type) = 0 THEN
				SET nullTest = duplicateTest(part1id, part2id, part1_type, part2_type);
			END IF;
		END LOOP memLoop;
	  
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
				gpuVga, gpuSvideo, gpuMinpower, gpuMultiGpuPower, gpu6PinPower, gpu8PinPower, gpuMemorysize;
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
				gpuVga, gpuSvideo, gpuMinpower, gpuMultiGpuPower, gpu6PinPower, gpu8PinPower, gpuMemorysize;
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
END$$
DELIMITER ;