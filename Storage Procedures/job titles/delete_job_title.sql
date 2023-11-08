-- Green Works ERP by Victor Martinez

DROP PROCEDURE IF EXISTS sp_delete_job_title;
CREATE PROCEDURE sp_delete_job_title (
	IN p_job_title_id int
)
BEGIN
	DELETE FROM job_titles WHERE job_title_id = p_job_title_id;
END;
CALL sp_delete_job_title(3);