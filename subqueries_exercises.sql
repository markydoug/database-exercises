USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = (
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
);

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT CONCAT(
		aamod.first_name, 
		' ', 
		aamod.last_name
	) AS full_name,
    title
FROM (
	SELECT *
	FROM employees
    WHERE first_name = "Aamod"
) AS aamod
JOIN titles
	ON titles.emp_no = aamod.emp_no;

-- 3. How many people in the employees table are no longer working for the company? 
SELECT COUNT(*)
FROM (SELECT e.emp_no
	FROM employees AS e
    JOIN dept_emp AS de
		ON de.emp_no = e.emp_no
    WHERE to_date < CURDATE()
    GROUP BY e.emp_no
    ) AS former;
-- Give the answer in a comment in your code. 85108

-- 4. Find all the current department managers that are female. 
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager
FROM (
	SELECT emp_no
    FROM dept_manager
    WHERE to_date > CURDATE()
    ) AS managers
JOIN employees AS e
	ON e.emp_no = managers.emp_no
WHERE e.gender = "F";
-- List their names in a comment in your code.
-- Isamu Legleitner
-- Karsten Sigstam
-- Leon DasSarma
-- Hilary Kambil

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
	s.salary
FROM employees AS e
JOIN salaries AS ss
	ON s.emp_no = e.emp_no
WHERE s.salary > (SELECT AVG(salary) FROM salaries) 
	AND s.to_date > CURDATE();

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) 

-- What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.



/**************BONUS****************/

-- 1. Find all the department names that currently have female managers.

-- 2. Find the first and last name of the employee with the highest salary.

-- 3. Find the department name that the employee with the highest salary works in.