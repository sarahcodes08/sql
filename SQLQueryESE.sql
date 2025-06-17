CREATE DATABASE Student1;

CREATE Table Students1  
(
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    DateOfBirth DATE,
    RegistrationDate DATE
);

CREATE Table Courses1 
(
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);

CREATE Table Enrollments1 (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollDate DATE
	FOREIGN KEY (StudentID) REFERENCES Students1(StudentID) ON DELETE CASCADE,
	FOREIGN KEY (CourseID) REFERENCES Courses1(CourseID) ON DELETE CASCADE
);

-- Students
INSERT INTO Students1 VALUES
(1, 'Ali Khan', '2000-05-15', '2022-08-20'),
(2, 'Sara Ahmed', '1999-11-30', '2023-01-10'),
(3, 'Omar Farooq', '2001-03-22', '2021-09-05');

-- Courses
INSERT INTO Courses1 VALUES
(101, 'Database Systems', 3),
(102, 'Operating Systems', 4),
(103, 'Web Development', 3);

-- Enrollments
INSERT INTO Enrollments1 VALUES
(1, 1, 101, '2023-01-15'),
(2, 1, 103, '2023-01-16'),
(3, 2, 102, '2023-02-01'),
(4, 3, 101, '2022-09-10');

SELECT * FROM Students1;
SELECT * FROM Courses1;
SELECT * FROM Enrollments1;

SELECT s.Name, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID=e.StudentID
JOIN Courses c ON e.CourseID=c.CourseID;

SELECT Name, RegistrationDate
FROM Students
WHERE RegistrationDate < ('2023-01-01');

SELECT c.CourseID, c.CourseName, Count(e.CourseID) AS No_of_std 
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID=e.CourseID
GROUP BY c.CourseID, c.CourseName;

CREATE OR ALTER VIEW CurrentEnrollments AS
SELECT s.Name, c.CourseName, e.EnrollDate
FROM Students s
JOIN Enrollments e ON s.StudentID=e.StudentID
JOIN Courses c ON e.CourseID=c.CourseID;

SELECT * FROM CurrentEnrollments;

CREATE DATABASE RetailStore;
CREATE Table Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2) CHECK (Price > 0),
    Stock INT
);

CREATE Table Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Products
INSERT INTO Products VALUES
(201, 'Laptop Model A', 75000.00, 10),
(202, 'Smartphone Model X', 35000.00, 25);

-- Sales
INSERT INTO Sales VALUES
(1, 201, 2, '2025-05-01'),
(2, 202, 5, '2025-05-03');

SELECT * FROM Products;
SELECT * FROM Sales;

SELECT ProductName, Stock
FROM Products;

SELECT * 
FROM Sales
WHERE SaleDate >= ('2025-05-01');

SELECT * 
UPDATE Products 
SET Stock = Stock -3
WHERE ProductID=201;

SELECT * FROM Products;

SELECT p.ProductName, SUM(s.Quantity) AS Total_quantity_sold
FROM Products p
JOIN Sales s ON p.ProductID=s.ProductID
GROUP BY p.ProductName;

USE RetailStore;

CREATE VIEW LowStockProductss AS
SELECT ProductName, Stock
FROM Products1 
WHERE Stock < 10;

SELECT * FROM LowStockProductss;


BEGIN TRANSACTION;

UPDATE Students1
SET RegistrationDate = '2025-06-01'
WHERE StudentID=1;

INSERT INTO Enrollments1 VALUES 
(5, 3, 101, GETDATE());

COMMIT;
SELECT * FROM Students1
SELECT * FROM Enrollments1;
BACKUP DATABASE Student1
TO DISK = 'D:\Backups\UniversityDB.bak';

RESTORE DATABASE Student1
FROM DISK = 'D:\Backups\UniversityDB.bak'
WITH REPLACE;