-- Updates for table service schedule

CREATE PROCEDURE sp_update_client_id_service_schedule(
   IN p_service_schedule_id BIGINT, 
   IN p_client_id BIGINT
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during service schedule update.';
    END;
    
    START TRANSACTION;
    
    UPDATE service_schedule
	SET client_id = p_client_id
	WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;

CREATE PROCEDURE sp_update_address_id_service_schedule(
   IN p_service_schedule_id BIGINT, 
   IN p_address_id BIGINT
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during service schedule update.';
    END;
    
    START TRANSACTION;
    
    UPDATE service_schedule
	SET address_id = p_address_id
	WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;

-- Not currently used
CREATE PROCEDURE sp_update_start_end_time_service_schedule(
   IN p_service_schedule_id BIGINT, 
   IN p_start_time TIME,
   IN p_end_time TIME
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during service schedule update.';
    END;
    
    START TRANSACTION;
    
    UPDATE service_schedule
	SET start_time = p_start_time, end_time = p_end_time
	WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;


CREATE PROCEDURE sp_update_todo_and_time_service_schedule(
   IN p_service_schedule_id BIGINT, 
   IN p_start_time TIME,
   IN p_end_time TIME,
   IN p_todo_date date
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during service schedule update.';
    END;
    
    START TRANSACTION;
    
    UPDATE service_schedule
	SET start_time = p_start_time, end_time = p_end_time, to_do_date = p_todo_date
	WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;


CREATE PROCEDURE sp_update_type_service_schedule(
   IN p_service_schedule_id BIGINT, 
   IN p_type ENUM('single', 'routine') 
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during service schedule update.';
    END;
    
    START TRANSACTION;
    
    UPDATE service_schedule
	SET type = p_type
	WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;


CREATE PROCEDURE sp_update_status_service_schedule(
   IN p_service_schedule_id BIGINT, 
   IN p_status ENUM('pending', 'in-progress', 'done', 'canceled')
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during service schedule update.';
    END;
    
    START TRANSACTION;
    
    UPDATE service_schedule
	SET status = p_status
	WHERE service_schedule_id = p_service_schedule_id;
    
    COMMIT;
END;



-- #########################################################################################
-- #####################################scheduled_service_services##########################
-- #########################################################################################

CREATE PROCEDURE sp_update_scheduled_service_services(
   IN p_scheduled_service_task_id BIGINT, 
   IN p_service_id BIGINT,
   IN p_quantity INT
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during schedule service services update.';
    END;
    
    START TRANSACTION;
    
    UPDATE scheduled_service_services
	SET service_id = p_service_id, quantity = p_quantity
	WHERE scheduled_service_task_id = p_scheduled_service_task_id;
    
    COMMIT;
END;

-- ##################################################################################
-- ######################### update employees at service scheduled ##################
-- ##################################################################################

CREATE PROCEDURE sp_update_employees_at_service_scheduled(
   IN p_emp_at_service_id BIGINT, 
   IN p_employee_id BIGINT
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during employees at schedule services update.';
    END;
    
    START TRANSACTION;
    
    UPDATE employees_at_service_scheduled
	SET employee_id = p_employee_id
	WHERE emp_at_service_id = p_emp_at_service_id;
    
    COMMIT;
END;


-- ###########################################################################################
-- ########################### rountine scheduled services####################################
-- ###########################################################################################

CREATE PROCEDURE sp_update_days_repeat_routine_scheduled_services(
   IN p_routine_schedule_id BIGINT, 
   IN p_days_until_repeat INT
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during routine schedule services update.';
    END;
    
    START TRANSACTION;
    
    UPDATE routine_scheduled_services
	SET days_until_repeat = p_days_until_repeat
	WHERE routine_schedule_id = p_routine_schedule_id;
    
    COMMIT;
END;

CREATE PROCEDURE sp_update_status_routine_scheduled_services(
   IN p_routine_schedule_id BIGINT, 
   IN p_status VARCHAR(20)
)
BEGIN 
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET
        MESSAGE_TEXT = 'An error occurred during routine schedule services update.';
    END;
    
    START TRANSACTION;
    
    UPDATE routine_scheduled_services
	SET status = p_status
	WHERE routine_schedule_id = p_routine_schedule_id;
    
    COMMIT;
END;
