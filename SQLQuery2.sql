CREATE TABLE Departments (
    DeptID VARCHAR(3) PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Major VARCHAR(50),
    Age INT,
    Email VARCHAR(100)
);
CREATE TABLE Courses (
    CourseID VARCHAR(4) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT,
    Department VARCHAR(50)
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Department VARCHAR(50)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID VARCHAR(4),
    Grade CHAR(1),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);