USE University;

INSERT INTO Departments (DeptID, DeptName, Location) VALUES
('D01', 'Computer Science', 'Building A'),
('D02', 'Mathematics', 'Building B'),
('D03', 'Physics', 'Building C');

INSERT INTO Students (StudentID, FirstName, LastName, Major, Age, Email) VALUES
(1, 'Alice', 'Johnson', 'Computer Science', 20, 'alice.johnson@example.com'),
(2, 'Bob', 'Smith', 'Mathematics', 22, 'bob.smith@example.com'),
(3, 'Carol', 'Lee', 'Physics', 19, 'carol.lee@example.com'),
(4, 'David', 'Miller', 'Biology', 17, 'david.miller@example.com');

INSERT INTO Courses (CourseID, CourseName, Credits, Department) VALUES
('C101', 'Database Systems', 3, 'Computer Science'),
('C102', 'Calculus I', 4, 'Mathematics'),
('C103', 'Physics I', 4, 'Physics');

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES
(1001, 1, 'C101', 'A'),
(1003, 3, 'C103', 'A'),
(1004, 1, 'C102', 'C'),
(1005, 2, 'C102', 'B');

INSERT INTO Instructors (InstructorID, FirstName, LastName, Department) VALUES
(501, 'Dr. Adams', 'Green', 'Computer Science'),
(502, 'Dr. Baker', 'White', 'Mathematics'),
(503, 'Dr. Clark', 'Black', 'Physics');
