-- questions required to be answered --
-- 1. what is the gender breakdown of employees in the company --
select gender, count(*) as Gender_breakdown
from hr
where age >=18 and termdate = '0000-00-00'
group by gender;

-- 2. what is the race/ethnicity breakdown of employees in the company --
select race, count(*)
from hr
where age >=18 and termdate = '0000-00-00'
group by race
order by count(*)desc;

-- 3. what is the age distribution of employees in the company --
select
	case 
	when age >= 18 and age <=28 then '18-28'
    when age >= 29 and age <=39 then '29-39'
    when age >= 40 and age <=50 then '40-50'
    when age >= 51 and age <=60 then '51-60'
    else '60+'
    end as age_group,gender,
    count(*) Distribution 
    from hr
    where age >=18 and termdate = '0000-00-00'
    group by age_group,gender
    order by age_group, gender;
    
-- 4. How many employees work at headquarters versus remote locations --
select location, count(*) as Distribution
from hr
 where age >=18 and termdate = '0000-00-00'
 group by location;
 
 -- 5. what is the average lenght of employement for employees who have been terminated --
 select
	round(avg(datediff(termdate, hire_date))/365,0) as Avg_emp_lenght
    from hr
    where termdate<=curdate() and age >=18 and termdate <> '0000-00-00';
    
 -- 6. How does the gender distribution vary across department and job titles --
 select department,gender, count(*) as Distribution
 from hr
  where age >=18 and termdate = '0000-00-00'
  group by department, gender
  order by department;
  
   -- 7. What is the distribution of job titles across the company --
   select jobtitle, count(*) as Distribution
   from hr
    where age >=18 and termdate = '0000-00-00'
    group by jobtitle
    order by jobtitle;
    
    -- 8. which department has the highest turnover rate --
    Select department, 
		total_count, 
		terminated_count, 
		terminated_count/total_count As termination_rate 
	From (
		Select department,
        count(*) as total_count,
         sum(case when termdate <> '0000-00-00' and termdate <= curdate() Then 1 else 0 end) as terminated_count
         From hr
         where age>=18
         group by department
         ) as subquery
	Order by termination_rate desc;
    
-- 9. what is the distribution of employees across locations by city and state?
select location_state, count(*)
from hr
where age >=18 and termdate = '0000-00-00'
group by location_state
order by count(*)desc;

-- 10. How has the company's employee count changed over time based on the hire and term dates --
Select 
	year,
    hires,
    terminations,
    hires - terminations as net_change,
    round((hires - terminations)/hires*100,2) as net_change_percent
From(
	Select
		 year(hire_date) as year,
         count(*) as hires,
         sum(case when termdate <> '0000-00-00' and termdate <=curdate() Then 1 else 0 end) as terminations
         from hr
         where age>= 18
         group by year (hire_date)
         ) as subquery
	order by year;
    
-- 11. what is the tenure distribution for eac department --
SELECT
    department,
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365), 0) AS avg_tenure_years
FROM hr
WHERE termdate <= CURDATE() AND age >= 18 AND termdate <> '0000-00-00'
GROUP BY department;