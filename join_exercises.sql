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


-- 5. Find the current salary of all current managers.

-- 6. Find the number of current employees in each department.

-- 7. Which department has the highest average salary? Hint: Use current not historic information.

-- 8. Who is the highest paid employee in the Marketing department?

-- 9. Which current department manager has the highest salary?

-- 10. Determine the average salary for each department. Use all salary information and round your results.


/**************BONUS****************/
-- 11. Find the names of all current employees, their department name, and their current manager's name.

-- 12. Who is the highest paid employee within each department.

