SELECT CourseID,
       AVG(
         CASE Grade
           WHEN 'A' THEN 4
           WHEN 'B' THEN 3
           WHEN 'C' THEN 2
           WHEN 'D' THEN 1
           WHEN 'F' THEN 0
         END
       ) AS AverageGrade
FROM Enrollments
GROUP BY CourseID;
