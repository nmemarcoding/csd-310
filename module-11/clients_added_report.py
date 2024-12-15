import mysql.connector
from mysql.connector import errorcode

def connect_to_database(config):
    """
    Connect to the MySQL database using the provided configuration.
    """
    try:
        db = mysql.connector.connect(**config)
        print("Connected to the database.")
        return db, db.cursor()
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Invalid username or password.")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist.")
        else:
            print(err)
        return None, None

def report_clients_added(cursor):
    """
    Fetch and display the number of clients added in the last six months.
    """
    print("\n--- Clients Added in the Last Six Months ---\n")
    query = """
        SELECT 
            DATE_FORMAT(ClientCreationDate, '%Y-%m') AS Month,
            COUNT(ClientID) AS NewClients
        FROM Clients
        WHERE ClientCreationDate >= LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 6 MONTH)) + INTERVAL 1 DAY
        GROUP BY Month
        ORDER BY Month;
    """
    cursor.execute(query)
    rows = cursor.fetchall()
    
    print(f"{'Month':<15}{'New Clients':<15}")
    print("-" * 30)
    for row in rows:
        month, new_clients = row
        print(f"{month:<15}{new_clients:<15}")
    print("\nReport generated successfully.")

def main():
    """
    Main function to execute the client count report.
    """
    # Database configuration
    config = {
        'user': 'Willson_user',
        'password': 'securepassword123',
        'host': '127.0.0.1',
        'database': 'WillsonFinancial',
        'raise_on_warnings': True
    }

    # Connect to the database
    db, cursor = connect_to_database(config)

    if cursor:
        # Generate the report
        report_clients_added(cursor)

    # Close the database connection
    if db:
        db.close()
        print("\nConnection closed.")

if __name__ == "__main__":
    main()

