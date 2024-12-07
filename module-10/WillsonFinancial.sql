
-- Drop the user if it exists
DROP USER IF EXISTS 'Willson_user'@'localhost';

-- Create a new user and set a password
CREATE USER 'Willson_user'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'securepassword123';

-- Grant all privileges on the WillsonFinancial database to the new user
GRANT ALL PRIVILEGES ON WillsonFinancial.* TO 'Willson_user'@'localhost';

-- Drop and create the database
DROP DATABASE IF EXISTS WillsonFinancial;
CREATE DATABASE WillsonFinancial;
USE WillsonFinancial;

-- Drop tables if they already exist
DROP TABLE IF EXISTS Compliance;
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Assets;
DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Clients;

-- Table: Clients
CREATE TABLE Clients (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

-- Table: Accounts
CREATE TABLE Accounts (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT NOT NULL,
    AccountType VARCHAR(50),
    Balance DECIMAL(10, 2),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

-- Table: Assets
CREATE TABLE Assets (
    AssetID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    AssetType VARCHAR(50),
    Value DECIMAL(10, 2),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Table: Transactions
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionDate DATE NOT NULL,
    TransactionType VARCHAR(50),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Table: Employees
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50)
);

-- Table: Compliance
CREATE TABLE Compliance (
    ComplianceID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    ActivityDescription TEXT,
    Date DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Table: Billing
CREATE TABLE Billing (
    BillingID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT NOT NULL,
    BillingDate DATE NOT NULL,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

-- Insert data into Clients
INSERT INTO Clients (Name, Address, Phone, Email) VALUES
('Alice Smith', '123 Main St, NM', '123-456-7890', 'alice@example.com'),
('Bob Jones', '456 Elm St, NM', '234-567-8901', 'bob@example.com'),
('Charlie Brown', '789 Oak St, NM', '345-678-9012', 'charlie@example.com'),
('Diana Prince', '101 Pine St, NM', '456-789-0123', 'diana@example.com'),
('Eve Adams', '202 Maple St, NM', '567-890-1234', 'eve@example.com'),
('Frank Wilson', '303 Birch St, NM', '678-901-2345', 'frank@example.com');

-- Insert data into Accounts
INSERT INTO Accounts (ClientID, AccountType, Balance) VALUES
(1, 'Savings', 15000.00),
(2, 'Checking', 8500.00),
(3, 'Investment', 24000.00),
(4, 'Retirement', 60000.00),
(5, 'Savings', 11000.00),
(6, 'Checking', 5000.00);

-- Insert data into Assets
INSERT INTO Assets (AccountID, AssetType, Value) VALUES
(1, 'Real Estate', 120000.00),
(2, 'Stocks', 50000.00),
(3, 'Bonds', 30000.00),
(4, 'Mutual Funds', 20000.00),
(5, 'Real Estate', 150000.00),
(6, 'Cryptocurrency', 7000.00);

-- Insert data into Transactions
INSERT INTO Transactions (AccountID, TransactionDate, TransactionType, Amount) VALUES
(1, '2024-01-01', 'Deposit', 5000.00),
(2, '2024-01-02', 'Withdrawal', 2000.00),
(3, '2024-01-03', 'Deposit', 1500.00),
(4, '2024-01-04', 'Withdrawal', 3000.00),
(5, '2024-01-05', 'Deposit', 7000.00),
(6, '2024-01-06', 'Deposit', 1000.00);

-- Insert data into Employees
INSERT INTO Employees (Name, Role) VALUES
('June Santos', 'Compliance Manager'),
('Phoenix Two Star', 'Office Manager'),
('Jake Willson', 'CFA'),
('Ned Willson', 'CFA'),
('John Doe', 'Advisor'),
('Jane Roe', 'Intern');

-- Insert data into Compliance
INSERT INTO Compliance (EmployeeID, ActivityDescription, Date) VALUES
(1, 'Reviewed SEC regulations', '2024-01-01'),
(1, 'Submitted quarterly report', '2024-01-15'),
(2, 'Scheduled client appointments', '2024-01-03'),
(3, 'Updated compliance manual', '2024-01-05'),
(4, 'Met with clients for portfolio review', '2024-01-10'),
(5, 'Drafted client proposals', '2024-01-12');

-- Insert data into Billing
INSERT INTO Billing (ClientID, BillingDate, Amount) VALUES
(1, '2024-01-31', 150.00),
(2, '2024-01-31', 85.00),
(3, '2024-01-31', 240.00),
(4, '2024-01-31', 600.00),
(5, '2024-01-31', 110.00),
(6, '2024-01-31', 50.00);
