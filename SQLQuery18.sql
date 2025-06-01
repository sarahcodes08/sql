SELECT c.CourseID, c.CourseName
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
WHERE e.CourseID IS NULL;
