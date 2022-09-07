USE PortfolioProject

--- UNION ALL 4 tables from 2014 into 1 new table

SELECT *
INTO [2014BikeTrips]
FROM [dbo].[2014_Bike_Trips1]
UNION ALL
SELECT *
FROM [dbo].[2014_Bike_Trips2]
UNION ALL
SELECT * 
FROM [dbo].[2014_Bike_Trips3]
UNION ALL
SELECT * 
FROM [dbo].[2014_Bike_Trips4]

--- View and analyze data

SELECT *
FROM [dbo].[2014BikeTrips]
ORDER BY [starttime]
--- View total number of trips within the year 
SELECT COUNT(*) as Trip_Count
FROM [dbo].[2014BikeTrips]


--- UNION ALL 6 tables from 2015 into 1 new table

SELECT *
INTO [2015BikeTrips]
FROM [dbo].[2015_Bike_Trips1]
UNION ALL
SELECT *
FROM [dbo].[2015_Bike_Trips2]
UNION ALL
SELECT * 
FROM [dbo].[2015_Bike_Trips3]
UNION ALL
SELECT * 
FROM [dbo].[2015_Bike_Trips4]
UNION ALL
SELECT *
FROM [dbo].[2015_Bike_Trips5]
UNION ALL
SELECT *
FROM [dbo].[2015_Bike_Trips6]

--- View and analyze data

SELECT *
FROM [2015BikeTrips]
ORDER BY [starttime]

--- View total number of trips within the year 
SELECT COUNT(*) as Trip_Count
FROM [dbo].[2015BikeTrips]

--- Combine 2014 and 2015 dataset into 1 table

SELECT *
INTO [BikeTripData]
FROM [dbo].[2014BikeTrips]
UNION ALL
SELECT *
FROM [dbo].[2015BikeTrips]

--- View and analyze data

SELECT *
FROM [dbo].[BikeTripData]
ORDER BY [starttime]

--- Irregularities found by COUNT as Station Id's and Station Names are not 1:1 ratio

SELECT
	COUNT(DISTINCT [from_station_id]) as total_start_station_ids,
	COUNT(DISTINCT [from_station_name]) as total_start_station_names
FROM [dbo].[BikeTripData]

--- Analyze Station Name with Station ID

SELECT [from_station_name],[from_station_id]
FROM [dbo].[BikeTripData]
WHERE [starttime] BETWEEN '2014-01-01T00:00:00'
    AND '2015-12-31T23:59:59'

SELECT  
	COUNT(DISTINCT [from_station_name]) as Name_Count
FROM [dbo].[BikeTripData]

--- Count number of trips and growth from 2014 to 2015

SELECT year([starttime]) as TripYear, COUNT(*) as tripcount, 3183439-2454634 as TripGrowth
FROM [dbo].[BikeTripData]
GROUP BY DATEPART(year,[starttime])

SELECT year([starttime]) as TripYear, month([starttime]) as TripMonth, COUNT(*) as tripcount 
FROM [dbo].[BikeTripData]
WHERE [starttime] BETWEEN '2014-01-01T00:00:00'
AND '2015-12-31T23:59:59'
AND bikeid is not null
GROUP BY [starttime]
ORDER BY [starttime]

--- Cleaning Data 
--- Split date and time into seperate columns

SELECT [starttime],
	StartDate = CONVERT(date, [starttime]),
	TimeStart = CONVERT(time, [starttime]),
	TimeEnd = CONVERT (time, [stoptime])
	FROM [dbo].[BikeTripData]
ORDER BY [starttime]

SELECT year([starttime]) as TripYear, COUNT(DISTINCT month([starttime])) as month, 
	COUNT(DISTINCT day([starttime])) as Days
FROM [dbo].[BikeTripData]
GROUP BY DATEPART(year,[starttime])






