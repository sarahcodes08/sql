CREATE VIEW StudentCourseGrades AS
SELECT s.StudentID,
       CONCAT(s.FirstName, ' ', s.LastName) AS FullName,
       c.CourseName,
       e.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

SELECT * FROM StudentCourseGrades;
