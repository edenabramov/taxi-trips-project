
-- Preference of payment methods of customers according to different companies
with company_prefer_payment as (
SELECT company, payment_type
FROM (SELECT company, Payment_Type,
             RANK () OVER (PARTITION BY company ORDER BY COUNT (*) DESC) AS rnk
      FROM taxi_trip
      GROUP BY company, Payment_Type
     ) AS ranked_data
WHERE rnk = 1
)

select Payment_Type,
       count (*) as number_of_company_prefer_payment
from company_prefer_payment
group by Payment_Type;


-- Division into payment types
select Payment_Type,
            count (*) as number_of_customers_use
from Taxi_Trip
group by Payment_Type;


--Effect of the type of payment method
with Trips_above_the_average_distance as (
select payment_type,
       count(*) as Travels_above_the_average_distance
from taxi_trip
where trip_Miles > (SELECT AVG(trip_miles)
                    from Taxi_Trip)
group by Payment_Type),

Trips_equal_to_or_below_average_distance as (
select payment_type,
       count(*) as Trips_equal_to_or_below_average_distance
from taxi_trip
where trip_Miles <= (SELECT AVG(trip_miles)
                     from Taxi_Trip)
group by Payment_Type)

select A.*, B.Trips_equal_to_or_below_average_distance
into payment_distance
from Trips_above_the_average_distance as A
join Trips_equal_to_or_below_average_distance as B
on A.payment_type = B.payment_type;









