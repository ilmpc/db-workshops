USE hr;


-- @block
-- Find all departments that don't have employees
SELECT d.department_name,
  e.employee_id
FROM departments AS d
  LEFT JOIN employees AS e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;


-- @block
SELECT department_id from departments;

-- @block 
-- Find employees without department
SELECT e.employee_id, e.first_name,
  e.department_id, d.department_id
FROM employees AS e
  LEFT JOIN departments AS d ON d.department_id = e.department_id
WHERE d.department_id IS NULL;

-- @block
SELECT * FROM employees where employee_id=1000;

-- @block
-- Create employee with non-existing department
INSERT INTO employees (employee_id, first_name, department_id)
VALUES (1000, 'Mark', 9999);


-- @block
DELETE FROM employees
WHERE department_id = 9999;