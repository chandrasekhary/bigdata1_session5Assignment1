/*

Top 3 employees (employee id and employee name) with highest salary, whose employee id

is an odd number. (In case two employees have same salary, employee with name coming first

in dictionary should get preference)


*/


emp = LOAD 'employee_details.txt' USING PigStorage(',') AS (emp_id:int, emp_name:chararray, emp_salary:int, rating:int);

group_salary = group emp by emp_salary ;

C = FOREACH group_salary{

odd_salary = filter emp by emp_id % 2 == 1;

sort = ORDER odd_salary BY emp_name asc;


latest = LIMIT sort 1;

GENERATE FLATTEN(latest);

};

--dump C;


high_salary = ORDER C by emp_salary desc;

--dump high_salary;
high_salary_2 = limit high_salary 3;

dump high_salary_2;





