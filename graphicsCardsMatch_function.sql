DELIMITER $$
DROP FUNCTION IF EXISTS graphicsCardMatch$$
CREATE FUNCTION graphicsCardMatch(gpuChipMan VARCHAR(10), graphicsProcessor VARCHAR(10), multiGpuReady INT, 
	gpuMemorysize INT, gpu2ChipMan VARCHAR(10), graphics2Processor VARCHAR(10), multiGpu2Ready INT, gpu2Memorysize INT)
	RETURNS INT DETERMINISTIC
BEGIN
	/*Flag to hold value for wether the sockets match or not*/
	DECLARE gpuMatch INT DEFAULT 1;
	DECLARE firstGpu VARCHAR(4);
	DECLARE secondGpu VARCHAR(4);
	
	IF STRCMP(gpuChipMan, gpu2ChipMan) != 0 THEN
		SET gpuMatch = 0;
	/*if chip manufacturer is AMD*/
	ELSEIF (STRCMP(gpuChipMan, 'ATI') = 0) OR (STRCMP(gpuChipMan, 'AMD') = 0) THEN
		/*Usually looks like 5870 or 5870  X2 if it is a dual GPU card*/
		SET firstGpu = SUBSTR(graphicsProcessor, 1, 4);
		SET secondGpu = SUBSTR(graphics2Processor, 1, 4);
		/*if it is a 6000 series*/
		IF firstGpu > 6000 AND firstGpu < 7000 THEN
			/*if it is in 6900*/
			IF firstGpu > 6900 AND secondGpu < 6900 THEN
				/*if the other card is not in 6900 also*/
					/*they cant crossfire*/
					SET gpuMatch = 0;
			/*else (it is in 6800)*/
			ELSE
				/*if the other card is not in 6800 also*/
				IF firstGpu > 6800 AND (secondGpu > 6900 OR secondGpu < 6800) THEN
					/*they cant crossfire*/
					SET gpuMatch = 0;
				END IF;
			END IF;
		/*else if it is a 5000 series*/
		ELSEIF firstGpu > 5000 AND firstGpu < 6000 THEN
			/*if it is in 5900*/
			IF firstGpu > 5900 AND secondGpu != 5870 AND secondGpu != 5970 THEN
				/*if the other card is not 5870 or 5970 or 5870 X2*/
					/*they cant crossfire*/
					SET gpuMatch = 0;
			/*else if it is in 5800*/
			ELSEIF firstGpu > 5800 AND firstGpu < 5900 THEN
				/*if card is 5870 || 5870 X2 && the other card is not 5870 or 5900 or 5870 X2*/
				IF firstGpu = 5870 AND secondGpu != 5870 AND secondGpu != 5970 THEN
					/*they cant crossfire*/
					SET gpuMatch = 0;
				/*else if the other card is not a 5850*/
				ELSE
					IF firstGpu = 5850 and secondGpu != 5850 THEN
					/*they cant crossfire*/
						SET gpuMatch = 0;
					END IF;
				END IF;
			/*else if it is in 5700*/
			ELSEIF firstGpu > 5700 AND firstGpu < 5800 AND STRCMP(firstGpu, secondGpu) != 0 THEN
				/*if both cards are not the same*/
					/*they cant crossfire*/
					SET gpuMatch = 0;
			/*else if it is in 5600*/
			ELSEIF firstGpu > 5600 AND firstGpu < 5700 AND (secondGpu > 5700 OR secondGpu < 5600) THEN
				/*if other card is not 5600*/
					/*they cant crossfire*/
					SET gpuMatch = 0;
			/*else if it is in 5500*/
			ELSEIF firstGpu > 5500 AND firstGpu < 5600 AND STRCMP(firstGpu, secondGpu) != 0 THEN
				/*if both cards are not the same*/
					/*they cant crossfire*/
					SET gpuMatch = 0;
			/*else (it is in 5400)*/
			ELSE
				/*if the other card is not 5450*/
				IF firstGpu = 5450 AND secondGpu != 5450 THEN
					/*they cant crossfire*/
					SET gpuMatch = 0;
				END IF;
			END IF;
		/*else (it is a 4000 series)*/
		ELSE
			/*if it is in 4800*/
			IF firstGpu > 4800 THEN
				/*if it is 4870 X2 or 4870 or 4890 and the other card is not 4870 X2 or 4870 or 4890*/
				IF (firstGpu = 4870 OR firstGpu = 4890) AND (secondGpu != 4870 AND secondGpu != 4890) THEN
					/*they cant crossfire*/
					SET gpuMatch = 0;
				/*else if it is 4850 X2 or 4850 and the other card is not 4850 X2 or 4850*/
				ELSEIF firstGpu = 4850 AND secondGpu != 4850 THEN
					/*they cant crossfire*/
					SET gpuMatch = 0;
				/*else if it is 4830 and the other card is not 4830*/
				ELSEIF firstGpu = 4830 AND secondGpu != 4830 THEN
					/*they cant crossfire*/
					SET gpuMatch = 0;
				END IF;
			/*else if it is in 4700*/
			ELSEIF firstGpu > 4700 AND firstGpu < 4800 AND (secondGpu > 4800 OR secondGpu < 4700) THEN
				/*if other card is not in 4700*/
					/*they cant crossfire*/
					SET gpuMatch = 0;
			/*else if it is in 4600*/
			ELSEIF firstGpu > 4600 AND firstGpu < 4700 AND STRCMP(firstGpu, secondGpu) != 0 THEN
				/*if both cards are not they same*/
					/*they cant crossfire*/
					SET gpuMatch = 0;
			/*else if it is in 4500*/
			ELSEIF firstGpu > 4500 AND firstGpu < 4600 AND (secondGpu > 4600 OR secondGpu < 4500) THEN
				/*if the other card is not 4500*/
					/*they cant crossfire*/
					SET gpuMatch = 0;
			/*else (it is in 4300)*/
			ELSE
				/*if the other card is not 4300*/
				IF firstGpu > 4400 AND firstGpu < 4500 AND (secondGpu > 4500 OR secondGpu < 4400) THEN
					/*they cant crossfire*/
					SET gpuMatch = 0;
				END IF;
			END IF;
		END IF;
	/*else (its an Nvidia chip)*/
	ELSE
		/*if the memory is not the same size*/
		IF gpuMemorysize > gpu2Memorysize OR gpuMemorysize < gpu2Memorysize THEN
			/*they cant sli*/
			SET gpuMatch = 0;
		/*else*/
		ELSE
			/*Usually looks like GTX 580 or GTX 460*/
			SET firstGpu = SUBSTR(graphicsProcessor, -3);
			/*if it is a 500 series*/
			IF firstGpu > 500 AND firstGpu < 600 AND 
				STRCMP(graphicsProcessor, graphics2Processor) != 0 THEN
				/*if both cards are not the same*/
					/*they cant sli*/
					SET gpuMatch = 0;
			/*else if it is a 400 series*/
			ELSEIF firstGpu > 400 AND firstGpu < 600 AND 
				STRCMP(graphicsProcessor, graphics2Processor) != 0 THEN
				/*if both cards are not the same*/
					/*they cant sli*/
					SET gpuMatch = 0;
			/*else (it is a 200 series)*/
			ELSE
				/*if both cards are not the same*/
				IF STRCMP(graphicsProcessor, graphics2Processor) != 0 THEN
					/*they cant sli*/
					SET gpuMatch = 0;
				END IF;
			END IF;
		END IF;
	END IF;
	
	RETURN gpuMatch;
END$$
DELIMITER ;