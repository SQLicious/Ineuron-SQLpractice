/* Examples of SELF JOIN in MYSQL
   Date Created : 05-07-2023
   Practice coursework for Ineuron FSDA 2.0 */

CREATE DATABASE DEMO_DATABASE;
USE DEMO_DATABASE;

CREATE TABLE student
(Student_Id INT NOT NULL,
name VARCHAR(30),
Course_Id INT,
duration INT);

INSERT INTO student VALUES (1,'Adam',1,3);
INSERT INTO student VALUES (2,'Peter',2,4);
INSERT INTO student VALUES (1,'Adam',2,4);
INSERT INTO student VALUES (3,'Brian',3,2);
INSERT INTO student VALUES (2,'Shane',3,5);

SELECT * from student;

/* EG 1 : Using SELF JOIN to get all rows (student_id and name) from the table
          where student_id is equal, and course_id is not equal. */

SELECT s1.student_id,
       s1.name
FROM student AS s1, student s2
WHERE s1.student_id=s2.student_id
AND s1.course_id <> s2.course_id;


/* EG 2 : Query to use Inner JOIN with SELF JOIN */
SELECT DISTINCT s1.student_id, 
	   s1.name
FROM student s1, student s2
WHERE s1.student_id = s2.student_id
    AND s1.course_id <> s2.course_id
GROUP BY s1.student_id;

/*This query returns the student id and name when the student_id of both tables are equal and
course_id are not equal.*/

/* Example 3 - SELF JOIN using LEFT JOIN */

SELECT (CONCAT(s1.stud_lname, ' ', s2.stud_fname)) AS 'Monitor', s1.city
FROM student s1
LEFT JOIN student s2 ON s1.student_id=s2.student_id
ORDER BY s1.city DESC;

DROP table Persons ;

-- Example 4 -  MySQL Self Join using Inner Join Clause

CREATE TABLE Persons 
(PersonID int NOT NULL PRIMARY KEY,
LastName varchar(255) NOT NULL, 
FirstName varchar(255),
ReportsTo int, 
Title varchar(255),
Salary decimal);

INSERT INTO Persons 
VALUES (1,'Jha','Anand',8,'Data Analyst',1200000),
       (8,'M','Sangeetha',10,'Manager',4500000),
       (2,'Chaturvedi','Ishan',8,'Data Scientist',1800000),
       (10,'Shekhar','Srinu',123,'Tech Lead',2300000),
       (4,'MESHRAM','VINEET',10,'Consultant',1200000),
       (123,'Goel','Neha',134,'Manager',40000000),
       (20,'kumar','sathish', 18,'Data Engineer',8000000),
       (18,'GUPTA','ANKITA',10,'Business Architect',1100000),
       (7, 'Yadav', 'Abhishek', 10, 'Data Analyst',1000000),
       (134,'Dixit','Nitesh',27,'VP',20000000),
       (27,'Bandekar','Kalpana',32,'CEO',50000000);
       
  SELECT * from Persons;    
  
  -- Example 5 -  List of employees who reports to the same manager using INNER JOIN
  
SELECT distinct p1.PersonID as emp_id, 
CONCAT(p1.FirstName, ' ', p1.LastName) AS empfullName,p2.ReportsTo as manager_id
FROM Persons AS p1, Persons p2
WHERE p1.PersonID <> p2.PersonID
AND p1.ReportsTo = p2.ReportsTo
order by emp_id,empfullName,manager_id;

-- List of all the reportees under a manager and the number of employees directly reporting to them
SELECT DISTINCT p2.ReportsTo AS manager_id,
-- CONCAT(p1.FirstName, ' ', p1.LastName) AS manager_name,
COUNT(DISTINCT p1.PersonID ) AS TOTAL_EMP_REPORTING
FROM Persons AS p1, Persons p2
WHERE p1.PersonID <> p2.PersonID
AND p1.ReportsTo = p2.ReportsTo
GROUP BY 1
order by 1;

-- LIST OF ALL THE EMPLOYEES AND THEIR ASSOCIATED MANAGERS using INNER JOIN
SELECT CONCAT(b.LastName, ', ', b.FirstName) AS 'Direct Reporting' ,
CONCAT (a.FirstName, ' ' , a.LastName) AS Manager
FROM Persons b 
INNER JOIN persons a ON a.PersonID = b.ReportsTo
ORDER BY Manager;

-- LIST OF ALL THE EMPLOYEES AND THEIR ASSOCIATED  MANAGERS IF IT EXISTS
SELECT CONCAT(b.LastName, ', ', b.FirstName) AS 'Direct Reporting' ,
CONCAT (a.FirstName, ' ' , a.LastName) AS Manager
FROM Persons b 
LEFT OUTER JOIN persons a ON a.PersonID = b.ReportsTo
ORDER BY Manager;

-- LIST OF MANAGERS HAVING TOT_EMP_REPORTING >=2
SELECT CONCAT (a.FirstName, ' ' , a.LastName) AS Manager,
COUNT(a.PersonID) AS TOT_EMP_REPORTING
FROM Persons b 
LEFT OUTER JOIN persons a ON a.PersonID = b.ReportsTo
GROUP BY 1 HAVING TOT_EMP_REPORTING >=2
ORDER BY 2 DESC;

/* Use MySQL Self Join (CROSS JOIN) for comparing  successive rows salary comparison */
-- SELECT k.ID, l.Name, k.Salary FROM customer_data k,
-- customer_data l WHERE k.Salary < l.Salary;

SELECT distinct p1.PersonID, p1.Salary 
-- CONCAT (p1.FirstName, ' ' , p1.LastName) as EMP_NAME, 
FROM Persons AS p1, Persons p2
WHERE p1.Salary < p2.Salary   -- CROSS-join
order by 2 desc;








