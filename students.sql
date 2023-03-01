/*
 1) Create table Students
 with fields:
 - id integer primary key autoincrement
 - name string 128 not null
 - age integer
 
 2) Create a Teachers table
 with fields:
 - id integer primary key autoincrement
 - name string 128 not null
 - age integer
 
 3) Create Competencies table
 with fields:
 - id integer primary key autoincrement
 - title string 128 not null
 
 4) Create a TeachersToCompetencies table
 with fields:
 - id integer primary key autoincrement
 - teacher_id integer
 - competencies_id integer
 
 5) Create table Courses
 - id integer primary key autoincrement
 - teacher_id integer
 - title string 128 not null
 - headman_id integer
 
 6) Create table StudentsToCourses
 - id integer primary key autoincrement
 - student_id integer
 - course_id integer
 */
/*
 Add 6 records to `Students` table
 
 Add 6 records to `Teachers` table
 
 Add 4 records to `Competencies` table
 Mathematics
 Computer science
 Programming
 Graphic arts
 
 Add 6 records to the `TeachersToCompetencies` table
 1 1
 2 1
 2 3
 3 2
 4 1
 5 3
 
 Add 5 records to the `Courses` table
 1 Algebra of logic 2
 2 Mathematical statistics 3
 4 Higher mathematics 5
 5 Javascript 1
 5 Basic Python 1
 
 Add 5 records to `StudentsToCourses` table
 1 1
 2 1
 3 2
 3 3
 4 5
 
 */
CREATE DATABASE IF NOT EXISTS uni;


USE uni;


CREATE TABLE IF NOT EXISTS Students (
  id integer PRIMARY KEY AUTO_INCREMENT,
  name varchar(128) NOT NULL,
  age integer
);


CREATE TABLE IF NOT EXISTS Teachers (
  id integer AUTO_INCREMENT,
  name varchar(128) NOT NULL,
  age integer,
  PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS Competencies (
  id integer AUTO_INCREMENT,
  title varchar(128) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS TeachersToCompetencies (
  id integer AUTO_INCREMENT,
  teacher_id integer,
  competencies_id integer,
  FOREIGN KEY (teacher_id) REFERENCES Teachers(id),
  FOREIGN KEY (competencies_id) REFERENCES Competencies(id),
  PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS Courses (
  id integer AUTO_INCREMENT,
  teacher_id integer,
  title varchar(128) NOT NULL,
  headman_id integer,
  FOREIGN KEY (teacher_id) REFERENCES Teachers(id),
  FOREIGN KEY (headman_id) REFERENCES Students(id),
  PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS StudentsToCourses (
  id integer AUTO_INCREMENT,
  student_id integer,
  course_id integer,
  FOREIGN KEY (student_id) REFERENCES Students(id),
  FOREIGN KEY (course_id) REFERENCES Courses(id),
  PRIMARY KEY (id)
);


-- Values
INSERT INTO Students (name, age)
VALUES ('Charles R.Campbell', 22),
  ('Brian L.Forrest', 23),
  ('Robert K.Lucas', 23),
  ('Melissa B.Lopez', 51),
  ('Jessica M.Farrell', 21),
  ('Inez J.Michel', 36);


INSERT INTO Teachers (name, age)
VALUES ('Lois C.Holmes', 44),
  ('Evelyn E.Anderson', 38),
  ('James D.Brown', 56),
  ('Randall L.Smith', 66),
  ('Roy S.Barron', 53),
  ('Kathy G.Howe', 48);


INSERT INTO Competencies (title)
VALUES ('Mathematics'),
  ('Computer science'),
  ('Programming'),
  ('Graphic arts');


INSERT INTO TeachersToCompetencies (teacher_id, competencies_id)
VALUES (1, 1),
  (2, 1),
  (2, 3),
  (3, 2),
  (4, 1),
  (5, 3);


INSERT INTO Courses (teacher_id, title, headman_id)
VALUES (1, 'Algebra of logic', 2),
  (2, 'Mathematical statistics', 3),
  (4, 'Higher mathematics', 5),
  (5, 'Javascript', 1),
  (5, 'Basic Python', 1);


INSERT INTO StudentsToCourses (student_id, course_id)
VALUES (1, 1),
  (2, 1),
  (3, 2),
  (3, 3),
  (4, 5);


-- @block
(1, 'Algebra of logic', 2),
(2, 'Mathematical statistics', 3),
(4, 'Higher mathematics', 5),
(5, 'Javascript', 1),
(5, 'Basic Python', 1),