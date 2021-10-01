Joining both the tables

create table exim_india as (
select e.year,e.Commodity , e.country , e.value , i.value 
from exports e
left join
imports i
on 
e.Commodity=i.Commodity
and
e.country=i.country
and
e.year=i.year) ;



Analysis


1. getting the 3 countries who have highest export and import with india

code : select country , sum(value) as total from exports
       group by country
       order by total desc
       limit 3 ;

       select country , sum(value) as total from imports
       group by country
       order by total desc
       limit 3 ;
       
       
2. getting which product is exported and imported the most and the least, in 8 years

Export -
code: select Commodity , sum(value) as total from exports
      group by Commodity
      order by total desc
      limit 10;

      select Commodity , sum(value) as total from exports
      group by Commodity
      order by total
      limit 10;
      
Import - 
code : select Commodity , sum(value) as total from imports
       group by Commodity
       order by total desc
       limit 10;

       select Commodity , sum(value) as total from imports
       group by Commodity
       order by total
       limit 10;      
      
      
3. getting yearly exports and imports

code : select year , sum(value) as total from exports
       group by year
       order by year ;

       select year , sum(value) as total from imports
       group by year
       order by year ;


4. In year 2011 and 2018 which commodity were in the top list for export and import to see the changes

Export - 

select year , country , Commodity , total from (
select year , Commodity , country , sum(value) as total
from exports
group by year , Commodity , country
order by total desc) year_top
where year = '2011'
limit 5 ;

select year , country , Commodity , total from (
select year , Commodity , country , sum(value) as total
from exports
group by year , Commodity , country
order by total desc) year_top
where year = '2018'
limit 5 ;


Imports - 

select year , country , Commodity , total from (
select year , Commodity , country , sum(value) as total
from imports
group by year , Commodity , country
order by total desc) year_top
where year = '2011'
limit 5 ;

select year , country , Commodity , total from (
select year , Commodity , country , sum(value) as total
from imports
group by year , Commodity , country
order by total desc) year_top
where year = '2018'
limit 5 ;


5. net exports for all the year

select exim_india.year , sum(nvl(exim_india.net_export,0)) from (
select e.year , trim(nvl(e.value,0)) , trim(nvl(i.value,0)) ,trim(nvl(e.value,0))-trim(nvl(i.value,0)) as net_export
from exports e
left join
imports i
on 
e.Commodity=i.Commodity
and
e.country=i.country
and
e.year=i.year ) exim_india 
group by year;


6. Countries which have highest net export with india

code - 
select exim_india.country , sum(nvl(exim_india.net_export,0)) as total from (
select e.country , trim(nvl(e.value,0)) , trim(nvl(i.value,0)) ,trim(nvl(e.value,0))-trim(nvl(i.value,0)) as net_export
from exports e
left join
imports i
on 
e.Commodity=i.Commodity
and
e.country=i.country
and
e.year=i.year) exim_india
group by exim_india.country
order by total desc
limit 5;


7. Commodities having highest net exports according to India's recorded data
 
code - 
select exim_india.Commodity , sum(nvl(exim_india.net_export,0)) as total from (
select e.Commodity , trim(nvl(e.value,0)) , trim(nvl(i.value,0)) ,trim(nvl(e.value,0))-trim(nvl(i.value,0)) as net_export
from exports e
left join
imports i
on 
e.Commodity=i.Commodity
and
e.country=i.country
and
e.year=i.year) exim_india
group by exim_india.Commodity
order by total desc
limit 5;

