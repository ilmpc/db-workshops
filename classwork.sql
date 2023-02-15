USE hr;


-- @block
-- Create a SALARY_GROUP field that equals
-- `1` IF employee 's salary is more than 10000
-- `0` if the employee' s salary IS less than 10000
SELECT *
FROM employees;


-- @block
-- Calculate amount of records in groups created in previous query.
SELECT *
FROM employees;


-- @block
-- Sort employees by their salary
SELECT *
FROM employees;


-- @block
-- Find all available `job_id` in table employees
SELECT *
FROM employees;


-- @block
-- Find all `job_id` of jobs that don't have `COMMISSION_PCT` or stated salary is less then 3000
SELECT *
FROM employees;