USE DBHospital;

CREATE TABLE Medical_Records (
	RecordID INT PRIMARY KEY,
	DateofVisit DATE,
	Diagnosis VARCHAR(255),
	TreatmentPlan VARCHAR(255),
	PatientID INT, 
	staffID INT,
	treatmentID INT,
	FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
	FOREIGN KEY (staffID) REFERENCES Medical_Staff(staffID) ON DELETE CASCADE,
	FOREIGN KEY (treatmentID) REFERENCES Treatments(treatmentID) ON DELETE CASCADE,
);
SELECT * FROM Medical_Records;