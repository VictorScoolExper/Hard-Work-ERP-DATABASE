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

    COMMIT;
END