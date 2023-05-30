-- create service
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
		VALUES (p_service_name, p_description, p_is_per_hour, p_price, p_duration_mintues);
	COMMIT;
END