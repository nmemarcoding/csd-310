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

# Function to display films
def show_films(cursor, title):
    # Query with INNER JOINs to display the required data
    cursor.execute("""
        SELECT film.film_name AS Name, film.film_director AS Director, 
               genre.genre_name AS Genre, studio.studio_name AS 'Studio Name'
        FROM film
        INNER JOIN genre ON film.genre_id = genre.genre_id
        INNER JOIN studio ON film.studio_id = studio.studio_id
    """)
    
    # Fetch results
    films = cursor.fetchall()

    # Display results
    print("\n -- {} --".format(title))
    for film in films:
        print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(
            film[0], film[1], film[2], film[3]
        ))

try:
    # Connect to the database
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    # Display the initial list of films
    show_films(cursor, "DISPLAYING FILMS")
    
    # Insert a new film
    cursor.execute("""
        INSERT INTO film (film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id)
        VALUES ('Star Wars', '1977', '121', 'George Lucas', 
                (SELECT studio_id FROM studio WHERE studio_name = '20th Century Fox'), 
                (SELECT genre_id FROM genre WHERE genre_name = 'SciFi'))
    """)
    db.commit()
    show_films(cursor, "DISPLAYING FILMS AFTER INSERT")
    
    # Update the genre of Alien to Horror
    cursor.execute("""
        UPDATE film
        SET genre_id = (SELECT genre_id FROM genre WHERE genre_name = 'Horror')
        WHERE film_name = 'Alien'
    """)
    db.commit()
    show_films(cursor, "DISPLAYING FILMS AFTER UPDATE - Changed Alien to Horror")
    
    # Delete the film Gladiator
    cursor.execute("""
        DELETE FROM film
        WHERE film_name = 'Gladiator'
    """)
    db.commit()
    show_films(cursor, "DISPLAYING FILMS AFTER DELETE")
    
except mysql.connector.Error as err:
    # Handle errors
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("* The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("* The specified database does not exist")
    else:
        print(err)

finally:
    # Ensure the connection is closed
    try:
        cursor.close()
        db.close()
    except NameError:
        pass
