USE DBHospital;

CREATE TABLE Patients (
	PatientID INT PRIMARY KEY,
	Name VARCHAR (50),
	Address VARCHAR(255),
	Contact VARCHAR(15) UNIQUE
);
CREATE TABLE Medical_Staff (
	staffID INT PRIMARY KEY,
	Name VARCHAR (50),
	Contact VARCHAR(15) UNIQUE,
);

SELECT * FROM Patients;
SELECT * FROM Medical_staff;