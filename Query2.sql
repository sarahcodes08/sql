CREATE VIEW ActiveCustomers AS
SELECT CustomerID, Name, Address
FROM Customers 
WHERE IsActive = 1;
