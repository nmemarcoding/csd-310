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

def report_high_transaction_clients(cursor):
    """
    Generate a report of clients with more than 10 transactions in any single month.
    """
    print("\n--- High-Transaction Clients (More than 10 Transactions in a Month) ---\n")
    query = """
        SELECT 
            C.Name AS ClientName,
            COUNT(T.TransactionID) AS TransactionCount,
            DATE_FORMAT(T.TransactionDate, '%Y-%m') AS Month
        FROM Transactions T
        JOIN Accounts A ON T.AccountID = A.AccountID
        JOIN Clients C ON A.ClientID = C.ClientID
        GROUP BY C.ClientID, Month
        HAVING TransactionCount > 10
        ORDER BY Month, TransactionCount DESC;
    """
    
    # Execute the query
    cursor.execute(query)
    rows = cursor.fetchall()
    
    # Print header
    print(f"{'Client Name':<20}{'Transaction Count':<20}{'Month':<10}")
    print("-" * 50)
    
    # Print each row
    for row in rows:
        client_name, transaction_count, month = row
        print(f"{client_name:<20}{transaction_count:<20}{month:<10}")
    
    if not rows:
        print("No clients with more than 10 transactions in a single month.")
    
    print("\nReport generated successfully.")

def main():
    """
    Main function to execute the high-transaction client report.
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
        report_high_transaction_clients(cursor)

    # Close the database connection
    if db:
        db.close()
        print("\nConnection closed.")

if __name__ == "__main__":
    main()
