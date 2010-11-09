DELIMITER $$

DROP PROCEDURE IF EXISTS compatibilityAlgorithm$$

CREATE PROCEDURE compatibilityAlgorithm(part1Id INT, parttype VARCHAR(20))
BEGIN
    /*Variables for each part*/
    DECLARE primId INT;
    DECLARE mainId INT;
    DECLARE part2Id INT;
    DECLARE part2Type VARCHAR(20);
    DECLARE maxMemory INT;
    DECLARE memoryType VARCHAR(5);
    DECLARE memorySlots INT;
    DECLARE memChannel INT;
    DECLARE pciex16 INT;
    DECLARE pcie2 INT;
    DECLARE moboSize VARCHAR(15);
    DECLARE caseSize VARCHAR(15);
    DECLARE moboCpuPower INT;
    DECLARE multiGpu INT;
    DECLARE cpuPower INT;
    DECLARE fsb INT;
    DECLARE psuMainPower INT;
    DECLARE moboMainPower INT;
    DECLARE Sli INT DEFAULT 0;
    DECLARE Crossfire INT DEFAULT 0;
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
    DECLARE transferType INT;
    DECLARE done INT DEFAULT 0;
    DECLARE vgaPorts INT;
    DECLARE hdmiPorts INT;
    DECLARE svideoPorts INT;
    DECLARE dviPorts INT;
    DECLARE displayports INT;
    DECLARE memSpeed INT;
    DECLARE memMultichannelType INT;
    DECLARE memType VARCHAR(5);
    DECLARE memDimms INT;
    DECLARE totalcapacity INT;
    DECLARE chipMan VARCHAR(10);
    DECLARE Gpu VARCHAR(10);
    DECLARE gpuWidth VARCHAR(10);
    DECLARE gup1Width VARCHAR(10);
    DECLARE gpuInterface VARCHAR(15);
    DECLARE gpuHdmi INT;
    DECLARE gpuDvi INT;
    DECLARE gpuDisplayport INT;
    DECLARE gpuVga INT;
    DECLARE gpuSvideo INT;
    DECLARE gpuMinpower INT;
    DECLARE gpuMultigpupower INT;
    DECLARE gpuPower6pin INT;
    DECLARE gpuPower8pin INT;
    
    /*Cursors for each part*/
    DECLARE motherboardCur CURSOR FOR
        SELECT id, part_id, parttype, maxmemory, memorytype, memoryslots, memchannel,
            pci_ex16, size, cpupowerpin, fsb, mainpower, crossfire, sli, 
            sockettype, sata3, sata6, ide
        FROM motherboards;
        
    DECLARE cpuCur CURSOR FOR
        SELECT part_id, parttype, sockettype, fsb, watts, cpupower,maxmemory, memchanneltype
        FROM cpus;
        
    DECLARE cpuCoolerCur CURSOR FOR
        SELECT id, part_id, parttype, maxmemheight, height, width, length
        FROM cpu_coolers;
        
    DECLARE graphicsCardCur CURSOR FOR
        SELECT part_id, parttype, width, length, interface, hdmi, dvi, displayport,
            vga, svideo, minpower, multigpupower, power6pin, power8pin
        FROM graphics_cards;
        
    DECLARE powerSupplyCur CURSOR FOR
        SELECT part_id, parttype, chipmanufacturer, gpu,mainpower, satapower, multi_gpu,
            peripheral, poweroutput, cpu4_4pin, cpu4pin, cpu8pin, gpu8pin, gpu6pin, 
            gpu6_2pin, length
        FROM power_supplies;
        
    DECLARE memoryCur CURSOR FOR
        SELECT part_id, parttype, speed, multichanneltype, memorytype, dimms,
            totalcapacity
        FROM memories;
        
    DECLARE discDriveCur CURSOR FOR
        SELECT part_id, parttype, interface
        FROM disc_drives;
        
    DECLARE hardDriveCur cursor FOR
        SELECT part_id, parttype, interface
        FROM hard_drives;
        
    DECLARE caseCur CURSOR FOR
        SELECT id, part_id, parttype, totalbays, hddbays, conversionbays, ssdbays, 
            expansionslots, discbays, length, width, height, maxcoolerheight
        FROM cases;
        
    DECLARE monitorCur CURSOR FOR
        SELECT part_id, parttype, vga, hdmi, svideo, dvi, displayport
        FROM displays;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    /*Start of Part Incompatibility algorithm*/
    CASE parttype
      /*
      WHEN 'Motherboard' THEN
      
        /*Get the data for the Motherboard being checked
        SELECT id, maxmemory, memorytype, memchannel, pci_ex16, pci_e2, memoryslots, 
            size, cpupowerpin, fsb, mainpower, crossfire, sli, sockettype, sata3, 
            sata6, ide
        INTO mainId, maxMemory, memoryType, memChannel, pciex16, pcie2, memorySlots, moboSize, 
            moboCpuPower, fsb, moboMainPower, Crossfire, Sli, moboSocketType, sata3, 
            sata6, ide
        FROM motherboards
        WHERE part1Id = motherboards.part_id;
        
        /*For each Memory
        OPEN memoryCur;
        memLoop:LOOP
            FETCH memoryCur INTO primId, part2Id, part2Type, memSpeed, memMultichannelType,
                memType, memDimms, totalcapacity;
            IF done = 1 THEN
                LEAVE memLoop;
            END IF;
            /*Its incompatible if memMultichannelType does not match
            IF memChannel != memMultiChannelType THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*or memType does not match
            ELSEIF memoryType != memType THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*or memDimms is greater than number of dimm slots
            ELSEIF memorySlots < memDimms THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*or the speed is one of the accepted speeds
            ELSEIF memSpeedMatch(mainId, memSpeed) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*or total capacity is greater than mobo total mem capacity
            ELSEIF maxMemory < totalcapacity THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP memLoop;
        
        /*For each CPU
        OPEN cpuCur;
        cpuLoop:LOOP
            FETCH cpuCur INTO part2Id, part2Type, cpuSocketType, fsb, watts, cpuPower, maxMemory,
                memChannelType;
            IF done = 1 THEN
                LEAVE cpuLoop;
            END IF;
            /*Its incompatible if the sockets dont match
            IF cpuSocketType != moboSocketType THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*Also incompatible if the mobo cant provide enough power through cpu connector
            ELSEIF cpuPower > moboCpuPower THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP cpuLoop;
        
        /*For each CPU Cooler
        OPEN cpuCoolerCur;
        coolerLoop:LOOP
            FETCH cpuCoolerCur INTO primId, part2Id, part2Type, maxMemHeight, coolerHeight,
                width, length;
            IF done = 1 THEN
                LEAVE coolerLoop;
            END IF;
            /*Its incompatible if no sockets match
            IF coolerSocketMatch(primId, moboSocketType) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP coolerLoop;
        
        /*For each Graphics Card
        OPEN graphicsCardCur;
        graphicsLoop:LOOP
            FETCH graphicsCardCur INTO part2Id, part2Type, chipMan, Gpu, gpuWidth, 
                gpuInterface, gpuHdmi, gpuDvi, gpuDisplayport, gpuVga, gpuSvideo, 
                gpuMinpower, gpuMultigpupower, gpuPower6pin, gpuPower8pin;
            IF done = 1 THEN
                LEAVE graphicsLoop;
            END IF;
            /*Incompatible if not pci_ex16 slots on the motherboard
            IF pci_ex16 = 0 THEN                
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP graphicsLoop;
        
        /*For each Hard Drive
        OPEN hardDriveCur;
        hddLoop:LOOP
            FETCH hardDriveCur INTO part2Id, part2Type, transferType;
            IF done = 1 THEN
                LEAVE hddLoop;
            END IF;
            /*Incompatible if transfer type is sata 3 and no sata3 ports on motherboard
            IF transferType = 'SATA 3' && sata3 = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*or transfer type is sata 6 and no sata6 ports on motherboard
            ELSEIF transferType = 'SATA 6' && sata6 = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*or transfer type is ide and no ide ports on motherboard
            ELSEIF transferType = 'IDE/PATA' && ide = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP hddLoop;
        
        /*For each Disc Drive
        OPEN discDriveCur;
        discLoop:LOOP
            FETCH discDriveCur INTO part2Id, part2Type, transferType;
            IF done = 1 THEN
                LEAVE discLoop;
            END IF;
            /*Incompatible if transfer type is sata and no sata ports on motherboard
            IF transferType = 'SATA' && sata6 = 0 && sata3 = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*or transfer type is ide and no ide ports on motherboard
            ELSEIF transferType = 'IDE/PATA' && ide = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP discLoop;

        /*For each Power Supply
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
            /*Its incompatible if the psu cant provide enough power to the mobo
            IF psuMainPower < moboMainPower THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP powerLoop;

        /*For each Case
        OPEN caseCur;
        caseLoop:LOOP
            FETCH caseCur INTO primId, part2Id, part2Type, totalBays, hddBays, conversionBays,
                ssdBays, expansionSlots, discBays, length, width, height, maxCoolerHeight;
            IF done = 1 THEN
                LEAVE caseLoop;
            END IF;
            /*If not sizes match its incompatible
            IF caseSizeMatch(primId, moboSize) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP caseLoop;
      */
      WHEN 'CPU' THEN

        /*Get the data for the cpu being checked*/
        SELECT sockettype, fsb, watts, cpupower,maxmemory, memchanneltype
        INTO cpuSocketType, fsb, watts, cpuPower, maxMemory,
            memChannelType
        FROM cpus
        WHERE part1Id = cpus.part_id;
        /*
        /*For each Motherboard
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO mainId, part2Id, part2Type, maxMemory, memoryType, memorySlots, memChannel, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, Crossfire, Sli, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*Incompatible if the sockets dont match
            IF cpuSocketType != moboSocketType THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP motherboardLoop;
        
        /*For each Power Supply
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
            /*Incompatible if CPU requires more power then Power Supply can give
            IF watts >= 125 && cpu8Pin = 0 && cpu4_4Pin = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP powerLoop;
        */
        /*For each CPU Cooler*/
		SELECT part2type;
        OPEN cpuCoolerCur;
        coolerLoop:LOOP
            FETCH cpuCoolerCur INTO primId, part2Id, part2Type, maxMemHeight, coolerHeight,
                width, length;
            IF done = 1 THEN
                LEAVE coolerLoop;
            END IF;
			SELECT part2type;
            /*Its incompatible if no sockets match*/
            IF coolerSocketMatch(primId, cpuSocketType) = 0 THEN
                SELECT part2type;
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type, created_at, updated_at)
                VALUES (part1Id, parttype, part2Id, part2Type, cast(now() as DATETIME), cast(now() as DATETIME));
            END IF;
        END LOOP coolerLoop;
        
      ELSE  
      /*WHEN 'CPU Cooler' THEN*/
      
        /*Get the data for the CPU Cooler being checked*/
        SELECT id, maxmemheight, height, width, length
        INTO primId, maxMemHeight, coolerHeight, width, length
        FROM cpu_coolers
        WHERE part1Id = cpu_coolers.part_id;
        /*
        /*For each Motherboard
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO mainId, part2Id, part2Type, maxMemory, memoryType, memorySlots, memChannel, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, Crossfire, Sli, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*Its incompatible if no sockets match
            IF coolerSocketMatch(primId, moboSocketType) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP motherboardLoop;
        
        /*For each Case
        OPEN caseCur;
        caseLoop:LOOP
            FETCH caseCur INTO primId, part2Id, part2Type, totalBays, hddBays, conversionBays,
                ssdBays, expansionSlots, discBays, length, width, height, maxCoolerHeight;
            IF done = 1 THEN
                LEAVE caseLoop;
            END IF;
            /*Incompatible if cooler is to tall for the case
            IF coolerHeight > maxCoolerHeight THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP caseLoop;
        */
        /*For each CPU*/
        OPEN cpuCur;
        cpuLoop:LOOP
            FETCH cpuCur INTO part2Id, part2Type, cpuSocketType, fsb, watts, cpuPower, maxMemory,
                memChannelType;
            IF done = 1 THEN
                LEAVE cpuLoop;
            END IF;
            /*Incompatible if sockets do not match*/
            IF coolerSocketMatch(primId, cpuSocketType) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP cpuLoop;
      /*  
      WHEN 'Graphics Card' THEN
        
        SELECT chipmanufacturer, gpu, width, length, interface, hdmi, dvi, displayport,
            vga, svideo, minpower, multigpupower, power6pin, power8pin
        INTO chipMan, Gpu, gpuWidth, gpuInterface, gpuHdmi, gpuDvi, gpuDisplayport, 
            gpuVga, gpuSvideo, gpuMinpower, gpuMultigpupower, gpuPower6pin, gpuPower8pin
        FROM graphics_cards
        WHERE part1Id = gaphics_cards.part_id;
        
        /*For each Motherboard
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO mainId, part2Id, part2Type, maxMemory, memoryType, memorySlots, memChannel, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, Crossfire, Sli, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*Incompatible if no pciex16 slots on motherboard
            IF pciex16 = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP motherboardLoop;
        
        /*For each Graphics Card
        OPEN graphicsCardCur;
        graphicsLoop:LOOP
            FETCH graphicsCardCur INTO part2Id, part2Type, chipMan, Gpu, gpuWidth, 
                gpuInterface, gpuHdmi, gpuDvi, gpuDisplayport, gpuVga, gpuSvideo, 
                gpuMinpower, gpuMultigpupower, gpuPower6pin, gpuPower8pin;
            IF done = 1 THEN
                LEAVE graphicsLoop;
            END IF;
            /*need to test graphics cards with one another
        END LOOP graphicsLoop;
        
        /*For each Power Supply
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
            /*Incompatible if power supply does not have enough power connectors for
              the graphics card
            /*If the gpu need both 6pin and 8pin power make sure if has enough of both
            IF gpuPower8pin > 0 && gpuPower6pin > 0 THEN
                /*If there is enough gpu8pin power then use the 6+2 pin for 6pin power
                IF gpu8pin >= gpuPower8pin THEN
                    IF (gpu6pin + gpu6_2pin) < gpuPower6pin THEN
                        INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                        VALUES (part1Id, parttype, part2Id, part2Type);
                    END IF;
                /*If not enough gpu8pin power then sue the 6+2pin power to balance out
                ELSEIF (gpu8pin + gpu6_2pin) >= gpuPower8pin THEN
                    /*Need to subtract because you need to see how many 6+2 power connectors are
                    left after using them up for any 8 power slots if needed
                    IF (gpu6pin + ((gpu8pin - gpuPower8pin) + gpu6_2pin)) <= gpuPower6pin THEN
                        INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                        VALUES (part1Id, parttype, part2Id, part2Type);
                    END IF;
                /*not enough 8pin power for the graphics card
                ELSE
                    INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                    VALUES (part1Id, parttype, part2Id, part2Type);
                END IF;
            /*If it needs just 8pin power check if there is enough
            ELSEIF gpuPower8pin > 0 THEN
                IF (gpu8pin + gpu6_2pin) < gpuPower8pin THEN
                    INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                    VALUES (part1Id, parttype, part2Id, part2Type);
                END IF;
            /*If it needs just 6pin power check if there is enough
            ELSE
                IF (gpu6pin + gpu6_2pin) < gpuPower6pin THEN
                    INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                    VALUES (part1Id, parttype, part2Id, part2Type);
                END IF;
            END IF;
        END LOOP powerLoop;
        
        /*For each Case
        OPEN caseCur;
        caseLoop:LOOP
            FETCH caseCur INTO primId, part2Id, part2Type, totalBays, hddBays, conversionBays,
                ssdBays, expansionSlots, discBays, length, width, height, maxCoolerHeight;
            IF done = 1 THEN
                LEAVE caseLoop;
            END IF;
            /*Create a new attribute for case that is maxGraphicsCardLength!
        END LOOP caseLoop;
        
        /*For each display
        OPEN monitorCur;
        monitorLoop:LOOP
            FETCH monitorCur INTO part2Id, part2Type, vgaPorts, hdmiPorts, svideoPorts,
                dviPorts, displayports;
            IF done = 1 THEN
                LEAVE monitorLoop;
            END IF;
            /*Incompatible if not  port on the monitor matches a port on the graphics card
            IF !((vgaPorts > 0 && gpuVga > 0) || (hdmiPorts > 0 && gpuHdmi > 0) ||
               (svideoPorts > 0 && gpuSvideo > 0) || (dviPorts > 0 && gpuDvi > 0) ||
               (displayports > 0 && gpuDisplayport > 0)) THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP monitorLoop;
        
      WHEN 'Power Supply' THEN
      
        /*Get data for Power Supply being checked
        SELECT mainpower, satapower, multi_gpu, peripheral, poweroutput,
            cpu4_4pin, cpu4pin, cpu8pin, gpu8pin, gpu6pin, gpu6_2pin, length
        INTO psuMainPower, sataPower, multiGpu, peripheral, powerOutput,
            cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin, gpu6_2Pin, length
        FROM power_supplies
        WHERE part1Id = power_supplies.part_id;
        
        /*For each Hard Drive
        OPEN hardDriveCur;
        hddLoop:LOOP
            FETCH hardDriveCur INTO part2Id, parttype, transferType;
            IF done = 1 THEN
                LEAVE hddLoop;
            END IF;
            /*Incompatible if the power supply does not have sata power for sata hdd
            IF peripheral = 0 && transferType = 'IDE/PATA' THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /* or if the power supply does not have molex power for ide hdd
            ELSEIF sataPower = 0 && 
                (transferType = 'SATA 3' || transferType = 'SATA 6') THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP hddLoop;
        
        /*For each Disc Drive
        OPEN discDriveCur;
        discLoop:LOOP
            FETCH discDriveCur INTO part2Id, parttype, transferType;
            IF done = 1 THEN
                LEAVE discLoop;
            END IF;
            /*Incompatible if the power supply does not have sata power for sata dsic drive
            IF sataPower = 0 && transferType = 'SATA' THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
                /* or if the power supply does not have molex power for ide disc drive
            ELSEIF peripheral = 0 && transferType = 'IDE/PATA' THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP discLoop;
        
        /*For each Motherboard
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO mainId, part2Id, part2Type, maxMemory, memoryType, memorySlots, memChannel, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, Crossfire, Sli, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*Incompatible if Power Supply cant provide enough power
            IF mainPower != moboMainPower THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);                
            END IF;
        END LOOP motherboardLoop;
        
        /*For each Graphics Card
        OPEN graphicsCardCur;
        graphicsLoop:LOOP        
            FETCH graphicsCardCur INTO part2Id, part2Type, chipMan, Gpu, gpuWidth, 
                gpuInterface, gpuHdmi, gpuDvi, gpuDisplayport, gpuVga, gpuSvideo, 
                gpuMinpower, gpuMultigpupower, gpuPower6pin, gpuPower8pin;
            IF done = 1 THEN
                LEAVE graphicsLoop;
            END IF;
            /*Incompatible if power supply does not have enough power connectors for
              the graphics card
            /*If the gpu need both 6pin and 8pin power make sure if has enough of both
            IF gpuPower8pin > 0 && gpuPower6pin > 0 THEN
                /*If there is enough gpu8pin power then use the 6+2 pin for 6pin power
                IF gpu8pin >= gpuPower8pin THEN
                    IF (gpu6pin + gpu6_2pin) < gpuPower6pin THEN
                        INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                        VALUES (part1Id, parttype, part2Id, part2Type);
                    END IF;
                /*If not enough gpu8pin power then sue the 6+2pin power to balance out
                ELSEIF (gpu8pin + gpu6_2pin) >= gpuPower8pin THEN
                    /*Need to subtract because you need to see how many 6+2 power connectors are
                    left after using them up for any 8 power slots if needed
                    IF (gpu6pin + ((gpu8pin - gpuPower8pin) + gpu6_2pin)) <= gpuPower6pin THEN
                        INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                        VALUES (part1Id, parttype, part2Id, part2Type);
                    END IF;
                /*not enough 8pin power for the graphics card
                ELSE
                    INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                    VALUES (part1Id, parttype, part2Id, part2Type);
                END IF;
            /*If it needs just 8pin power check if there is enough
            ELSEIF gpuPower8pin > 0 THEN
                IF (gpu8pin + gpu6_2pin) < gpuPower8pin THEN
                    INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                    VALUES (part1Id, parttype, part2Id, part2Type);
                END IF;
            /*If it needs just 6pin power check if there is enough
            ELSE
                IF (gpu6pin + gpu6_2pin) < gpuPower6pin THEN
                    INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                    VALUES (part1Id, parttype, part2Id, part2Type);
                END IF;
            END IF;
        END LOOP graphicsLoop;
        
        /*For each CPU
        OPEN cpuCur;
        cpuLoop:LOOP
            FETCH cpuCur INTO part2Id, part2Type, cpuSocketType, fsb, watts, cpuPower, maxMemory,
                memChannelType;
            IF done = 1 THEN
                LEAVE cpuLoop;
            END IF;
            /*Incompatible if CPU requires more power then Power Supply can give
            IF watts >= 125 && cpu8Pin = 0 && cpu4_4Pin = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP cpuLoop;
        
      WHEN 'Memory' THEN
        
        /*Get data for memory being checked
        SELECT speed, multichanneltype, memorytype, dimms, totalcapacity
        INTO memSpeed, memMultichannelType, memType, memDimms, totalcapacity
        FROM memories
        WHERE part1Id = memories.part_id;
        
        /*For each Motherboard
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO mainId, part2Id, part2Type, maxMemory, memoryType, memorySlots, memChannel, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, Crossfire, Sli, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
        
        END LOOP motherboardLoop;
        
      WHEN 'Disc Drive' THEN
        
        /*Get data for disc drive being checked
        SELECT interface
        INTO transferType
        FROM disc_drives
        WHERE part1Id = disc_drives.part_id;
        
        /*For each Motherboard
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO mainId, part2Id, part2Type, maxMemory, memoryType, memorySlots, memChannel, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, Crossfire, Sli, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*Incompatible if transfer type is sata and no sata ports on motherboard
            IF transferType = 'SATA' && sata6 = 0 && sata3 = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            /*or transfer type is ide and no ide ports on motherboard
            ELSEIF transferType = 'IDE/PATA' && ide = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP motherboardLoop;
        
        /*For each Power Supply
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
            /*Incompatible if the power supply does not have sata power for sata dsic drive
            IF sataPower = 0 && transferType = 'SATA' THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
                /* or if the power supply does not have molex power for ide disc drive
            ELSEIF peripheral = 0 && transferType = 'IDE/PATA' THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP powerLoop;
        
      WHEN 'Hard Drive' THEN
        
        /*Get data for hard drive being checked
        SELECT interface
        INTO transferType
        FROM hard_drives
        WHERE part1Id = hard_drives.part_id;
        
        /*For each Motherboard
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO mainId, part2Id, part2Type, maxMemory, memoryType, memorySlots, memChannel, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, Crossfire, Sli, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            IF (transferType = 'SATA 3' || transferType = 'SATA 6')
                && sata3 = 0 && sata6 = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            ELSEIF transferType = 'IDE/PATA' && ide = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP motherboardLoop;
        
        /*For each Power Supply
        OPEN powerSupplyCur;
        powerLoop:LOOP
            FETCH powerSupplyCur INTO part2Id, part2Type, psuMainPower, sataPower, multiGpu,
                peripheral, powerOutput, cpu4_4Pin, cpu4Pin, cpu8Pin, gpu8Pin, gpu6Pin,
                gpu6_2Pin, length;
            IF done = 1 THEN
                LEAVE powerLoop;
            END IF;
            IF peripheral = 0 && transferType = 'IDE/PATA' THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            ELSEIF sataPower = 0 && 
                (transferType = 'SATA 3' || transferType = 'SATA 6') THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP powerLoop;
        
      WHEN 'Case' THEN
      
        /*Get data for Case being checked
        SELECT id, totalbays, hddbays, conversionbays, ssdbays, 
            expansionslots, discbays, length, width, height, maxcoolerheight
        INTO primId, totalBays, hddBays, conversionBays,
                ssdBays, expansionSlots, discBays, length, width, height, maxCoolerHeight
        FROM cases
        WHERE part1Id = cases.part_id;
        
        /*For each Motherboard
        OPEN motherboardCur;
        motherboardLoop:LOOP
            FETCH motherboardCur INTO mainId, part2Id, part2Type, maxMemory, memoryType, memorySlots, memChannel, 
                pciex16, moboSize, moboCpuPower, fsb, moboMainPower, Crossfire, Sli, moboSocketType,
                sata3, sata6, ide;
            IF done = 1 THEN
                LEAVE motherboardLoop;
            END IF;
            /*If not sizes match its incompatible
            IF caseSizeMatch(primId, moboSize) = 0 THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP motherboardLoop;
        
        /*For each Graphics Card
        OPEN graphicsCardCur;
        graphicsLoop:LOOP
            FETCH graphicsCardCur INTO gpuWidth, gpuInterface, gpuHdmi, gpuDvi, gpuDisplayport,
                gpuVga, gpuSvideo, gpuMinpower, gpuMultigpupower, gpuPower6pin, gpuPower8pin;
            IF done = 1 THEN
                LEAVE graphicsLoop;
            END IF;        
        END LOOP graphicsLoop;
        
        /*For each CPU Cooler
        OPEN cpuCoolerCur;
        coolerLoop:LOOP
            FETCH cpuCoolerCur INTO primId, part2Id, part2Type, maxMemHeight, coolerHeight,
                width, length;
            IF done = 1 THEN
                LEAVE coolerLoop;
            END IF;
            /*Incompatible if cooler is to tall for the case
            IF coolerHeight > maxCoolerHeight THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP coolerLoop;
        
      ELSE /*parttype is monitor
        
        /*Get data for display being checked
        SELECT vga, hdmi, svideo, dvi, displayport
        INTO vgaPorts, hdmiPorts, svideoPorts, dviPorts, displayports
        FROM displays
        WHERE part1Id = displays.part_id;
        
        /*For each Graphics Card
        OPEN graphicsCardCur;
        graphicsLoop:LOOP
            FETCH graphicsCardCur INTO part2Id, part2Type, chipMan, Gpu, gpuWidth, 
                gpuInterface, gpuHdmi, gpuDvi, gpuDisplayport, gpuVga, gpuSvideo, 
                gpuMinpower, gpuMultigpupower, gpuPower6pin, gpuPower8pin;
            IF done = 1 THEN
                LEAVE graphicsLoop;
            END IF;
            /*Incompatible if not a port on the monitor matches a port on the graphics card
            IF !((vgaPorts > 0 && gpuVga > 0) || (hdmiPorts > 0 && gpuHdmi > 0) ||
               (svideoPorts > 0 && gpuSvideo > 0) || (dviPorts > 0 && gpuDvi > 0) ||
               (displayports > 0 && gpuDisplayport > 0)) THEN
                INSERT INTO incompatibles(part1_id, part1type, part2_id, part2Type)
                VALUES (part1Id, parttype, part2Id, part2Type);
            END IF;
        END LOOP graphicsLoop;
        */
    END CASE;
END$$

DELIMITER ;