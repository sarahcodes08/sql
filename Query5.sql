USE BookStoreDB;

SELECT
	SUM(TotalAmount) AS Total_revenue
FROM Orders;