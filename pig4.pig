/*


(d) List of employees (employee id and employee name) having entries in employee_expenses

file.

*/


emp = LOAD 'employee_details.txt' USING PigStorage(',') AS (emp_id:int, emp_name:chararray, emp_salary:int, rating:int);

emp_expanses = LOAD 'employee_expanses.txt'   AS (emp_id:int, expanses:int);


emp_join = join emp by emp_id, emp_expanses by emp_id;

emp_join_foreach = foreach emp_join generate emp::emp_id,emp::emp_name;

dump emp_join_foreach;
