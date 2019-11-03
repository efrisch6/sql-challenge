# Modify this code to update the DB schema diagram.
# To reset the sample schema, replace everything with
# two dots ('..' - without quotes).


departments
-
dept_no PK VARCHAR(5), FK >- dept_emp.dept_no
dept_name VARCHAR(30)

dept_emp
-
emp_no PK INT, FK >- empolyees.emp_no
dept_no PK VARCHAR(5), FK >- dept_managers.dept_no
from_date DATE,
to_date DATE


dept_managers
-
dept_no PK VARCHAR(5), FK >- departments.dept_no
emp_no PK INT, FK >- titles.emp_no
from_date DATE,
to_date DATE

empolyees
-
emp_no PK INT, FK >- dept_managers.emp_no
birth_date DATE,
first_name VARCHAR(30),
last_name VARCHAR(30),
gender VARCHAR(1),
hire_date DATE

salaries
-
emp_no PK INT, FK >- empolyees.emp_no
salary PK INT,
from_date DATE,
to_date DATE



titles
-
emp_no PK INT,
title PK VARCHAR(30),
from_date DATE,
to_date DATE
