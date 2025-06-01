SELECT DISTINCT s.FirstName, s.LastName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Instructors i ON c.Department = i.Department
WHERE s.Major = i.Department;
