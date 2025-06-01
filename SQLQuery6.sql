UPDATE Enrollments
SET Grade = 'A'
WHERE StudentID = 1 AND CourseID = 'C102';

SELECT * FROM Enrollments WHERE StudentID = 1 AND CourseID = 'C102';