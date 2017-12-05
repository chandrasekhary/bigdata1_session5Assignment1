emp = LOAD 'employee_details.txt' USING PigStorage(',') AS (emp_id:int, emp_name:chararray, emp_salary:int, rating:int);

group_rating = group emp by rating ;

C = FOREACH group_rating{

sort = ORDER emp BY emp_name asc;

latest = LIMIT sort 1;

GENERATE FLATTEN(latest);

};

dump C;


high_rating = ORDER C by rating desc;

high_rating_2 = limit high_rating 5;

dump high_rating_2;





