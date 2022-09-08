USE employees;

-- 2. List the first 10 distinct last name sorted in descending order.
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name
LIMIT 10;

-- 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records.
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%-12-25"
ORDER BY hire_date
LIMIT 5;
-- Write a comment in your code that lists the five names of the employees returned.
/* Alselm,Cappello
Utz,Mandell
Bouchung,Schreiter
Baocai,Kushner
Petter,Stroustrup*/ 

-- 4. Update the query to find the tenth page of results.