USE BookStoreDB;

SELECT
	SUM(StockQuantity) AS Total_stockqty
FROM Books;