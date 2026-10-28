-- 1. Create a database named CollegeDB and select it for use.
SHOW DATABASES;
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- 2. Create a table Students with the columns: student_id (INT, primary key), student_name (VARCHAR(50), NOT NULL), department (VARCHAR(30)), age(INT) and city (VARCHAR(40))
CREATE TABLE Students(
	student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    department VARCHAR(30),
    age INT,
    city VARCHAR(40)
    );
SHOW TABLES;

-- 3. Create a table Courses with course_id as the primary key and course_name as a NOT NULL column.
CREATE TABLE Courses(
	course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL
    );
SHOW TABLES;

-- 4. Insert atleast 5 records into Students table, using different departments and cities
DESCRIBE students;
INSERT INTO students (
				student_id,
				student_name,
				department,
				age,
				city
				)
	VALUES (
			 001 , 'Karan Verma'   , 'Mechanical Engineering' , 19 , 'Pune'),
			(002 , 'Hemant Nimje'  , 'Civil Engineering'      , 20 , 'Nagpur'),
            (003 , 'Anshul Parate' , 'Computer Technology'    , 21 , 'Mumbai'),
            (004 , 'Praful Ramteke', 'Electrical Enginerring' , 22 , 'Vadodara'),
            (005 , 'Tarun Sharma'  , 'Information Technology' , 23 , 'Amravati');
SELECT * FROM students;

-- 5. Display all student records. Then display only the student names and departments 
SELECT * FROM students;

SELECT student_name, department
FROM students;

-- 6. Display students who belong to the IT department and students whose age is greater than 20.
SELECT student_name, age
FROM students
WHERE department = 'Information Technology' AND age > 20;

-- 7. Display student records in ascending order by name and show only the first 3 records.
SELECT *
FROM students
ORDER BY student_name ASC
LIMIT 3;

-- 8. Write a query to count the total number of students and find the average age of students
SELECT 
	COUNT(*) as Total_Students, 
    AVG(age) as Avg_Age
FROM students;

-- 9. Update the city of a student using their student_id. Display the updated record.
UPDATE students
SET city = 'Nepal'
WHERE student_id = 003;

SELECT *
FROM students
WHERE student_id = 003;

-- 10. Increase the age of all students in the IT department by 1 year.
UPDATE students 
SET age = age + 1
WHERE department = 'Information Technology';

SELECT * 
FROM students 
WHERE department = 'Information Technology';

-- 11. Delete one student record using student_id and verify the deletion.
DELETE FROM students
WHERE student_id = 001;

SELECT *
FROM students
WHERE student_id = 001;

-- 12. Add an email column of type VARCHAR(100) to the students table.
ALTER TABLE students
ADD email VARCHAR(100);

DESCRIBE students;

-- 13. Create an enrollments table with student_id and course_id. Set appropriate foreign key referencing students and courses
CREATE TABLE enrollment (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 14. Insert sample records into courses and enrolments. Write an INNER JOIN query to display each enrolled studnet's name and course name.
INSERT INTO courses (course_id, course_name)
VALUES
(101 , 'DBMS'),
(102 , 'Python'),
(103 , 'Java'),
(104 , 'Data Science');

INSERT INTO enrollment (student_id, course_id)
VALUES
(002, 101),
(003, 102),
(004, 103),
(005, 104);

SELECT
    s.student_name,
    c.course_name
FROM enrollment e
INNER JOIN students s
    ON e.student_id = s.student_id
INNER JOIN courses c
    ON e.course_id = c.course_id;

-- 15. Write a LEFT JOIN query to list every student and their course information, including students who are not enrolled in any courses.
SELECT
    s.student_id,
    s.student_name,
    c.course_name
FROM enrollment e
left JOIN students s
    ON e.student_id = s.student_id
left JOIN courses c
    ON e.course_id = c.course_id;

-- 16. Write a RIGHT JOIN query to display all courses and any students enrolled in them, including courses with no enrollments. 
SELECT
    c.course_id,
    c.course_name,
    s.student_name
FROM students s
JOIN enrollment e
    ON s.student_id = e.student_id
RIGHT JOIN courses c
    ON e.course_id = c.course_id;

-- 17. Create a view named ITStudentView that displays the names and cities of students in the IT department. Query the view to display its contents.
CREATE VIEW ITStudentView AS
SELECT student_name, city
FROM students
WHERE department = 'Information Technology';
SELECT * FROM ITStudentView;

-- 18. Create or replace the view to include the student's name, age and city for students older than 20. Display the view contents.
CREATE OR REPLACE VIEW StudentAgeView AS
SELECT student_name, age, city
FROM students
WHERE age > 20;
SELECT * FROM StudentAgeView;

-- 19. Write a query using subquery to display students whose age is greater than the average age of all students.
SELECT student_id, student_name, age
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);

-- 20. Use a transaction to insert a sample record, then demonstrate COMMIT or ROLLBACK.