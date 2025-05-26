SELECT b.Title, oi.Quantity, oi.Price
FROM OrderItems oi
INNER JOIN Books b ON oi.BookID = b.BookID;