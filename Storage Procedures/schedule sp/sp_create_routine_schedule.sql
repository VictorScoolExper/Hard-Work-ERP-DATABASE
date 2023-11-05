DROP PROCEDURE IF EXISTS sp_create_routine_service_schedule;

CREATE PROCEDURE SP_CREATE_ROUTINE_SERVICE_SCHEDULE
(IN P_CLIENT_ID BIGINT, IN P_ADDRESS_ID BIGINT, IN 
P_START_TIME TIME, IN P_END_TIME TIME, IN P_TO_DO_DATE 
DATE, IN P_TYPE ENUM('SINGLE', 'ROUTINE'), IN P_STATUS 
ENUM('PENDING', 'IN-PROGRESS', 'DONE', 'CANCELED')
, IN P_SERVICES JSON, IN P_MATERIALS JSON, IN P_EMPLOYEES 
JSON, IN P_DAYS_UNTIL_REPEAT INT, IN P_MONTHS_SCHEDULED 
INT) BEGIN DECLARE 
	DECLARE currentIndex INT DEFAULT 0;
	DECLARE totalElements INT;
	DECLARE currentElement JSON;
	DECLARE last_id BIGINT DEFAULT 0;
	DECLARE p_service_id BIGINT;
	DECLARE p_quantity INT;
	DECLARE p_material_id BIGINT;
	DECLARE p_qty INT;
	DECLARE p_sub_total DECIMAL(10,2);
	DECLARE p_employee_id INT;
	DECLARE EXIT
	HANDLER
	    FOR SQLEXCEPTION,
	    SQLWARNING,
	    NOT FOUND BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'An error occurred during service schedule creation.';
	END;
	START TRANSACTION;
	-- Insert into service schedule
	INSERT INTO
	    service_schedule (
	        client_id,
	        address_id,
	        start_time,
	        end_time,
	        to_do_date,
	        type,
	        status
	    )
	VALUES (
	        p_client_id,
	        p_address_id,
	        p_start_time,
	        p_end_time,
	        p_to_do_date,
	        p_type,
	        p_status
	    );
	-- Get the last inserted id
	SET last_id = LAST_INSERT_ID();
	-- Insert services
	SET totalElements = JSON_LENGTH(p_services);
	-- services can be left as a blank array if they want to add services later
	IF totalElements > 0 THEN
	WHILE
	    currentIndex < totalElements
	DO
	SET
	    currentElement = JSON_EXTRACT(
	        p_services,
	        CONCAT('$[', currentIndex, ']')
	    );
	-- Process current JSON
	SET
	    p_service_id = JSON_EXTRACT(
	        currentElement,
	        '$.service_id'
	    );
	SET
	    p_quantity = JSON_EXTRACT(currentElement, '$.quantity');
	-- Insert statement
	INSERT INTO
	    scheduled_service_services (
	        service_schedule_id,
	        service_id,
	        quantity
	    )
	VALUES (
	        last_id,
	        p_service_id,
	        p_quantity
	    );
	SET currentIndex = currentIndex + 1;
	END WHILE;
	ELSE ROLLBACK;
	SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'No services provided';
	END IF;
	-- Insert materials
	SET currentIndex = 0;
	SET totalElements = JSON_LENGTH(p_materials);
	IF totalElements > 0 THEN
	WHILE
	    currentIndex < totalElements
	DO
	SET
	    currentElement = JSON_EXTRACT(
	        p_materials,
	        CONCAT('$[', currentIndex, ']')
	    );
	-- Process current JSON
	SET
	    p_material_id = JSON_EXTRACT(
	        currentElement,
	        '$.material_id'
	    );
	SET p_qty = JSON_EXTRACT(currentElement, '$.qty');
	SET
	    p_sub_total = JSON_EXTRACT(currentElement, '$.sub_total');
	-- Insert statement
	INSERT INTO
	    scheduled_service_materials (
	        service_schedule_id,
	        material_id,
	        qty,
	        sub_total
	    )
	VALUES (
	        last_id,
	        p_material_id,
	        p_qty,
	        p_sub_total
	    );
	SET currentIndex = currentIndex + 1;
	END WHILE;
	END IF;
	-- Insert employees
	SET currentIndex = 0;
	SET totalElements = JSON_LENGTH(p_employees);
	IF totalElements > 0 THEN
	WHILE
	    currentIndex < totalElements
	DO
	SET
	    currentElement = JSON_EXTRACT(
	        p_employees,
	        CONCAT('$[', currentIndex, ']')
	    );
	-- Process current JSON
	SET
	    p_employee_id = JSON_EXTRACT(
	        currentElement,
	        '$.employee_id'
	    );
	-- Insert statement
	INSERT INTO
	    employees_at_service_scheduled (
	        service_schedule_id,
	        employee_id
	    )
	VALUES (last_id, p_employee_id);
	SET currentIndex = currentIndex + 1;
	END WHILE;
	END IF;
    
	INSERT INTO
	    routine_scheduled_services (
	        service_schedule_id,
	        days_until_repeat,
	        last_service_date,
	        status
	    )
	VALUES (
	        last_id,
	        p_days_until_repeat,
	        NULL,
	        'active'
	    );
	COMMIT;
	END;
