DELIMITER $$
DROP FUNCTION IF EXISTS duplicateTest$$
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
END$$
DELIMITER ;