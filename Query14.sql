USE BookStoreDB;

SELECT
	OrderID,
	AVG(BookID) AS Avg_no_of_books
FROM OrderItems
GROUP BY OrderID;