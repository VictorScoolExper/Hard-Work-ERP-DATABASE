-- create service
DROP PROCEDURE IF EXISTS sp_create_service;
CREATE PROCEDURE sp_create_service(
	IN p_service_name VARCHAR(100),
	IN p_description TEXT,
	IN p_is_per_hour TINYINT,
	IN p_price DECIMAL(10,2),
	IN p_duration_min INT
)
BEGIN
	START TRANSACTION;
		INSERT INTO services (service_name, description, is_per_hour, price, duration_minutes)
		VALUES (p_service_name, p_description, p_is_per_hour, p_price, p_duration_min);
	COMMIT;
END

-- Get services
DROP PROCEDURE IF EXISTS sp_get_service;
CREATE PROCEDURE sp_get_service()
BEGIN
	START TRANSACTION;
		SELECT service_id, service_name, description, is_per_hour, price, duration_minutes FROM services;
	COMMIT;
END

-- update service
DROP PROCEDURE IF EXISTS sp_update_service;
CREATE PROCEDURE sp_update_service(
	IN p_service_id INT,
	IN p_service_name VARCHAR(100),
	IN p_description TEXT,
	IN p_is_per_hour TINYINT,
	IN p_price DECIMAL(10,2),
	IN p_duration_min INT
)
BEGIN
	START TRANSACTION;
		UPDATE services 
		SET service_name = p_service_name, 
			description =  p_description, 
			is_per_hour = p_is_per_hour, 
			price = p_price, 
			duration_minutes = p_duration_min
		WHERE service_id = p_service_id;
	COMMIT;
END

-- delete service
DROP PROCEDURE IF EXISTS sp_delete_service;
CREATE PROCEDURE sp_delete_service(
	IN p_service_id INT
)
BEGIN
	START TRANSACTION;
		DELETE FROM services WHERE service_id = p_service_id;
	COMMIT;
END;
