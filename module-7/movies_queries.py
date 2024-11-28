import mysql.connector
from mysql.connector import errorcode

# Database configuration
config = {
    'user': 'movies_user',
    'password': 'popcorn',
    'host': '127.0.0.1',
    'database': 'movies',
    'raise_on_warnings': True
}

try:
    # Connect to the database
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    # Query 1: All fields from studio table
    print("-- DISPLAYING Studio RECORDS --")
    cursor.execute("SELECT * FROM studio;")
    studios = cursor.fetchall()
    for studio in studios:
        print(f"Studio ID: {studio[0]}")
        print(f"Studio Name: {studio[1]}\n")

    # Query 2: All fields from genre table
    print("-- DISPLAYING Genre RECORDS --")
    cursor.execute("SELECT * FROM genre;")
    genres = cursor.fetchall()
    for genre in genres:
        print(f"Genre ID: {genre[0]}")
        print(f"Genre Name: {genre[1]}\n")

    # Query 3: Movies with runtime < 2 hours
    print("-- DISPLAYING Short Film RECORDS --")
    cursor.execute("SELECT film_name, film_runtime FROM film WHERE film_runtime < 120;")
    movies = cursor.fetchall()
    for movie in movies:
        print(f"Film Name: {movie[0]}")
        print(f"Runtime: {movie[1]}\n")

    # Query 4: Film names and directors grouped by director
    print("-- DISPLAYING Director RECORDS in Order --")
    cursor.execute("""
        SELECT film_name, film_director
        FROM film
        ORDER BY film_director;
    """)
    directors = cursor.fetchall()
    for director in directors:
        print(f"Film Name: {director[0]}")
        print(f"Director: {director[1]}\n")

except mysql.connector.Error as err:
    # Handle database connection errors
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("* The supplied username or password are invalid.")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("* The specified database does not exist.")
    else:
        print(err)
finally:
    # Ensure the database connection is closed
    if 'db' in locals() and db.is_connected():
        db.close()
