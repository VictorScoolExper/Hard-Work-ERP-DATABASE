CREATE PROCEDURE sp_insert_crew(
    IN p_crew_name VARCHAR(200),
    IN p_crew_leader BIGINT,
    OUT crew_id BIGINT
)
BEGIN   
    -- we insert the crew values
    INSERT INTO crews(crew_name, crew_leader)
    VALUES (p_crew_name, p_crew_leader);
    -- we save the id
    SET crew_id = LAST_INSERT_ID();
END

-- This associates a list of employees to crews
-- saves array of employees
CREATE PROCEDURE sp_add_employees_to_crew(IN crew_id BIGINT, IN employee_ids JSON)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE n INT DEFAULT JSON_LENGTH(employee_ids);
    DECLARE employee_id BIGINT;

    WHILE i < n DO
        SET employee_id = CAST(JSON_EXTRACT(employee_ids, CONCAT('$[', i, ']')) AS UNSIGNED);
        INSERT INTO crews_employees (crew_id, employee_id) VALUES (crew_id, employee_id);
        SET i = i + 1;
    END WHILE;
END;

-- Get list of employees from crew
CREATE PROCEDURE sp_get_employees_by_crew_id(IN crew_id_in BIGINT)
BEGIN
    SELECT users.*, employees.*
    FROM crews_employees
    JOIN employees ON crews_employees.employee_id = employees.employee_id
    JOIN users ON employees.user_id = users.user_id
    WHERE crews_employees.crew_id = crew_id_in;
END

-- Edit Crew Details
CREATE PROCEDURE sp_update_crew(IN crew_id_in BIGINT, IN crew_name_in VARCHAR(255), IN crew_leader_in BIGINT)
BEGIN
    UPDATE crews SET
        crew_name = crew_name_in,
        crew_leader = crew_leader_in,
        updated_at = CURRENT_TIMESTAMP
    WHERE crew_id = crew_id_in;
END

-- Delete employee from crew
CREATE PROCEDURE sp_delete_employee_from_crew(IN p_crew_id BIGINT, IN p_employee_id BIGINT)
BEGIN
    DELETE FROM crews_employees WHERE crew_id = p_crew_id AND employee_id = p_employee_id;
END




