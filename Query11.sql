USE BookStoreDB;

SELECT 
SUM(Price * Quantity) AS Total_revenue
FROM OrderItems
GROUP BY BookID
HAVING SUM(Price * Quantity)>50;