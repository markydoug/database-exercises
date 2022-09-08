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