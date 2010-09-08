DELIMITER $$

DROP PROCEDURE IF EXISTS compatibilityAlgorithm$$

CREATE PROCEDURE compatibilityAlgorithm(part1Id INT, parttype VARCHAR(20))
BEGIN
    /*Variables for each part*/
    DECLARE primId INT;
    DECLARE part2Id INT;
    DECLARE part2Type VARCHAR(20);
    DECLARE maxMemory INT;
    DECLARE memoryType VARCHAR(5);
    DECLARE memorySlots INT;
    DECLARE pciex16 INT;
    DECLARE pcie2 INT;
    DECLARE moboSize VARCHAR(15);
    DECLARE caseSize VARCHAR(15);
    DECLARE moboCpuPower INT;
    DECLARE cpuPower INT;
    DECLARE fsb INT;
    DECLARE psuMainPower INT;
    DECLARE moboMainPower INT;
    DECLARE multiGpu INT DEFAULT 0;
    DECLARE cpuSocketType VARCHAR(10);
    DECLARE moboSocketType VARCHAR(10);
    DECLARE sata3 INT;
    DECLARE sata6 INT;
    DECLARE ide INT;
    DECLARE watts INT;
    DECLARE memChannelType INT;
    DECLARE maxMemHeight INT;
    DECLARE coolerHeight INT;
    DECLARE height INT;
    DECLARE length INT;
    DECLARE width INT;
    DECLARE sataPower INT;
    DECLARE peripheral INT;
    DECLARE powerOutput INT;
    DECLARE cpu4_4Pin INT;
    DECLARE cpu4pin INT;
    DECLARE cpu8pin INT;
    DECLARE gpu8pin INT;
    DECLARE gpu6pin int;
    DECLARE gpu6_2pin INT;
    DECLARE totalBays INT;
    DECLARE hddBays INT;
    DECLARE conversionBays INT;
    DECLARE ssdBays INT;
    DECLARE expansionSlots INT;
    DECLARE discBays INT;
    DECLARE maxCoolerHeight INT;
    DECLARE done INT DEFAULT 0;
    /*Cursors for each part*/
    DECLARE motherboardCur CURSOR FOR
        SELECT part_id, parttype, maxmemory, memorytype, memoryslots, pci_ex16, size,
            cpupowerpin, fsb, mainpower, sli_crossfire, sockettype, sata3, sata6, ide
        FROM motherboards;
    DECLARE cpuCur CURSOR FOR
        SELECT part_id, parttype, sockettype, fsb, watts, cpupower,maxmemory, memchanneltype
        FROM cpus;
    DECLARE cpuCoolerCur CURSOR FOR
        SELECT id, part_id, parttype, maxmemheight, height, width, length
        FROM cpu_coolers;
    /*DECLARE graphicsCardCur CURSOR FOR
        SELECT part_id, parttype
        FROM graphics_cards;*/
    DECLARE powerSupplyCur CURSOR FOR
        SELECT part_id, parttype, mainpower, satapower, multi_gpu, peripheral, poweroutput,
            cpu4_4pin, cpu4pin, cpu8pin, gpu8pin, gpu6pin, gpu6_2pin, length
        FROM power_supplies;
    /*DECLARE memoryCur CURSOR FOR
        SELECT part_id, parttype
        FROM memories;*/
    /*DECLARE discDriveCur CURSOR FOR
        SELECT part_id, parttype
        FROM disc_drives;*/
    /*DECLARE hardDriveCur cursor FOR
        SELECT part_id, parttype
        FROM hard_drives;*/
    DECLARE caseCur CURSOR FOR
        SELECT id, part_id, parttype, totalbays, hddbays, conversionbays, ssdbays, 
            expansionslots, discbays, length, width, height, maxcoolerheight
        FROM cases;
    /*DECLARE monitorCur CURSOR FOR
        SELECT part_id, parttype
        FROM monitors;*/
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    /*Start of part incompatibility algorithm*/
    CASE parttype
      WHEN 'Motherboard' THEN
        /*Get the data for the Motherboard being checked*/
        SELECT maxmemory, memorytype, pci_ex16, pci_e2, memoryslots, size, cpupowerpin, fsb,
            mainpower, sli_crossfire, sockettype, sata3, sata6, ide 
        INTO maxMemory, memoryType, pciex16, pcie2, memorySlots, moboSize, moboCpuPower, fsb, 
            moboMainPower, multiGpu, moboSocketType, sata3, sata6, ide
        FROM motherboards
        WHERE part1Id = part_id;
        /*For each Memory*/
        /*OPEN memoryCur;
        memLoop:LOOP

        EMD LOOP memLoop;*/
        /*For each CPU*/
        OPEN cpuCur;
        cpuLoop:LOOP
            FETCH cpuCur INTO part2Id, part2Type, cpuSocketType, fsb, watts, cpuPower, maxMemory,
                memChannelType;
            IF done = 1 THEN
                LEAVE cpuLoop;
            END IF;
            /*Its incompatible if the sockets dont match*/
            IF cpuSocketType != moboSocketType THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*Also incompatible if the mobo cant provide enough power through cpu connector*/
            ELSEIF cpuPower > moboCpuPower THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP cpuLoop;
        /*For each CPU Cooler*/
        OPEN cpuCoolerCur;
        coolerLoop:LOOP
            FETCH cpuCoolerCur INTO primId, part2Id, part2Type, maxMemHeight, coolerHeight,
                width, length;
            IF done = 1 THEN
                LEAVE coolerLoop;
            END IF;
            /*Its incompatible if no sockets match*/
            IF coolerSocketMatch(primId, moboSocketType) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP coolerLoop;
        /*For each Graphics Card*/
        /*OPEN graphicsCardCur;
        graphicsLoop:LOOP
        
        END LOOP graphicsLoop;*/
        /*For each Hard Drive*/
        /*OPEN hardDriveCur;
        hddLoop:LOOP
        
        END LOOP hddLoop;*/        
        /*For each Disc Drive*/
        /*OPEN discDriveCur;
        discLoop:LOOP
        
        END LOOP discLoop;*/
        /*For each Power Supply*/
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
            /*Its incompatible if the psu cant provide enough power to the mobo*/
            IF psuMainPower < moboMainPower THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP powerLoop;
        /*For each Case*/
        OPEN caseCur;
        caseLoop:LOOP
            FETCH caseCur INTO primId, part2Id, part2Type, totalBays, hddBays, conversionBays,
                ssdBays, expansionSlots, discBays, length, width, height, maxCoolerHeight;
            IF done = 1 THEN
                LEAVE caseLoop;
            END IF;
            /*If not sizes match its incompatible*/
            IF caseSizeMatch(primId, moboSize) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP caseLoop;
      WHEN 'CPU' THEN
        /*Get the data for the cpu being checked*/
        SELECT part_id, parttype, sockettype, fsb, watts, cpupower,maxmemory, memchanneltype
        INTO part2Id, part2Type, cpuSocketType, fsb, watts, cpuPower, maxMemory,
            memChannelType
        FROM cpus
        WHERE part1Id = part_id;
        /*For each Motherboard*/
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO part2Id, part2Type, maxMemory, memoryType, memorySlots, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, multiGpu, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*Incompatible if the sockets dont match*/
            IF cpuSocketType != moboSocketType THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP motherboardLoop;
        /*For each Power Supply*/
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
            /*Incompatible if CPU requires more power then Power Supply can give*/
            IF watts >= 125 && cpu8Pin = 0 && cpu4_4Pin = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP powerLoop;
        /*For each CPU Cooler*/
        coolerLoop:LOOP
            FETCH cpuCoolerCur INTO primId, part2Id, part2Type, maxMemHeight, coolerHeight,
                width, length;
            IF done = 1 THEN
                LEAVE coolerLoop;
            END IF;
            /*Its incompatible if no sockets match*/
            IF coolerSocketMatch(primId, cpuSocketType) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP coolerLoop;
      WHEN 'CPU Cooler' THEN
        /*Get the data for the CPU Cooler being checked*/
        SELECT id, part_id, parttype, maxmemheight, height, width, length
        INTO primId, part2Id, part2Type, maxMemHeight, coolerHeight, width, length
        FROM cpu_coolers
        WHERE part1Id = part_id;
        /*For each Motherboard*/
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO part2Id, part2Type, maxMemory, memoryType, memorySlots, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, multiGpu, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*Its incompatible if no sockets match*/
            IF coolerSocketMatch(primId, moboSocketType) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP motherboardLoop;
        /*For each Case*/
        OPEN caseCur;
        caseLoop:LOOP
            FETCH caseCur INTO primId, part2Id, part2Type, totalBays, hddBays, conversionBays,
                ssdBays, expansionSlots, discBays, length, width, height, maxCoolerHeight;
            IF done = 1 THEN
                LEAVE caseLoop;
            END IF;
            /*Incompatible if cooler is to tall for the case*/
            IF coolerHeight > maxCoolerHeight THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP caseLoop;
        /*For each CPU*/
        OPEN cpuCur;
        cpuLoop:LOOP
            FETCH cpuCur INTO part2Id, part2Type, cpuSocketType, fsb, watts, cpuPower, maxMemory,
                memChannelType;
            IF done = 1 THEN
                LEAVE cpuLoop;
            END IF;
            IF coolerSocketMatch(primId, cpuSocketType) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP cpuLoop;
      WHEN 'Graphics Card' THEN
        /*For each Motherboard*/
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO part2Id, part2Type, maxMemory, memoryType, memorySlots, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, multiGpu, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
        
        END LOOP motherboardLoop;
        /*For each Graphics Card*/
        /*OPEN graphicsCardCur;
        graphicsLoop:LOOP
        
        END LOOP graphicsLoop;*/
        /*For each Power Supply*/
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
        
        END LOOP powerLoop;
        /*For each Case*/
        OPEN caseCur;
        caseLoop:LOOP
            FETCH caseCur INTO primId, part2Id, part2Type, totalBays, hddBays, conversionBays,
                ssdBays, expansionSlots, discBays, length, width, height, maxCoolerHeight;
            IF done = 1 THEN
                LEAVE caseLoop;
            END IF;
        
        END LOOP caseLoop;
      WHEN 'Power Supply' THEN
        /*Get data for Power Supply being checked*/
        SELECT part_id, parttype, mainpower, satapower, multi_gpu, peripheral, poweroutput,
            cpu4_4pin, cpu4pin, cpu8pin, gpu8pin, gpu6pin, gpu6_2pin, length
        INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu, peripheral, powerOutput,
            cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin, gpu6_2Pin, length
        FROM power_supplies
        WHERE part1Id = part_id;
        /*For each Hard Drive*/
        /*OPEN hardDriveCur;
        hddLoop:LOOP
        
        END LOOP hddLoop;*/        
        /*For each Disc Drive*/
        /*OPEN discDriveCur;
        discLoop:LOOP
        
        END LOOP discLoop;*/
        /*For each Motherboard*/
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO part2Id, part2Type, maxMemory, memoryType, memorySlots, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, multiGpu, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*Incompatible if Power Supply cant provide enough power*/
            IF mainPower != moboMainPower THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);                
            END IF;
        END LOOP motherboardLoop;
        /*For each Graphics Card*/
        /*OPEN graphicsCardCur;
        graphicsLoop:LOOP
        
        END LOOP graphicsLoop;*/  
        /*For each CPU*/
        OPEN cpuCur;
        cpuLoop:LOOP
            FETCH cpuCur INTO part2Id, part2Type, cpuSocketType, fsb, watts, cpuPower, maxMemory,
                memChannelType;
            IF done = 1 THEN
                LEAVE cpuLoop;
            END IF;
            /*Incompatible if CPU requires more power then Power Supply can give*/
            IF watts >= 125 && cpu8Pin = 0 && cpu4_4Pin = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP cpuLoop;
      WHEN 'Memory' THEN
        /*For each Motherboard*/
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO part2Id, part2Type, maxMemory, memoryType, memorySlots, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, multiGpu, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
        
        END LOOP motherboardLoop;
      WHEN 'Disc Drive' THEN
        /*For each Motherboard*/
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO part2Id, part2Type, maxMemory, memoryType, memorySlots, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, multiGpu, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
        
        END LOOP motherboardLoop;
        /*For each Power Supply*/
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
        
        END LOOP powerLoop;
      WHEN 'Hard Drive' THEN
        /*For each Motherboard*/
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO part2Id, part2Type, maxMemory, memoryType, memorySlots, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, multiGpu, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
        
        END LOOP motherboardLoop;
        /*For each Power Supply*/
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
        
        END LOOP powerLoop;
      WHEN 'Case' THEN
        /*Get data for Case being checked*/
        SELECT id, part_id, parttype, totalbays, hddbays, conversionbays, ssdbays, 
            expansionslots, discbays, length, width, height, maxcoolerheight
        INTO primId, part2Id, part2Type, totalBays, hddBays, conversionBays,
                ssdBays, expansionSlots, discBays, length, width, height, maxCoolerHeight
        FROM cases
        WHERE part1Id = part_id;
        /*For each Motherboard*/
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO part2Id, part2Type, maxMemory, memoryType, memorySlots, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, multiGpu, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*If not sizes match its incompatible*/
            IF caseSizeMatch(primId, moboSize) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP motherboardLoop;
        /*For each Graphics Card*/
        /*OPEN graphicsCardCur;
        graphicsLoop:LOOP
        
        END LOOP graphicsLoop;*/  
        /*For each CPU Cooler*/
        OPEN cpuCoolerCur;
        coolerLoop:LOOP
            FETCH cpuCoolerCur INTO primId, part2Id, part2Type, maxMemHeight, coolerHeight,
                width, length;
            IF done = 1 THEN
                LEAVE coolerLoop;
            END IF;
            /*Incompatible if cooler is to tall for the case*/
            IF coolerHeight > maxCoolerHeight THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP coolerLoop;
      /*ELSE parttype is monitor*/
        /*For each Graphics Card*/
        /*OPEN graphicsCardCur;
        graphicsLoop:LOOP
        
        END LOOP graphicsLoop;*/  
    END CASE;
    
END$$

DELIMITER ;