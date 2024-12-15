
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
    Email VARCHAR(100),
    ClientCreationDate DATE NOT NULL
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
INSERT INTO Clients (Name, Address, Phone, Email, ClientCreationDate) VALUES
('Alice Smith', '123 Main St, NM', '123-456-7890', 'alice@example.com', '2024-06-01'),
('Bob Jones', '456 Elm St, NM', '234-567-8901', 'bob@example.com', '2024-06-15'),
('Charlie Brown', '789 Oak St, NM', '345-678-9012', 'charlie@example.com', '2024-07-05'),
('Diana Prince', '101 Pine St, NM', '456-789-0123', 'diana@example.com', '2024-07-20'),
('Eve Adams', '202 Maple St, NM', '567-890-1234', 'eve@example.com', '2024-08-10'),
('Frank Wilson', '303 Birch St, NM', '678-901-2345', 'frank@example.com', '2024-08-25'),
('Grace Lee', '404 Cedar St, NM', '789-012-3456', 'grace@example.com', '2024-09-05'),
('Henry Ford', '505 Ash St, NM', '890-123-4567', 'henry@example.com', '2024-10-01'),
('Ivy Green', '606 Pine St, NM', '901-234-5678', 'ivy@example.com', '2024-11-15'),
('Jake White', '707 Oak St, NM', '012-345-6789', 'jake@example.com', '2024-11-25');

-- Insert data into Accounts
INSERT INTO Accounts (ClientID, AccountType, Balance) VALUES
(1, 'Savings', 15000.00),
(1, 'Checking', 5000.00),
(2, 'Checking', 1000.00),
(3, 'Checking', 500.00),
(3, 'Investment', 2300000.00),
(4, 'Savings', 15000.00),
(4, 'Checking', 5000.00),
(4, 'Retirement', 81000.00),
(5, 'Savings', 15000.00),
(6, 'Checking', 5000.00),
(7, 'Savings', 1000.00),
(7, 'Checking', 500.00),
(7, 'Investment', 807000.00),
(7, 'Retirement', 170000.00),
(8, 'Retirement', 607000.00),
(9, 'Savings', 15000.00),
(9, 'Checking', 5000.00),
(10, 'Checking', 1000.00);

-- Insert data into Assets
INSERT INTO Assets (AccountID, AssetType, Value) VALUES
(1, 'USD', 15000.00),
(2, 'USD', 5000.00),
(3, 'USD', 1000.00),
(4, 'USD', 500.00),
(5, 'Real Estate', 1200000.00),
(5, 'Cryptocurrency', 700000.00),
(5, 'Stocks', 400000.00),
(6, 'USD', 15000.00),
(7, 'USD', 5000.00),
(8, 'USD', 1000.00),
(8, 'Stocks', 50000.00),
(8, 'Bonds', 30000.00),
(9, 'USD', 15000.00),
(10, 'USD', 5000.00),
(11, 'USD', 1000.00),
(12, 'USD', 500.00),
(13, 'Bonds', 30000.00),
(13, 'Mutual Funds', 20000.00),
(13, 'Real Estate', 350000.00),
(13, 'Cryptocurrency', 7000.00),
(13, 'Stocks', 400000.00),
(14, 'Mutual Funds', 20000.00),
(14, 'Real Estate', 150000.00),
(15, 'Real Estate', 150000.00),
(15, 'Cryptocurrency', 7000.00),
(15, 'Stocks', 400000.00),
(15, 'Bonds', 50000.00),
(16, 'USD', 15000.00),
(17, 'USD', 5000.00),
(18, 'USD', 1000.00);

-- Insert data into Transactions
-- Ensuring one client has more than 10 transactions in a single month
INSERT INTO Transactions (AccountID, TransactionDate, TransactionType, Amount) VALUES
-- Client 1: Alice Smith Savings (December 2024)
(1, '2024-12-01', 'Deposit', 1000.00),
(1, '2024-12-02', 'Deposit', 1500.00),
(1, '2024-12-03', 'Withdrawal', 500.00),
(1, '2024-12-04', 'Deposit', 2000.00),
(1, '2024-12-05', 'Deposit', 1500.00),
(1, '2024-12-06', 'Withdrawal', 700.00),
(1, '2024-12-07', 'Deposit', 1000.00),
(1, '2024-12-08', 'Deposit', 1200.00),
(1, '2024-12-09', 'Deposit', 800.00),
(1, '2024-12-10', 'Deposit', 900.00),
(1, '2024-12-11', 'Deposit', 500.00),

-- Client 1: Alice Smith Checking (December 2024)
(2, '2024-12-01', 'Deposit', 1000.00),
(2, '2024-12-02', 'Deposit', 1500.00),
(2, '2024-12-03', 'Withdrawal', 500.00),
(2, '2024-12-04', 'Deposit', 2000.00),
(2, '2024-12-05', 'Deposit', 1500.00),
(2, '2024-12-06', 'Withdrawal', 700.00),
(2, '2024-12-07', 'Deposit', 1000.00),
(2, '2024-12-08', 'Deposit', 1200.00),
(2, '2024-12-09', 'Deposit', 800.00),
(2, '2024-12-10', 'Deposit', 900.00),
(2, '2024-12-11', 'Deposit', 500.00),

-- Client 1: Alice Smith (October 2024)
(1, '2024-10-01', 'Deposit', 1300.00),
(1, '2024-10-02', 'Withdrawal', 400.00),
(1, '2024-10-03', 'Deposit', 1500.00),
(2, '2024-10-04', 'Deposit', 2000.00),
(2, '2024-10-05', 'Deposit', 1700.00),
(2, '2024-10-06', 'Deposit', 1500.00),
(2, '2024-10-07', 'Withdrawal', 900.00),
(2, '2024-10-08', 'Deposit', 1400.00),
(1, '2024-10-09', 'Deposit', 800.00),
(2, '2024-10-10', 'Deposit', 700.00),
(1, '2024-10-11', 'Deposit', 1200.00),

-- Client 2: Bob Jones (November 2024)
(3, '2024-11-01', 'Deposit', 1100.00),
(3, '2024-11-02', 'Withdrawal', 800.00),
(3, '2024-11-03', 'Deposit', 700.00),
(3, '2024-11-04', 'Deposit', 1500.00),
(3, '2024-11-05', 'Withdrawal', 600.00),
(3, '2024-11-06', 'Deposit', 900.00),
(3, '2024-11-07', 'Deposit', 1200.00),
(3, '2024-11-08', 'Deposit', 1000.00),
(3, '2024-11-09', 'Deposit', 700.00),
(3, '2024-11-10', 'Deposit', 1100.00),
(3, '2024-11-11', 'Deposit', 500.00),

-- Client 3: Charlie Brown (October 2024)
(4, '2024-10-01', 'Deposit', 1300.00),
(4, '2024-10-02', 'Withdrawal', 400.00),
(4, '2024-10-03', 'Deposit', 1500.00),
(4, '2024-10-04', 'Deposit', 2000.00),
(4, '2024-10-05', 'Deposit', 1700.00),
(4, '2024-10-06', 'Deposit', 1500.00),
(4, '2024-10-07', 'Withdrawal', 900.00),
(4, '2024-10-08', 'Deposit', 1400.00),
(4, '2024-10-09', 'Deposit', 800.00),
(4, '2024-10-10', 'Deposit', 700.00),
(4, '2024-10-11', 'Deposit', 1200.00);

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
(1, 'Reviewed SEC regulations', '2024-06-01'),
(1, 'Submitted quarterly report', '2024-07-15'),
(2, 'Scheduled client appointments', '2024-08-20'),
(3, 'Updated compliance manual', '2024-09-05'),
(4, 'Met with clients for portfolio review', '2024-10-10'),
(5, 'Drafted client proposals', '2024-11-25');

-- Insert data into Billing
INSERT INTO Billing (ClientID, BillingDate, Amount) VALUES
(1, '2024-11-30', 150.00),
(2, '2024-10-31', 85.00),
(3, '2024-09-30', 240.00),
(4, '2024-08-31', 600.00),
(5, '2024-07-31', 110.00),
(6, '2024-06-30', 50.00),
(7, '2024-09-30', 300.00),
(8, '2024-10-31', 400.00),
(9, '2024-11-30', 200.00),
(10, '2024-11-30', 100.00);
