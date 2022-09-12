/**********Join Example Database************/

-- Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT *
FROM users;

SELECT *
FROM roles;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name,
	COUNT(users.name)
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.name;

/************Employees Database**************/
USE employees;

-- 2. Write a query that shows each department along with the name of the current manager for that department.
SELECT d.dept_name AS Department_Name, 
	CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager
FROM departments AS d
JOIN dept_manager AS dm
    ON dm.dept_no = d.dept_no
JOIN employees AS e
    ON e.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE();

-- 3. Find the name of all departments currently managed by women.
SELECT d.dept_name AS Department_Name, 
	CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager
FROM departments AS d
JOIN dept_manager AS dm
    ON dm.dept_no = d.dept_no
JOIN employees AS e
    ON e.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE()
    AND e.gender = 'F';

-- 4. Find the current titles of employees currently working in the Customer Service department.
SELECT t.title, 
    COUNT(de.emp_no) AS Count
FROM titles as t
JOIN employees AS e
    ON e.emp_no = t.emp_no
JOIN dept_emp AS de
	ON de.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE t.to_date > CURDATE()
	AND	de.to_date > CURDATE()
	AND d.dept_name = "Customer Service"
GROUP BY t.title
ORDER BY t.title;

-- 5. Find the current salary of all current managers.
SELECT d.dept_name AS Department_Name, 
	CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager,
	s.salary
FROM departments AS d
JOIN dept_manager AS dm
    ON dm.dept_no = d.dept_no
JOIN employees AS e
    ON e.emp_no = dm.emp_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE dm.to_date > CURDATE()
	AND s.to_date > CURDATE()
ORDER BY Department_Name;

-- 6. Find the number of current employees in each department.
SELECT d.dept_no,
	d.dept_name, 
    COUNT(de.emp_no) AS num_employees
FROM employees AS e
JOIN dept_emp AS de
	ON de.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE de.to_date > CURDATE()
GROUP BY d.dept_no, d.dept_name
ORDER BY d.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
SELECT d.dept_name AS department_name, 
	AVG(s.salary) AS average_salary
FROM departments AS d
JOIN dept_emp AS de
    ON de.dept_no = d.dept_no
JOIN employees AS e
    ON e.emp_no = de.emp_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE s.to_date > CURDATE()
	AND de.to_date > CURDATE()
GROUP BY Department_Name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
SELECT e.first_name,
	e.last_name
FROM employees AS e
JOIN dept_emp AS de
    ON de.emp_no = e.emp_no
JOIN departments AS d
    ON d.dept_no = de.dept_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE s.to_date > CURDATE()
	AND d.dept_name = "Marketing"
ORDER BY s.salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?
SELECT  e.first_name, 
    e.last_name,
	s.salary,
    d.dept_name
FROM departments AS d
JOIN dept_manager AS dm
    ON dm.dept_no = d.dept_no
JOIN employees AS e
    ON e.emp_no = dm.emp_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE dm.to_date > CURDATE()
	AND s.to_date > CURDATE()
ORDER BY s.salary DESC
LIMIT 1;

-- 10. Determine the average salary for each department. Use all salary information and round your results.
SELECT d.dept_name AS department_name, 
	ROUND(AVG(s.salary),0) AS average_salary
FROM departments AS d
JOIN dept_emp AS de
    ON de.dept_no = d.dept_no
JOIN employees AS e
    ON e.emp_no = de.emp_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
GROUP BY Department_Name
ORDER BY average_salary DESC;

/**************BONUS****************/
-- 11. Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(
	em.first_name, 
    " ",
    em.last_name
    ) AS Employee_Name,
	d.dept_name AS Department_Name, 
	CONCAT(
		e.first_name, 
		' ', 
		e.last_name
	) AS Department_Manager
FROM departments AS d
JOIN dept_manager AS dm
    ON dm.dept_no = d.dept_no
JOIN employees AS e
    ON e.emp_no = dm.emp_no
LEFT JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
LEFT JOIN employees AS em
	ON de.emp_no = em.emp_no
WHERE de.to_date > CURDATE()
	AND dm.to_date > CURDATE();  

-- 12. Who is the highest paid employee within each department.

SELECT d.dept_name AS Department_Name,
	MAX(s.salary)
FROM departments AS d
JOIN dept_emp AS de
    ON de.dept_no = d.dept_no
JOIN employees AS e
    ON e.emp_no = de.emp_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE de.to_date > CURDATE()
	AND s.to_date > CURDATE()
GROUP BY d.dept_name;

-- missing employee names