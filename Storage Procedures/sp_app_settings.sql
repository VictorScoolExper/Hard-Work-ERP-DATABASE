CREATE PROCEDURE `sp_create_app_settings`(
    IN p_setting_name VARCHAR(100),
    IN p_setting_value VARCHAR(100),
    IN p_type_value enum('percent','number','string')
)
BEGIN
    START TRANSACTION;
        INSERT INTO app_settings (setting_name, setting_value, type_value)
        VALUES (p_setting_name, p_setting_value, p_type_value);
    COMMIT;
END;

CREATE PROCEDURE `sp_get_app_settings` ()
BEGIN
    START TRANSACTION;
        SELECT setting_name, setting_value, type_value FROM app_settings;
    COMMIT;
END;

CREATE PROCEDURE `sp_update_app_setting`(
    IN p_setting_name VARCHAR(100),
    IN p_setting_value VARCHAR(100)
)
BEGIN
    START TRANSACTION;
        UPDATE app_settings 
        SET setting_value = p_setting_value
        WHERE setting_name = p_setting_name;
    COMMIT;
END;

CREATE PROCEDURE `sp_delete_app_settings`(
    IN p_setting_id INT
)
BEGIN 
    START TRANSACTION;
        DELETE FROM app_settings WHERE setting_id = p_setting_id;
    COMMIT;
END;