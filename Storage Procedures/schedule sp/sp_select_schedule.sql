-- We create a select all service_schedules
CREATE PROCEDURE sp_select_all_service_schedule()
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred selecting service schedule.';
    END;
    
    START TRANSACTION;
    
   		SELECT service_schedule_id, client_id, address_id, start_time, end_time, to_do_date, type, status FROM service_schedule;

    COMMIT;
END;

-- we select a specific schedule
CREATE PROCEDURE sp_select_service_schedule(
	IN p_service_schedule_id BIGINT
)
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred selecting service schedule.';
    END;
    
    START TRANSACTION;
    
   		SELECT service_schedule_id, client_id, address_id, start_time, end_time, to_do_date, type, status FROM service_schedule WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;
-- #############################################################################################
-- We create single sp_select for best practices and easier to modify in the future
-- #############################################################################################
CREATE PROCEDURE sp_select_scheduled_service_services(
	IN p_service_schedule_id BIGINT
)
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred selecting service schedule.';
    END;
    
    START TRANSACTION;
    
   		SELECT scheduled_service_task_id, service_schedule_id, service_id, quantity FROM scheduled_service_services WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;

-- #############################################################################################
-- get materials by service_id
-- #############################################################################################

CREATE PROCEDURE sp_select_scheduled_service_materials(
	IN p_service_schedule_id BIGINT
)
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred selecting service schedule.';
    END;
    
    START TRANSACTION;
    
   		SELECT scheduled_service_material_id, service_schedule_id, material_id, qty, sub_total  FROM scheduled_service_materials WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;


CREATE PROCEDURE sp_select_single_scheduled_service_material(
	IN p_scheduled_service_material_id BIGINT
)
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred selecting service schedule.';
    END;
    
    START TRANSACTION;
    
   		SELECT scheduled_service_material_id, service_schedule_id, material_id, qty, sub_total  FROM scheduled_service_materials WHERE scheduled_service_material_id = p_scheduled_service_material_id;
    
    COMMIT;
END;


-- #############################################################################################
-- get employees at service
-- #############################################################################################
CREATE PROCEDURE sp_select_employees_at_service_scheduled(
	IN p_service_schedule_id BIGINT
)
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred selecting service schedule.';
    END;
    
    START TRANSACTION;
    
   		SELECT emp_at_service_id, service_schedule_id, employee_id FROM employees_at_service_scheduled WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;

-- #############################################################################################
-- get routine associated with service
-- #############################################################################################
CREATE PROCEDURE sp_select_routine_scheduled_services(
	IN p_service_schedule_id BIGINT
)
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred selecting service schedule.';
    END;
    
    START TRANSACTION;
    
   		SELECT routine_schedule_id, service_schedule_id, days_until_repeat, last_service_date, status FROM routine_scheduled_services WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;