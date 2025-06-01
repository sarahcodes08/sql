CREATE INDEX idx_ISBN ON Books(ISBN);

EXEC sp_helpindex 'dbo.books';