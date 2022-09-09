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
SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%"
GROUP BY last_name;

-- 7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;

-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. 
SELECT DISTINCT CONCAT(
    LOWER(SUBSTR(first_name, 1, 1)), 
    LOWER(SUBSTR(last_name, 1, 4)),
    '_',
    SUBSTR(birth_date, 6, 2),
    SUBSTR(birth_date, 3, 2))
    AS username, COUNT(*)
FROM employees
GROUP BY username;
-- Are there any duplicate usernames? YES
-- BONUS: How many duplicate usernames are there? 13251
SELECT DISTINCT CONCAT(
    LOWER(SUBSTR(first_name, 1, 1)), 
    LOWER(SUBSTR(last_name, 1, 4)),
    '_',
    SUBSTR(birth_date, 6, 2),
    SUBSTR(birth_date, 3, 2))
    AS username, COUNT(*) AS Total
FROM employees
GROUP BY username
HAVING Total > 1;

