/*
 1. Create `students` table with columns
 - name (required)
 - lastname (required)
 - avg_mark (0 to 5) ex. 3.5
 - sex (use varchar(64) here) (check to be `M` or `F`)
 2. Add five students
 3. Add field `id` as primary key and auto increment modifier
 4. Change `sex` type to char(1)
 5. Change label of a `name` column to `first_name`
 6. Create queries to find students which:
 - mark is more than 4
 - mark is outside of 3..4 range
 - name starts with `A`
 - mark equal 2.2, 3.1 or 4.7
 7. Create view that shows only men
 8. Create view that shows only women
 9. Find all unique marks in table
 10. Our school changes grade system to 0..10 range. Safely migrate old data and change constraints according to the new system rules.
 11. Expel students whose grades are worse that 4.0
 */

 -- @block
CREATE DATABASE IF NOT EXISTS college;

-- @block
USE college;

-- @block
DROP TABLE IF EXISTS students;

-- @block
CREATE TABLE students (
  name VARCHAR(64) NOT NULL,
  lastname VARCHAR(64) NOT NULL,
  avg_mark DECIMAL(3,1) UNSIGNED,
  sex VARCHAR(64) CHECK (sex = 'M' OR sex = 'F')
);

-- @block
INSERT INTO students (name, lastname, avg_mark, sex)
VALUES 
  ('Simon', 'Lowe', 2.3, 'M'),
  ('Jimmy', 'Lee', 4.6, 'M'),
  ('Sandra', 'Brown', 1.2, 'F'),
  ('Steven', 'Kraft', 3.4, 'M'),
  ('Karen', 'Hill', 2.8, 'F');

-- @block
ALTER TABLE students 
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- @block
ALTER TABLE students 
MODIFY COLUMN sex CHAR(1);

-- @block
ALTER TABLE students 
CHANGE COLUMN name first_name VARCHAR(64) NOT NULL;

-- @block
SELECT * FROM students 
WHERE avg_mark > 4;

-- @block
SELECT * FROM students 
WHERE avg_mark < 3 OR avg_mark > 4;

-- @block
SELECT * FROM students 
WHERE first_name LIKE 'A%';

-- @block
SELECT * FROM students 
WHERE avg_mark IN (2.2, 3.1, 4.7);

-- @block
CREATE VIEW male_students AS
SELECT * FROM students WHERE sex = 'M';

-- @block
CREATE VIEW female_students AS
SELECT * FROM students WHERE sex = 'F';

-- @block
CREATE VIEW male_students AS
SELECT * FROM students WHERE sex = 'M';

-- @block
SELECT DISTINCT avg_mark FROM students;

-- @block
DELETE FROM students WHERE avg_mark < 4;