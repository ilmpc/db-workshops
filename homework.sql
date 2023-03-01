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
SELECT s.name, c.title
FROM Students AS s
  INNER JOIN StudentsToCourses AS s2c ON s.id = s2c.student_id
  INNER JOIN Courses as c on c.id = s2c.course_id;