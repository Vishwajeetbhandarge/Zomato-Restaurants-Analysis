create database Zomato_Analysis;
select *from main;
select * from country;
select* from currency;

----------- Find the Numbers of Resturants based on City and Country.
select city,count(RestaurantId) from main
group by city;

select countryname,count(RestaurantId) from main m
left join country C on M.countrycode=C.countryId
group by countryname;

SELECT m.city, COUNT(m.restaurantid) AS city_count, c.countryname
FROM main m
LEFT JOIN Country c ON m.countrycode = c.countryid
GROUP BY m.city, c.countryname;

-----------  Numbers of Resturants opening based on Year , Quarter , Month
SELECT 
    `Year Opening` AS Year, 
    QUARTER(STR_TO_DATE(CONCAT(`Year Opening`, '-', `Month Opening`, '-01'), '%Y-%m-%d')) AS Quarter,
    `Month Opening` AS Month, 
    COUNT(*) AS Restaurant_Count
FROM Main
GROUP BY `Year Opening`, Quarter, `Month Opening`
ORDER BY `Year Opening`, Quarter, `Month Opening`;

----------- Count of Resturants based on Average Ratings

SELECT 
    Rating, 
    COUNT(*) AS Restaurant_Count
FROM Main
GROUP BY Rating
ORDER BY Rating DESC;

-------- Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets

SELECT 
    CASE
        WHEN `Average_Cost_for_two` <= 100 THEN '0-100'
        WHEN `Average_Cost_for_two` <= 300 THEN '101-300'
        WHEN `Average_Cost_for_two` <= 600 THEN '301-600'
        ELSE '601+'
    END AS Price_Bucket,
    COUNT(*) AS Restaurant_Count
FROM Main
GROUP BY Price_Bucket
ORDER BY Price_Bucket;

-----------  Percentage of Resturants based on "Has_Table_booking"

SELECT 
    `Has_Table_booking`, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Main) AS Percentage
FROM Main
GROUP BY `Has_Table_booking`;

-------- Percentage of Resturants based on "Has_Online_delivery"

SELECT 
    `Has_Online_delivery`, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Main) AS Percentage
FROM Main
GROUP BY `Has_Online_delivery`;
