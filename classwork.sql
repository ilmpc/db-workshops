SELECT STR_TO_DATE('21,5,2013', '%d,%m,%Y') AS dttm;
SELECT STR_TO_DATE('2017-03-13T14:39:01.123', '%Y-%m-%dT%H:%i:%s.%f') AS dttm;

-- @block
SELECT *
FROM hr.employees
WHERE start_date is not NULL;

-- @block
SELECT employee_id, start_date
FROM hr.employees
WHERE start_date BETWEEN '2022-10-01' AND '2022-10-31';

-- @block
SELECT DATE_ADD('2022-10-01', INTERVAL 6 month);

-- @block Query emp. that passed 6 month test period
SELECT first_name, last_name, start_date
FROM hr.employees
WHERE start_date < SUBDATE(CURDATE() , INTERVAL 6 month);

-- start_date before (now - 6 month)