-- create service
DROP PROCEDURE IF EXISTS sp_create_service;
CREATE PROCEDURE sp_create_service(
	IN p_service_name VARCHAR(100),
	IN p_description TEXT,
	IN p_is_per_hour VARCHAR(5),
	IN p_price DECIMAL(10,2)
)
BEGIN
	START TRANSACTION;
		INSERT INTO services (service_name, description, is_per_hour, price )
		VALUES (p_service_name, p_description, p_is_per_hour, p_price );
	COMMIT;
END

-- Get services
DROP PROCEDURE IF EXISTS sp_get_services;
CREATE PROCEDURE sp_get_service()
BEGIN
	START TRANSACTION;
		SELECT service_id, service_name, description, is_per_hour, price FROM services;
	COMMIT;
END

-- update service
DROP PROCEDURE IF EXISTS sp_update_service;
CREATE PROCEDURE sp_update_service(
	IN p_service_id INT,
	IN p_service_name VARCHAR(100),
	IN p_description TEXT,
	IN p_is_per_hour VARCHAR(5),
	IN p_price DECIMAL(10,2)
)
BEGIN
	START TRANSACTION;
		UPDATE services 
		SET service_name = p_service_name, 
			description =  p_description, 
			is_per_hour = p_is_per_hour, 
			price = p_price
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
