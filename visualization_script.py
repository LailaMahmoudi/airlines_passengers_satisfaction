import psycopg2
import matplotlib.pyplot as plt

# Connect to my PostgreSQL database
conn = psycopg2.connect(dbname='postgres', user='laila', password='', host='localhost', port='5432')
cursor = conn.cursor()

# Execute the SQL query
sql_query = """
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
"""
cursor.execute(sql_query)

# Fetch the results
result = cursor.fetchone()

# Close the database connection
cursor.close()
conn.close()

# Plotting the results
factors = ['Baggage Handling', 'Ease of Online Booking', 'Online Boarding', 'Check-in Service', 'Gate Location', 'On-board Service', 'Seat Comfort', 'Leg Room Service', 'Cleanliness', 'Food and Drink', 'In-flight Service', 'In-flight Wifi Service', 'In-flight Entertainment']
slopes = result[:13]


plt.bar(factors, slopes, color='skyblue')
plt.xlabel('Factors')
plt.ylabel('Regression Slope')
plt.title('Regression Slopes for Satisfaction and Different Factors')
plt.show()
