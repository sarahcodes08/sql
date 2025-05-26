SELECT c.Name, SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name
HAVING SUM(o.TotalAmount) > 20;