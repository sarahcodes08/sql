SELECT Title
FROM Books
WHERE Price > (SELECT AVG(Price) FROM Books);