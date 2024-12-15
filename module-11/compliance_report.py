import mysql.connector
from mysql.connector import errorcode

def connect_to_database():
    """
    Connect to the MySQL database using provided credentials.
    """
    config = {
        'user': 'Willson_user',
        'password': 'securepassword123',
        'host': '127.0.0.1',
        'database': 'WillsonFinancial',
        'raise_on_warnings': True
    }

    try:
        connection = mysql.connector.connect(**config)
        print("Connected to the database successfully.")
        return connection
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Invalid username or password.")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist.")
        else:
            print(err)
        return None

def fetch_compliance_reports(cursor):
    """
    Fetch total compliance reports per employee.
    """
    query = """
    SELECT 
        Employees.Name AS Employee_Name,
        COUNT(Compliance.ComplianceID) AS Total_Compliance_Reports 
    FROM 
        Compliance 
    INNER JOIN 
        Employees ON Compliance.EmployeeID = Employees.EmployeeID 
    GROUP BY 
        Employees.Name;
    """
    cursor.execute(query)
    rows = cursor.fetchall()

    print("\n--- Compliance Reports by Employee ---\n")
    print(f"{'Employee Name':<20}{'Total Compliance Reports':<25}")
    print("-" * 45)
    for row in rows:
        print(f"{row[0]:<20}{row[1]:<25}")
    print("\nReport generated successfully.")

def main():
    """
    Main function to execute the compliance reports query.
    """
    db_connection = connect_to_database()

    if db_connection:
        cursor = db_connection.cursor()
        fetch_compliance_reports(cursor)
        cursor.close()
        db_connection.close()
        print("\nConnection closed.")

if __name__ == "__main__":
    main()
