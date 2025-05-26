USE BookStoreDB;

SELECT 
	OrderID,
	SUM(Price * Quantity) AS Total_revenue,
	SUM(Quantity) AS Total_quantity,
	COUNT(BookID) AS Unique_books,
	COUNT(*) AS Total_orderitems
FROM OrderItems
GROUP BY OrderID
ORDER BY OrderID ASC;