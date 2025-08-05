-- Data Preparation and Cleaning

-- Check for nulls in each column of the dataset

SELECT 
  SUM(CASE WHEN `trip_id` IS NULL THEN 1 ELSE 0 END) AS `trip_id_nulls`,
  SUM(CASE WHEN `start_time` IS NULL THEN 1 ELSE 0 END) AS `start_time_nulls`,
  SUM(CASE WHEN `end_time` IS NULL THEN 1 ELSE 0 END) AS `end_time_nulls`,
  SUM(CASE WHEN `bikeid` IS NULL THEN 1 ELSE 0 END) AS `bike_id_nulls`,
  SUM(CASE WHEN `tripduration` IS NULL THEN 1 ELSE 0 END) AS `tripduration_nulls`,
  SUM(CASE WHEN `from_station_id` IS NULL THEN 1 ELSE 0 END) AS `from_station_id_nulls`,
  SUM(CASE WHEN `from_station_name` IS NULL THEN 1 ELSE 0 END) AS `from_station_name_nulls`,
  SUM(CASE WHEN `to_station_id` IS NULL THEN 1 ELSE 0 END) AS `to_station_id_nulls`,
  SUM(CASE WHEN `to_station_name` IS NULL THEN 1 ELSE 0 END) AS `to_station_name`,
  SUM(CASE WHEN `usertype` IS NULL THEN 1 ELSE 0 END) AS `usertype`,
  SUM(CASE WHEN `gender` IS NULL THEN 1 ELSE 0 END) AS `gender`,
  SUM(CASE WHEN `birthyear` IS NULL THEN 1 ELSE 0 END) AS `birthyear`,
  SUM(CASE WHEN `day_of_week` IS NULL THEN 1 ELSE 0 END) AS `day_of_week`
FROM `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`;


-- Check for nulls in birthyear and gender per usertype

SELECT
   usertype,
   SUM(CASE WHEN `birthyear` IS NULL THEN 1 ELSE 0 END) AS `birthyear_nulls`,
   SUM(CASE WHEN `gender` IS NULL THEN 1 ELSE 0 END) AS `gender_nulls`
FROM 
  `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
WHERE
   usertype = "Subscriber" OR 
   usertype = "Customer"
GROUP BY 
   usertype;


-- Check for duplicate rows

SELECT 
  *, 
  COUNT(*) AS duplicate_count
FROM `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
GROUP BY 
  trip_id, 
  start_time, 
  end_time, 
  bikeid, 
  tripduration, 
  from_station_id,
  from_station_name,
  to_station_id,
  to_station_name,
  usertype,
  gender,
  birthyear,
  day_of_week
HAVING COUNT(*) > 1;


-- Rename columns in Q2 dataset to match Q1, Q3, and Q4 for union

ALTER TABLE `yobpractice-466113.divvy2019.Divvy_Trips_Q2` 
RENAME COLUMN `01 - Rental Details Local Start Time` TO `start_time`,
RENAME COLUMN `01 - Rental Details Local End Time` TO `end_time`,
RENAME COLUMN `01 - Rental Details Bike ID` TO `bikeid`,
RENAME COLUMN `01 - Rental Details Duration In Seconds Uncapped` TO `tripduration`,
RENAME COLUMN `03 - Rental Start Station ID` TO `from_station_id`,
RENAME COLUMN `03 - Rental Start Station Name` TO `from_station_name`,
RENAME COLUMN `02 - Rental End Station ID` TO `to_station_id`,
RENAME COLUMN `02 - Rental End Station Name` TO `to_station_name`,
RENAME COLUMN `User Type` TO `usertype`,
RENAME COLUMN `Member Gender` TO `gender`,
RENAME COLUMN `05 - Member Details Member Birthday Year` TO `birthyear`;


-- Combine Q1, Q2, Q3, Q4 datasets into one table

CREATE TABLE `yobpractice-466113.divvy2019.Cyclistic_2019_Combined` AS (
  SELECT * 
  FROM `yobpractice-466113.divvy2019.Divvy_Trips_Q1`
    UNION ALL
  SELECT *
  FROM `yobpractice-466113.divvy2019.Divvy_Trips_Q2`
    UNION ALL
  SELECT *
  FROM `yobpractice-466113.divvy2019.Divvy_Trips_Q3`
    UNION ALL
  SELECT *
  FROM `yobpractice-466113.divvy2019.Divvy_Trips_Q4`
);


-- Add day_of_week column

ALTER TABLE `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
ADD COLUMN `day_of_week` INT64;


-- Populate day_of_week using start_time

UPDATE `yobpractice-466113.divvy2019.Cyclistic_2019_Combined`
SET `day_of_week` = EXTRACT(DAYOFWEEK FROM `start_time`)
WHERE TRUE;
