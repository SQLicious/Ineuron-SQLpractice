/* This file contains queries to practice CASCADING IN SQL
includes queries to :
Add ON DELETE CASCADE constraint
ADD ON UPDATE CASCADE constraint
validate deletion 
validate updation 
*/
CREATE DATABASE DEMO_SYNTAX ;
USE  DEMO_SYNTAX;

CREATE TABLE Employee (
	emp_id int(10) NOT NULL,
	name varchar(40) NOT NULL,
	birthdate date NOT NULL,
	gender varchar(10) NOT NULL,
	hire_date date NOT NULL,
	PRIMARY KEY (emp_id)
);

-- Insert values into the Employee table
INSERT INTO Employee (emp_id, name, birthdate, gender, hire_date) VALUES
	(101, 'Bryan', '1988-08-12', 'M', '2015-08-26'),
	(102, 'Joseph', '1978-05-12', 'M', '2014-10-21'),
	(103, 'Mike', '1984-10-13', 'M', '2017-10-28'),
	(104, 'Daren', '1979-04-11', 'M', '2006-11-01'),
	(105, 'Marie', '1990-02-11', 'F', '2018-10-12');

SELECT * FROM Employee;

/* Creating child table called payment */ 
CREATE TABLE Payment (
payment_id int(10) PRIMARY KEY NOT NULL,
emp_id int(10) NOT NULL,
amount float NOT NULL,
payment_date date NOT NULL,
FOREIGN KEY (emp_id) REFERENCES Employee (emp_id) ON DELETE CASCADE
);
INSERT INTO Payment (payment_id, emp_id, amount, payment_date) VALUES
(301, 101, 1200, '2015-09-15'),
(302, 101, 1200, '2015-09-30'),
(303, 101, 1500, '2015-10-15'),
(304, 101, 1500, '2015-10-30'),
(305, 102, 1800, '2015-09-15'),
(306, 102, 1800, '2015-09-30');

SELECT * FROM payment;

/* Validating Deletion ON CASCADE */
DELETE FROM Employee WHERE emp_id = 102;

/*How to find the affected table by ON DELETE CASCADE action? */
USE information_schema;
SELECT table_name FROM referential_constraints
WHERE constraint_schema = 'demo_syntax'
AND referenced_table_name = 'Employee'
AND delete_rule = 'CASCADE';

-- MySQL ON UPDATE CASCADE
/* First, we need to use the ALTER TABLE statement to add the ON UPDATE CASCADE
clause in the table Payment as below: */

ALTER TABLE Payment ADD CONSTRAINT `payment_fk`
FOREIGN KEY(emp_id) REFERENCES Employee (emp_id) ON UPDATE CASCADE;
DESCRIBE TABLE payment;

/*  ON UPDATE Example - Updating  the id of the employee in the Parent Table, 
will automatically reflect this change in the child table. */

UPDATE Employee SET emp_id = 108 WHERE emp_id = 103;
SELECT * FROM Employee;

-- Create master table that joins the employee and payment tables
DROP TABLE RG_MASTER_EMP_CASCADE;
CREATE TABLE IF NOT EXISTS RG_MASTER_EMP_CASCADE AS 
SELECT E.emp_id,
	   E.name,
       E.birthdate,
       E.gender,
       E.hire_date,
       P.payment_id,
       P.amount,
       P.payment_date
FROM employee AS E 
LEFT OUTER JOIN payment P ON E.emp_id = P.emp_id;
SELECT * FROM RG_MASTER_EMP_CASCADE;


