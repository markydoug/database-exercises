USE employees;

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
-- What was the first and last name in the first row of the results? 
-- Irena, Reutenauer
-- What was the first and last name of the last person in the table?
-- Vidya, Simmen

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;
-- What was the first and last name in the first row of the results? 
-- Irena, Acton
-- What was the first and last name of the last person in the table?
-- Vidya, Zweizig

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
-- What was the first and last name in the first row of the results? 
-- Irena, Acton
-- What was the first and last name of the last person in the table?
-- Maya, Zyda

-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
SELECT *
FROM employees
WHERE last_name LIKE "E%" AND last_name LIKE "%e"
ORDER BY emp_no;
-- Number of employees returned: 899
-- First employee number and their first and last name: 10021, Ramzi, Erde
-- Last employee number with their first and last name: 499648, Tadahiro, Erde

-- 6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. 
SELECT *
FROM employees
WHERE last_name LIKE "E%" AND last_name LIKE "%e"
ORDER BY hire_date DESC;
-- Number of employees returned: 899
-- Name of the newest employee: 67892, 1958-08-15, Teiji, Eldridge, M, 1999-11-27
-- Name of the oldest employee: 233488, 1961-12-16, Sergi, Erde, F, 1985-02-02

-- 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result.
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%-12-25"
ORDER BY birth_date, hire_date DESC;
-- Number of employees returned: 362
-- Name of the oldest employee who was hired last: Khun, Bernini
-- Name of the youngest employee who was hired first: Douadi, Pettis
