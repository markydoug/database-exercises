USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT first_name, last_name, hire_date
FROM employees
WHERE to_date > CURDATE()
AND hire_date = (
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
);

-- Forgot CURRENT employees so below is the correction
SELECT first_name, last_name, hire_date
FROM employees
JOIN dept_emp USING (emp_no)
WHERE to_date > CURDATE()
AND hire_date = (
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
);

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT title
FROM titles
WHERE emp_no IN (SELECT emp_no
		FROM employees
		WHERE first_name = "Aamod"
		)
	AND to_date > CURDATE();

-- Focus on CURENT employees and list ALL titles
SELECT title
FROM titles
WHERE emp_no IN (SELECT emp_no
		FROM employees
        JOIN dept_emp USING (emp_no)
		WHERE first_name = "Aamod"
        AND to_date > CURDATE()
		);

/* IF YOU WANT EMPLOYEES NAME AND NOT JUST TITLE
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
	ON titles.emp_no = aamod.emp_no;*/

-- 3. How many people in the employees table are no longer working for the company? 
SELECT COUNT(*)
	FROM employees AS e
    WHERE emp_no IN (
		SELECT emp_no
        FROM dept_emp
        WHERE to_date < CURDATE()
	);
-- Give the answer in a comment in your code. 85108
/*************The above doesn't work because it will take out some people IF
They have a to_date below CURDATE() EVEN if they are still working**********/

-- MUST GO WITH BELOW
SELECT COUNT(*)
	FROM employees AS e
    WHERE emp_no NOT IN (
		SELECT emp_no
        FROM dept_emp
        WHERE to_date > CURDATE()
	);
-- Give the answer in a comment in your code. 59900


-- 4. Find all the current department managers that are female. 
SELECT CONCAT(first_name, ' ', last_name) AS Department_Manager
FROM employees 
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE emp_no IN (
		SELECT emp_no
		FROM employees 
		WHERE gender = "F"
	)
	AND to_date > CURDATE()
);
-- List their names in a comment in your code.
-- Isamu Legleitner
-- Karsten Sigstam
-- Leon DasSarma
-- Hilary Kambil

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees 
WHERE emp_no IN (
	SELECT emp_no
    FROM salaries
    WHERE salary > (SELECT AVG(salary) FROM salaries) 
		AND to_date > CURDATE()
);

-- Below code will produce both employee name and current salary
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
	s.salary
FROM employees AS e
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE s.salary > (SELECT AVG(salary) FROM salaries) 
	AND s.to_date > CURDATE();

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 83
SELECT COUNT(*)
FROM salaries
WHERE salary >= (
		(SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE()) 
		- (SELECT STD(salary) FROM salaries WHERE to_date > CURDATE())
		) 
	AND to_date > CURDATE();
-- What percentage of all salaries is this? 0.0346%
SELECT (
		(
			SELECT COUNT(*)
			FROM salaries
			WHERE salary >= ((SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE()) - (SELECT STD(salary) FROM salaries WHERE to_date > CURDATE())) AND 
			to_date > CURDATE()
		) / 
        (
        SELECT COUNT(*)
		FROM salaries
		WHERE to_date > CURDATE()
        ) * 100
	) AS percentage
FROM salaries
GROUP BY percentage;

-- Beautiful All Info Together
SELECT calc.one_std_away AS "Number of Salaries 1 STD Away",
calc.total AS "Total Number of Current Salaries",
(calc.one_std_away / calc.total * 100) as "Percentage of Current Salaries 1 STD Away"
FROM (
	SELECT
		(SELECT COUNT(*)
			FROM (
				SELECT * 
				FROM salaries
				WHERE to_date > CURDATE() 
					AND 
				salary >= ((SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE()) 
				- (SELECT ROUND(STD(salary)) FROM salaries WHERE to_date > CURDATE()))
			) as result)
		AS one_std_away,
		(SELECT COUNT(*) 
			FROM salaries 
			WHERE to_date > CURDATE()
        ) AS total
            ) calc;

-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
-- Highest current salary = 158220
SELECT MAX(salary)
FROM salaries;
-- WHERE to_date > CURDATE();

-- STD of current salary = 17309.95933634675 
SELECT STD(salary)
FROM salaries
WHERE to_date > CURDATE();

-- STD of all salary = 16904.82828800014
SELECT STD(salary)
FROM salaries;

-- Salaries 1 STD from highest current salary = 83 
SELECT COUNT(*)
FROM salaries
WHERE salary >= ((SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE()) - (SELECT STD(salary) FROM salaries WHERE to_date > CURDATE())) AND 
    to_date > CURDATE();
    
-- All current salaries = 240124
SELECT COUNT(*)
FROM salaries
WHERE to_date > CURDATE();



/**************BONUS****************/

-- 1. Find all the department names that currently have female managers.
SELECT dept_name
FROM departments
WHERE dept_no IN (
	SELECT dept_no
	FROM dept_manager
	WHERE emp_no IN (
		SELECT emp_no
		FROM employees 
		WHERE gender = "F"
	)
	AND to_date > CURDATE()
);

-- 2. Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no 
    FROM salaries
    WHERE salary = (SELECT MAX(salary) 
		FROM salaries 
		WHERE to_date > CURDATE()
	)
);

-- 3. Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
WHERE dept_no = (
	SELECT dept_no
	FROM dept_emp
	WHERE emp_no = (
		SELECT emp_no 
		FROM salaries
		WHERE salary = (SELECT MAX(salary) 
			FROM salaries 
			WHERE to_date > CURDATE()
		)
	)
);