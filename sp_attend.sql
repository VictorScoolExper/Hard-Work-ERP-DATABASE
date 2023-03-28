-- add attend
CREATE PROCEDURE sp_add_shifts(
  IN table_name VARCHAR(255),
  IN shifts_array JSON,
  OUT success BOOLEAN
)
BEGIN
  DECLARE i INT DEFAULT 0;
  DECLARE shift_count INT;
  DECLARE employee_id BIGINT;
  DECLARE shift_date DATE;
  DECLARE start_time TIME;
  DECLARE end_time TIME;
  
  SET success = TRUE;
  
  -- Validate the JSON data
  IF NOT JSON_VALID(shifts_array) THEN
    SET success = FALSE;
    LEAVE sp_add_shifts;
  END IF;
  
  IF NOT JSON_CONTAINS_PATH(shifts_array, 'all', '$[*].employee_id', '$[*].shift_date', '$[*].start_time', '$[*].end_time') THEN
    SET success = FALSE;
    LEAVE sp_add_shifts;
  END IF;
  
  -- Use a transaction
  START TRANSACTION;
  
  SELECT JSON_LENGTH(shifts_array) INTO shift_count;
  
  WHILE i < shift_count DO
    -- Get the values from the JSON data
    SET employee_id = JSON_EXTRACT(shifts_array, CONCAT('$[', i, '].employee_id'));
    SET shift_date = JSON_EXTRACT(shifts_array, CONCAT('$[', i, '].shift_date'));
    SET start_time = JSON_EXTRACT(shifts_array, CONCAT('$[', i, '].start_time'));
    SET end_time = JSON_EXTRACT(shifts_array, CONCAT('$[', i, '].end_time'));
    
    -- Use prepared statements to insert the data into the table
    SET @stmt = CONCAT('INSERT INTO ', table_name, ' (employee_id, shift_date, start_time, end_time) VALUES (?, ?, ?, ?)');
    PREPARE stmt FROM @stmt;
    EXECUTE stmt USING employee_id, shift_date, start_time, end_time;
    DEALLOCATE PREPARE stmt;
    
    SET i = i + 1;
  END WHILE;
  
  -- Handle errors
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    SET success = FALSE;
    ROLLBACK;
  END;
  
  -- Commit the transaction
  COMMIT;
END;


