USe retail_sales

-- Data Cleaning

Alter Table sales
rename column ï»¿transactions_id to transactions_id;

Alter Table sales
rename column quantiy to quantity;

-- Null Values

Select *
From sales
Where transactions_id Is Null
OR
sale_date Is Null
Or	
sale_time Is Null	
Or 
customer_id Is Null
Or 
gender Is Null
Or
age Is Null
or
category Is Null
Or	
quantiy Is Null
Or	
price_per_unit	Is Null
Or
cogs Is Null
Or
total_sale Is Null ;



-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

Select * 
From sales
where sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

Select * 
From sales
Where category = 'Clothing'
And Date_Format(sale_date,'%Y-%m') = '2022-11'
And quantity >= 4;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

Select category , sum(total_sale) as Total_sales
from sales
Group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

Select Round(avg(age),2) as averg_age 
From sales
Where category = 'Beauty'



-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

Select * 
From sales
Where total_sale >= 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

Select gender , category , count(transactions_id) as total_transactions
From sales
Group by gender , category  
Order by category


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
Select   Year,
         Month,
         Avg_Sales
From  (
		Select    EXTRACT(Year From Sale_date) as Year, 
                   EXTRACT(Month From Sale_date) as Month,
                   Avg(Total_sale) as Avg_Sales ,
                   Rank() 
                         Over(
                         Partition by EXTRACT(Year From Sale_date)
                         Order by Avg(Total_sale) Desc
                         ) as ranking
                   
		From Sales
		Group By  EXTRACT(Year From Sale_date) , 
                   EXTRACT(Month From Sale_date) ) as t
Where t.ranking = 1;



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

Select   category , Count( Distinct Customer_id) as unique_customers
From sales
Group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
     
    Select  Shift , Count(quantity) as cnt_of_orders 
    From
    (
    Select * ,
           Case 
                When Extract( Hour From sale_time ) < 12 Then 'Morning'
                When Extract( Hour From sale_time ) Between 12 And 17 Then 'Afternoon'
                Else 'Evening'
           End As Shift    
    From Sales  ) t
    Group By Shift
    

                







