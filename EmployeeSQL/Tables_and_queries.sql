-- departments.csv
DROP TABLE IF EXISTS departments;
CREATE TABLE departments(
	dept_no VARCHAR(5) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(30)
);

-- employees.csv
DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	emp_no INT NOT NULL PRIMARY KEY,
	birth_date DATE,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(1),
	hire_date DATE NOT NULL
);

-- dept_emp.csv
DROP TABLE IF EXISTS dept_employees;
CREATE TABLE dept_employees(
	emp_no INT NOT NULL,
	FOREIGN KEY emp_no REFERENCES employees(emp_no),
	dept_no VARCHAR(5) NOT NULL,
	FOREIGN KEY dept_no REFERENCES departments(dept_no),
	from_date DATE NOT NULL,
	to_date DATE,
	PRIMARY KEY (emp_no,dept_no)
);

-- dept_manager.csv
DROP TABLE IF EXISTS dept_managers;
CREATE TABLE dept_managers(
	dept_no VARCHAR(5) NOT NULL,
	FOREIGN KEY dept_no REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY emp_no REFERENCES employees(emp_no),
	from_date DATE NOT NULL,
	to_date DATE,
	PRIMARY KEY (emp_no,dept_no)
);



-- salaries.csv
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, salary)
);

-- titles.csv
DROP TABLE IF EXISTS titles;
CREATE TABLE titles(
	emp_no INT NOT NULL,
	title VARCHAR(30) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no,title)
);

SELECT * FROM titles;

-- 1. List the following details of each employee: 
-- employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no;

-- 2. List employees who were hired in 1986.
SELECT *
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, e.hire_date, m.to_date
FROM dept_managers m
INNER JOIN departments dONon m.dept_no = d.dept_no
INNER JOIN employees e ON m.emp_no = e.emp_no;

-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name as department
FROM dept_employees de
INNER JOIN employees e ON de.emp_no = e.emp_no
INNER JOIN departments d ON de.dept_no=d.dept_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name as department
FROM dept_employees de
INNER JOIN employees e ON de.emp_no = e.emp_no
INNER JOIN departments d ON de.dept_no=d.dept_no
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name as department
FROM dept_employees de
INNER JOIN employees e ON de.emp_no = e.emp_no
INNER JOIN departments d ON de.dept_no=d.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, count(*) AS count
FROM employees
GROUP BY last_name
ORDER BY 2 DESC;

-- BONUS
SELECT title, salary 
FROM titles t 
INNER JOIN salaries s ON t.emp_no = s.emp_no;

