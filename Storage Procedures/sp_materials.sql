DROP PROCEDURE IF EXISTS sp_create_materials;
CREATE PROCEDURE sp_create_materials (
    IN p_material_name VARCHAR(100),
    IN p_description VARCHAR(255),
    IN p_unit enum('yard','ton','piece')
)
BEGIN
    START TRANSACTION;
        INSERT INTO materials (material_name, description, unit)
        VALUES (p_material_name, p_description, p_unit);
    COMMIT;
END

DROP PROCEDURE IF EXISTS sp_get_materials;
CREATE PROCEDURE sp_get_materials ()
BEGIN
    START TRANSACTION;
        SELECT material_id, material_name, description, unit FROM materials;
    COMMIT;
END

DROP PROCEDURE IF EXISTS sp_update_material;
CREATE PROCEDURE sp_update_material(
    IN p_material_id INT,
    IN p_material_name VARCHAR(100),
    IN p_description VARCHAR(255),
    IN p_unit enum('yard','ton','piece')
)
BEGIN
    START TRANSACTION;
        UPDATE materials
        SET material_name = p_material_name,
            description = p_description,
            unit = p_unit
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