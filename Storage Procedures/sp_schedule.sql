DROP PROCEDURE IF EXISTS sp_create_service_schedule;

CREATE PROCEDURE SP_CREATE_SERVICE_SCHEDULE(
    IN p_client_id INT, 
    IN p_address_id INT, 
    IN p_start_time DATE, 
    IN p_end_time DATE,
    IN p_to_do_date DATE,
    IN p_type enum('single', 'routine'),
    IN p_status enum('pending', 'in-progress', 'done', 'canceled')
    IN p_services JSON, 
    IN p_materials JSON, 
    IN p_employees JSON, 
   
) BEGIN 
	DECLARE last_id BIGINT DEFAULT 0;
	START TRANSACTION;
        -- TODO: insert into service schedule
        INSERT INTO service_schedule (
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
            p_services, 
            p_address_id, 
            p_start_time, 
            p_end_time, 
            p_to_do_date,
            p_type,
            p_status
        );
        -- set last_id variable with last id
        SET last_id = LAST_INSERT_ID();

        -- validate that services exist
        IF JSON_LENGTH(p_services) > 0 THEN 
            -- TODO: INSERT STATEMENT
            INSERT INTO 
        ELSE SIGNAL SQLSTATE '45000'
        SET
            MESSAGE_TEXT = 'No services provided'
        END IF;

        -- validate that materials exist
        IF JSON_LENGTH(p_materials) > 0 THEN 
            -- TODO: INSERT STATEMENT
            
        ELSE SIGNAL SQLSTATE '45000'
        SET
            MESSAGE_TEXT = 'No materials provided'
        END IF;

        -- validate if employees exist
        IF JSON_LENGTH(p_employees) > 0 THEN 
            -- TODO: INSERT STATEMENT
        END IF;

	COMMIT;
	END 
