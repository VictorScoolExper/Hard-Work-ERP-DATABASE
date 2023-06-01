

CREATE PROCEDURE `sp_create_genderal_settings`(
    IN p_sales_tax_percent decimal(10,2),
    IN p_mark_up_percent decimal(10,2)
)
BEGIN
    START TRANSACTION;
        INSERT INTO general_settings (sales_tax_percent, mark_up_percent)
        VALUES (p_sales_tax_percent, p_mark_up_percent);
    COMMIT;
END;

CREATE PROCEDURE `sp_get_general_settings` ()
BEGIN
    START TRANSACTION;
        SELECT sales_tax_percent, mark_up_percent FROM general_settings;
    COMMIT;
END;

CREATE PROCEDURE `sp_update_general_settings`(
    IN p_sales_tax_percent decimal(10,2),
    IN p_mark_up_percent decimal(10,2)
)
BEGIN
    START TRANSACTION;
        UPDATE general_settings 
        SET sales_tax_percent = p_sales_tax_percent,
            mark_up_percent = p_mark_up_percent
        WHERE 
    COMMIT;
END;