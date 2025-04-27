--1. Find top 10 highest revenue generating product

select product_id, round(SUM(sale_price),1) as total_revenue
from insight
group by product_id
order by total_revenue desc 
limit 10

--2. Find top 5 highest selling products in region
-- select * from insight
WITH top5 AS(
	select product_id, SUM(sale_price) as total_sales,region,
	RANK() OVER(PARTITION BY region ORDER BY SUM(sale_price) DESC) as rnk
	from insight
	GROUP BY region, product_id -- We need GROUP BY because of SUM
)
select *  from top5 
where rnk <=5

-- 3. Find MoM growth comparison for 2022 and 2023 sales  eg : jan 2022 and jan 2023
WITH CTE AS (
 	select EXTRACT('year' from order_date) as order_year,
	 	   EXTRACT('Month' from order_date) as order_month,
			SUM(sale_price) as sale
	from insight
	GROUP BY order_year, order_month
	--order by order_year, order_month
)
select order_month,
		SUM(CASE WHEN order_year =2022 then sale ELSE 0 END) AS sales_2023,
		SUM(CASE WHEN order_year =2023 then sale ELSE 0 END) AS sales_2023
		FROM cte
Group by order_month
order by order_month

-- For each category which month highest sale

WITH cte AS(
	select category,
		   TO_CHAR(order_date, 'YYYY-MM') AS order_mnt_year,
		   SUM(sale_price) as sales
		   from insight
	group by category,order_mnt_year
),
Seq AS(
select *, 
  ROW_NUMBER() OVER(PARTITION BY category order by sales DESC) AS rankk
  from cte
 )

select * from Seq
where rankk =1

-- Which sub_Category had highest growth by profit 2023  compare to 2022

WITH cte AS (
		select sub_category,
		EXTRACT('year' from order_date) as Year_sales,
		SUM(sale_price) as total_sales
from insight
GROUP BY sub_category, Year_sales
),
sub AS(
  select sub_category,
     SUM(CASE WHEN year_sales =2022 THEN TOTAL_SALES ELSE 0 END) AS sales_2022,
	 SUM(CASE WHEN year_sales =2023 THEN TOTAL_SALES ELSE 0 END) AS sales_2023
FROM CTE
GROUP BY SUB_CATEGORY
ORDER BY SUB_CATEGORY
)
select *, 
Round((sales_2023 - sales_2022) *100 / sales_2022,2) as Growth_Percentage
from sub





