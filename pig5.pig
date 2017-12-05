/*


(e) List of employees (employee id and employee name) having no entry in employee_expenses

*/


emp = LOAD 'employee_details.txt' USING PigStorage(',') AS (emp_id:int, emp_name:chararray, emp_salary:int, rating:int);

emp_expanses = LOAD 'employee_expanses.txt'   AS (emp_id:int, expanses:int);


emp_join = join emp by emp_id left outer, emp_expanses by emp_id;

--dump emp_join;

emp_join_filter = filter emp_join by emp_expanses::emp_id is null;

--dump emp_join_filter;

--describe emp_join_filter;

emp_join_foreach = foreach emp_join_filter generate emp::emp_id,emp::emp_name;

 dump emp_join_foreach;
