USE BookStoreDB;
CREATE TABLE Books (
	BookID INT PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	Author VARCHAR(255) NOT NULL,
	ISBN VARCHAR(255) Unique,
	Price DECIMAL(10, 2),
	StockQuantity INT
);
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Email VARCHAR(255) Unique,
	Address VARCHAR(255) NOT NULL 
);

CREATE TABLE Orders (
	OrderID INT PRIMARY KEY,
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID) ,
	OrderDate DATE,
	TotalAmount DECIMAL(10, 2)
);
CREATE TABLE OrderItems (
	OrderItemID INT PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	BookID INT FOREIGN KEY REFERENCES Books(BookID),
	Quantity INT,
	Price DECIMAL(10, 2)
);