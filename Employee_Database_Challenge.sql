

-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
	);
	
	CREATE TABLE salaries (
		emp_no INT NOT NULL,
		salary INT NOT NULL,
		from_date DATE NOT NULL,
		to_date DATE NOT NULL,
		FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
		PRIMARY KEY (emp_no)
	);
	
	CREATE TABLE dept_emp (
		emp_no INT NOT NULL,
		dept_no VARCHAR(4) NOT NULL,
		from_date DATE NOT NULL,
		to_date DATE NOT NULL,
		FOReIGN KEY (emp_no) REFERENCES employees (emp_no),
		FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
		PRIMARY KEY (emp_no, dept_no)
	);
	
	DROP TABLE titles
	
	CREATE TABLE titles (
		emp_no INT NOT NULL,
		title VARCHAR NOT NULL,
		from_date DATE NOT NULL,
		to_date DATE NOT NULL,
		FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
		PRIMARY KEY (emp_no, title, from_date)
	);
	
	SELECT * FROM dept_emp
	
	-- Retirement eligibility
	SELECT first_name, last_name
	FROM employees
	WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	
	-- Number of employees retiring
	SELECT COUNT(first_name)
	FROM EMPLOYEES
	WHERE (birth_date BETWEEN '19520101' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- joining departments and dept_manager tables
SELECT d.dept_name,
	de.emp_no,
	de.from_date,
	de.to_date
FROM departments AS d
INNER JOIN dept_emp AS de
ON d.dept_no = de.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Current employees eligible for retirement
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_retirement_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no, e.first_name, e.last_name, e.gender, 
	s.salary, 
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT dm.dept_no, 
	d.dept_name, 
	dm.emp_no,
	ce.last_name, ce.first_name, 
	dm.from_date, dm.to_date 
INTO managment_info
FROM dept_manager as dm
	INNER JOIN current_emp as ce
		ON (dm.emp_no = ce.emp_no)
	INNER JOIN departments as d
		ON (dm.dept_no = d.dept_no);
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	Inner JOIN departments AS d
		ON (de.dept_no = d.dept_no);

-- Query for Sales team reitrement info
SELECT * FROM dept_info
WHERE (dept_info.dept_name IN ('Sales', 'Development'));


-- Deliverable 1
SELECT e.emp_no, e.first_name, e.last_name,
		ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as e
	INNER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no,
r.first_name,
r.last_name,
r.title

INTO unique_titles
FROM retirement_titles as r
ORDER BY r.emp_no ASC, r.to_date DESC;

-- Retrieve # of employees by most recent job title who are about to retire
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
-- LEFT JOIN dept_emp as de
-- ON ce.emp_no = de.emp_no
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;



