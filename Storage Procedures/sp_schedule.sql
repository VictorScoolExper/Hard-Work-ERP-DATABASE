DROP PROCEDURE IF EXISTS sp_create_service_schedule;
CREATE PROCEDURE sp_create_service_schedule (
    IN p_client_id INT,
    IN p_address_id INT,
    IN p_services JSON,
    IN p_materials JSON,
    IN p_employees JSON,
    IN p_start_time date,
    IN p_to_do_date date
)
BEGIN
    START TRANSACTION;
        -- TODO: insert into service schedule

        IF JSON_LENGTH(p_services) > 0 THEN
            -- TODO: INSERT STATEMENT
        ELSE 
            SIGNAL SQLSTATE  '45000' SET MESSAGE_TEXT = 'No services provided'
        END IF;

        IF JSON_LENGTH(p_materials) > 0 THEN
            -- TODO: INSERT STATEMENT
        ELSE 
            SIGNAL SQLSTATE  '45000' SET MESSAGE_TEXT = 'No materials provided'
        END IF;

        IF JSON_LENGTH(p_employees) > 0 THEN
            -- TODO: INSERT STATEMENT
        END IF;


    COMMIT;
END