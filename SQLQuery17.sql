SELECT s.StudentID, s.FirstName, s.LastName
FROM Students s
WHERE NOT EXISTS (
    SELECT c.CourseID
    FROM Courses c
    WHERE c.Department = 'Mathematics'
    EXCEPT
    SELECT e.CourseID
    FROM Enrollments e
    WHERE e.StudentID = s.StudentID
);
