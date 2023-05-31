-- CREATE TABLE `materials` (
--   `material_id` int NOT NULL AUTO_INCREMENT,
--   `material_name` varchar(100) NOT NULL,
--   `description` varchar(255),
--   `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
--   `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   PRIMARY KEY (`material_id`)
-- )

CREATE PROCEDURE sp_create_materials (
    IN p_material_name VARCHAR(100),
    IN p_description VARCHAR(255)
)
BEGIN
    START TRANSACTION;
        INSERT INTO materials (material_name, description)
        VALUES (p_material_name, p_description);
    COMMIT;
END

CREATE PROCEDURE sp_get_materials ()
BEGIN
    START TRANSACTION;
        SELECT material_id, material_name, description FROM materials;
    COMMIT;
END

CREATE PROCEDURE sp_update_material(
    IN p_material_id INT,
    IN p_material_name VARCHAR(100),
    IN p_description VARCHAR(255)
)
BEGIN
    START TRANSACTION;
        UPDATE materials
        SET material_name = p_material_name,
            description = p_description
        WHERE material_id = p_material_id;
    COMMIT;
END

-- TODO: verify that it works when DELETE actions is added to table
CREATE PROCEDURE sp_delete_materials(
    p_material_id INT
)
BEGIN
    START TRANSACTION;
        DELETE FROM materials WHERE material_id = p_material_id;
    COMMIT;
END