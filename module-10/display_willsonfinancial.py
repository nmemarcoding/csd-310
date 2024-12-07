import mysql.connector
from mysql.connector import errorcode
from datetime import date
from decimal import Decimal

def connect_to_database(config):
    """
    Connects to the database using the given configuration.
    Returns the database connection object and cursor.
    """
    try:
        db = mysql.connector.connect(**config)
        print("\n Database user '{}' connected to MySQL on host '{}' with database '{}'".format(
            config["user"], config["host"], config["database"]))
        return db, db.cursor()
    except mysql.connector.Error as err:
        handle_database_error(err)
        return None, None

def handle_database_error(err):
    """
    Handles MySQL database connection errors.
    """
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("* The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("* The specified database does not exist")
    else:
        print(err)

def fetch_and_display_table_data(cursor, tables):
    """
    Fetches and displays data from the given list of tables.
    """
    for table in tables:
        print(f"\n--- Data from {table} ---")
        try:
            cursor.execute(f"SELECT * FROM {table}")
            rows = cursor.fetchall()
            
            # Format datetime.date and Decimal for cleaner display
            for row in rows:
                formatted_row = tuple(
                    str(item) if isinstance(item, date) else
                    float(item) if isinstance(item, Decimal) else
                    item
                    for item in row
                )
                print(formatted_row)
            
            if not rows:
                print(f"No data available in {table}.")
        except mysql.connector.Error as err:
            print(f"Error retrieving data from {table}: {err}")

def close_connection(db):
    """
    Closes the database connection.
    """
    if db:
        db.close()
        print("\nConnection closed.")

def main():
    """
    Main function to execute the database operations.
    """
    # Configuration for the database connection
    config = {
        'user': 'Willson_user',
        'password': 'securepassword123',
        'host': '127.0.0.1',
        'database': 'WillsonFinancial',
        'raise_on_warnings': True
    }

    db, cursor = connect_to_database(config)

    if cursor:
        # List of tables to fetch data from
        tables = ["Clients", "Accounts", "Assets", "Transactions", "Employees", "Compliance", "Billing"]
        fetch_and_display_table_data(cursor, tables)

    # Wait for user input before exiting
    input("\n\nPress any key to exit...")
    
    close_connection(db)
    
    

if __name__ == "__main__":
    main()
