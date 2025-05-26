
SELECT b.Title, COUNT(o.OrderItemID) AS Order_freq
FROM Books b
LEFT JOIN OrderItems o ON b.BookID = o.bookID
GROUP BY b.BookID, b.Title;