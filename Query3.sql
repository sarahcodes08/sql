USE DBHospital;

CREATE TABLE Treatments (
	treatmentID INT PRIMARY KEY,
	Medication_Name VARCHAR (50),
	Dosage VARCHAR(15) UNIQUE,
	Frequency INT,
);

SELECT * FROM Treatments;