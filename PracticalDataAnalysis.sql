/* Practical Data Analysis */
/* Joseph Christian M. San Pablo */

CREATE TABLE appleStore_description_combined AS

SELECT * FROM appleStore_description1

UNION ALL

SELECT * FROM appleStore_description2

UNION ALL

SELECT * FROM appleStore_description3

UNION ALL

SELECT * FROM appleStore_description4

/* Data Analysis */

-- checking the number of unique apps in the appstore tables --

select COUNT(DISTINCT id) as UniqueAppIDs
FROM AppleStore

select COUNT(DISTINCT id) as UniqueAppIDs
FROM appleStore_description_combined

--checking for any missing key values in the key fields --

SELECT count(*) as MissingValues
from AppleStore
where track_name is NULL or user_rating is NULL or prime_genre is NULL

SELECT count(*) as MissingValues
from appleStore_description_combined
where app_desc is NULL 

-- finding out the number of apps per genre --

SELECT prime_genre, COUNT(*) as NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC;

-- Over view of the apps' ratings --

SELECT min(user_rating) as MinRating,
	   max(user_rating) as MaxRating,
       avg(user_rating) as AvgRating
FROM AppleStore

-- Getting the Distribution of app prices --

SELECT
	(price / 2) *2 as PriceBinStart,
    ((price / 2) *2) +2 as PriceBinEnd,
    COUNT(*) as NumApps
FROM AppleStore

GROUP by PriceBinStart
GROUP by PriceBinEnd

/* Data Analysis */

-- Determing whether paid apps have a higher rating than free apps' --

SELECT CASE
			WHEN price > 0 THEN 'Paid'
            ELSE 'Free'
       end as App_Type,
       avg(user_rating) as Avg_Rating
from AppleStore
GROUP by App_Type

-- Checking if apps that support more languanges have a higher ratings --

SELECT CASE
			WHEN lang_num < 10 then '<10 languages'
            when lang_num BETWEEN 10 and 30 then '10-30 languages'
            ELSE '>30 languages'
       END as language_bucket,
       avg(user_rating) as Avg_Rating
FROM AppleStore
GROUP by language_bucket
ORDER by Avg_Rating DESC

-- checking genres with low ratings --

select prime_genre,
       avg(user_rating) as Avg_Rating
FROM AppleStore
group by prime_genre
ORDER by Avg_Rating asc
LIMIT 10

-- checking if there is a correlation between the lenght of the app description and the user rating --

SELECT CASE
            WHEN LENGTH(b.app_desc) < 500 THEN 'Short'
            WHEN LENGTH(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
            ELSE 'Long'            
       END AS description_length_bucket,
       AVG(a.user_rating) AS average_rating
       
FROM AppleStore AS a
JOIN appleStore_description_combined AS b ON a.id = b.id

GROUP BY description_length_bucket
ORDER BY average_rating DESC;

-- Checking the top rating apps for each genre --

SELECT
	prime_genre,
    track_name,
    user_rating
FROM (
  		SELECT
  		prime_genre,
  		track_name,
  		user_rating,
  		Rank() OVER(PARTITION BY prime_genre ORDER by user_rating DESC, rating_count_tot desc) as rank
  		from
 		AppleStore
  		) as a
where
a.rank = 1