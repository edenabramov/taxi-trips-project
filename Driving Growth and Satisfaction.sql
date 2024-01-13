
-- Average Customer Satisfaction Rating= Sum of all customer ratings/number of rated trips
select Payment_Type,
       cast (Trip_Start_Timestamp as date) as StartDate,
       sum(customer_rate)/count(Trip_id) as Average_Customer_Satisfaction_Rating
from Taxi_Trip
group by Payment_Type,
         cast (Trip_Start_Timestamp as date)
order by 1, 2;

-- Effect of the distance on the customer rate
with customer_rate_above_the_average_distance as (
select customer_rate,
       count(*) as customer_rate_above_the_average_distance
from taxi_trip
where Trip_Miles > (SELECT AVG(trip_miles)
                    from Taxi_Trip)
group by customer_rate),

customer_rate_equal_to_or_below_average_distance as (
select customer_rate,
       count(*) as customer_rate_equal_to_or_below_average_distance
from taxi_trip
where Trip_Miles <= (SELECT AVG(trip_miles)
                     from Taxi_Trip)
group by customer_rate)

select A.*, B.customer_rate_equal_to_or_below_average_distance
into customer_rate_distance
from customer_rate_above_the_average_distance as A
join customer_rate_equal_to_or_below_average_distance as B
on A.customer_rate = B.customer_rate;