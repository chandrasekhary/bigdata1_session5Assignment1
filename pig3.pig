/*

(c) Employee (employee id and employee name) with maximum expense (In case two

employees have same expense, employee with name coming first in dictionary should get

preference)

*/



emp = LOAD 'employee_details.txt' USING PigStorage(',') AS (emp_id:int, emp_name:chararray, emp_salary:int, rating:int);

emp_expanses = LOAD 'employee_expanses.txt'   AS (emp_id:int, expanses:int);

-- dump emp;

-- dump emp_expanses;

emp_join = join emp by emp_id, emp_expanses by emp_id;

-- dump emp_join;

emp_join_group = group emp_join by expanses;

dump emp_join_group;



C = FOREACH emp_join_group {



sort = ORDER emp_join BY emp_name asc;


latest = LIMIT sort 1;

GENERATE FLATTEN(latest);

};

--dump C;


high_expanse = ORDER C by expanses;

dump high_expanse;

describe high_expanse;

high_ex_group = group high_expanse by emp::emp_id;


--dump high_ex_group;




high_ex_group_foreach = FOREACH high_ex_group {



sorts = ORDER high_expanse BY rating desc;


latests = LIMIT sorts 1;

GENERATE FLATTEN(latests);

};

dump high_ex_group_foreach;





high_ex_group_foreach_rating = order high_ex_group_foreach by rating desc;

high_ex_group_foreach_rating_limit = limit high_ex_group_foreach_rating 2;

dump high_ex_group_foreach_rating_limit;




high_ex_group_foreach_rating_limit_details = foreach high_ex_group_foreach_rating_limit generate emp::emp_id,emp::emp_name;

dump high_ex_group_foreach_rating_limit_details;

/*


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

*/




