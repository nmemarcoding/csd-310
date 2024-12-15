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

def report_average_asset_per_client(cursor):
    """
    Generate a report showing the average asset value for each client in alphabetical order.
    """
    print("\n--- Average Asset Value for Each Client Report ---\n")
    query = """
        SELECT 
            C.Name AS ClientName,
            AVG(A.Value) AS AverageAssetValue
        FROM Clients C
        LEFT JOIN Accounts Ac ON C.ClientID = Ac.ClientID
        LEFT JOIN Assets A ON Ac.AccountID = A.AccountID
        GROUP BY C.ClientID
        ORDER BY C.Name ASC;
    """
    
    # Execute the query
    cursor.execute(query)
    rows = cursor.fetchall()
    
    # Display the results
    if rows:
        print(f"{'Client Name':<20}{'Average Asset Value':<20}")
        print("-" * 40)
        for row in rows:
            client_name, avg_asset_value = row
            avg_asset_value = avg_asset_value if avg_asset_value is not None else 0.0
            print(f"{client_name:<20}${avg_asset_value:,.2f}")
    else:
        print("No asset data found in the database.")
    
    print("\nReport generated successfully.")

def main():
    """
    Main function to execute the average asset per client report.
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
        report_average_asset_per_client(cursor)

    # Close the database connection
    if db:
        db.close()
        print("\nConnection closed.")

if __name__ == "__main__":
    main()
