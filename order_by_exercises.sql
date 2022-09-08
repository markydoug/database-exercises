/************* Contents from previous lesson***************/
USE employees;

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT COUNT(emp_no)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- Result: 709 

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
SELECT COUNT(emp_no)
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
-- Result: 709, just like Q2

-- 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
SELECT COUNT(emp_no)
FROM employees
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = "M";
-- Result: 441

-- 5. Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
SELECT COUNT(emp_no)
FROM employees
WHERE last_name LIKE "E%";
-- Results: 7330 

-- 6. Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. 
SELECT COUNT(emp_no)
FROM employees
WHERE last_name LIKE "E%" OR last_name LIKE "%e";
-- Results: 30723

-- How many employees have a last name that ends with E, but does not start with E?
SELECT COUNT(emp_no)
FROM employees
WHERE last_name NOT LIKE "E%" AND last_name LIKE "%e";
-- Results: 23393

-- 7. Find all current or previous employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. 
SELECT COUNT(emp_no)
FROM employees
WHERE last_name LIKE "E%" AND last_name LIKE "%e";
-- Results: 899

-- How many employees' last names end with E, regardless of whether they start with E?
SELECT COUNT(emp_no)
FROM employees
WHERE last_name LIKE "%e";
-- Results: 24292

-- 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
SELECT count(emp_no)
FROM employees
WHERE hire_date LIKE "199%";
-- Results: 135214

-- 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
SELECT count(emp_no)
FROM employees
WHERE birth_date LIKE "%-12-25";
-- Results: 842

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
SELECT count(emp_no)
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%-12-25";
--Results: 362

-- 11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
SELECT count(emp_no)
FROM employees
WHERE last_name LIKE "%q%";
-- Results: 1873

-- 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
SELECT count(emp_no)
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%";
-- Results: 547


/***************** New Lesson *******************/

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
-- What was the first and last name in the first row of the results? 
-- Irena, Reutenauer
-- What was the first and last name of the last person in the table?
--Irena, Reutenauer

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
