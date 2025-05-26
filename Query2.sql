USE BookStoreDB;

SELECT 
	MAX(Quantity) AS Max_quantity,
	MIN(Quantity) AS Min_quantity
FROM OrderItems;