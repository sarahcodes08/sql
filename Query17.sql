SELECT o.OrderID, o.OrderDate, b.Title
FROM Orders o
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Books b ON oi.BookID = b.BookID;