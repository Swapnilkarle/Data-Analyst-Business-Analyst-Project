USE Blinkit_Analysis_Project1

Select * from [BlinkIT Grocery Data]
select COUNT(*) from [BlinkIT Grocery Data]

update [BlinkIT Grocery Data]
set Item_Fat_Content = 
case 
when Item_Fat_Content in ('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content 
End

select distinct(Item_Fat_Content) from [BlinkIT Grocery Data]

select sum(Sales) from [BlinkIT Grocery Data] 
select CAST(sum(Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions from  [BlinkIT Grocery Data]

where Item_Fat_Content = 'Low Fat'

select cast(AVG(Sales) as decimal(10,0)) as Avg_Sales from [BlinkIT Grocery Data]

select count(*) as Number_Of_Items from [BlinkIT Grocery Data]

Select cast(AVG(Rating)as decimal(10,2)) as Avg_Rating from [BlinkIT Grocery Data]

select Item_Fat_Content, 
   concat
   (cast (Cast (sum (Sales)/1000 as decimal (10,2)) as varchar(20)),'K' ) as Total_Sales_K,
     Cast(AVG(Sales) as decimal(10,0)) as Avg_Sales, 
	 count(*) as Number_Of_Items,
	 cast(AVG(Rating)as decimal(10,2)) as Avg_Rating
from [BlinkIT Grocery Data]
group by Item_Fat_Content 
order by Total_Sales_K desc

select top 5 Item_Type, 
   concat
   (cast (Cast (sum (Sales)/1000 as decimal (10,2)) as varchar(20)),'K' ) as Total_Sales_K,
     Cast(AVG(Sales) as decimal(10,0)) as Avg_Sales, 
	 count(*) as Number_Of_Items,
	 cast(AVG(Rating)as decimal(10,2)) as Avg_Rating
from [BlinkIT Grocery Data]
group by Item_Type 
order by Total_Sales_K Asc

select Outlet_Location_Type, Item_Fat_Content,
   concat
   (cast (Cast (sum (Sales)/1000 as decimal (10,2)) as varchar(20)),'K' ) as Total_Sales_K,
     Cast(AVG(Sales) as decimal(10,0)) as Avg_Sales, 
	 count(*) as Number_Of_Items,
	 cast(AVG(Rating)as decimal(10,2)) as Avg_Rating
from [BlinkIT Grocery Data]
group by Outlet_Location_Type,Item_Fat_Content 
order by Total_Sales_K Asc

select Outlet_Location_type,
      ISNULL([Low Fat],0) as Low_Fat,
	  ISNULL([Regular],0) as Regular
	  from
	  (
	  select Outlet_Location_Type, Item_Fat_Content,
	  cast(sum(Sales) as decimal(10,2)) as Total_Sales
	  from [BlinkIT Grocery Data]
	  group by Outlet_Location_Type, Item_Fat_Content
	  ) as SourceTable
	  Pivot
	  ( 
	  Sum(Total_Sales)
	  for Item_Fat_Content in ([Low Fat],[Regular])
	)
	as PivotTable
	order by Outlet_Location_Type;

 SELECT 
    Outlet_Establishment_Year,
    CONCAT(CAST(SUM(Sales) / 1000 AS DECIMAL(10,2)), 'K') AS Total_Sales_K,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS Number_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Outlet_Establishment_Year
ORDER BY SUM(Sales) / 1000 ASC;

Select 
 Outlet_Size,
 CONCAT(CAST(SUM(Sales) / 1000 AS DECIMAL(10,2)), 'K') AS Total_Sales_K,
 cast (Sum(Sales) *100 / sum(sum(Sales)) over() as decimal (10,2)) as sales_percentage
 from [BlinkIT Grocery Data]
 group by Outlet_Size
 order by Total_Sales_K  ASC;


 SELECT 
    Outlet_Location_Type,
    CONCAT(CAST(SUM(Sales) / 1000 AS DECIMAL(10,2)), 'K') AS Total_Sales_K,
	cast ((Sum(Sales) *100 / sum(sum(Sales)) over()) as decimal (10,2)) as sales_percentage,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS Number_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM dbo.[BlinkIT Grocery Data]
where Outlet_Establishment_Year = 2022
GROUP BY Outlet_Location_Type
ORDER BY SUM(Sales) / 1000 desc;

SELECT 
    Outlet_Type,
    CONCAT(CAST(SUM(Sales) / 1000 AS DECIMAL(10,2)), 'K') AS Total_Sales_K,
	cast ((Sum(Sales) *100 / sum(sum(Sales)) over()) as decimal (10,2)) as sales_percentage,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS Number_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM dbo.[BlinkIT Grocery Data]
GROUP BY Outlet_Type 
ORDER BY SUM(Sales) / 1000 desc;