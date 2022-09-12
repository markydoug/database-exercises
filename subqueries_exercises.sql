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

-- Give the answer in a comment in your code.

-- 4. Find all the current department managers that are female. 
SELECT d.dept_name AS Department_Name, 
	CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager
FROM departments AS d
JOIN dept_manager AS dm
    ON dm.dept_no = d.dept_no
JOIN employees AS e
    ON e.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE()
    AND e.gender = 'F';
-- List their names in a comment in your code.

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.



/**************BONUS****************/

-- 1. Find all the department names that currently have female managers.

-- 2. Find the first and last name of the employee with the highest salary.

-- 3. Find the department name that the employee with the highest salary works in.