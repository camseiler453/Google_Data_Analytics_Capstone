-- Data Analysis

-- average trip duration by day of the week

SELECT 
  ROUND(AVG(tripduration),2) AS average_tripduration,
  day_of_week
FROM 
`yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
GROUP BY
  day_of_week
ORDER BY 
  day_of_week


-- average trip duration by usertype

SELECT 
  ROUND(AVG(tripduration),2) AS average_tripduration,
  usertype
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
GROUP BY
  usertype
ORDER BY 
  usertype


-- average trip duration by usertype per day of the week

SELECT 
  ROUND(AVG(tripduration),2) AS average_tripduration,
  day_of_week,
  usertype
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
GROUP BY
  day_of_week,
  usertype
ORDER BY 
  day_of_week,
  usertype


-- average trip durration by usertype per month

SELECT  
  EXTRACT(MONTH FROM start_time) AS Month,
  ROUND(AVG(tripduration),2) AS avg_trip_duration,
  usertype
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
GROUP BY 
  Month,
  usertype
ORDER BY
  Month,
  usertype


-- total trips by usertype per day of the week

SELECT 
  COUNT(trip_id) AS trips, 
  day_of_week,
  usertype
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
GROUP BY 
  day_of_week, 
  usertype
ORDER BY 
  day_of_week,
  usertype


-- total trips by usertype per month

SELECT 
  COUNT(trip_id) AS trips, 
  EXTRACT(MONTH FROM start_time) AS Month,
  usertype
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
GROUP BY 
  Month,
  usertype
ORDER BY 
  Month,
  usertype


-- top 10 customer starting stations

SELECT 
  COUNT(usertype) AS customer_starts,
  from_station_id,
  from_station_name
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
WHERE
  usertype = "Customer"
GROUP BY
  from_station_id,
  from_station_name
ORDER BY
  customer_starts DESC
LIMIT 10


-- top 10 customer ending stations

SELECT 
  COUNT(usertype) AS customer_ends,
  to_station_id,
  to_station_name
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
WHERE
  usertype = "Customer"
GROUP BY
  to_station_id,
  to_station_name
ORDER BY
  customer_ends DESC
LIMIT 10


-- top 10 subscriber starting stations

SELECT 
  COUNT(usertype) AS subscriber_starts,
  from_station_id,
  from_station_name
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
WHERE
  usertype = "Subscriber"
GROUP BY
  from_station_id,
  from_station_name
ORDER BY
  subscriber_starts DESC
LIMIT 10


-- top 10 subscriber ending stations

SELECT 
  COUNT(usertype) AS subscriber_ends,
  to_station_id,
  to_station_name
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
WHERE
  usertype = "Subscriber"
GROUP BY
  to_station_id,
  to_station_name
ORDER BY
  subscriber_ends DESC
LIMIT 10
