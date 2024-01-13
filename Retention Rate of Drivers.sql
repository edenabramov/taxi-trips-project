--What is the retention rate of drivers over the year?
with Drivers as ( select distinct Taxi_ID_New,
                 min(CAST(trip_start_timestamp AS DATE)) over (PARTITION by Taxi_ID_New) as StartDate,
                 max(CAST(trip_start_timestamp AS DATE)) over (PARTITION by Taxi_ID_New) as EndDate
                 from Taxi_Trip)

select 
    (cast(COUNT(CASE WHEN EndDate = '2023-12-10' THEN 1 END) as float) -
    cast(COUNT(CASE WHEN StartDate > '2023-01-01' and StartDate < '2023-12-10' THEN 1 END) as float)) /
    cast(COUNT(CASE WHEN StartDate = '2023-01-01' THEN 1 END) as float)) * 100 AS RetentionRate
into RetentionRate
from Drivers

with CohortAnalysis as (
Select first,
SUM(CASE WHEN month_number = 0 THEN 1 ELSE null END) AS drivers,
SUM(CASE WHEN month_number = 1 THEN 1 ELSE null END) AS month1,
SUM(CASE WHEN month_number = 2 THEN 1 ELSE null END) AS month2,
SUM(CASE WHEN month_number = 3 THEN 1 ELSE null END) AS month3,
SUM(CASE WHEN month_number = 4 THEN 1 ELSE null END) AS month4,
SUM(CASE WHEN month_number = 5 THEN 1 ELSE null END) AS month5,
SUM(CASE WHEN month_number = 6 THEN 1 ELSE null END) AS month6,
SUM(CASE WHEN month_number = 7 THEN 1 ELSE null END) AS month7,
SUM(CASE WHEN month_number = 8 THEN 1 ELSE null END) AS month8,
SUM(CASE WHEN month_number = 9 THEN 1 ELSE null END) AS month9,
SUM(CASE WHEN month_number = 10 THEN 1 ELSE null END) AS month10,
SUM(CASE WHEN month_number = 11 THEN 1 ELSE null END) AS month11,
SUM(CASE WHEN month_number = 12 THEN 1 ELSE null END) AS month12
from (Select m.Taxi_ID_New, m.login_month, n.first as first,
             m.login_month-first as month_number
      from (SELECT Taxi_ID_New, DATEPART(month, Trip_Start_Timestamp) AS login_month
            FROM Taxi_Trip_2
            GROUP BY Taxi_ID_New, DATEPART(MONTH, Trip_Start_Timestamp)) as m,
           (SELECT Taxi_ID_New, min(DATEPART(month, Trip_Start_Timestamp)) AS first
            FROM Taxi_Trip_2
            GROUP BY Taxi_ID_New) as n
      where m.Taxi_ID_New=n.Taxi_ID_New) as with_month_number
group by first )

select first,
case 
    when first = 1 then 'January'
    when first = 2 then 'February'
	when first = 3 then 'March'
	when first = 4 then 'April'
	when first = 5 then 'May'
	when first = 6 then 'June'
	when first = 7 then 'July'
	when first = 8 then 'August'
	when first = 9 then 'September'
	when first = 10 then 'October'
	when first = 11 then 'November'
    else 'December'
end as Cohort,
drivers,
cast(month1 as float)/cast(drivers as float) as '1',
cast(month2 as float)/cast(drivers as float) as '2',
cast(month3 as float)/cast(drivers as float) as '3',
cast(month4 as float)/cast(drivers as float) as '4',
cast(month5 as float)/cast(drivers as float) as '5',
cast(month6 as float)/cast(drivers as float) as '6',
cast(month7 as float)/cast(drivers as float) as '7',
cast(month8 as float)/cast(drivers as float) as '8',
cast(month9 as float)/cast(drivers as float) as '9',
cast(month10 as float)/cast(drivers as float) as '10',
cast(month11 as float)/cast(drivers as float) as '11',
cast(month12 as float)/cast(drivers as float) as '12'
from CohortAnalysis
order by first