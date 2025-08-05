-- Data Discovery

-- COUNT of Customers and Subscribers; Returned 880637 Customers records, 2937367 Subscribers records

SELECT 
  SUM(CASE WHEN usertype = "Customer" THEN 1 ELSE 0 END) AS Count_Customers,
  SUM(CASE WHEN usertype = "Subscriber" THEN 1 ELSE 0 END) AS Count_Subscribers
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`


-- total trips per day

SELECT 
  COUNT(trip_id) AS trips, 
  day_of_week
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
GROUP BY 
  day_of_week
ORDER BY 
  day_of_week


-- total trips per month

SELECT 
  COUNT(trip_id) AS trips, 
  EXTRACT(MONTH FROM start_time) AS Month,
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
GROUP BY 
  Month
ORDER BY 
  Month


-- COUNT unique undirected routes between bike stations; Returned 78165 records
-- trip between a "from" and "to" station is considered the same as a trip between a "to" and "from" station (one route)

SELECT
  COUNT(DISTINCT CONCAT(
    LEAST(from_station_name, to_station_name), '||',
    GREATEST(from_station_name, to_station_name)
  )) AS unique_undirected_routes,
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`


-- COUNT unique records exclusive to subscribers, customers, and shared by both groups
-- returned 46657 shared records, 22297 subscriber records, and 9211 customer records

WITH undirected_routes AS (
  SELECT
    usertype,
    CONCAT(
      LEAST(from_station_name, to_station_name), '||',
      GREATEST(from_station_name, to_station_name)
    ) AS route_key
  FROM `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
),
route_user_map AS (
  SELECT DISTINCT route_key, usertype FROM undirected_routes
),
route_type AS (
  SELECT
    route_key,
    COUNT(DISTINCT usertype) AS usertype_count
  FROM route_user_map
  GROUP BY route_key
),
labeled_routes AS (
  SELECT
    m.route_key,
    m.usertype,
    CASE
      WHEN o.usertype_count = 1 THEN 'Exclusive'
      WHEN o.usertype_count = 2 THEN 'Shared'
    END AS route_category
  FROM route_user_map m
  JOIN route_type o
  ON m.route_key = o.route_key
)

SELECT
  CASE
  WHEN route_category = 'Shared' THEN 'Shared by Both'
  ELSE CONCAT('Exclusive to ', usertype)
  END AS route_group,
  COUNT(DISTINCT route_key) AS route_count
FROM labeled_routes
GROUP BY route_group
ORDER BY route_count DESC

