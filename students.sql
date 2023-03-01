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