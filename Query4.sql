CREATE OR ALTER VIEW ActiveCustomers AS 
SELECT CustomerID, Name, Country, Email 
FROM Customers 
WHERE IsActive = 1; 

SELECT * FROM ActiveCustomers;