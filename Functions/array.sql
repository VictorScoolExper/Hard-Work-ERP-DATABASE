CREATE FUNCTION hard_work_erp_db.ARRAY_AGG(
  expression VARCHAR(255),
  delimiter VARCHAR(1)
) RETURNS JSON
DETERMINISTIC
BEGIN
  DECLARE
    result JSON;
  BEGIN
    SELECT JSON_ARRAY(expression) INTO result
    FROM (
      SELECT expression
      FROM (
        SELECT expression
        ORDER BY expression
      ) AS t
    ) AS t;
    RETURN result;
  END;
END;
