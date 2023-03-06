USE hr;


-- @block
-- Find employees names that has max salary in their department
SELECT first_name,
  last_name
FROM employees;


-- @block
SELECT department_id,
  MAX(salary) AS salary
FROM employees
GROUP BY department_id
ORDER BY salary DESC;


-- @block
SELECT first_name,
  last_name,
  department_id
FROM employees
WHERE salary IN (
    SELECT MAX(salary)
    FROM employees
    GROUP BY department_id
  );


-- @block
SELECT first_name,
  last_name,
  e.department_id,
  e.salary
FROM employees AS e
  INNER JOIN (
    SELECT department_id,
      MAX(salary) AS salary
    FROM employees
    GROUP BY department_id
  ) AS s ON e.department_id = s.department_id
  AND e.salary = s.salary;


-- @block
INSERT INTO hr.employees (first_name, salary, department_id)
VALUES ('test', 24000, 90);


-- @block Query data of the biggest department in company
-- @block Query amount in each department
SELECT department_id,
  COUNT(*) AS employees_count
FROM employees
GROUP BY department_id;


-- @block Department with max employees_count
SELECT max(employees_count)
FROM (
    SELECT COUNT(*) AS employees_count
    FROM employees
    GROUP BY department_id
  ) AS count_each_dep;


-- @block Find dep_id with max employees_count
SELECT department_id,
  COUNT(*) AS employees_count
FROM employees
GROUP BY department_id
HAVING employees_count = (
    SELECT max(employees_count)
    FROM (
        SELECT COUNT(*) AS employees_count
        FROM employees
        GROUP BY department_id
      ) AS count_each_dep
  );


-- @block 
SELECT d.department_name,
  employees_count
FROM departments AS d
  INNER JOIN (
    SELECT department_id,
      COUNT(*) AS employees_count
    FROM employees
    GROUP BY department_id
    HAVING employees_count = (
        SELECT MIN(employees_count)
        FROM (
            SELECT COUNT(*) AS employees_count
            FROM employees
            GROUP BY department_id
          ) AS count_each_dep
      )
  ) AS met USING (department_id);


-- @block Deps where more than 5 employees
SELECT department_id,
  COUNT(*) AS employees_count,
  department_name
FROM employees AS e
  INNER JOIN departments AS d USING (department_id)
GROUP BY department_id,
  department_name
HAVING employees_count > 5;


-- @block
SELECT department_id,
  department_name,
  ec.employees_count
FROM departments AS d
  INNER JOIN (
    SELECT department_id,
      COUNT(*) AS employees_count
    FROM employees
    GROUP BY department_id
    HAVING employees_count > 5
  ) AS ec USING (department_id);


-- @block
CREATE VIEW employeesInDeps AS
SELECT department_id,
  COUNT(*) AS employees_count
FROM employees
GROUP BY department_id;


-- @block Dep with amount of employees more than avg
SELECT *
FROM employeesInDeps inner join departments using (department_id)
WHERE employees_count > (
    SELECT avg(employees_count)
    FROM employeesInDeps
  );