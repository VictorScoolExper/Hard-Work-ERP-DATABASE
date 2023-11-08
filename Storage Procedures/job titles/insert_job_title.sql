-- Green Works ERP by Victor Martinez

--------------------------------------------------------------------------------------------------
---- Add Job title
DROP PROCEDURE IF EXISTS sp_insert_job_title;
CREATE PROCEDURE sp_insert_job_title (
	IN p_name varchar(100),
	IN p_description text
)
BEGIN
	INSERT INTO job_titles (name, description) VALUES (p_name, p_description);
END;
CALL sp_insert_job_title('test title', 'naw naw naw, blaw blaw');