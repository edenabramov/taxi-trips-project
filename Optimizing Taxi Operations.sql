select FORMAT(CAST(Trip_Start_Timestamp AS DATE), 'dddd', 'en-en') as date_start,
		DATEPART(HOUR, Trip_Start_Timestamp) as hour_in_day,
		COUNT(*) number_trips
into DAY_HOUR_COUNT
from Taxi_Trip
group by FORMAT(CAST(Trip_Start_Timestamp AS DATE), 'dddd', 'en-en') ,
		DATEPART(HOUR, Trip_Start_Timestamp);


select FORMAT(CAST(Trip_Start_Timestamp AS DATE), 'MMMM', 'en-en') as N_month,
	  avg(Fare) as avg_fare,
	  avg(Tips) as avg_Tips,
	  avg(Extras) as avg_Extras,
	  avg(trip_total) as avg_trip_total
into Avg_Taxi_by_Month
from Taxi_Trip
group by FORMAT(CAST(Trip_Start_Timestamp AS DATE), 'MMMM', 'en-en');




with weather as (select  Trip_ID,
              (case 
			  when month(Trip_Start_Timestamp)=12 or month(Trip_Start_Timestamp)=1 or month(Trip_Start_Timestamp)=2 then 'winter'
		     when month(Trip_Start_Timestamp) between 2 and 5 then 'spring'
		     when month(Trip_Start_Timestamp) between 6 and 8 then 'summer'
		     else 'fall'
             end) as weather
             from taxi_trip) 
select distinct weather,
       count (*) over (partition by weather) as num_trips
from weather;

select CAST(Trip_Start_Timestamp AS DATE) as date,
	  avg(Fare) as avg_fare,
	  avg(Tips) as avg_Tips,
	  avg(Extras) as avg_Extras,
	  avg(trip_total) as avg_trip_total,
	  count(Fare) as count_fare,
	  count(Tips) as count_Tips,
	  count(Extras) as count_Extras,
	  count(trip_total) as count_trip_total,
	  avg(Trip_Miles) as abg_trip_miles,
	  avg(Trip_Hours) as avg_trip_hours
into Avg_Taxi_by_day_count_miles_hours
from Taxi_Trip
group by CAST(Trip_Start_Timestamp AS DATE);
