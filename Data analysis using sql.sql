create database bikes;

use bikes;

select * from bike_sales;

 -- 1 Find the total number of records and total sales amount in the table.
 
 select count(*), sum(resale_price) 
 from bike_sales;
 
 -- 2 Show the average sales amount for each product (or category).
 
 select brand, round(avg(price),2) as average_price ,round(avg(resale_price),2) as average_resale_price, round(avg(price) - avg(resale_price),2) as diff
 from bike_sales 
 group by brand;
 
 -- 3 Find the top 5 products with the highest total sales.
 
select brand, round(sum(resale_price),2) as total 
from bike_sales 
group by brand  
order by total desc 
limit 5;
 
 -- 4 Calculate yearly sales trends (group sales by year and month)
 
select year_of_manufacture, round(sum(resale_price),2)
from bike_sales 
group by year_of_manufacture ;
 
 -- 5 Identify the product (or category) with the lowest total sales.
 
select brand, round(sum(resale_price),2) as total  
from bike_sales
group by brand
order by total
limit 5;
 
 -- 6 Calculate the percentage contribution of each product to overall sales.
 
 select brand, round((sum(resale_price) / (select sum(resale_price) from bike_sales))*100,2) as percentage
 from bike_sales
 group by brand ;
 
 -- 7 Compare sales between two time periods (for example: last year vs this year).

select brand, round(sum(case when  year_of_manufacture =2024 then resale_price else 0 end ),2) as "2024" ,  
round(sum(case when  year_of_manufacture =2023 then resale_price else 0 end ),2) as "2023"
from bike_sales 
group by brand;
 

-- 8 Find days where sales were higher than the overall average sales.
 
select brand, avg(resale_price) 
from bike_sales 
group by brand 
having avg(resale_price)>(select avg(resale_price) from bike_sales) 
limit 1  
 