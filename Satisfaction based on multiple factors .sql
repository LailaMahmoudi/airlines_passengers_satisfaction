--Get the columns names

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'customer_satisfaction';

--see column data type and some info

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'customer_satisfaction';


--Check for the number of missing values in Arrival Delay

SELECT "Arrival Delay", COUNT(*) AS missing_values_count
FROM customer_satisfaction
WHERE "Arrival Delay" IS NULL
GROUP BY 1;



--Count the Number of Rows

SELECT count(*) FROM customer_satisfaction ;

--Statistics

SELECT * 
FROM pg_stats
WHERE tablename = 'customer_satisfaction';



--Distribution of Satisfaction Scores

SELECT
    "Satisfaction",
    COUNT(*) AS count
FROM passengers_satisfaction
GROUP BY 1
ORDER BY 1;

--Class Breakdown

SELECT
    "Class",
    COUNT(*) AS count
FROM passengers_satisfaction
GROUP BY 1;

--Type of Travel Breakdown

SELECT
    "Type of Travel",
    COUNT(*) AS count
FROM passengers_satisfaction
GROUP BY 1;



--Change data type of Satisfaction column
--Convert the textual data to numeric values:

UPDATE passengers_satisfaction 
SET "Satisfaction" = CASE 
                        WHEN "Satisfaction" = 'Satisfied' THEN '1'
                        WHEN "Satisfaction" = 'Neutral or Dissatisfied' THEN '2'
                        ELSE '0'
                      END;
--this query will replace all instances of 'Satisfied' with '1', 'Neutral or Dissatisfied' with '2', and any other value with '0'



--check a few rows to ensure the data has been updated correctly:

SELECT "Satisfaction" FROM passengers_satisfaction
 LIMIT 10;



--change the data type from text to numeric:

ALTER TABLE passengers_satisfaction 
ALTER COLUMN "Satisfaction" SET DATA TYPE numeric USING "Satisfaction"::numeric;



--Data Analysis

SELECT
    CASE
        WHEN "Age" BETWEEN 18 AND 24 THEN '18-24'
        WHEN "Age" BETWEEN 25 AND 34 THEN '25-34'
        WHEN "Age" BETWEEN 35 AND 44 THEN '35-44'
        WHEN "Age" BETWEEN 45 AND 54 THEN '45-54'
        WHEN "Age" BETWEEN 55 AND 64 THEN '55-64'
        WHEN "Age" >= 65 THEN '65+'
        ELSE 'Unknown'
    END AS age_group,
    AVG("Satisfaction") AS avg_satisfaction
FROM passengers_satisfaction
GROUP BY age_group;


SELECT "Gender", "Satisfaction", COUNT(*) AS count
FROM passengers_satisfaction
GROUP BY 1,2
ORDER BY 1,2;


SELECT "Class", "Satisfaction", COUNT(*) AS count
FROM passengers_satisfaction
Group by 1,2
ORDER BY 1,2



SELECT "Customer Type", "Satisfaction", COUNT(*) AS count
FROM passengers_satisfaction
GROUP BY 1,2
ORDER BY 1,2;



SELECT "Type of Travel", "Satisfaction", COUNT(*) AS count
FROM passengers_satisfaction
GROUP BY 1,2
ORDER BY 1,2;


SELECT "Seat Comfort", AVG("Satisfaction") AS avg_satisfaction_rating
FROM passengers_satisfaction 
GROUP BY 1;



SELECT "Baggage Handling", AVG("Satisfaction") AS avg_satisfaction_rating
FROM passengers_satisfaction 
GROUP BY 1;


SELECT "Ease of Online Booking", AVG("Satisfaction") AS avg_satisfaction_rating
FROM passengers_satisfaction 
GROUP BY 1;

--Aggregate Data:
--Calculate average satisfaction scores for each factor.

SELECT
    AVG("Satisfaction") AS avg_satisfaction,
    AVG("Baggage Handling") AS avg_baggage_handling,
    AVG("Ease of Online Booking") AS avg_ease_of_booking,
    AVG("Online Boarding") AS avg_online_boarding,
    AVG("Check-in Service") AS avg_check_in_service,
    AVG("Gate Location") AS avg_gate_location,
    AVG("On-board Service") AS avg_on_board_service,
    AVG("Seat Comfort") AS avg_seat_comfort,
    AVG("Leg Room Service") AS avg_leg_room_service,
    AVG("Cleanliness") AS avg_cleanliness, 
    AVG("Food and Drink") AS avg_food_drink,
    AVG("In-flight Service") AS avg_in_flight_service, 
    AVG("In-flight Wifi Service") AS avg_in_flight_wifi_service, 
    AVG("In-flight Entertainment") AS avg_in_flight_entertainment
 
FROM passengers_satisfaction;


--Correlation Analysis:
--Check the correlation between satisfaction and each factor.

SELECT
    CORR("Satisfaction", "Baggage Handling") AS correlation_baggage,
    CORR("Satisfaction", "Ease of Online Booking") AS correlation_booking,
    CORR("Satisfaction", "Online Boarding") AS correlation_boarding,
    CORR("Satisfaction", "Check-in Service") AS correlation_check_in,
    CORR("Satisfaction", "Gate Location") AS correlation_gate,
    CORR("Satisfaction", "On-board Service") AS correlation_on_board,
    CORR("Satisfaction", "Seat Comfort") AS correlation_comfort,
    CORR("Satisfaction", "Leg Room Service") AS correlation_leg_room,
    CORR("Satisfaction", "Cleanliness") AS correlation_cleanliness,
    CORR("Satisfaction", "Food and Drink") AS correlation_food_drink,
    CORR("Satisfaction", "In-flight Service") AS correlation_in_flight_service,
    CORR("Satisfaction", "In-flight Wifi Service") AS correlation_wifi,
    CORR("Satisfaction", "In-flight Entertainment") AS correlation_in_flight_entertainment
    

FROM passengers_satisfaction;

--Regression Analysis:
--Perform a simple linear regression analysis to understand the impact of each factor on satisfaction.

SELECT
    regr_slope("Satisfaction", "Baggage Handling") AS slope_baggage,
    regr_slope("Satisfaction", "Ease of Online Booking") AS slope_booking,
    regr_slope("Satisfaction", "Online Boarding") AS slope_boarding,
    regr_slope("Satisfaction", "Check-in Service") AS slope_check_in,
    regr_slope("Satisfaction", "Gate Location") AS slope_gate,
    regr_slope("Satisfaction", "On-board Service") AS slope_on_board,
    regr_slope("Satisfaction", "Seat Comfort") AS slope_comfort,
    regr_slope("Satisfaction", "Leg Room Service") AS slope_leg_room,
    regr_slope("Satisfaction", "Cleanliness") AS slope_cleanliness,
    regr_slope("Satisfaction", "Food and Drink") AS slope_food_drink,
    regr_slope("Satisfaction", "In-flight Service") AS slope_in_flight_service,
    regr_slope("Satisfaction", "In-flight Wifi Service") AS slope_wifi,
    regr_slope("Satisfaction", "In-flight Entertainment") AS slope_in_flight_entertainment
    

FROM passengers_satisfaction;