create table departments (
	dept_no varchar primary key,
	dept_name varchar unique not null
);

create table titles (
	title_id varchar primary key,
	title varchar
);

create table employees (
	emp_no integer primary key, 
	emp_title_id varchar references titles(title_id),
	foreign key (emp_title_id) references titles(title_id),
	birth_date date,
	first_name varchar,
	last_name varchar,
	sex varchar, 
	hire_date date
);

create table dept_emp (
	emp_no integer references employees(emp_no),
	dept_no varchar references departments(dept_no),
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no)
);

create table dept_managers (
	dept_no varchar references departments(dept_no),
	emp_no integer references employees(emp_no),
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
);

create table salaries (
	emp_no integer references employees(emp_no),
	salary integer
);


------------------------------------------------------------------------------------
-- 1. List the employee number, last name, first name, sex, and salary of each employee.

SELECT  emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM employees as emp
    JOIN salaries as sal
    ON emp.emp_no = sal.emp_no
ORDER BY emp.emp_no;

------------------------------------------------------------------------------------
-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.

select first_name, last_name, hire_date
from employees
where hire_date >= '1986-01-01' 
	and hire_date < '1987-01-01'
order by hire_date ASC;

------------------------------------------------------------------------------------
-- 3. List the manager of each department along with their department number, department name, 
-------employee number, last name, and first name.

--add employees and dept_manager table
select emp.emp_no, emp.first_name, emp.last_name, managers.dept_no, departments.dept_name
from employees as emp
	join dept_managers as managers
	on emp.emp_no = managers.emp_no
	--add departments to dept_manager table
	join departments as departments
	on managers.dept_no = departments.dept_no
order by departments.dept_no asc, emp.first_name asc;

------------------------------------------------------------------------------------
-- 4. List the department number for each employee along with that employee’s employee number, 
------last name, first name, and department name.

select emp.emp_no, emp.first_name, emp.last_name, dept_emp.dept_no, departments.dept_name
from employees as emp
	join dept_emp as dept_emp
	on emp.emp_no = dept_emp.emp_no
	--add departments to dept_emp table
	join departments as departments
	on dept_emp.dept_no = departments.dept_no
order by departments.dept_no asc, emp.first_name asc;

------------------------------------------------------------------------------------
-- 5. List first name, last name, and sex of each employee whose first name is Hercules 
------and whose last name begins with the letter B.

select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%'
order by last_name ASC;


------------------------------------------------------------------------------------
-- 6. List each employee in the Sales department, including their employee number, last name, and first name.

select emp.emp_no, emp.first_name, emp.last_name
from employees as emp
	join dept_emp as dept_emp
	on emp.emp_no = dept_emp.emp_no
	join departments as departments
	on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales'
order by  emp.first_name asc, emp.emp_no asc;

--To check the full rows with the department id and name of sales column:

select emp.emp_no, emp.first_name, emp.last_name, departments.dept_no, departments.dept_name
from employees as emp
	join dept_emp as dept_emp
	on emp.emp_no = dept_emp.emp_no
	join departments as departments
	on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales'
order by  emp.first_name asc, emp.emp_no asc;

------------------------------------------------------------------------------------
-- 7. List each employee in the Sales and Development departments, including their employee number, 
----last name, first name, and department name.

select emp.emp_no, emp.first_name, emp.last_name, departments.dept_name
from employees as emp
	join dept_emp as dept_emp
	on emp.emp_no = dept_emp.emp_no
	join departments as departments
	on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales'
or departments.dept_name = 'Development'
order by departments.dept_name asc, emp.first_name asc, emp.emp_no asc;

------------------------------------------------------------------------------------
-- 8. List the frequency counts, in descending order, of all the employee last names 
------(that is, how many employees share each last name).

select emp.last_name, count(*)
from employees as emp
group by emp.last_name
order by count desc;





