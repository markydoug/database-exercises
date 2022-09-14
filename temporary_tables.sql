USE mirzakhani_1935;

-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT e.first_name, e.last_name, d.dept_name
FROM employees.employees AS e
JOIN employees.dept_emp AS de USING(emp_no)
JOIN employees.departments AS d USING(dept_no)
WHERE to_date > CURDATE();

-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

-- b. Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- d. What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT CONCAT(e.first_name, ' ', e.last_name), d.dept_name
FROM employees.employees AS e
JOIN employees.dept_emp AS de USING(emp_no)
JOIN employees.departments AS d USING(dept_no);

-- how to drop the temporary table
DROP TABLE IF EXISTS table_name

-- 2. Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE payment_temp AS
SELECT *
FROM sakila.payment;
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
ALTER TABLE payment_temp ADD num_of_cents INT;

UPDATE payment_temp
SET num_of_cents = amount * 100;

ALTER TABLE payment_temp DROP amount;
ALTER TABLE payment_temp ADD amount INT;

UPDATE payment_temp
SET amount = num_of_cents;

ALTER TABLE payment_temp DROP num_of_cents;

-- MORE EFFICIENT WAY
CREATE TEMPORARY TABLE payment_temp AS
SELECT payment_id, customer_id, staff_id, rental_id, amount * 100 AS amount
FROM FROM sakila.payment;

ALTER TABLE payment_temp MODIFY amount INT NOT NULL;

-- 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
USE mirzakhani_1935;

CREATE TEMPORARY TABLE avg_salaries_by_dept AS
SELECT d.dept_name,
	AVG(salary) AS dept_current_average_salary
FROM employees.dept_emp AS de
JOIN employees.salaries AS s ON de.emp_no = s.emp_no
	AND de.to_date > CURDATE()
	AND s.to_date > CURDATE()
JOIN employees.departments AS d ON de.dept_no = d.dept_no
GROUP BY d.dept_name;

ALTER TABLE avg_salaries_by_dept ADD current_avg DECIMAL(10,2);
ALTER TABLE avg_salaries_by_dept ADD current_std DECIMAL(10,2);
ALTER TABLE avg_salaries_by_dept ADD zscore DECIMAL(10,2);

UPDATE avg_salaries_by_dept
SET current_avg = (SELECT AVG(s.salary) FROM employees.salaries as s WHERE s.to_date > CURDATE());

UPDATE avg_salaries_by_dept
SET current_std = (SELECT STD(s.salary) FROM employees.salaries as s WHERE s.to_date > CURDATE());

UPDATE avg_salaries_by_dept
SET zscore = ((dept_current_average_salary - current_avg)/current_std);

SELECT * FROM avg_salaries_by_dept
ORDER BY zscore DESC;
