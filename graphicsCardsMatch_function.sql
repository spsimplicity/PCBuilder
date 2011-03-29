DELIMITER $$
DROP FUNCTION IF EXISTS graphicsCardMatch$$
CREATE FUNCTION graphicsCardMatch(gpuChipMan VARCHAR(10), graphicsProcessor VARCHAR(10), multiGpuReady INT, 
    gpu2ChipMan VARCHAR(10), graphics2Processor VARCHAR(10), multiGpu2Ready INT)
    RETURNS INT DETERMINISTIC
BEGIN
    /*Flag to hold value for wether the sockets match or not*/
    DECLARE gpuMatch INT DEFAULT 0;
	DECLARE loopDone INT DEFAULT 0;
	/*if chip manufacturer is AMD*/
		/*if it is a 6000 series*/
			/*if it is in 6900*/
				/*if the other card is not in 6900 also*/
					/*they cant crossfire*/
				/*end if*/
			/*else (it is in 6800)*/
				/*if the other card is not in 6800 also*/
					/*they cant crossfire*/
				/*end if*/
			/*end if*/
		/*else if it is a 5000 series*/
			/*if it is in 5900*/
				/*if the other card is not 5870 or 5900 or 5870 X2*/
					/*they cant crossfire*/
				/*end if*/
			/*else if it is in 5800*/
				/*if card is 5870 || 5870 X2 && the other card is not 5870 or 5900 or 5870 X2*/
				    /*they cant crossfire*/
				/*else if the other card is not a 5850*/
					/*they cant crossfire*/
				/*end if*/
			/*else if it is in 5700*/
				/*if both cards are not they same*/
					/*they cant crossfire*/
				/*end if*/
			/*else if it is in 5600*/
				/*if other card is not 5600*/
					/*they cant crossfire*/
				/*end if*/
			/*else if it is in 5500*/
				/*if both cards are not they same*/
					/*they cant crossfire*/
				/*end if*/
			/*else (it is in 5400)*/
			    /*if the other card is not 5450*/
				    /*they cant crossfire*/
				/*end if*/
			/*end if*/
		/*else (it is a 4000 series)*/
			/*if it is in 4800*/
			    /*if it is 4870 X2 or 4870 or 4890 and the other card is not 4870 X2 or 4870 or 4890*/
				    /*they cant crossfire*/
				/*else if it is 4850 X2 or 4850 and the other card is not 4850 X2 or 4850*/
				    /*they cant crossfire*/
				/*else if it is 4830 and the other card is not 4830*/
				    /*they cant crossfire*/
				/*end if*/
			/*else if it is in 4700*/
			    /*if other card is not in 4700*/
				    /*they cant crossfire*/
				/*end if*/
			/*else if it is in 4600*/
				/*if both cards are not they same*/
					/*they cant crossfire*/
				/*end if*/
			/*else if it is in 4500*/
			    /*if the other card is not 4500*/
				    /*they cant crossfire*/
				/*end if*/
			/*else (it is in 4300)*/
			    /*if the other card is not 4300*/
				    /*they cant crossfire*/
				/*end if*/
			/*end if*/
		/*end if*/
	/*else (its an Nvidia chip)*/
	    /*if the memory is not the same size*/
		    /*they cant sli*/
		/*else*/
			/*if it is a 500 series*/
			    /*if both cards are not the same*/
				    /*they cant sli*/
				/*end if*/
			/*else if it is a 400 series*/
			    /*if both cards are not the same*/
				    /*they cant sli*/
				/*end if*/
			/*else (it is a 200 series)*/
			    /*if both cards are not the same*/
				    /*they cant sli*/
				/*end if*/
			/*end if*/
		/*end if*/
	/*end if*/
END$$
DELIMITER ;