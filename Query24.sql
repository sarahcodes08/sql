SELECT Title
FROM Books
WHERE Price > ALL (
    SELECT Price
    FROM Books
    WHERE Author = 'J.K. Rowling'
);