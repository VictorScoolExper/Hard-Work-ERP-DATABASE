-- Green Works ERP by Victor Martinez
DROP PROCEDURE IF EXISTS sp_select_job_title_name;
CREATE PROCEDURE sp_select_job_title_name(
    IN p_job_title_id int
)
BEGIN
	SELECT name FROM job_titles WHERE job_title_id = p_job_title_id;
END;

CALL sp_select_job_title_name(1);