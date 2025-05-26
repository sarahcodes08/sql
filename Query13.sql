USE BookStoreDB;

SELECT 
	CustomerID,
	COUNT(*) AS Num_of_orders
FROM Orders
GROUP BY CustomerID;