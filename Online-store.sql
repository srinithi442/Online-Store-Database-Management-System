CREATE DATABASE OnlineStore;
show databases;
USE OnlineStore;

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address TEXT
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Categories (CategoryName) VALUES ('Electronics'), ('Books'), ('Clothing');

INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity) VALUES
('Laptop', 1, 799.99, 50),
('Smartphone', 1, 499.99, 100),
('Novel', 2, 19.99, 200),
('T-Shirt', 3, 9.99, 150);

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '123 Elm Street'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '456 Oak Avenue');

INSERT INTO Orders (CustomerID, TotalAmount) VALUES
(1, 819.98),
(2, 29.98);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 799.99),
(1, 2, 1, 499.99),
(2, 3, 1, 19.99),
(2, 4, 1, 9.99);

SELECT p.ProductName, c.CategoryName, p.Price, p.StockQuantity
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID;

SELECT o.OrderID, o.OrderDate, o.TotalAmount
FROM Orders o
WHERE o.CustomerID = 1;

SELECT od.OrderID, p.ProductName, od.Quantity, od.UnitPrice
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE od.OrderID = 1;

SELECT p.ProductName, SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName;

SELECT c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
HAVING SUM(o.TotalAmount) > 50;




