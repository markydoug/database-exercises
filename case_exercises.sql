USE employees

-- 1. Write a query that returns all employees, their department number, 
-- their start date, their end date, and a new column 'is_current_employee'
-- that is a 1 if the employee is still with the company and 0 if not.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, dept_no, from_date, to_date,
	CASE
		WHEN emp_no IN (select emp_no FROM dept_emp WHERE to_date > CURDATE()) THEN 1
		ELSE 0
    END AS is_current_employee
FROM employees AS e
JOIN dept_emp USING(emp_no);

--Use IF to do the same thing
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, dept_no, from_date, to_date,
	IF(emp_no  IN (select emp_no FROM dept_emp WHERE to_date > CURDATE()),1,0)
	AS is_current_employee
FROM employees AS e
JOIN dept_emp USING(emp_no);

-- 2. Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending 
-- on the first letter of their last name.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
	CASE 
		WHEN SUBSTR(e.last_name, 1,1) IN ('A', 'B','C','D','E','F','G','H') THEN 'A-H'
        WHEN SUBSTR(e.last_name, 1,1) IN ('I', 'J','K','L','M','N','O','P','Q') THEN 'I-Q'
        WHEN SUBSTR(e.last_name, 1,1) IN ('R', 'S','T','U','V','W','X','Y', 'Z') THEN 'R-Z'
		ELSE 'ERROR'
    END AS alpha_group
FROM employees AS e;

-- 3. How many employees (current or previous) were born in each decade?
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
	CASE
		WHEN e.birth_date LIKE '195%' THEN '50s'
        WHEN e.birth_date LIKE '196%'THEN '60s'
		ELSE 'ERROR'
    END AS birth_decade
FROM employees AS e;

-- 4.What is the current average salary for each of the following department 
-- groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT 
   CASE
       WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
       WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
       ELSE dept_name
   END AS dept_group,
   ROUND(AVG(salary),2) AS Average_Salary
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
WHERE salaries.to_date > CURDATE() AND demp_emp.to_date > CURDATE()
GROUP BY dept_group;