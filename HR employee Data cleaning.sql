-- Data cleaning
-- changing the field name of the employee ID --
alter table hr
change column ï»¿id emp_id varchar(20)NUll;

-- checking the data type of fields --
describe hr;

select birthdate from hr;
select hire_date from hr;


set sql_safe_updates =0;

-- Correcting and changing the date format for birthdate
update hr
set birthdate = case
  when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
  when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
  else null
End;

-- changing the data type from to date data type for birthdate
alter table hr
modify column birthdate Date;

-- Correcting and changing the date format for hire_date
update hr
set hire_date = case
  when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
  when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
  else null
End;

-- changing the data type from to date data type for hire_date
alter table hr
modify column hire_date date;

-- Correcting and changing the date format for termdate
update hr
  set termdate=date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
  where termdate is not null and termdate != ' ';
  
-- changing the data type from to date data type for termdate
Alter table hr
modify column termdate date;

-- creating a new column for age
alter table hr
add column age int;

-- Creating rows for the age column
Update hr
set age = timestampdiff(year,birthdate,curdate());

-- checking for ages less or equal to 18 as required for analysis
SELECT count(*) FROM nproject.hr
where age < '18';

-- Turning on the sql safe updates
set sql_safe_updates =1;