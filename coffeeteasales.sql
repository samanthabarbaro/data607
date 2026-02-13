
---calculating the 6-day rolling average
--I've rounded to the nearest whole number because this table represents sales of cofee/tea in cups
--- you cannot sell part of a cup
SELECT
    date,
    sales as daily_sales, commodity,
    round(AVG(sales) OVER (
		PARTITION BY commodity
        ORDER BY date, commodity
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW 
    ),0) AS six_day_rolling_avg
FROM
    sales
ORDER BY
  commodity, date;

  ---but how do we add a YTD rolling average?--

  --can we sum everything, partition by year, 
  --and divide by the rolling count of days?

  SELECT
    date,
    sales as daily_sales, commodity,
    round(AVG(sales) OVER (
		PARTITION BY commodity
        ORDER BY date, commodity
        ROWS BETWEEN 365 PRECEDING AND CURRENT ROW 
    ),0) AS ytd_avg
FROM
    sales
ORDER BY
  commodity, date;


---combine the two

SELECT
    date,
    sales as daily_sales, commodity,
    round(AVG(sales) OVER (
		PARTITION BY commodity
        ORDER BY date, commodity
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW 
    ),0) AS six_day_rolling_avg,
	    round(AVG(sales) OVER (
		PARTITION BY commodity
        ORDER BY date, commodity
        ROWS BETWEEN 364 PRECEDING AND CURRENT ROW 
    ),0) AS ytd_avg
FROM
    sales
ORDER BY
  commodity, date;

  ---But how do I partition by year? (not just a yearly rolling average)
  --Let's try extracting a year and adding it to the partition
  --I believe the correct # for this is 364 (as that's 365 inclusive)
  --BUT it doesn't matter if I put 600 if we're partitioning by year
  SELECT
    date, EXTRACT (YEAR from date) as cal_year,
    sales as daily_sales, commodity, 
    round(AVG(sales) OVER (
		PARTITION BY commodity
        ORDER BY date, commodity
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW 
    ),0) AS six_day_rolling_avg,
	    round(AVG(sales) OVER (
		PARTITION BY commodity, (EXTRACT (YEAR from date))
        ORDER BY date, commodity
        ROWS BETWEEN 364 PRECEDING AND CURRENT ROW 
    ),0) AS ytd_avg
FROM
    sales
ORDER BY
commodity, date;


---to show that this works, I will add data from 2025
--since the new data starts in February
--(maybe the store closed down and had to reopen in a smaller location, hence the lower sales)
--we should also partition the 6-day rolling average by year
--I've added that here as well

  SELECT
    date, EXTRACT (YEAR from date) as cal_year,
    sales as daily_sales, commodity, 
    round(AVG(sales) OVER (
		PARTITION BY commodity, (EXTRACT (YEAR from date))
        ORDER BY date, commodity
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW 
    ),0) AS six_day_rolling_avg,
	    round(AVG(sales) OVER (
		PARTITION BY commodity, (EXTRACT (YEAR from date))
        ORDER BY date, commodity
        ROWS BETWEEN 364 PRECEDING AND CURRENT ROW 
    ),0) AS ytd_avg
FROM
    sales
ORDER BY
commodity, date;

--and it works!
