-- Green Works ERP by Victor Martinez

--------------------------------------------------------------------------------------------------
--- SELECT all Job Titles
DROP PROCEDURE IF EXISTS sp_select_job_titles;
CREATE PROCEDURE sp_select_job_titles ()
BEGIN
	SELECT * FROM job_titles;
END;
CALL sp_select_job_titles();

-----------------------------------------------------------------------------------------------------
---- Select Job Title name
DROP PROCEDURE IF EXISTS sp_select_job_title_name;
CREATE PROCEDURE sp_select_job_title_name(
    IN p_job_title_id int
)
BEGIN
	SELECT name FROM job_titles WHERE job_title_id = p_job_title_id;
END;

CALL sp_select_job_title_name(1);