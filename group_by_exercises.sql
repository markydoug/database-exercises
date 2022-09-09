USE employees

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. 
SELECT DISTINCT title
FROM titles;
-- How many unique titles have there ever been? 7
-- Senior Engineer
-- Staff
-- Engineer
-- Senior Staff
-- Assistant Engineer
-- Technique Leader
-- Manager

-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name
FROM employees
WHERE last_name LIKE "E%e"
GROUP BY last_name;

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE "E%e"
GROUP BY last_name, first_name;

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. 
SELECT last_name
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%"
GROUP BY last_name;
-- Include those names in a comment in your sql code.
-- Chleq
-- Lindqvist
-- Qiwen

-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, 
    COUNT(last_name)
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%"
GROUP BY last_name;

-- 7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
-- Group by gender and first name
SELECT first_name, gender, 
    COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;

-- Group ONLY by gender
SELECT gender, 
    COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. 
SELECT 
    LOWER(
        CONCAT(
            SUBSTR(first_name, 1, 1), 
            SUBSTR(last_name, 1, 4),
            '_',
            SUBSTR(birth_date, 6, 2),
            SUBSTR(birth_date, 3, 2)
            ) 
        ) AS username, COUNT(*)
FROM employees
GROUP BY username;
-- Are there any duplicate usernames? YES
-- BONUS: How many duplicate usernames are there? 13251
SELECT 
    LOWER(
        CONCAT(
            SUBSTR(first_name, 1, 1), 
            SUBSTR(last_name, 1, 4),
            '_',
            SUBSTR(birth_date, 6, 2),
            SUBSTR(birth_date, 3, 2)
            ) 
        ) AS username, COUNT(*)
FROM employees
GROUP BY username;
HAVING Total > 1;

/****************Bonus*****************/
-- Determine the historic average salary for each employee. 
SELECT emp_no, 
    ROUND(AVG(salary),2)
FROM salaries
GROUP BY emp_no;

-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
SELECT dept_no, 
    COUNT(emp_no)
FROM dept_emp
WHERE to_date > CURDATE()
GROUP BY dept_no;

-- Determine how many different salaries each employee has had. This includes both historic and current.
SELECT emp_no,
	COUNT(salary)
FROM salaries
GROUP BY emp_no;

-- Find the maximum salary for each employee.
SELECT emp_no,
	MAX(salary) AS Maximum_Salary
FROM salaries
GROUP BY emp_no;

-- Find the minimum salary for each employee.
SELECT emp_no,
	MIN(salary) AS Minimum_Salary
FROM salaries
GROUP BY emp_no;

-- Find the standard deviation of salaries for each employee.
SELECT emp_no,
	STDDEV(salary) AS Standard_Deviation_Salary
FROM salaries
GROUP BY emp_no;

-- Now find the max salary for each employee where that max salary is greater than $150,000.
SELECT emp_no,
	MAX(salary) AS Maximum_Salary
FROM salaries
GROUP BY emp_no
HAVING Maximum_Salary > 150000;

-- Find the average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no,
	AVG(salary) AS Average_Salary
FROM salaries
GROUP BY emp_no
HAVING Average_Salary BETWEEN 80000 AND 90000;