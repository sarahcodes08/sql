USE BookStoreDB;

SELECT 
	AVG(Price) AS Avg_price, 
	MAX(Price) AS Max_price, 
	MIN(Price) AS Min_price 
FROM BOOKS;