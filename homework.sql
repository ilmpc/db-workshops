/*
 1) Query the names of the students and the courses they are taking
 2) Query the names of all teachers with their competencies
 3) Find a teacher who has no competencies
 4) Find the names of students who do not take any course
 5) Find courses that no student attends
 6) Find competencies that no teacher has
 7) Query the name of the course and the name of the headman
 8) Query the name of the student and the names of the headman that are in the courses he is taking
 */
-- @block
USE uni;


-- @block
SELECT s.name,
  c.title
FROM Students AS s
  INNER JOIN StudentsToCourses AS s2c ON s.id = s2c.student_id
  INNER JOIN Courses AS c ON c.id = s2c.course_id;


-- @block
SELECT t.id,
  t.name,
  t2c.id c.title
FROM Teachers AS t
  LEFT JOIN TeachersToCompetencies AS t2c ON t.id = t2c.teacher_id
  LEFT JOIN Competencies AS c ON t2c.competencies_id = c.id;


-- @block
SELECT t.id,
  t.name
FROM Teachers AS t
  LEFT JOIN TeachersToCompetencies AS t2c ON t.id = t2c.teacher_id
WHERE t2c.id IS NULL;


-- @block
SELECT s.name
FROM Students AS s
  LEFT JOIN StudentsToCourses AS s2c ON s.id = s2c.student_id
WHERE s2c.id IS NULL;


-- @block
SELECT c.title
FROM Courses AS c
  LEFT JOIN StudentsToCourses AS s2c ON c.id = s2c.course_id
WHERE s2c.id IS NULL;


-- @block
SELECT c.title
FROM Competencies AS c
  LEFT JOIN TeachersToCompetencies AS t2c ON c.id = t2c.competencies_id
WHERE t2c.id IS NULL;


-- @block
-- Query the name of the course and the name of the headman
SELECT c.title,
  s.name
FROM Courses AS c
  INNER JOIN Students AS s ON c.headman_id = s.id;


-- @block
-- Query the name of the student and the names of the headman that are in the courses he is taking
SELECT s.id,
  s.name,
  c.headman_id,
  hds.name AS hds_name
FROM Students AS s
  INNER JOIN StudentsToCourses AS s2c ON s.id = s2c.student_id
  INNER JOIN Courses AS c ON c.id = s2c.course_id
  INNER JOIN Students AS hds ON c.headman_id = hds.id;