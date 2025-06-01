SELECT c.CourseName, CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName
FROM Courses c
JOIN Instructors i ON c.Department = i.Department;
