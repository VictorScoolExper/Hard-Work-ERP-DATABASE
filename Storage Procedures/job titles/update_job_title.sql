-- Green Works ERP by Victor Martinez

--------------------------------------------------------------------------------
------ Update Job Title
DROP PROCEDURE IF EXISTS sp_update_job_title;
CREATE PROCEDURE sp_update_job_title (
	IN p_job_title_id int,
	IN p_name varchar(100),
	IN p_description text
)
BEGIN
	UPDATE job_titles
	SET name = p_name, description = p_description
	WHERE job_title_id = p_job_title_id;
END;
CALL sp_update_job_title(3, 'updated title', 'naw naw again naw naw');