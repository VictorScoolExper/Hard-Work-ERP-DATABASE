DROP PROCEDURE IF EXISTS sp_create_service_schedule;
CREATE PROCEDURE sp_create_service_schedule(
    IN p_client_id BIGINT, 
    IN p_address_id BIGINT, 
    IN p_start_time TIME, 
    IN p_end_time TIME,
    IN p_to_do_date DATE,
    IN p_type ENUM('single', 'routine'),
    IN p_status ENUM('pending', 'in-progress', 'done', 'canceled'),
    IN p_services JSON, 
    IN p_materials JSON, 
    IN p_employees JSON, 
    IN p_days_until_repeat INT
)
BEGIN 
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
    
    START TRANSACTION;
    
    -- TODO: validate that the address belongs to the client (VALIDATION IMPORTANT)
   
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
        p_address_id, 
        p_start_time, 
        p_end_time, 
        p_to_do_date,
        p_type,
        p_status
    );
    -- set last_id variable with last id
    SET last_id = LAST_INSERT_ID();
    
    SET totalElements = JSON_LENGTH(p_services);
    -- validate that services exist
    IF totalElements > 0 THEN 
        WHILE currentIndex < totalElements DO
            SET currentElement = JSON_EXTRACT(p_services, CONCAT('$[', currentIndex, ']'));

            -- Process current json
            SET p_service_id = JSON_EXTRACT(currentElement, '$.service_id');
            SET p_quantity = JSON_EXTRACT(currentElement, '$.quantity');

            -- INSERT STATEMENT
            INSERT INTO scheduled_service_services (
                service_schedule_id, 
                service_id, 
                quantity
            ) 
            VALUES (
                last_id,
                p_service_id,
                p_quantity
            );
            -- set the next index
            SET currentIndex = currentIndex + 1;
        END WHILE;
    ELSE 
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'No services provided';
    END IF;

    SET currentIndex = 0;
    SET totalElements = JSON_LENGTH(p_materials);
    -- validate that materials exist
    IF totalElements > 0 THEN 
        WHILE currentIndex < totalElements DO
            SET currentElement = JSON_EXTRACT(p_materials, CONCAT('$[', currentIndex, ']'));

            -- Process current json
            SET p_material_id = JSON_EXTRACT(currentElement, '$.material_id');
            SET p_qty = JSON_EXTRACT(currentElement, '$.qty');
            SET p_sub_total = JSON_EXTRACT(currentElement, '$.sub_total');

            -- INSERT STATEMENT
            INSERT INTO employees_at_service_scheduled (
                service_schedule_id,
                material_id,
                qty,
                subtotal
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

    SET currentIndex = 0;
    SET totalElements = JSON_LENGTH(p_employees);
    -- validate if employees exist
    IF totalElements > 0 THEN 
        WHILE currentIndex < totalElements DO
            SET currentElement = JSON_EXTRACT(p_employees, CONCAT('$[', currentIndex, ']'));

            -- Process the current JSON element
            SET p_employee_id = JSON_EXTRACT(currentElement, '$.employee_id');
            -- TODO: INSERT STATEMENT
            INSERT INTO employees_at_service_scheduled (
                client_serviced_id, 
                employee_id
            ) 
            VALUES (
                last_id,
                p_employee_id
            );

            SET currentIndex = currentIndex + 1;
        END WHILE;
    END IF;

    IF p_type = 'routine' THEN
        INSERT INTO routine_scheduled_services (
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
    END IF;

    COMMIT;
END;
