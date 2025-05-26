USE BookStoreDB;

SELECT c.Name, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;