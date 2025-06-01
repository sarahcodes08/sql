SELECT CourseID, COUNT(*) AS StudentCount
FROM Enrollments
GROUP BY CourseID;
